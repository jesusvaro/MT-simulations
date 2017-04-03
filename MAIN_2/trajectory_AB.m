% ----------------------------------------------------------------------
%   trajectory_AB
%       generates the state at the initial point A and the state at the
%       final point B
% ----------------------------------------------------------------------

% switch-case structure with the initial and end point in a trajectory

% state: ['x', 'y', 'z',  'phi', 'theta', 'psi',... 
% index   (1)  (2)  (3)   (4)    (5)      (6)     
%         'x_dot', 'y_dot', 'z_dot',  'phi_dot', 'theta_dot', 'psi_dot']
%         (7)      (8)      (9)       (10)       (11)         (12)

opt = 1;

switch opt
    case 1
        % first simulation of mahony
        StateIni = [ 0 0 0 0 0 0 0 0 0 0 0 0 ];
        StateFin = [ 1 -2 3 0 0 1 0 0 0 0 0 0 ];
    
    case 2

end


%%
% separate states for simulation

switch version
    case {'v1', 'v1_2', 'v1_3'}
        % Outer loop
        % vector state: ['x', 'y', 'z', 'psi']
        init.out     = [StateIni(1), StateIni(2), StateIni(3), StateIni(6)]';
        init.out_dot = [StateIni(7), StateIni(8), StateIni(9), StateIni(12)]';


        % Inner loop
        % vector state: ['phi', 'theta']
        init.in     = [StateIni(4), StateIni(5)]';
        init.in_dot = [StateIni(10), StateIni(11)]';

    case {'v2','v2_1','v2_2','v2_12'}
        init.full = StateIni;
        
end

%%
% separate states for trajectory generation
p_ini = [StateIni(1), StateIni(2), StateIni(3), StateIni(6)]';
p_fin = [StateFin(1), StateFin(2), StateFin(3), StateFin(6)]';