function dot_X = eq_quad ( X, U )
% Computes the non-linear dynamics model of a quadcopter

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
    m  = param.m;    g = param.g;
    Ix = param.Ix;  Iy = param.Iy;  Iz = param.Iz;

    
% Equations
dot_X(1)  = Vx;
dot_X(2)  = Vy;
dot_X(3)  = Vz;

dot_X(4)  = -(T/m) * ( sin(theta)*sin(psi) + cos(phi)*sin(theta)*cos(psi) );
dot_X(5)  = -(T/m) * ( cos(phi)*sin(theta)*sin(psi) - sin(phi)*cos(psi) );
dot_X(6)  = -(T/m) * ( cos(phi)*cos(theta) ) + 0;

dot_X(7)  = p + sin(phi)*tan(theta)*q + ( cos(phi)*tan(theta) )*r;
dot_X(8)  = cos(phi)*q - sin(phi)*r;
dot_X(9)  = ( sin(phi)/cos(theta) )*q + ( cos(phi)/cos(theta) )*r;

dot_X(10) = ( (Iy-Iz)/Ix )*r*q + Tphi   / Ix;
dot_X(11) = ( (Iz-Ix)/Iy )*p*r + Ttheta / Iy;
dot_X(12) = ( (Ix-Iy)/Iz )*p*q + Tpsi   / Iz;

% states as a column vector
dot_X = dot_X';
end