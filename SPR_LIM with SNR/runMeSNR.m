% Master File for SPR-LIM full propagation and finding SNR

% When using new material, remember to find refractive index data and insert
% into initialiseRefIndex function. This code only uses non-magnetic
% materials, therefore mu is always equal to mu_0 (and can therefore be
% neglected)

close all

% Start by initialising theta, lambda and n (refractive index) values of layers
thetaSpacing1 = 0.5; % in degrees
theta1 = 0:thetaSpacing1:90;
lambdaSpacing1 = 1; %in nm
lambda1 = 300 : lambdaSpacing1 : 1000; %in nm

layersRefIndex1 = [1,2,3];
layersRefIndex2 = [1,2,7,3];
% array with elements defining layers according to:
% 1: prism in lab (n = 1.774 for all lambda)
% 2: Gold (from RefractiveIndexInfo)
% 3: water (n = 1.33 for all lambda)
% 4: water (from RefractiveIndexInfo)
% 5: Aluminium (from RefractiveIndexInfo)
% 6: Silver (from RefractiveIndexInfo)
% 7: SiO2 (from RefractiveIndexInfo)
%  etc

% array with layer thicknesses in nm (two elements shorter than layersRefIndex)
d1 = 50;
d2 = [50, 2];

% Phase due to Savart plates
alpha1_1 = linspace(0,2*pi,20);
alpha2_1 = 0;

% Define input and measurement polariser 
% (electric field in x,y basis (xhat = [1;0] and yhat = [0;1]))
inputPol = 1/(sqrt(2)) * [1;1];
measurementPol = 1/(sqrt(2)) * [-1;1];

tic
[ measuredIntensity1, measuredIntensitySimple1, forPSDH_Analytical1  ] = propagationInt( theta1, lambda1, layersRefIndex1, d1,...
    alpha1_1, alpha2_1, inputPol, measurementPol, 45, 45);
toc


tic
[ phase1, intensity1 ] = PSDH( measuredIntensity1, alpha1_1, alpha2_1);
toc

tic
[ phaseSimple1, intensitySimple1 ] = PSDH( measuredIntensitySimple1, alpha1_1, alpha2_1);
toc

phaseSimple1 = mod(phaseSimple1, pi);

tic
[checkP, checkS, ~, ~ ]...
     = transferMatrixFunction( layersRefIndex1, d1, lambda1, theta1 );
phaseCheck1 = angle(checkP)-angle(checkS);
phaseCheck1 = mod(phaseCheck1, pi);
intensityCheck1 = abs(checkP).* abs(checkS);
toc

tic
[ phasePSDHAnalytical1, IntPSDHAnalytical1 ] = PSDH_Analytical( forPSDH_Analytical1 );
toc

tic
% plotting1( theta1, lambda1, phase1, intensity1, phaseSimple1, intensitySimple1, measuredIntensity1, measuredIntensitySimple1)
% plotting1( theta1, lambda1, phaseSimple1, intensitySimple1, phaseCheck1, intensityCheck1, measuredIntensity1, measuredIntensitySimple1)
plotting1( theta1, lambda1, phasePSDHAnalytical1, IntPSDHAnalytical1, phaseCheck1, intensityCheck1, measuredIntensity1, measuredIntensitySimple1)
toc