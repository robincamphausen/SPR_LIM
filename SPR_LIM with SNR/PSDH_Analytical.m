function [ phasePSDHAnalytical, IntPSDHAnalytical ] = PSDH_Analytical( forPSDH_Analytical )
%UNTITLED2 Summary of this function goes here
% finds phase and intensity using exact method from PSDH paper (Yamaguchi,
% 1997)
% forPSDH_Analytical is measuredIntensitySimple for alpha1 values 0, pi/2,
% pi, 3*pi/2

numerator = forPSDH_Analytical(:,:,4)-forPSDH_Analytical(:,:,2);
denominator = forPSDH_Analytical(:,:,1)-forPSDH_Analytical(:,:,3);
phasePSDHAnalytical = mod( atan(numerator./denominator),pi);
IntPSDHAnalytical = 2*sqrt(numerator.^2 + denominator.^2);
end

