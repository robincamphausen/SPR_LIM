function [ output_args ] = transmissionP( layer1, layer2 , theta)
%UNTITLED3 Summary of this function goes here
%   Detailed explanation goes here
global epsilon kz
numerator = 2*repmat(epsilon(:,layer2),1,length(theta)).*kz(:,:,layer1);
denominator = repmat(epsilon(:,layer2),1,length(theta)).*kz(:,:,layer1) + repmat(epsilon(:,layer1),1,length(theta)).*kz(:,:,layer2);
scalingConstant = sqrt(repmat(epsilon(:,layer1),1,length(theta))./repmat(epsilon(:,layer2),1,length(theta)));
output_args = (numerator./denominator).*scalingConstant;
end
