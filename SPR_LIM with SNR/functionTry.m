% Master File for SPR-LIM full propagation

% When using new material, remember to find refractive index data and insert
% into initialiseRefIndex function. This code only uses non-magnetic
% materials, therefore mu is always equal to mu_0 (and can therefore be
% neglected)

tic
close all
% Start by initialising theta, lambda and n (refractive index) values of layers
thetaSpacing = 0.1; % in degrees
global theta
theta = 0:thetaSpacing:90;
% theta = 51.2;
lambdaSpacing = 1; %in nm
global lambda
% lambda = 850;
lambda = 300 : lambdaSpacing : 1000; %in nm
lambda = lambda *1E-9; % in m now

layersRefIndex1 = [1,2,7,3];
layersRefIndex2 = [1,2,3];
%array with elements defining layers according to:
% 1: prism in lab (n = 1.774 for all lambda)
% 2: Gold (from RefractiveIndexInfo)
% 3: water (n = 1.33 for all lambda)
% 4: water (from RefractiveIndexInfo)
% 5: Aluminium (from RefractiveIndexInfo)
% 6: Silver (from RefractiveIndexInfo)
% 7: SiO2 (from RefractiveIndexInfo)
%  etc

% d1 = [50,10]; %array with layer thicknesses in nm (two elements shorter than layersRefIndex)
d1 = [50, 2];
d1 = d1* 1E-9; %in nm now
d2 = 50* 1E-9;


% Phase due to Savart plates
% alpha1 = 0:pi/40:3*pi;
alpha1 = pi/2;
alpha2 = [0, pi/4];

% varyingalpha1_1_625 = zeros(length(alpha2),length(alpha1));
% varyingalpha1_2_625 = zeros(length(alpha2),length(alpha1));
% varyingalpha1_1_850 = zeros(length(alpha2),length(alpha1));
% varyingalpha1_2_850 = zeros(length(alpha2),length(alpha1));


[refP1, refS1, transP1, transS1] = transferMatrixFunction(layersRefIndex1, d1);


% Now do propagation:
% Initialise electric field in x,y basis (xhat = [1;0] and yhat = [0;1])
E_0 = [0;1];
% E_0 = 1/sqrt(2) * [1;1];

for savartloop2 = 1:length(alpha2)
for savartloop = 1:length(alpha1)
SP1 = savartPlate(45,alpha1(savartloop));
SP2 = savartPlate(45,alpha2(savartloop2));
% SP1 = savartPlate(0,alpha1(savartloop));
% SP2 = savartPlate(0,alpha2(savartloop2));

E_beforeSPR = SP1*E_0;
Ex_afterSPR = refP1*E_beforeSPR(1);
Ey_afterSPR = refS1*E_beforeSPR(2);

Ex_afterSP2 = SP2(1,1)*Ex_afterSPR + SP2(1,2)*Ey_afterSPR;
Ey_afterSP2 = SP2(2,1)*Ex_afterSPR + SP2(2,2)*Ey_afterSPR;

if loopy ==1
%   analysing polariser along x
%     intensity1 = abs(Ex_afterSP2).^2;
%   analysing polariser along D-
    intensity1 = 0.5* abs(-Ex_afterSP2 + Ey_afterSP2).^2;
    justr1 = abs(refP1).^2;
    broad625_1 = broadSpectrum(intensity1,625);
    varyingalpha1_1_625(savartloop2, savartloop) = broad625_1;
    broad850_1 = broadSpectrum(intensity1,850);
    varyingalpha1_1_850(savartloop2, savartloop) = broad850_1;
else
%   analysing polariser along x
%   intensity2 = abs(Ex_afterSP2).^2;
%   analysing polariser along D-
    intensity2 = 0.5* abs(-Ex_afterSP2 + Ey_afterSP2).^2;
    justr2 = abs(refP1).^2;
    broad625_2(savartloop2,:) = broadSpectrum(intensity2,625);
    varyingalpha1_2_625(savartloop2,savartloop) = broad625_2(savartloop2,:);
    broad850_2(savartloop2,:) = broadSpectrum(intensity2,850);
    varyingalpha1_2_850(savartloop2,savartloop) = broad850_2(savartloop2,:);
end
end
end
end
toc
