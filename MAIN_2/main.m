% create the model

% generate the general trajectory

% call both controllers
    % outer loop controller
    % inner loop controller - maybe put less constrain over u when lqr?¿
    
% run simulation
    
% plot everything!!!!
    % state (vs ref)
    % state_dot (vs ref)
    % control action
    
clc, close all, clear all

%% VERSION

version = 'v1'; 


%% MAIN

% call parameters
parameters
    disp('** Parameters loaded **')
% simulation time
Tfin = 50;

%%
% call trajectory generation
     % initial and final states
     trajectory_AB
     disp('** Initial and Final point loaded **')
     % trajectory generation
     trajectory_gen
     disp('** Trajectory generated **')

%%
% call controllers
    % Outer & inner loop controllers
switch version
    case {'v1', 'v1_3'}
       control_out_lp
            disp('** Outer loop controller loaded **')
       control_in_lp
            disp('** Inner loop controller loaded **')
    case 'v1_2'
       control_out_lp_v1_2
            disp('** Outer loop controller loaded **')
       control_in_lp
            disp('** Inner loop controller loaded **')
    case {'v2', 'v2_1', 'v2_2','v2_12'}
        PD_constants
end

global K1
    K1 = K;
    
close all %, clc
%% SIMULATION
addpath('G:\Masters Thesis\3.simulation\MAIN_2\model');

    disp('** Loading simulation **')

    disp([' ---Version ',version,'---'])
switch version
    case 'v1'
        % decoupled linear model separated in:
        %   · outer loop: position and psi
        %   · inner loop: attitude
        % outer and inner loop controllers ar PD
        sys = 'trial_main_sys_v1';
        
        case 'v1_2'
            % like v1 with mods:
            %   · Z is considered 'down' (change in control outer loop
            %   controller
            %   · desired phi and theta computed by another algorithm
            sys = 'main_sys_v1_2';
                %-> problem with initiation
         case 'v1_3'
            % like v1 with mods:
            %   · U2eul: other project. doesnt work
            sys = 'main_sys_v1_3';
    case 'v2'
        % linear non-coupled model
        % 1 control loop
        % state: full state (position, attitude, and its derivatives)
        % # se inestabiliza al final, por parte de: x, y, phi y theta.
        % #  -> porbar con: referencia de velocidad, o introducir param.h n
        %       la simu
        sys = 'main_sys_v2';
        case 'v2_1'
            % like v2 with mods:
            %   · modified controller: change of base modified
            % % no improvement: full change of base unnecessary - causes error
            sys = 'main_sys_v2_1';
            case 'v2_12'
                % like v2_1 with mods:
                %   · with velocity reference
                % % no improvement: probably same error as in v2_1
                sys = 'main_sys_v2_12';
        case 'v2_2'
            % like v2 with mods:
            %   · linear model
            %   · normal  bas modification
            
            sys = 'main_sys_v2_2';
            case 'v2_22'
                % like v2_2 with mods:
                %   · with non-linear model
                sys = 'main_sys_v2_22';
    case 'v2_3'
        % like v2 with velocity reference
    % v3 -> fix v2 problem with unstabilized ending of simulation
    %   try: change controller for constants for phi&theta: put a lower
    %   contraint over action and bigger constraints over state!!
    
    % v4 -> RE-DO: everuthing with hs or hf!!!!!
    % v5 -> introduce discrete loop with the correct timing!! 
        

end
%open(sys)
sim(sys)
    disp('** Simulation completed **')

%%
switch version
    case 'v1'
    sim('trial_main_sys_v1_in'),
        disp('** Simulation sys-in completed **')
end


%% PLOTS
    disp('** Ploting results **')
plotss
              
              