% % close all; clear all; clc;
% % parameters;
% % dot = eq_quad( zeros(param.Nstates, 1), [ 1 1 1 1 ])
% % 
% % % a = zeros( param.Nstates,1)';
% % % b = numel(a);
% % % c = a(4);
% referencein = ones(16,1);
% referenceout = zeros(17,1);
% rh = 50;
% referenceout(1:16) = referencein(1+referencein(end):rh:end-1);

% for i = ['a','b','c']
%     disp(i);
% end

% for i=1:3
%    x{i}=i; 
% end

% j=100;
% for i=['x','y','z']
%    s.( sprintf('%s',i) ) = j;
%    j = j+20;
% end

j=100;
a = 'xxx';
for i={a,'yyyy','zzzzzzz'}
    disp(i)
%    l.(sprintf ('%s', strcat('K_',i)) ) = j;
%    j = j+20;
end