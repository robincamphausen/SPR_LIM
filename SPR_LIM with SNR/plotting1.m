function [  ] = plotting1( theta, lambda, phasePSDH, intensityPSDH, phaseCheck, ...
    intensityCheck, measuredIntensity, measuredIntensity2)
%UNTITLED4 Summary of this function goes here
%   Detailed explanation goes here

figure(1)
subplot(2,2,1)
surf(theta, lambda, phasePSDH)
shading flat
view(0,90)
colorbar
subplot(2,2,2)
surf(theta, lambda, intensityPSDH)
shading flat
view(0,90)
colorbar
subplot(2,2,3)
surf(theta, lambda, phaseCheck)
shading flat
view(0,90)
colorbar
subplot(2,2,4)
surf(theta, lambda, intensityCheck)
shading flat
view(0,90)
colorbar

figure(2)
subplot(1,2,1)
surf(theta, lambda, measuredIntensity(:,:,2))
shading flat
view(0,90)
colorbar

subplot(1,2,2)
surf(theta, lambda, measuredIntensity2(:,:,2))
shading flat
view(0,90)
colorbar

figure(3)
subplot(1,2,1)
surf(phasePSDH - phaseCheck)
shading flat
view(0,90)
colorbar
subplot(1,2,2)
surf(intensityPSDH - intensityCheck)
shading flat
view(0,90)
colorbar
end

