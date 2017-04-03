% ---------------------------------------------------------------------
%   control_out_lp
%       compute the LQR controller for the simplified model of the
%       quadcopter. This controller is aimed to be the outer loop
%       controller
% ---------------------------------------------------------------------
% close all, clear all, clc;

%% Parameters
addpath('G:\Masters Thesis\3.simulation\November');
parameters; global param
m  = param.m;    g = param.g;
Ix = param.Ix;  Iy = param.Iy;  Iz = param.Iz;
hs = param.hs;  hf = param.hf;

%% simplified model
% [ x_ydot        [ u/m         [ 0
%   y_2dot      =   v/m       +   0
%   z_2dot          w/m          +g
%   psi_2dot ]     tau_psi/Iz ]   0 ]

% the dynamics of the simplified model can be decoupled into 4 decoupled
%  system-models


disp(' K var     :  KP          KD');
disp(' ---------------------------------------------------------');

i=0; % loop secod counter
for var = {'x', 'y', 'z', 'psi'}; i=i+1;
    % compute the LQR controller
    var = char(var);
    switch var
        case 'x' 
            % state variables: [ x, x_dot ]
            % decoupled model
            A = [ 0 1
                  0 0 ];
            B = [ 0; 1/m];
            C = eye(2);
            D = 0;
            
            sysd = c2d( ss(A, B, C, D), hf);
            Ad = sysd.a; Bd = sysd.b;
            
            % LQR controller
            Q = diag( [1 0.1] ); R = 10;
            k = dlqr( Ad, Bd, Q, R );
            
        case 'y' 
            % state variables: [ y, y_dot ]
            % decoupled model
            A = [ 0 1
                  0 0 ];
            B = [ 0; 1/m];
            C = eye(2);
            D = 0;
            
            sysd = c2d( ss(A, B, C, D), hf);
            Ad = sysd.a; Bd = sysd.b;
            
            % LQR controller
            Q = diag( [1 0.1] ); R = 10;
            k = dlqr( Ad, Bd, Q, R );

        case 'z'    % effect of gravity is FF!
            % state variables: [ z, z_dot ]
            % decoupled model
            A = [ 0 1
                  0 0 ];
            B = [ 0; -1/m];
            C = eye(2);
            D = 0;
            
            sysd = c2d( ss(A, B, C, D), hf);
            Ad = sysd.a; Bd = sysd.b;
            
            % LQR controller
            Q = diag( [1 0.1] ); R = 10;
            k = dlqr( Ad, Bd, Q, R );

        case 'psi'
            % state variables: [ psi, psi_dot ]
            % decoupled model
            A = [ 0 1
                  0 0 ];
            B = [ 0; 1/Iz];
            C = eye(2);
            D = 0;
            
            sysd = c2d( ss(A, B, C, D), hf);
            Ad = sysd.a; Bd = sysd.b;
            
            % LQR controller
            Q = diag( [1 1] ); R = 10;
            k = dlqr( Ad, Bd, Q, R );
            
    end
    
    % store
    K.(sprintf('%s', strcat('K_', var)) ).K = k;
        K.(sprintf('%s', strcat('K_', var)) ).KP = k(1);
        K.(sprintf('%s', strcat('K_', var)) ).KD = k(2);
    K.out.KP(i) = k(1);
    K.out.KD(i) = k(2);
    
    % display
    disp(['  K ',var,'      :  ', num2str(k)])
    
    % plots
    switch var
        case {'x', 'y', 'z'}
            figure(i)
            subplot(2,2,1), impulse( ss( Ad-Bd*k, [0;hf], [1 0], 0, hf) );  % state imp response
            subplot(2,2,2), impulse( ss( Ad-Bd*k, [0;hf], [0 1], 0, hf) );  % state_dot imp response
            subplot(2,2,3), impulse( ss( Ad-Bd*k, [0;hf], k,     0, hf) );  % u control action - state axis  
        case 'psi'
            figure(i)
            subplot(2,2,1), impulse( ss( Ad-Bd*k, [0;hf], [1 0], 0, hf) );  % psi imp response
            subplot(2,2,2), impulse( ss( Ad-Bd*k, [0;hf], [0 1], 0, hf) );  % psi_dot imp response
            subplot(2,2,3), impulse( ss( Ad-Bd*k, [0;hf], k,     0, hf) );  % u control action - phi torque
    end

    clearvars A B  C D sysd Ad Bd Q R k
end

%% controller in matrix form

K.out.KPm = diag(K.out.KP);
K.out.KDm = diag(K.out.KD);

K.out.K = [ K.out.KP, K.out.KD ];

%%
clearvars m g Ix Iy Iz hf var i