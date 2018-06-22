% Master File for SPR-LIM - plotting a bunch of different Fresnel P ref.
% coefficients for Roland with internal angle 60º(?) or 53º(?) and wavelength
% range 500-750nm

% exports: CSV file of angle vs int and phase for all three cases

% 22 June 2018
% ------------------------------------------------------------------------
clear all
close all

% When using new material, remember to find refractive index data and insert
% into initialiseRefIndex function. This code only uses non-magnetic
% materials, therefore mu is always equal to mu_0 (and can therefore be
% neglected):

% layersRefIndex is array with elements defining layers according to:
    % 1: prism in lab (n = 1.774 for all lambda)
    % 2: Gold (from RefractiveIndexInfo)
    % 3: water (n = 1.333 for all lambda)
    % 4: water (from RefractiveIndexInfo)
    % 5: Aluminium (from RefractiveIndexInfo)
    % 6: Silver (from RefractiveIndexInfo)
    % 7: SiO2 (from RefractiveIndexInfo)
    % 8: glycerol/H20 (n = 1.335 for all lambda)
    %  etc
    
% Initialise n (refractive index) values of layers and thicknesses
n1 = [1,2,3];
n3 = [1,2,8];
d1 = 40; %in nm
d2 = 50; %in nm

% Initialise theta and lambda:
theta = 60; % @theta=60, theta_ext = 48.6
% theta = 53; % @theta=53, theta_ext = 35
lambdaSpacing = 0.1; %in nm
lambda = 250 : lambdaSpacing : 1000; %in nm

% find complex P reflection coefficients:
[refP(1,:), ~, ~, ~] = transferMatrixFunction(n1, d1, lambda, theta);
[refP(2,:), ~, ~, ~] = transferMatrixFunction(n1, d2, lambda, theta);
[refP(3,:), ~, ~, ~] = transferMatrixFunction(n3, d2, lambda, theta);

% apply spectral broadening:
% normalised Gaussian pulse with 2*sigma^2=5nm (i.e. width of whole pulse is 5nm):
centreLambda = lambda(ceil(length(lambda)/2));
sigma = sqrt(5/2);
sourceWidth = lambdaSpacing* 1/(sigma*sqrt(2*pi)) * exp(-0.5*((lambda-centreLambda)/sigma).^2);

%or for tabletop source:
flatSource = zeros(1,length(lambda));
notZero = abs(lambda-centreLambda)<=sigma;
flatSource(notZero) = lambdaSpacing* 1/(2*sigma);

for counter = 1:length(refP(:,1))
    broadRefP(counter,:) = conv(refP(counter,:),sourceWidth,'same');
    broadRefP_flat(counter,:) = conv(refP(counter,:),flatSource,'same');
end

figure(1)
hold on
yyaxis left
ylim([0 1])
int1 = plot(lambda, abs(broadRefP(1,:)).^2,'b');
int2 = plot(lambda, abs(broadRefP(2,:)).^2,'r');
int3 = plot(lambda, abs(broadRefP(3,:)).^2,'g');
yyaxis right
ylim([-pi pi])
phase1 = plot(lambda, angle(broadRefP(1,:)),'--b');
phase2 = plot(lambda, angle(broadRefP(2,:)),'--r');
phase3 = plot(lambda, angle(broadRefP(3,:)),'--g');
xlim([500,750])

legend('40nm Au, Water','50nm Au, Water','50nm Au, Water and Glycerol')

% export fig
export_fig .\plotsRoland_june2018\60degrees.pdf -transparent -m5
% save coeffs for exporting
SPR_june2018(1,:)= lambda;
SPR_june2018([2 4 6],:) = abs(broadRefP).^2;
SPR_june2018([3 5 7],:) = angle(broadRefP);
SPR_june2018 = SPR_june2018';