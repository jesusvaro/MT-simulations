% -----------------------------------------------------
%   MAIN
% 
% -----------------------------------------------------
close all, clear all, clc;

% include parameters & functions
    root = 'G:\Masters Thesis\3.simulation';
    addpath([root, '\November']);                 % parameters
    addpath([root, '\November\reference']);       % trajectory generation
    addpath('G:\Masters Thesis\3.simulation\December');
    addpath('G:\Masters Thesis\3.simulation\December\Outer loop control');
    
% Simulation
    Tfin = 50;        % simulation time
    parameters; global param;
    hs = param.hs;  % sampling time - guidance
    hf = param.hf;  % sampling time - control
    
    Ns = floor(Tfin/hs);   % rate # of trajectories generated
    Nf = floor(hs/hf);     % rate # of low lvl control references
                           % trajectory is considered in Ns or Nf points,
                           %  if any time is left it is not considered at
                           %  this level of control. (->hover time)
  
                           % trajectory_v1 ->ok
trajectory_v1;

    addpath('G:\Masters Thesis\3.simulation\December\Outer loop control');
control_out_lp
    close all, clc;
    % call the controller too!
    
% trajectory generation
    % se lee una trayectoria guardada en el workspace (q ha sido genereda
    %  previamente por otro programa)
    % ...por ahorase genera una trayectoria muy simple
   
% diseñar controlador: P? o PD? PD
    % este con¡trolador no equivaldria al de mahony?+¡rolador d bajo nivel..al PD?
    
 %% SIMULATION
 clc;
 
 % initial states
 init_state     = [ p_ini ]';
 init_state_dot = [ 0 0 0 0 ]';
 
%  open('model_smpl');
 
 sim('model_smpl');
 

 
 
 %% PLOTS
 
 variables={'x', 'y', 'z', 'psi'};
 
 % state vs reference
 figure(1), 
 j=0;
 for i = variables, vars = char(i); j=j+1;
     subplot(2,2,j), 
        plot( traj.time, traj.signals.values(:,j) )             % ref
        hold on;
        plot ( out_state.time, out_state.signals.values(:,j) )  % state
        hold off;
        title( strcat(vars, ' axis') ),
        xlim([traj.time(1), traj.time(end)])
 end
 suptitle('State vs. Ref')
 
 % sates_dot vs ref_dot
 figure(2), 
 j=0;
 for i = variables, vars = char(i); j=j+1;
     subplot(2,2,j), 
        plot( t_s, trajec.(sprintf('%s', vars))(2,:) );             % ref_dot
        hold on;
        plot ( out_state.time, out_state_dot.signals.values(:,j) )  % state_dot
        hold off;
        title( strcat(vars, ' axis') ),
        xlim([t_s(1), t_s(end)])
 end
 suptitle('State dot vs. Ref dot')
 
 % Control actions
 figure(3)
 j=0;
 for i = variables, vars = char(i); j=j+1;
    subplot(2,2,j),
        plot( out_u_mac.time, out_u_mac.signals.values(:,j) );      % control action
        title( strcat(vars, ' control action') ),
        xlim([out_u_mac.time(1), out_u_mac.time(end)])     
 end
 suptitle('Control Actions')
 
 
  % sates_2dot vs ref_2dot
 figure(4)
 j=0;
 for i = variables, vars = char(i); j=j+1;
     subplot(2,2,j), 
        plot( t_s, trajec.(sprintf('%s', vars))(3,:) );             % ref_2dot
        hold on;
        plot ( out_state.time, out_state_2dot.signals.values(:,j) )  % state_2dot
        hold off;
        title( strcat(vars, ' axis') ),
        xlim([t_s(1), t_s(end)])   
 end
suptitle('State 2dot vs. Ref 2dot')
 
% 
% figure();
% plot( traj.time, traj.signals.values(:,1) );
%      hold on;
% plot ( out_state.time, out_state.signals.values(:,1) )

%% inner loop
 close all,
 
 % trajectory
  % u_des - out_u
    u_des.time = out_u.time;
    u_des.signals = out_u.signals;
 % state_out_in - out_state
    state_out_in.time = out_state.time;
    state_out_in.signals = out_state.signals;
 
 % controller
 addpath('G:\Masters Thesis\3.simulation\December\inner loop control')
 control_in_lp
 close all;


 %% SIM inner loop
 
 % initial states
 init_in = [0;0];
 init_in_dot = [0;0];
 %%
 sim('model_inner');

 %% PLOT inner loop
 
 variables1={'u','v','w','Tpsi'};
 
 % state vs reference
 figure(1), 
 j=0;
 for i = variables1, vars = char(i); j=j+1;
     subplot(2,2,j), 
        plot( u_des.time, u_des.signals.values(:,j) )             % ref
        hold on;
        plot ( in_state.time, in_state.signals.values(:,j) )  % state
        hold off;
        title( strcat(vars, ' angle') ),
        xlim([u_des.time(1), u_des.time(end)])
 end
 suptitle('U-state vs. U-ref')
 
 
 variables2={'phi', 'theta'};
  % state vs reference
 figure(2), 
 j=0;
 for i = variables2, vars = char(i); j=j+1;
     subplot(2,1,j), 
        plot( u_ref_B.time, u_ref_B.signals.values(:,j) )   % ref
        hold on;
        plot ( state_B.time, state_B.signals.values(:,j) )  % state
        hold off;
        title( strcat(vars, ' angle') ),
        xlim([u_ref_B.time(1), u_ref_B.time(end)])
 end
 suptitle('U-state B vs. U-ref B')

 
 
 
 