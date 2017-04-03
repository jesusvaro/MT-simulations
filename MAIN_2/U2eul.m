function [ eul, T, Tpsi ] = U2eul( U, state )
% Mathematical derivation of formulas in XXXX
% control and coordination algorithms for autonomous multi_agent quadrotor
% systems - B.C.M. van Aert

% parameters m = 0.429;
global param

% Inputs
    u_abs = U(1);   v_abs = U(2);   w_abs = U(3);
    Tpsi = U(4);
    psi = state(4);
    
% Torque
T = sqrt( u_abs^2 + v_abs^2 + w_abs^2 );

% normalization of thrust components
u = u_abs/param.m;
v = v_abs/param.m;
w = w_abs/param.m;

% Euler angles

    % Considering w =! 0 (always true)
    %   Considering phi and theta are never 90º (iff w=!0)    

     % psi is a known value
        a = cos(psi);
        b = sin(psi);

    % compute phi & theta
    phi = asin( (v*a - u*b) / (T/param.m)  );
    
    theta = atan( (u*a + v*b) / w );
    
    eul = [phi; theta; psi];
end


