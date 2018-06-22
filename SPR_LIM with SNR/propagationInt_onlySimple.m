function [ measuredIntensitySimple ] = propagationInt_onlySimple( theta, lambda, layersRefIndex, d,...
    alpha1, inputPol, measurementPol)
% propagationInt gives a theta*lambda*alpha1*alpha2 multi-dimensional array
% of measured intensities after propagating input light with polarisation
% inputPol (electric field in x,y basis (xhat = [1;0] and yhat = [0;1]))
% through Savart plates at angles angleSP1/2 (in degrees), inducing phases alpha1/2 and
% measured by polariser at outputPol, after interacting with thin-film
% layered sample given by layersRefIndex and d:

%d, lambda are given in nm

[refP, refS, ~, ~] = transferMatrixFunction(layersRefIndex, d, lambda, theta);

measuredIntensitySimple = simpleProp45( inputPol, measurementPol, refP, refS, alpha1 );
end

