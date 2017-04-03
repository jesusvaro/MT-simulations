function [ U ] = PDv2control( Error, State )
%#codegen
%PDV2CONTROL 
    % Compute the control action U = (T, Tphi, Ttheta, Tpsi) from the 
    %   error of a full state feedbacK1.
    % the implemented controller has a structure of 4 PD controllers, each
    %  one for each subsytem: 'z', 'psi', 'x-theta', 'y-phi'
    
    % feedforward control...g is considered FF?
    
% Inputs
    % Error = Ref - State
    x_e = Error(1);       x_dot_e = Error(4);
    y_e = Error(2);       y_dot_e = Error(5);
    z_e = Error(3);       z_dot_e = Error(6);

    phi_e   = Error(7);   phi_dot_e   = Error(10);
    theta_e = Error(8);   theta_dot_e = Error(11);
    psi_e   = Error(9);   psi_dot_e   = Error(12);
    
    % State
    x = State(1);       x_dot = State(4);
    y = State(2);       y_dot = State(5);
    z = State(3);       z_dot = State(6);

    phi   = State(7);   phi_dot   = State(10);
    theta = State(8);   theta_dot = State(11);
    psi   = State(9);   psi_dot   = State(12);    

% Parameters & constants
    global K1
    global param
        m = param.m;
        g = param.g;

% change of base
    % Rotation 
    R = [ cos(psi), -sin(psi);
          sin(psi),  cos(psi) ];

    xy_e     = R * [x_e; y_e];
    xy_dot_e = R * [x_dot_e; y_dot_e];
    
% Controller
    % Torque  - subsystem 'z'
    T_d = K1.k_z.KP * z_e + K1.k_z.KD * z_dot_e;
    T = T_d + m*g;
    % Tpsi   - subsytem 'psi'
    Tpsi = K1.k_psi.KP * psi_e + K1.k_psi.KD * psi_dot_e;
    % Tphi   - subsytem 'y-phi'
    Tphi = ( K1.k_y.KP * xy_e(2) + K1.k_y.KD * xy_dot_e(2) ) +...
             K1.k_phi.KP * phi_e + K1.k_phi.KD * phi_dot_e;
    % Ttheta - subsytem 'x-theta'
    Ttheta = ( K1.k_x.KP * xy_e(1) + K1.k_x.KD * xy_dot_e(1) ) +...
               K1.k_theta.KP * theta_e + K1.k_theta.KD * theta_dot_e;

U  = [ T, Tphi, Ttheta, Tpsi ];
end

