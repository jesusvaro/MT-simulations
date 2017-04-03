% ---------------------------------------------------------------
%   trajectory_v1
%       generate trajectories and save them in the workspace
% ---------------------------------------------------------------
% close all, clear all, clc;

Tfin=50;
% Parameters
addpath('G:\Masters Thesis\3.simulation\November');
addpath('G:\Masters Thesis\3.simulation\November\control low lvl');
addpath('G:\Masters Thesis\3.simulation\November\reference');
parameters; global param
    hs = param.hs;         % sampling time - guidance
    hf = param.hf;         % sampling time - control
    Ns = floor(Tfin/hs);   % rate # of trajectories generated
    Nf = floor(hs/hf);     % rate # of low lvl control references
    
    T_s = Ns*hs;    t_s = 0:hs:T_s;
    T_f = Nf*hf;    t_f = 0:hf:T_f;

% switch-case structure whith the initial and end point in a trajectory
% vector state: ['x', 'y', 'z', 'psi']
opt = 1;

switch opt
    case 1
        % first simulation of mahony
        p_ini = [0 0 0 0];
        p_fin = [1 2 -4 0];
    
    case 2

end



% call function 'refe' for generating the trajectories
i=0;
for var = {'x', 'y', 'z', 'psi'}, var = char(var);  i=i+1;
    trajec.(sprintf('%s', var)) = refe( p_ini(i), p_fin(i), 0, T_s, var );
    try
        trajec.(sprintf('%s', var)) = horzcat( [0; 0; 0; 0; 0],...
                                    trajec.(sprintf('%s', var)) ) ;
    catch
        trajec.(sprintf('%s', var)) = [ [0 0 0]',...
                                    trajec.(sprintf('%s', var)) ];
    end
end

%% TIMESERIES trajectories

% For structure format, use the following kind of structure:
%  var.time=[TimeValues]
%  var.signals.values=[DataValues]
%  var.signals.dimensions=[DimValues]

traj.time = [t_s]';
traj.signals.values = [ trajec.x(1,:)'  trajec.y(1,:)'  trajec.z(1,:)'  trajec.psi(1,:)'];

