% trial of uvw2eul
%%
% given a control action-trajectory by out_u (with G)...
 trial_traj = out_u.signals.values;

% ... and the state-psi out_state(4)
trial_state = out_state.signals.values;

%%
for i = 1:length(out_u.time)
     u_abs = trial_traj(i,1);
     v_abs = trial_traj(i,2);
     w_abs = trial_traj(i,3);
     psi = trial_state(i,4);
    
    
    % Torque
T = sqrt( u^2 + v^2 + w^2 );

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
            phi   = asin( u/b );
            theta = atan( v/(w*b) );   
        elseif ( b==0 )
            phi   = asin( -v/a );
            theta = atan( u/(w*a) );
        else
            aux = (u-v*w) / (b*(1+w));
            phi   = asin( aux );
            theta = atan ( (u-b*aux) / (w*a) );
        end

    elseif ( u == 0 && v == 0 )
        phi   = 0;
        theta = 0;

    elseif ( u == 0 && v ~= 0 )
        if ( a==0 )
            phi   = 0;
            theta = atan ( v/(b*w) );
        elseif ( b==0 )
            phi   = asin( -v/a );
            theta = 0;
        else
            phi   = asin( -a*v );
            theta = atan( b*v/w );
        end

    elseif ( u ~=0 && v == 0 )
        if ( a==0 )
            phi   = asin( b*u );
            theta = 0;
        elseif ( b==0 )
            phi   = 0;
            theta = atan( u/(a*w) );
        else 
            phi   = asin( b*u );
            theta = atan( a*u/w);
        end
    else
        phi   = pi/3;
        theta = pi/3;  
    end

        euler_angles(:,i) = [phi; theta; psi];

end


%%
figure()
subplot(2,2,1),
    plot(out_u.time, euler_angles(1,:) ), title('phi')
subplot(2,2,2),
    plot(out_u.time, euler_angles(2,:) ), title('theta')
subplot(2,2,3),
    plot(out_u.time, euler_angles(3,:) ), title('psi')