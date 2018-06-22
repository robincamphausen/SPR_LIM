function [ output_args ] = simpleProp45( inputPol, measurementPol, refP, refS, alpha1 )
%UNTITLED Summary of this function goes here
%   for only SP oriented such that it separates into orthogonal basis
%   xhat = (1;0) and yhat = (0;1)

exp_toUse = zeros(1,1,length(alpha1));
exp_toUse(1,1,:) = exp(1i*alpha1);
beforeSPR_P = inputPol(1)*exp_toUse;
beforeSPR_S = inputPol(2)*ones(1,1,length(alpha1));

afterSPR_P = repmat(beforeSPR_P, [length(refP(:,1)),length(refP(1,:)),1]).*repmat(refP, [1,1,length(alpha1)]);
afterSPR_S = repmat(beforeSPR_S, [length(refP(:,1)),length(refP(1,:)),1]).*repmat(refS, [1,1,length(alpha1)]);

afterPol2 = afterSPR_P*measurementPol(1) + afterSPR_S*measurementPol(2);
output_args = abs(afterPol2).^2;
end

