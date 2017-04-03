% design of the controller PD constants by LQR-control

% the model used are the linerised equations of the quadcopter.
% the equations obtained can be decoupled into 4 subsystemsd.
% a PD controller will be designed for each of the subsystems

% subsystems:
% 1 z, z_dot                   -> altitude control           - thrust
% 2 psi, psi_dot               -> yaw control                - torque_psi
% 3 x, x_dot, theta, theta_dot -> longitudinal/pitch control - torque_theta
% 4 y, y_dot, phi, phi_dot     -> lateral/roll control       - torque_phi

%%
close all, clc;

%% Parameters
addpath('G:\Masters Thesis\3.simulation\November');
parameters; global param
m  = param.m;    g = param.g;
Ix = param.Ix;  Iy = param.Iy;  Iz = param.Iz;
hs = param.hs;

%%
disp(' K var     :  KP          KD');
disp(' ---------------------------------------------------------');

for opt = 1:4
    switch opt
        case 1  % ALTITUDE Control - Thrust
            % state: [z, z_dot]'
            A = [ 0  1
                  0  0];
            B = [ 0 -1/m]'; 

            sysd = c2d( ss(A,B,eye(2),0), hs);
            Ad = sysd.a;  Bd = sysd.b;

            Q = eye(2); R = 0.1;
            k = dlqr( Ad, Bd, Q, R );

            figure(opt)
            subplot(2,2,1), impulse( ss( Ad-Bd*k, [0;hs], [1 0], 0, hs) );  % z imp response
            subplot(2,2,2), impulse( ss( Ad-Bd*k, [0;hs], [0 1], 0, hs) );  % z_dot imp response
            subplot(2,2,3), impulse( ss( Ad-Bd*k, [0;hs], k,     0, hs) );  % u control action - thrust
            
            K.k_z.K  = k;
            K.k_z.KP = k(1);
            K.k_z.KD = k(2);

            disp(['  K Z      :  ',num2str(k)]) 

        case 2  % YAW Control - Torque Psi
            % state: [psi, psi_dot]'
            A = [ 0 1
                  0 0];
            B = [ 0 1/Iz]'; 

            sysd = c2d( ss(A,B,eye(2),0), hs);
            Ad = sysd.a;  Bd = sysd.b;

            Q = eye(2); R = 100;
            k = dlqr( Ad, Bd, Q, R );

            figure(opt)
            subplot(2,2,1), impulse( ss( Ad-Bd*k, [0;hs], [1 0], 0, hs) );  % psi imp response
            subplot(2,2,2), impulse( ss( Ad-Bd*k, [0;hs], [0 1], 0, hs) );  % psi_dot imp response
            subplot(2,2,3), impulse( ss( Ad-Bd*k, [0;hs], k,     0, hs) );  % u control action - torque psi

            K.k_psi.K  = k;
            K.k_psi.KP = k(1);
            K.k_psi.KD = k(2);

            disp(['  K Psi    :  ',num2str(k)])          

        case 3  % LONGITUDINAL / PITCH control - Torque Theta
            % state: [x, x_dot, theta, theta_dot]'
            A = [ 0   1    0   0
                  0   0 -m*g   0
                  0   0    0   1
                  0   0    0   0];
            B = [ 0   0    0   1/Iy ]';

            sysd = c2d(ss(A,B,eye(4),0),hs); 
            Ad = sysd.a; Bd = sysd.b;

            Q = diag( [ 1 0.1 0.1 0.1 ] ); R = 10;
            k = dlqr( Ad, Bd, Q, R );

            figure(opt)
            subplot(3,2,1), impulse( ss( Ad-Bd*k, [0;0;0;hs], [1 0 0 0], 0, hs) )   % x imp response
            subplot(3,2,2), impulse( ss( Ad-Bd*k, [0;0;0;hs], [0 1 0 0], 0, hs) )   % x_dot imp response
            subplot(3,2,3), impulse( ss( Ad-Bd*k, [0;0;0;hs], [0 0 1 0], 0, hs) )   % theta imp response
            subplot(3,2,4), impulse( ss( Ad-Bd*k, [0;0;0;hs], [0 0 0 1], 0, hs) )   % theta_dot imp response
            subplot(3,2,5), impulse( ss( Ad-Bd*k, [0;0;0;hs], k,         0, hs) )   % u control action - torque theta

            K.k_xtheta.K = k;
            K.k_x.KP     = k(1);
            K.k_x.KD     = k(2);
            K.k_theta.KP = k(3);
            K.k_theta.KD = k(4);

            disp('   K X_Theta')
            disp(['  K X     :  ',num2str( k(1:2) )])
            disp(['  K Theta :  ',num2str( k(3:4) )])

        case 4  % LATERAL / ROLL control - Torque phi
            % state: [y, y_dot, phi, phi_dot]'
            A = [ 0   1   0   0
                  0   0 m*g   0
                  0   0   0   1
                  0   0   0   0];
            B = [ 0   0   0   1/Ix ]';

            sysd = c2d( ss(A,B,eye(4),0), hs); 
            Ad = sysd.a; Bd = sysd.b;

            Q = diag( [ 1 0.1 0.1 0.1 ] ); R = 10;
            k = dlqr( Ad, Bd, Q, R );

            figure(opt)
            subplot(3,2,1), impulse( ss( Ad-Bd*k, [0;0;0;hs], [1 0 0 0], 0, hs) )   % y imp response
            subplot(3,2,2), impulse( ss( Ad-Bd*k, [0;0;0;hs], [0 1 0 0], 0, hs) )   % y_dot imp response
            subplot(3,2,3), impulse( ss( Ad-Bd*k, [0;0;0;hs], [0 0 1 0], 0, hs) )   % phi imp response
            subplot(3,2,4), impulse( ss( Ad-Bd*k, [0;0;0;hs], [0 0 0 1], 0, hs) )   % phi_dot imp response
            subplot(3,2,5), impulse( ss( Ad-Bd*k, [0;0;0;hs], k,         0, hs) )   % u control action - torque phi


            K.k_yphi.K = k;
            K.k_y.KP   = k(1);
            K.k_y.KD   = k(2);
            K.k_phi.KP = k(3);
            K.k_phi.KD = k(4);

            disp('   K Y_Phi')
            disp(['  K Y     :  ',num2str( k(1:2) )])
            disp(['  K Phi   :  ',num2str( k(3:4) )])


    end
clearvars A B sysd Ad Bd Q R k

end

clearvars m g Ix Iy Iz hs opt
