function [ output_args ] = reflectionP( layer1, layer2, theta )
%UNTITLED3 Summary of this function goes here
%   Detailed explanation goes here
global epsilon kz
numerator = repmat(epsilon(:,layer2),1,length(theta)).*kz(:,:,layer1) - repmat(epsilon(:,layer1),1,length(theta)).*kz(:,:,layer2);
denominator = repmat(epsilon(:,layer2),1,length(theta)).*kz(:,:,layer1) + repmat(epsilon(:,layer1),1,length(theta)).*kz(:,:,layer2);
output_args = numerator./denominator;
end

