% ---------------------------------------------------+
%   Parameters
% ---------------------------------------------------+

% turn structure into class so params cannot be changed¿?

global param
    % constants
    param.g = 9.80665;          % [m/s2]

    % Drone 
    param.Nstates = 12;

    % mechanical
    param.m  = 0.429;           % [kg]
    param.Ix = 0.0022375681;    % [kg·m2]
    param.Iy = 0.002985236;     % [kg·m2]
    param.Iz = 0.00480374;      % [kg·m2]

    % motors
    param.CT = 8.048e-6;      % thrust coefficient []
    param.L  = 0.1785;        % normal distance from motor to phi & theta angles [m], x config
    param.CQ = 2.423e-7;      % drag coefficient []
    
    param.CM = 0.025;
    param.pcoeff = [1.4878e-04 0.006931357945865 0.135415];
    
    % air resistance
        % Mahony & Hamel - table I
    param.QM = 0.002;
    param.QT = 0.0002;

    % sampling time
    param.hs = 1;         % guidance
    param.hf = 0.02;      % control

    % simulation
    param.h = 0.005;     % step simulation
    
        % saturation values
        param.sat.theta_r.max =  0.8;
        param.sat.theta_r.min = -0.8;
        param.sat.Ttheta.max  =  0.2;
        param.sat.Ttheta.min  = -0.2;
        
        param.sat.phi_r.max =  0.8;
        param.sat.phi_r.min = -0.8;
        param.sat.Tphi.max  =  0.2;
        param.sat.Tphi.min  = -0.2;
        
% disp(' *** Paramenters loaded *** ')
