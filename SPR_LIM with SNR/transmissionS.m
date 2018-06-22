function [ output_args ] = transmissionS( layer1, layer2 )
%TRANSMISSIONS Summary of this function goes here
%   Detailed explanation goes here
% Assumes mu1 = mu2 = mu0
global kz
numerator = 2*kz(:,:,layer1);
denominator = kz(:,:,layer1) + kz(:,:,layer2);
output_args = numerator./denominator;
end

