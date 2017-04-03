% ------------------------------------------------------------------
%   generate the control trayectory between 2 points given by guidance
%
% -----------------------------------------------------------------

% state = [x, y, z,  vx, vy, cz,  phi, theta, psi,  vphi, vtheta, vpsi]'
%  guidance will provide 2D (x,y,phi) or 3D (x,y,z,phi,theta,psi)
%   for now..2D

    % the controller will generate the rest of variables needed!

% Position: initial & final
X_ini = [ 0 0 0  0 0 0  0 0 0  0 0 0 ]';
X_fin = [ 1 1 1  0 0 0  1 1 1  0 0 0 ]';

% Time: initial & final
T_ini = 0;
T_fin = 50;

 % select type of trajectory coordinates: (2D)
 %  · z, phi
 %  · x, y
 %  ...as a string format. e.g.: 'x', 'phi'
 
 z_traj   = refe ( X_ini(3), X_fin(3), T_ini, T_fin, 'z');
 phi_traj = refe ( X_ini(7), X_fin(7), T_ini, T_fin, 'psi');
 x_traj   = refe ( X_ini(1), X_fin(1), T_ini, T_fin, 'x');
 y_traj   = refe ( X_ini(2), X_fin(2), T_ini, T_fin, 'y');      % in the future:change it to a list + for
    
%% PLOT

% parameters
    global param
    hs = param.hs; % hs=1
    
[~,N] = size(x_traj);
tt = [0:1:N-1]*hs;

figure(1)
for i = 1:3
    subplot(3,1, i)
    plot (tt, z_traj(3+1-i,:))
        if (5+1-i>1) title( strcat('z dot',num2str(3-i)) )
        else         title('z')
        end
end

figure(2)
for i = 1:3
    subplot(3,1, i)
    plot (tt, phi_traj(3+1-i,:))
        if (3+1-i>1) title( strcat('phi dot',num2str(3-i)) )
        else         title('phi')
        end
end

figure(3)
for i = 1:5
    subplot(5,1, i)
    plot (tt, x_traj(5+1-i,:))
        if (5+1-i>1) title( strcat('x dot',num2str(5-i)) )
        else         title('x')
        end
end

figure(4)
for i = 1:5
    subplot(5,1, i)
    plot (tt, y_traj(5+1-i,:))
        if (5+1-i>1) title( strcat('y dot',num2str(5-i)) )
        else         title('y')
        end
end