% PLOTS

%
switch version
    case {'v1', 'v1_2', 'v1_3'}
        % simplified model
        FIN.time = out_state.time;
        
        FIN.state.x     = out_state.signals.values(:,1);
        FIN.state.y     = out_state.signals.values(:,2);
        FIN.state.z     = out_state.signals.values(:,3);
        FIN.state.phi   = in_state.signals.values(:,1);
        FIN.state.theta = in_state.signals.values(:,2);
        FIN.state.psi   = out_state.signals.values(:,4);

        FIN.state_dot.x     = out_state_dot.signals.values(:,1);
        FIN.state_dot.y     = out_state_dot.signals.values(:,2);
        FIN.state_dot.z     = out_state_dot.signals.values(:,3);
        FIN.state_dot.phi   = in_state_dot.signals.values(:,1);
        FIN.state_dot.theta = in_state_dot.signals.values(:,2);
        FIN.state_dot.psi   = out_state_dot.signals.values(:,4);
        
        U.time = out_u.time;
        U.Tu   = out_u.signals.values(:,1);
        U.Tv   = out_u.signals.values(:,2);
        U.Tw   = out_u.signals.values(:,3);
        U.Tpsi = out_u.signals.values(:,4);

    case {'v2','v2_1','v2_12','v2_2'}
        % full state model
        FIN.time = state_sim.time;
        
        FIN.state.x     = state_sim.signals.values(:,1);
        FIN.state.y     = state_sim.signals.values(:,2);
        FIN.state.z     = state_sim.signals.values(:,3);
        FIN.state.phi   = state_sim.signals.values(:,7);
        FIN.state.theta = state_sim.signals.values(:,8);
        FIN.state.psi   = state_sim.signals.values(:,9);

        FIN.state_dot.x     = state_sim.signals.values(:,4);
        FIN.state_dot.y     = state_sim.signals.values(:,5);
        FIN.state_dot.z     = state_sim.signals.values(:,6);
        FIN.state_dot.phi   = state_sim.signals.values(:,10);
        FIN.state_dot.theta = state_sim.signals.values(:,11);
        FIN.state_dot.psi   = state_sim.signals.values(:,12);
        
        U.time   = u_sim.time;
        U.T      = u_sim.signals.values(:,1);
        U.Tphi   = u_sim.signals.values(:,2);
        U.Ttheta = u_sim.signals.values(:,3);
        U.Tpsi   = u_sim.signals.values(:,4);
end


%%
% states
switch version
    case {'v1', 'v1_2', 'v1_3'}
        figure();
        
        subplot(3,2,1),
            plot(FIN.time, FIN.state.x), title('x')
            hold on,
        % subplot(6,2,2),    
            plot( traj.time(1:Tfin+1), trajec.x(1,(1:Tfin+1)) )


        subplot(3,2,3),
            plot(FIN.time, FIN.state.y),title('y')
                hold on,
        % subplot(6,2,4),    
            plot( traj.time(1:Tfin+1), trajec.y(1,(1:Tfin+1)) )


        subplot(3,2,5),
            plot(FIN.time, FIN.state.z),title('z')
                hold on,
        % subplot(6,2,6),    
            plot( traj.time(1:Tfin+1), trajec.z(1,(1:Tfin+1)) )

%         subplot(3,2,2),
%             plot(FIN.time, FIN.state.phi),title('phi'),
%             %hold on
%          %subplot(3,2,1),    
           % plot( casee_angles.time, casee_angles.signals.values(:,1)*180/pi )

%         subplot(3,2,4),
%             plot(FIN.time, FIN.state.theta),title('theta'),
%          %   hold on,
%          %subplot(6,2,10),    
%             %plot( casee_angles.time, casee_angles.signals.values(:,2)*180/pi )

        subplot(3,2,6),
            plot(FIN.time, FIN.state.psi),title('psi')
               hold on,
               plot( traj.time(1:Tfin+1), trajec.psi(1,(1:Tfin+1)) )
        %subplot(6,2,12),    
          %  plot( traj.time(1:Tfin+1), trajec.psi(1,(1:Tfin+1))*180/pi )
          
          figure();  %states_dot
          subplot(3,2,1),
            plot(FIN.time, FIN.state_dot.x), title('x.dot')
            hold on,  
            plot( traj.time(1:Tfin+1), trajec.x(2,(1:Tfin+1)) )

        subplot(3,2,3),
            plot(FIN.time, FIN.state_dot.y),title('y.dot')
            hold on,    
            plot( traj.time(1:Tfin+1), trajec.y(2,(1:Tfin+1)) )

        subplot(3,2,5),
            plot(FIN.time, FIN.state_dot.z),title('z.dot')
            hold on,
            plot( traj.time(1:Tfin+1), trajec.z(2,(1:Tfin+1)) )

