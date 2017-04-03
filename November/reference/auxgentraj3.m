close all, clear all, clc
% delta
opt = 1; % 1 z, psi, 2 x, y
switch opt
    case 1
        % z
        deltaz  = 1;
        deltat  = 1;
        deltauz = 4*deltaz/(deltat^2);
        s(1) = deltat/2;
        s(2) = deltat;
        hs = 0.02;
        N = round(deltat/hs);
        A = [0 1; 0 0];
        B = [0;1];
        n = size(A,1);
        J = [eye(n) zeros(n,1); zeros(1,n) -1];
        H = [A B; zeros(1,n+1)];
        x0 = [zeros(n,1);deltauz];
        x(:,1) = x0;
        EH = (eye(n+1)+H*hs+H*H*hs^2/2);
        i = 1;
        for k = 1:N-1
            t = k*hs;
            if t > s(i)
                x(:,k+1) = (eye(n+1)+H*(t-s(i))+H*H*(t-s(i))^2/2)*J*(eye(n+1)+H*(s(i)-(t-hs))+H*H*((s(i)-(t-hs)))^2/2)*x(:,k);
                i = i+1;
            else
                x(:,k+1) = EH*x(:,k);
            end
        end
        figure(1)
        tt = [0:1:N-1]*hs;
        subplot(3,1,1),
        plot(tt,x(3,:)), title('x(3,:)')
        subplot(3,1,2)
        plot(tt,x(2,:)), title('x(2,:)')
        subplot(3,1,3)
        plot(tt,x(1,:)), title('x(1,:)')
    case 2
        deltax  = -1.5;
        deltat  = 2;
        alpha = deltat/(2+sqrt(2));
        beta = sqrt(2)*alpha;
        t = alpha+beta/2;
        ft = (1/384*alpha^4 + 1/48*alpha^3*(t-alpha/2) + 1/16*alpha^2*(t-alpha/2)^2 + alpha/12*(t-alpha/2)^3-1/24*(t-alpha/2)^4);
        deltaux =  deltax/(2*ft);
        
        s(1) = alpha/2;
        s(2) = alpha+beta/2;
        s(3) = alpha*3/2+beta;
        s(4) = 2*alpha+beta;
        hs = 0.02;
        N = round(deltat/hs);
        A = [0 1 0 0;0 0 1 0; 0 0 0 1; 0 0 0 0];
        B = [0;0;0;1];
        n = size(A,1);
        J = [eye(n) zeros(n,1); zeros(1,n) -1];
        H = [A B; zeros(1,n+1)];
        x0 = [zeros(n,1);deltaux];
        x(:,1) = x0;
        EH = (eye(n+1)+H*hs+H*H*hs^2/2+H*H*H*hs^3/6+H*H*H*H*hs^4/24);
        i = 1;
        for k = 1:N-1
            t = k*hs;
            if t > s(i)
                x(:,k+1) = (eye(n+1)+H*(t-s(i))+H*H*(t-s(i))^2/2+H*H*H*(t-s(i))^3/6+H*H*H*H*(t-s(i))^4/24)*J*(eye(n+1)+H*(s(i)-(t-hs))+H*H*((s(i)-(t-hs)))^2/2+H*H*H*((s(i)-(t-hs)))^3/6+H*H*H*H*((s(i)-(t-hs)))^4/24)*x(:,k);
                i = i+1;
            else
                x(:,k+1) = EH*x(:,k);
            end
        end
        figure(1)
        tt = [0:1:N-1]*hs;
        subplot(5,1,1)
        plot(tt,x(5,:)), title('x(5,:)')
        subplot(5,1,2)
        plot(tt,x(4,:)), title('x(4,:)')
        subplot(5,1,3)
        plot(tt,x(3,:)), title('x(3,:)')
        subplot(5,1,4)
        plot(tt,x(2,:)), title('x(2,:)')
        subplot(5,1,5)
        plot(tt,x(1,:)), title('x(1,:)')
end