function [ supposedUnity ] = instabilitySource( refP, refS )
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here

supposedUnity = (abs(refS).*abs(refP))./(abs(refS).*abs(refP));
max(max(supposedUnity))
figure(1)
subplot(2,2,1)
surf(abs(refP))
shading flat
view(0,90)
colorbar
subplot(2,2,2)
surf(abs(refS))
shading flat
view(0,90)
colorbar
subplot(2,2,3)
surf(abs(refS).*abs(refP))
shading flat
view(0,90)
colorbar
subplot(2,2,4)
surf(supposedUnity-1)
shading flat
view(0,90)
colorbar
end

