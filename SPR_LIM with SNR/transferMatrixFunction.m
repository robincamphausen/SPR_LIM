function [ outputRefP, outputRefS, outputTransP, outputTransS ]...
    = transferMatrixFunction( layersRefIndex, d, lambda, theta )
%TRANSFERMATRIXFUNCTION Summary of this function goes here
%   Gives transmitted and reflected P and S polarised electric fields from
%   stack given by refractive indices "layersRefIndex" and thicknesses "d"
n = initialiseRefIndex(layersRefIndex,lambda);
numLayers = length(layersRefIndex);

global epsilon kz
epsilon = n.^2; %dielectric functions
kz = zeros(length(lambda),length(theta),numLayers);
k = 2*pi./repmat(lambda',1,numLayers) .*n;
kpara = k(:,1)*sind(theta);
for loop1 = 1:numLayers
    kz(:,:,loop1) = sqrt(repmat(k(:,loop1),1,length(theta)).^2 - kpara.^2 +eps*1i);
end

% Initialise transmission/reflection coefficients
rP = zeros(length(lambda),length(theta),numLayers-1);
rS = zeros(length(lambda),length(theta),numLayers-1);
tP = zeros(length(lambda),length(theta),numLayers-1);
tS = zeros(length(lambda),length(theta),numLayers-1);

% get all individual transmission/reflection coefficients for all lambda
% and theta
for loop2 = 1:numLayers-1
    rP(:,:,loop2) = reflectionP(loop2, loop2+1, theta);
    rS(:,:,loop2) = reflectionS(loop2, loop2+1);
    tP(:,:,loop2) = transmissionP(loop2, loop2+1, theta);
    tS(:,:,loop2) = transmissionS(loop2, loop2+1);
end

% Initialise T and newT arrays (without 1/t scaling factor)
TP = zeros(length(lambda),length(theta),2,2);
TS = zeros(length(lambda),length(theta),2,2);
newTP = zeros(length(lambda),length(theta),2,2);
newTS = zeros(length(lambda),length(theta),2,2);

TP(:,:,1,1) = 1;
TP(:,:,1,2) = rP(:,:,1);
TP(:,:,2,1) = rP(:,:,1);
TP(:,:,2,2) = 1;
TS(:,:,1,1) = 1;
TS(:,:,1,2) = rS(:,:,1);
TS(:,:,2,1) = rS(:,:,1);
TS(:,:,2,2) = 1;

% Delta array (phase due to propagation)
delta = zeros(length(lambda),length(theta),numLayers-2);
for loop3 = 1:numLayers-2
    delta(:,:,loop3) = d(loop3)*kz(:,:,loop3+1);
end

for loop4 = 1:numLayers-2
    newTP(:,:,1,1) = TP(:,:,1,1) + TP(:,:,1,2).*exp(2i*delta(:,:,loop4)).*rP(:,:,loop4+1);
    newTP(:,:,1,2) = TP(:,:,1,1).*rP(:,:,loop4+1) + TP(:,:,1,2).*exp(2i*delta(:,:,loop4));
    newTP(:,:,2,1) = TP(:,:,2,1) + TP(:,:,2,2).*exp(2i*delta(:,:,loop4)).*rP(:,:,loop4+1);
    newTP(:,:,2,2) = TP(:,:,2,1).*rP(:,:,loop4+1) + TP(:,:,2,2).*exp(2i*delta(:,:,loop4));
        
    newTS(:,:,1,1) = TS(:,:,1,1) + TS(:,:,1,2).*exp(2i*delta(:,:,loop4)).*rS(:,:,loop4+1);
    newTS(:,:,1,2) = TS(:,:,1,1).*rS(:,:,loop4+1) + TS(:,:,1,2).*exp(2i*delta(:,:,loop4));
    newTS(:,:,2,1) = TS(:,:,2,1) + TS(:,:,2,2).*exp(2i*delta(:,:,loop4)).*rS(:,:,loop4+1);
    newTS(:,:,2,2) = TS(:,:,2,1).*rS(:,:,loop4+1) + TS(:,:,2,2).*exp(2i*delta(:,:,loop4));
    
    TP = newTP;
    TS = newTS;
end

% Reflection Coefficients from transfer matrix:
reflectionTotalP = TP(:,:,2,1)./TP(:,:,1,1);
reflectionTotalS = TS(:,:,2,1)./TS(:,:,1,1);

% Calculate scaling factor for transmission coefficients:
scalingFactorP = 1./tP(:,:,1);
scalingFactorS = 1./tS(:,:,1);
for loop5 = 1:numLayers-2
    scalingFactorP = scalingFactorP.*exp(-1i*delta(:,:,loop5)).*1./tP(:,:,loop5+1);
    scalingFactorS = scalingFactorS.*exp(-1i*delta(:,:,loop5)).*1./tS(:,:,loop5+1);
end

transmissionTotalP = scalingFactorP.*1./TP(:,:,1,1);
transmissionTotalS = scalingFactorS.*1./TS(:,:,1,1);

outputRefP = reflectionTotalP;
outputRefS = reflectionTotalS;
outputTransP = transmissionTotalP;
outputTransS = transmissionTotalS;

clear epsilon
clear kz
end

