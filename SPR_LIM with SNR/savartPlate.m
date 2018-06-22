function [ output_args ] = savartPlate( orientation, tiltPhase )
%UNTITLED4 Summary of this function goes here
%   E is in x,y basis, orientation in degrees from horizontal (x)
%   tiltPhase in radians
%   Rplus and Rminus are rotation operators to rotate from xhat, yhat basis
%   into Savart plate basis given by orientation

Rplus = [cosd(orientation), -sind(orientation);sind(orientation), cosd(orientation)];
Rminus = [cosd(orientation), sind(orientation);-sind(orientation), cosd(orientation)];

if length(tiltPhase)==1
    P = [exp(1i*tiltPhase), 0 ; 0, 1];
    
    output_args = Rplus*P*Rminus;
else
    P = zeros(2,2,length(tiltPhase));
    output = zeros(2,2,length(tiltPhase));
    for n = 1:length(tiltPhase)
        P(:,:,n) = [exp(1i*tiltPhase(n)), 0 ; 0, 1];
        output(:,:,n) = Rplus*P(:,:,n)*Rminus;
    end
    output_args = output;
end
end

