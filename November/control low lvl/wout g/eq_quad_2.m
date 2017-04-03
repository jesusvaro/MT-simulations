function dot_X = eq_quad_2 ( A )
% Computes the non-linear dynamics model of a quadcopter

% State
    x      = A(1);     Vx   = A(4);
    y      = A(2);     Vy   = A(5);
    z      = A(3);     Vz   = A(6);

    phi    = A(7);     p    = A(10);
    theta  = A(8);     q    = A(11);
    psi    = A(9);     r    = A(12);

% Inputs
    T  = A(13);      Tphi   = A(14);
                     Ttheta = A(15);
                     Tpsi   = A(16);
                
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
dot_X(6)  = -(T/m) * ( cos(phi)*cos(theta) ) + g;

dot_X(7)  = p + sin(phi)*tan(theta)*q + ( cos(phi)*tan(theta) )*r;
dot_X(8)  = cos(phi)*q - sin(phi)*r;
dot_X(9)  = ( sin(phi)/cos(theta) )*q + ( cos(phi)/cos(theta) )*r;

dot_X(10) = ( (Iy-Iz)/Ix )*r*q + Tphi   / Ix;
dot_X(11) = ( (Iz-Ix)/Iy )*p*r + Ttheta / Iy;
dot_X(12) = ( (Ix-Iy)/Iz )*p*q + Tpsi   / Iz;

% states as a column vector
dot_X = dot_X';
end