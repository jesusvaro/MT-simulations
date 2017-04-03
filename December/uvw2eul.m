function [ euler_angles ] = uvw2eul( U, state )
%uvw2eul Computes the angular references necesaries for the refernces and
%       Torque provided.
%   Computes the angles phi and theta according to the references u, v, w
%   and Torque provided by the rotation matrix.
%       [u; v; w] = R(euler_angles) * [ 0; 0; T]
%           euler_angles = [phi, theta, psi] 
%               psi is known (state)

% Mathematical derivation of formulas in XXXX

% Inputs
    u_abs = U(1);   v_abs = U(2);   w_abs = U(3);
    Tpsi = U(4);
    psi = state(4);
    
% Torque
T = sqrt( u_abs^2 + v_abs^2 + w_abs^2 );

% normalization
u = u_abs/T;
v = v_abs/T;
w = w_abs/T;

% Euler angles

    % Considering w =! 0 (always true)
    %   Considering phi and theta are never 90º (iff w=!0)    

     % psi is a known value
        a = cos(psi);
        b = sin(psi);
    % compute phi & theta
    if ( u ~= 0 && v ~=0 )
        if ( a==0 )
            phi   = asinn( u/b );
            theta = atann( v/(w*b) );   
        elseif ( b==0 )
            phi   = asinn( -v/a );
            theta = atann( u/(w*a) );
        else
            aux = (u-v*w) / (b*(1+w));
            phi   = asinn( aux );
            theta = atann ( (u-b*aux) / (w*a) );
        end

    elseif ( u == 0 && v == 0 )
        phi   = 0;
        theta = 0;

    elseif ( u == 0 && v ~= 0 )
        if ( a==0 )
            phi   = 0;
            theta = atann ( v/(b*w) );
        elseif ( b==0 )
            phi   = asinn( -v/a );
            theta = 0;
        else
            phi   = asinn( -a*v );
            theta = atann( b*v/w );
        end

    elseif ( u ~=0 && v == 0 )
        if ( a==0 )
            phi   = asinn( u7b );
            theta = 0;
        elseif ( b==0 )
            phi   = 0;
            theta = atann( u/(a*w) );
        else 
            phi   = asinn( b*u );
            theta = atann( a*u/w);
        end
    else
        phi   = pi/3;
        theta = pi/3;  
    end

% % Validate results
%     % rotation matrix - only 3rd colum relevant
%     R = [ 0 0 cos(phi)*sin(theta)*cos(psi)+sin(phi)*sin(psi);
%           0 0 cos(phi)*sin(theta)*sin(psi)-sin(phi)*cos(psi);
%           0 0 cos(phi)*cos(theta)                            ];
%       
%     uvw_r = R * [0;0;T];
%     
%     u_TF = ( u-eps < uvw_r(1) < u+eps );
%     v_TF = ( v-eps < uvw_r(2) < v+eps );
%     w_TF = ( w-eps < uvw_r(3) < w+eps );
%     
%     if ~( u_TF && v_TF && w_TF )
%         disp('*** Phi and/or Theta not correct ***');
% %         return 
%     else
        euler_angles = [phi; theta; psi];
%     end

end


function [ angle ] = asinn( aa )
    angle = asin(aa);
    % angle correction
    if ~( -pi/2 < angle < pi/2 )
        angle = angle - pi/2;
    end
end

function [ angle ] = atann( aa )
    angle = atan(aa);
    % angle correction
    if ~( -pi/2 < angle < pi/2 )
        angle = angle - pi/2;
    end
end
