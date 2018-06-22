function [ measuredIntensity, measuredIntensitySimple, forPSDH_Analytical ] = propagationInt( theta, lambda, layersRefIndex, d,...
    alpha1, alpha2, inputPol, measurementPol, angleSP1, angleSP2)
% propagationInt gives a theta*lambda*alpha1*alpha2 multi-dimensional array
% of measured intensities after propagating input light with polarisation
% inputPol (electric field in x,y basis (xhat = [1;0] and yhat = [0;1]))
% through Savart plates at angles angleSP1/2 (in degrees), inducing phases alpha1/2 and
% measured by polariser at outputPol, after interacting with thin-film
% layered sample given by layersRefIndex and d:

%d, lambda are given in nm

[refP, refS, ~, ~] = transferMatrixFunction(layersRefIndex, d, lambda, theta);

SP1 = savartPlate(angleSP1,alpha1);
SP2 = savartPlate(angleSP2,alpha2);

[Ex_afterSP2, Ey_afterSP2] = EAfterPropFunction( inputPol, SP1, SP2, refP, refS, alpha1, alpha2);

measuredE_amplitude = measurementPol(1)*Ex_afterSP2 + measurementPol(2)* Ey_afterSP2;

measuredIntensity = abs(measuredE_amplitude).^2;

measuredIntensitySimple = simpleProp45( inputPol, measurementPol, refP, refS, alpha1 );

forPSDH_Analytical = simpleProp45( inputPol, measurementPol, refP, refS, [0,pi/2,pi,3*pi/2] );
end

