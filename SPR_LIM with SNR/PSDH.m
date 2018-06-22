function [ phase, intensity, Psi_sin, Psi_cos ] = PSDH( measuredIntensity, alpha1, alpha2 )
%UNTITLED3 Summary of this function goes here
%   Detailed explanation goes here
Gamma_sin = zeros(1,1,length(alpha1),1);
Gamma_cos = zeros(1,1,length(alpha1),1);
Gamma_sin(1,1,:,1) = sin(alpha1)/pi;
Gamma_cos(1,1,:,1) = cos(alpha1)/pi;
% measuredIntensity
toIntegrate_sin = measuredIntensity.*repmat(Gamma_sin, [length(measuredIntensity(:,1,1,1)),length(measuredIntensity(1,:,1,1)),1,length(alpha2)]);
% sum(sum(sum(sum(toIntegrate_sin))))
toIntegrate_cos = measuredIntensity.*repmat(Gamma_cos, [length(measuredIntensity(:,1,1,1)),length(measuredIntensity(1,:,1,1)),1,length(alpha2)]);
Psi_sin = trapz(alpha1,toIntegrate_sin,3);
Psi_cos = trapz(alpha1,toIntegrate_cos,3);
phase = -atan(Psi_sin./Psi_cos);
intensity = 2*sqrt(Psi_sin.^2 + Psi_cos.^2);
end