%         subplot(3,2,2),
%             plot(FIN.time, FIN.state_dot.phi),title('phi.dot'),
% 
%         subplot(3,2,4),
%             plot(FIN.time, FIN.state_dot.theta),title('theta.dot'),

        subplot(3,2,6),
            plot(FIN.time, FIN.state_dot.psi),title('psi.dot')
            hold on,
            plot( traj.time(1:Tfin+1), trajec.psi(2,(1:Tfin+1)) )
    
    case {'v2','v2_1','v2_12'}
        figure();   % states
        
        subplot(3,2,1),
            plot(FIN.time, FIN.state.x), title('x')
            hold on,  
            plot( traj.time(1:Tfin+1), trajec.x(1,(1:Tfin+1)) )

        subplot(3,2,3),
            plot(FIN.time, FIN.state.y),title('y')
            hold on,    
            plot( traj.time(1:Tfin+1), trajec.y(1,(1:Tfin+1)) )

        subplot(3,2,5),
            plot(FIN.time, FIN.state.z),title('z')
            hold on,
            plot( traj.time(1:Tfin+1), trajec.z(1,(1:Tfin+1)) )

        subplot(3,2,2),
            plot(FIN.time, FIN.state.phi),title('phi'),

        subplot(3,2,4),
            plot(FIN.time, FIN.state.theta),title('theta'),

        subplot(3,2,6),
            plot(FIN.time, FIN.state.psi),title('psi'),
            hold on,
            plot( traj.time(1:Tfin+1), trajec.psi(1,(1:Tfin+1)) )
            
        figure();   % states_dot
        
        subplot(3,2,1),
            plot(FIN.time, FIN.state_dot.x), title('x.dot')
            hold on,  
            plot( traj.time(1:Tfin+1), trajec.x(2,(1:Tfin+1)) )

        subplot(3,2,3),
            plot(FIN.time, FIN.state_dot.y),title('y.dot')
            hold on,    
            plot( traj.time(1:Tfin+1), trajec.y(2,(1:Tfin+1)) )

        subplot(3,2,5),
            plot(FIN.time, FIN.state_dot.z),title('z.dot')
            hold on,
            plot( traj.time(1:Tfin+1), trajec.z(2,(1:Tfin+1)) )

        subplot(3,2,2),
            plot(FIN.time, FIN.state_dot.phi),title('phi.dot'),

        subplot(3,2,4),
            plot(FIN.time, FIN.state_dot.theta),title('theta.dot'),

        subplot(3,2,6),
            plot(FIN.time, FIN.state_dot.psi),title('psi.dot')
            hold on,
            plot( traj.time(1:Tfin+1), trajec.psi(2,(1:Tfin+1)) )
            
        case {'v2_2'}
        figure();   % states
        
        subplot(3,2,1),
            plot(FIN.time, FIN.state.x), title('x')
            hold on,  
            plot( traj_2.time(1:Tfin+1), traj_2.signals.values(1:(Tfin+1),1 ) )

        subplot(3,2,3),
            plot(FIN.time, FIN.state.y),title('y')
            hold on,    
            plot( traj_2.time(1:Tfin+1), traj_2.signals.values(1:(Tfin+1),2 ) )

        subplot(3,2,5),
            plot(FIN.time, FIN.state.z),title('z')
            hold on,
            plot( traj_2.time(1:Tfin+1), traj_2.signals.values(1:(Tfin+1),3 ) )

        subplot(3,2,2),
            plot(FIN.time, FIN.state.phi),title('phi'),

        subplot(3,2,4),
            plot(FIN.time, FIN.state.theta),title('theta'),

        subplot(3,2,6),
            plot(FIN.time, FIN.state.psi),title('psi'),
            hold on,
            plot( traj_2.time(1:Tfin+1), traj_2.signals.values(1:(Tfin+1),4 ) )
            
        figure();   % states_dot
        
        subplot(3,2,1),
            plot(FIN.time, FIN.state_dot.x), title('x.dot')
            hold on,  
            plot( traj_2.time(1:Tfin+1), traj_2.signals.values(1:(Tfin+1),5 ) )

        subplot(3,2,3),
            plot(FIN.time, FIN.state_dot.y),title('y.dot')
            hold on,    
            plot( traj.time(1:Tfin+1), traj_2.signals.values(1:(Tfin+1),6 ) )

        subplot(3,2,5),
            plot(FIN.time, FIN.state_dot.z),title('z.dot')
            hold on,
            plot( traj.time(1:Tfin+1), traj_2.signals.values(1:(Tfin+1),7 ) )

        subplot(3,2,2),
            plot(FIN.time, FIN.state_dot.phi),title('phi.dot'),

        subplot(3,2,4),
            plot(FIN.time, FIN.state_dot.theta),title('theta.dot'),

        subplot(3,2,6),
            plot(FIN.time, FIN.state_dot.psi),title('psi.dot')
            hold on,
            plot( traj_2.time(1:Tfin+1), traj_2.signals.values(1:(Tfin+1),8 ) )
        
        
end


%%
% control actions
switch version
    case 'v1'
        figure() ,   %cartesian
        subplot(2,2,1),
            plot(U.time, U.Tu), title('Tu')
        subplot(2,2,2),
            plot(U.time, U.Tv), title('Tv')
        subplot(2,2,3),
            plot(U.time, U.Tw), title('Tw')
        subplot(2,2,4),
            plot(U.time, U.Tu), hold on,
            plot(U.time, U.Tv),
            plot(U.time, U.Tw),
            plot(U.time, sqrt(U.Tu.^2 + U.Tv.^2 + U.Tw.^2) ),
            hold off, title('Thrust')
        
    case 'v2'
        figure();   % control action
        subplot(2,2,1),
            plot(U.time, U.T),      title('Thrust')
        subplot(2,2,2),
            plot(U.time, U.Tphi),   title('T Phi')
        subplot(2,2,3),
            plot(U.time, U.Ttheta), title('T Theta')
        subplot(2,2,4),
            plot(U.time, U.Tpsi),   title('T Psi')
    
end
    
    