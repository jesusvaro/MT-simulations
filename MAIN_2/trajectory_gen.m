% ---------------------------------------------------------------
%   trajectory_gen
%       generate trajectories and save them in the workspace
% ---------------------------------------------------------------
% close all, clear all, clc;

% Parameters
 global param
    hs = param.hs;         % sampling time - guidance
    hf = param.hf;         % sampling time - control
   
    Ns = floor(Tfin/hs);   % rate # of trajectories generated
    Nf = floor(hs/hf);     % rate # of low lvl control references
    
    T_s = Ns*hs;    t_s = 0:hs:T_s;
    T_f = Nf*hf;    t_f = 0:hf:T_f;

% call function 'refe' for generating the trajectories
i=0;
for var = {'x', 'y', 'z', 'psi'}, var = char(var);  i=i+1;
     trajec.(sprintf('%s', var)) = refe( p_ini(i), p_fin(i), 0, T_s, var );

    
    switch var
    case {'x', 'y'}
        trajec.(sprintf('%s', var)) = [ [0 0 0 0 0]',...
                                        trajec.(sprintf('%s', var)) ];
%         trajec.(sprintf('%s', var)) = horzcat( [0; 0; 0; 0; 0],...
%                                     trajec.(sprintf('%s', var)) ) ;
    case {'z', 'psi'}
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
traj.signals.values = [ trajec.x(1,:)',  trajec.y(1,:)',  trajec.z(1,:)',  trajec.psi(1,:)'];

traj_2.time = [t_s]';
traj_2.signals.values = [ trajec.x(1,:)',  trajec.y(1,:)',  trajec.z(1,:)',  trajec.psi(1,:)',...
                          trajec.x(2,:)',  trajec.y(2,:)',  trajec.z(2,:)',  trajec.psi(2,:)'];

