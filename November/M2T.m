function [ Torques ] = M2T( Mspeed, method )
%M2T: transforms the motor speeds into the torques generated in
% z-direction and each angle
%   
% Inputs: 
%  ·Mspeed == [w1; w2; w3; w4]
%    each w_i is the motor speed of one of the motors of the drone.
%    unit: [?]
%  ·method: 'theorical' or 'experimental'
%    computes the ouput by the theorical method or by the polynom deduced
%    experimentally
%
% Output: Torques == [T, Tphi, Ttheta, Tpsi]
%  ·T: thrust generated in z-direction
%    unit: [?] body frame
%  ·Tphi, Ttheta, Tpsi: torques generated in (phi,theta,psi) angles
%    unit: [?] body frame

% Parameters
CT = param.CT;  L = param.L;
CQ = param.CQ;

CM = param.CM;  pcoeff = param.pcoeff;

% identifying errors
if length(Mspeed) ~= 4
    disp('unbalanced number of values in Mspeed');
    %return error
else
    for i = 1:4
        if ~isfloat(Mspeed(i))
            disp(['element ',num2str(i),' in Mspeed is no a float']);
        end
    end
end


if isa(method, 'string')
    switch method
        case 'theorical'
            H = [   CT     CT     CT     CT
                  L*CT   L*CT  -L*CT  -L*CT
                  L*CT  -L*CT  -L*CT   L*CT
                   -CQ     CQ    -CQ     CQ ];
            
            Torques = H * Mspeed.^2;
            
        case 'experimental'
            % method calculated by P.L.M. Roijakkers in his project
           Mforce = pcoeff(3) + pcoeff(2)*Mspeed + pcoeff(1)*Mspeed.^2; 
           
           H = [  1   1    1   1
                  L   L   -L  -L
                  L  -L   -L   L
                -CM  CM  -CM  CM ];
           
           Torques = H * Mforce;
           
        otherwise
            disp(['method "',method,'" not accepted']);
            disp('select method "theorical" or "experimental"');
    end
else
    disp('method must be a string: "theorical" or "experimental"');

end

