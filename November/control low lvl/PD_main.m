% function to compute all the linear PD controller parameters & execute
% simulations to compate their response

%% COMPUTE linear controller parameters

PD_constants

%% SIMULATION

% execute simulation

% will have:
%   - continous non-linear model
%   - continous lineal model
%   - discrete lineal model

% adding continous non-linear eq & continous linear eq
addpath('G:\Masters Thesis\3.simulation\November');
    % eq_quad     -> non-linear
    % eq_quad_lin -> linear

    % initial staes
    state_init = zeros(param.Nstates, 1);
    
open('PD_sim')
sim('PD_sim')