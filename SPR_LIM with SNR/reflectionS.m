function [ output_args ] = reflectionS( layer1, layer2 )
%REFLECTIONT Summary of this function goes here
% Assumes mu1 = mu2 = mu0
global kz
numerator = kz(:,:,layer1) - kz(:,:,layer2);
denominator = kz(:,:,layer1) + kz(:,:,layer2);
output_args = numerator./denominator;
end

