% Master File for SPR-LIM simple propagation and calculating noise
% propagation with broad spectrum detection

% When using new material, remember to find refractive index data and insert
% into initialiseRefIndex function. This code only uses non-magnetic
% materials, therefore mu is always equal to mu_0 (and can therefore be
% neglected)

clear all
close all

% Start by initialising theta, lambda and n (refractive index) values of layers
thetaSpacing = 0.05; % in degrees
theta = 50:thetaSpacing:60;
lambdaSpacing = 1; %in nm
lambda = 500 : lambdaSpacing : 800; %in nm

% Phase due to Savart plate
alpha1 = linspace(0,2*pi,20);

% Define input and measurement polariser 
% (electric field in x,y basis (xhat = [1;0] and yhat = [0;1]))
inputPol = 1/(sqrt(2)) * [1;1];
measurementPol = 1/(sqrt(2)) * [-1;1];

numThicknesses = 4;

numSamples = 200;
noiseLevel = 0.05;

phase = zeros(numThicknesses,length(theta),numSamples);
intensity = zeros(numThicknesses,length(theta),numSamples);
phaseExact = zeros(numThicknesses,length(theta));
intensityExact = zeros(numThicknesses,length(theta));

%always let phase(1,:) and intensity(1,:) be for no sample, i.e.
%prism-Au-H2O structure
for thicknessCounter = 1:numThicknesses
    
    if thicknessCounter ==1
        layersRefIndex = [1,2,3];
    else
        layersRefIndex = [1,2,7,3];
    end
    % layersRefIndex is array with elements defining layers according to:
    % 1: prism in lab (n = 1.774 for all lambda)
    % 2: Gold (from RefractiveIndexInfo)
    % 3: water (n = 1.33 for all lambda)
    % 4: water (from RefractiveIndexInfo)
    % 5: Aluminium (from RefractiveIndexInfo)
    % 6: Silver (from RefractiveIndexInfo)
    % 7: SiO2 (from RefractiveIndexInfo)
    %  etc

    if thicknessCounter ==1
        d = 50;
    elseif thicknessCounter ==2
        d = [50, 1];
    elseif thicknessCounter ==3
        d = [50, 2.5];
    else
        d = [50, 5];
    end
    %d is array with layer thicknesses in nm (two elements shorter than layersRefIndex)

measuredIntensitySimple = propagationInt_onlySimple( theta, lambda, layersRefIndex, d,...
    alpha1, inputPol, measurementPol);

measuredIntensitySimpleBroad = broadSpectrum(measuredIntensitySimple,625, lambda);

[ phaseExact(thicknessCounter,:), intensityExact(thicknessCounter,:), psi_sinExact(thicknessCounter,:),...
    psi_cosExact(thicknessCounter,:)] = PSDH( measuredIntensitySimpleBroad, alpha1, 0);

measuredIntensitySimpleBroad_noisy = repmat(measuredIntensitySimpleBroad,numSamples,1)...
    +noiseLevel*randn(numSamples,length(theta),length(alpha1));

for noiseCounter = 1:numSamples
    [ phase(thicknessCounter,:,noiseCounter), intensity(thicknessCounter,:,noiseCounter)] = ...
        PSDH( measuredIntensitySimpleBroad_noisy(noiseCounter,:,:), alpha1, 0);
end
end
phaseExact = mod(phaseExact, pi);
phase = mod(phase, pi);

muchBigger = abs((phase-pi)-repmat(phaseExact,1,1,numSamples))<...
    abs(phase-repmat(phaseExact,1,1,numSamples));
muchSmaller = abs((phase+pi)-repmat(phaseExact,1,1,numSamples))<...
    abs(phase-repmat(phaseExact,1,1,numSamples));
phase(muchBigger) = phase(muchBigger)-pi;
phase(muchSmaller) = phase(muchSmaller)+pi;

% phaseExact = 625/(2*pi)*phaseExact;
% phase = 625/(2*pi)*phase;

theta_ext = 74+180/pi*asin(sin(pi/180 * (theta-74))*1.775);
% plotsNoisy( phase, intensity, theta_ext, intensityExact, phaseExact, psi_sinExact, psi_cosExact )
plotsNoisyForAug2017( phase, intensity, theta_ext, intensityExact, phaseExact, psi_sinExact, psi_cosExact )