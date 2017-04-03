function [ X ] = refe( POS_ini, POS_fin, T_ini, T_fin, variab)
%REFE Generates 1-D trajectory in range space [POS_ini, POS_fin] in the
%       given time range [T_ini, T_fin] of varible 'variab'. Trajectory
%       generated is 2nd/4th order
%   Input_args: initial position, final postion, initial time, final time
%       · position vars: x, y, z, psi
%
%   Outpus_arg: trajectory
%       · trajectory: includes a trajectory, and its derivatives up to 
%          2nd/4th order, from POS_ini to POS_fin in the time required
%         X = [ x, x_dot, x_dot2, opt(x_dot3), opt(x_dot4) ]

% parameters
    global param
    hs = param.hs;

switch variab
    case {'z', 'psi'} % 'z' or 'psi'
       
        delta_z = POS_fin - POS_ini;
        delta_t = T_fin - T_ini;

        A = [0 1; 0 0];
        B = [0; 1];
        n = size(A,1);
        J = [eye(n) zeros(n,1); zeros(1,n) -1];
        H = [A B; zeros(1,n+1)];
        
        EH = eye(n+1) + H*hs + H*H*hs^2/2;
                
        delta_uz = 4*delta_z / (delta_t^2);
        x0 = [zeros(n,1); delta_uz];
        X(:,1) = x0;
                 
        s(1) = delta_t/2;
        s(2) = delta_t;
        
        i = 1;
        N = round(delta_t/hs);
        
        for k = 1:N-1
            t = k*hs;
            if t > s(i)
                X(:, k+1) = ( eye(n+1) + H*(t-s(i))      + H*H*(t-s(i))^2/2 )      * J *...
                            ( eye(n+1) + H*(s(i)-(t-hs)) + H*H*(s(i)-(t-hs))^2/2 ) * X(:,k);
                i = i+1;
            else
                X(:, k+1) = EH*X(:, k);
            end
        end
        
    case {'x', 'y'} % 'x' or 'y'
        
        delta_x = POS_fin - POS_ini;
        delta_t = T_fin - T_ini;
        
        A = [0 1 0 0; 0 0 1 0; 0 0 0 1; 0 0 0 0];
        B = [0; 0; 0; 1];
        n = size(A,1);
        J = [eye(n) zeros(n,1); zeros(1,n) -1];
        H = [A B; zeros(1,n+1)];
        
        EH = eye(n+1) + H*hs + H*H*hs^2/2 + H*H*H*hs^3/6 + H*H*H*H*hs^4/24;
        
        alpha = delta_t / (2+sqrt(2));
        beta = sqrt(2)*alpha;
        t = alpha + beta/2;
        ft = 1/384*alpha^4 + 1/48*alpha^3*(t-alpha/2) + 1/16*alpha^2*(t-alpha/2)^2 + alpha/12*(t-alpha/2)^3 - 1/24*(t-alpha/2)^4;
        delta_ux =  delta_x / (2*ft);
        x0 = [zeros(n,1) ;delta_ux];
        X(:,1) = x0;
        
        s(1) = alpha/2;
        s(2) = alpha + beta/2;
        s(3) = alpha*3/2 + beta;
        s(4) = 2*alpha + beta;
       
        i = 1;
        N = round(delta_t/hs);
        
        for k = 1:N-1
            t = k*hs;
            if t > s(i)
                X(:, k+1) = ( eye(n+1) + H*(t-s(i)) + H*H*(t-s(i))^2/2 + H*H*H*(t-s(i))^3/6 + H*H*H*H*(t-s(i))^4/24) * J *...
                            ( eye(n+1) + H*(s(i)-(t-hs)) + H*H*(s(i)-(t-hs))^2/2 + H*H*H*(s(i)-(t-hs))^3/6 + H*H*H*H*(s(i)-(t-hs))^4/24) * X(:,k);
                i = i+1;
            else
                X(:, k+1) = EH*X(:,k);
            end
        end
 
    otherwise
        disp('****************************************')
        disp([' Variable "varaib": ',variab,' unknown'])
        disp(' Variable "variab" must be a string: "x", "y", "z", "psi"')
        disp('****************************************')
end
end