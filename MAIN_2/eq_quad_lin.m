function dot_x = eq_quad_lin( X, U )
% Computes the linearized dynamics model of a quadcopter

% State
    x      = X(1);     Vx   = X(4);
    y      = X(2);     Vy   = X(5);
    z      = X(3);     Vz   = X(6);

    phi    = X(7);     p    = X(10);
    theta  = X(8);     q    = X(11);
    psi    = X(9);     r    = X(12);

% Inputs
    T  = U(1);       Tphi   = U(2);
                     Ttheta = U(3);
                     Tpsi   = U(4);
                
% Paramenters
    global param
    m  = param.m;    g  = param.g;
    Ix = param.Ix;   Iy = param.Iy;  Iz = param.Iz;
    
% Equations
dot_x(1)  = Vx;
dot_x(2)  = Vy;
dot_x(3)  = Vz;

dot_x(4)  = -(T/m) * ( theta );
dot_x(5)  = +(T/m) * ( phi );
dot_x(6)  = -(T/m) + g;

dot_x(7)  = p;
dot_x(8)  = q;
dot_x(9)  = r;

dot_x(10) = Tphi   / Ix;
dot_x(11) = Ttheta / Iy;
dot_x(12) = Tpsi   / Iz;

end

