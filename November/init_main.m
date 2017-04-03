close all; clear all; clc;

% Call for parameters
parameters;
    disp('Parameters loaded');

% ----sequence of control loop----

% read inputs of reference and outputs/state
% controler algorithm
% plant simulation
% write ouput/state of plant


    
% generate u; u = torques to apply
%   toques must be transformed into MotorSpeed
%   MotorSpeed must be saturated with experimental values
% 'signal' to apply is pwm == MotorSpeed

% for simlation purposes: the 'drone' in the simulation must change the
% u-signal in form of MotorSpeed into Torques:
%   Mspeed2Torques

% state and input -> eq_quad => dot_state -- by simulink --> integrate and
% obtain the new states

% black box of measurements after the states

% blac box for obtaining the outputs after the measurements


% control box: from output? or from the state?
% first from the states and after, after implementing an observer, feedback
% from the output
%   see document which i have to relay on!