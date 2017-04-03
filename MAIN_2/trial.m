% trial of uvw2eul in main_sys
%%
% given a control action-trajectory by out_u (with G)...
 trial_traj = u_inn.signals.values;

% ... and the state-psi out_state(4)
trial_state = out_state.signals.values;

%%
for i = 1:length(out_u.time)
     u_abs = trial_traj(i,1);
     v_abs = trial_traj(i,2);
     w_abs = trial_traj(i,3);
     psi = trial_state(i,4);
    
    
    % Torque
T = sqrt( u_abs^2 + v_abs^2 + w_abs^2 );

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
            phi   = asin( u/b );
            theta = 0;
        elseif ( b==0 )
            phi   = 0;
            theta = atan( u/(a*w) );
        else 
            phi   = asin( b/u );
            theta = atan( a*u/w);
        end
    else
        phi   = pi/3;
        theta = pi/3;  
    end

        euler_angles(i,:) = [phi; theta; psi];

end

%% verification
[N_euler_angles,~] = size(euler_angles);
uvw_rel = zeros(N_euler_angles,3); 
uvw_rel2 = zeros(N_euler_angles,3); 
for i = 1:N_euler_angles
    N_phi   = euler_angles(i,1);
    N_theta = euler_angles(i,2);
    N_psi   = euler_angles(i,3);
    
    R = [ 0, 0, cos(N_phi)*sin(N_theta)*cos(N_psi)+sin(N_phi)*sin(N_psi);
          0, 0, cos(N_phi)*sin(N_theta)*sin(N_psi)-sin(N_phi)*cos(N_psi);
          0, 0, cos(N_phi)*cos(N_theta)                                 ];
     
    R2 = eul2rotm( [N_psi, N_theta, N_phi] ) ;

    uvw_rel(i,:) = R * [0;0;T];
    uvw_rel2(i,:) = R2 * [0;0;T];
end



%%
figure()
subplot(2,2,1),
    plot(out_u.time, euler_angles(:,1) ), title('phi')
subplot(2,2,2),
    plot(out_u.time, euler_angles(:,2) ), title('theta')
subplot(2,2,3),
    plot(out_u.time, euler_angles(:,3) ), title('psi')
    
    
figure()
subplot(2,2,1),
    plot(out_u.time, trial_traj(:,1) ), %u_abs
    hold on,
    plot(out_u.time, uvw_rel(:,1) ),    %u 
    plot(out_u.time, uvw_rel2(:,1) ),
    title('u')
subplot(2,2,2),
    plot(out_u.time, trial_traj(:,2) ),
    hold on
    plot(out_u.time, uvw_rel(:,2) ),
    plot(out_u.time, uvw_rel2(:,2) ),
    title('v')
subplot(2,2,3),
    plot(out_u.time, trial_traj(:,3) ),
    hold on,
    plot(out_u.time, uvw_rel(:,2) ),
    plot(out_u.time, uvw_rel2(:,2) ),
    title('w')
    

figure()
subplot(2,2,1),
    plot(out_u.time, trial_traj(:,1) ), %u_abs
    hold on,
    plot(out_u.time, uvw_rel(:,1) ),    %u 
    plot(out_u.time, uvw_rel2(:,1) ),
    title('u')
subplot(2,2,2),
    plot(out_u.time, trial_traj(:,2) ),
    hold on
    plot(out_u.time, uvw_rel(:,2) ),
    plot(out_u.time, uvw_rel2(:,2) ),
    title('v')
subplot(2,2,3),
    plot(out_u.time, trial_traj(:,3) ),
    hold on,
    plot(out_u.time, uvw_rel(:,2) ),
    plot(out_u.time, uvw_rel2(:,2) ),
    title('w')
    
    