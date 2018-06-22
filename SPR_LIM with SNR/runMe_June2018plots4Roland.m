% Master File for SPR-LIM full propagation - plotting a bunch of different
% coefficients for Roland's thesis with internal angle 60� and wavelength
% range 500-750nm

% 22 June 2018
% ------------------------------------------------------------------------

% When using new material, remember to find refractive index data and insert
% into initialiseRefIndex function. This code only uses non-magnetic
% materials, therefore mu is always equal to mu_0 (and can therefore be
% neglected)

clear all
close all

% Start by initialising theta, lambda and n (refractive index) values of layers
theta = 60;
lambdaSpacing = 0.1; %in nm
lambda = 500 : lambdaSpacing : 750; %in nm



[refP_toPlot, refS_toPlot, ~, ~] = transferMatrixFunction(layersRefIndex, d, lambda, theta);


% Phase due to Savart plate
alpha1 = linspace(0,2*pi,20);

% Define input and measurement polariser 
% (electric field in x,y basis (xhat = [1;0] and yhat = [0;1]))
inputPol = 1/(sqrt(2)) * [1;1];
measurementPol = 1/(sqrt(2)) * [-1;1];

numThicknesses = 4;
phase = zeros(numThicknesses,length(theta));
intensity = zeros(numThicknesses,length(theta));

%always let phase(1,:) and intensity(1,:) be for no sample, i.e.
%prism-Au-H2O structure

refCoeff_forPlotting = cell (2,numThicknesses);

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

    [refP_toPlot, refS_toPlot, ~, ~] = transferMatrixFunction(layersRefIndex, d, lambda, theta);
    
    refCoeff_forPlotting{1,thicknessCounter} = refP_toPlot;
    refCoeff_forPlotting{2,thicknessCounter} = refS_toPlot;
%     
%     refCoeff_forPlotting{:,thicknessCounter} = ...
%         transferMatrixFunction(layersRefIndex, d, lambda, theta);
    
measuredIntensitySimple = propagationInt_onlySimple( theta, lambda, layersRefIndex, d,...
    alpha1, inputPol, measurementPol);

measuredIntensitySimpleBroad = broadSpectrum(measuredIntensitySimple,625, lambda);

[ phase(thicknessCounter,:), intensity(thicknessCounter,:)] = ...
    PSDH( measuredIntensitySimpleBroad, alpha1, 0);
end
phase = mod(phase, pi);

% 
% plotsForJan2017( phase, intensity, theta_ext )
% plotsForJuly2017Report(theta_ext, lambda, refCoeff_forPlotting)