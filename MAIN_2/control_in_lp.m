% ---------------------------------------------------------------------
%   control_in_lp
%       compute the LQR controller for the simplified model of the
%       Euler angles of the quadcopter. This controller is aimed to be 
%       the inner loop controller
% ---------------------------------------------------------------------
%  close all, clear all, clc;

%% Parameters
addpath('G:\Masters Thesis\3.simulation\November');
parameters; global param
m  = param.m;    g = param.g;
Ix = param.Ix;  Iy = param.Iy;  Iz = param.Iz;
hs = param.hs;  hf = param.hf;

%% inner loop equations model
% [ phi_2dot        [ tau_phi/Ix
%   theta_2dot ]  =   tau_theta/Iy ]


% the dynamics of the inner loop equations model can be decoupled into 2 
%  decoupled system-models


disp(' K var     :  KP          KD');
disp(' ---------------------------------------------------------');

i=0; % loop secod counter
for var = {'phi', 'theta'}; i=i+1;
    % compute the LQR controller
    var = char(var);
    switch var
        case 'phi'
            % state variables: [ phi, phi_dot ]
            % decoupled model
            A = [ 0 1
                  0 0 ];
            B = [ 0; 1/Ix ];
            C = eye(2);
            D = 0;
            
            sysd = c2d( ss(A, B, C, D), hf);
            Ad = sysd.a; Bd = sysd.b;
            
            % LQR controller
            Q = diag( [5 0.05] ); R = 30;
            k = dlqr( Ad, Bd, Q, R );

        case 'theta'
            % state variables: [ theta, theta_dot ]
            % decoupled model
            A = [ 0 1
                  0 0 ];
            B = [ 0; 1/Iy ];
            C = eye(2);
            D = 0;
            
            sysd = c2d( ss(A, B, C, D), hf);
            Ad = sysd.a; Bd = sysd.b;
            
            % LQR controller
            Q = diag( [5 0.05] ); R = 30;
            k = dlqr( Ad, Bd, Q, R );
        
    end

    % store
    K.(sprintf('%s', strcat('K_', var)) ).K = k;
        K.(sprintf('%s', strcat('K_', var)) ).KP = k(1);
        K.(sprintf('%s', strcat('K_', var)) ).KD = k(2);
    K.in.KP(i) = k(1);
    K.in.KD(i) = k(2);
    
    % display
    disp(['  K ',var,'      :  ', num2str(k)])
    
    % plots
    switch var
        case 'phi'
            figure(i)
            subplot(2,2,1), impulse( ss( Ad-Bd*k, [0;hf], [1 0], 0, hf) );  % phi imp response
            subplot(2,2,2), impulse( ss( Ad-Bd*k, [0;hf], [0 1], 0, hf) );  % phi_dot imp response
            subplot(2,2,3), impulse( ss( Ad-Bd*k, [0;hf], k,     0, hf) );  % u control action - phi torque
            suptitle('Phi impulse resp')
        case 'theta'
            figure(i)
            subplot(2,2,1), impulse( ss( Ad-Bd*k, [0;hf], [1 0], 0, hf) );  % theta imp response
            subplot(2,2,2), impulse( ss( Ad-Bd*k, [0;hf], [0 1], 0, hf) );  % theta_dot imp response
            subplot(2,2,3), impulse( ss( Ad-Bd*k, [0;hf], k,     0, hf) );  % u control action - theta torque
            suptitle('Theta impulse resp')
    end

    clearvars A B C D sysd Ad Bd Q R k
end

%% controller in matrix form

K.in.KP = diag(K.in.KP);
K.in.KD = diag(K.in.KD);

K.in.K = [ K.in.KP, K.in.KD ];

%%
clearvars m g Ix Iy Iz hf var i
