function [  ] = plotsForJuly2017Report(theta, lambda, refCoeff_forPlotting )
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here

amplitude3layerP = abs(refCoeff_forPlotting{1,1});
phase3layerP = angle(refCoeff_forPlotting{1,1});
amplitude3layerS = abs(refCoeff_forPlotting{2,1});
phase3layerS = angle(refCoeff_forPlotting{2,1})+pi;
% amplitude4layer5nmP = abs(refCoeff_forPlotting{1,4});
% phase4layer5nmP = angle(refCoeff_forPlotting{1,4});
% amplitude4layer5nmS = abs(refCoeff_forPlotting{2,4});
% phase4layer5nmS = angle(refCoeff_forPlotting{2,4})+pi;
figure(3)
subplot(2,2,1)
surf(theta, lambda, amplitude3layerP)
shading flat
colorbar
view([0 90])
title('|r^P|')
xlabel('\theta')
ylabel('\lambda (nm)')
xlim([0 80])
subplot(2,2,2)
surf(theta, lambda,phase3layerP)
shading flat
colorbar
title('\phi^P')
xlabel('\theta')
ylabel('\lambda (nm)')
xlim([0 80])
view([0 90])
subplot(2,2,3)
surf(theta, lambda,amplitude3layerS)
shading flat
colorbar
title('|r^S|')
xlabel('\theta')
ylabel('\lambda (nm)')
xlim([0 80])
view([0 90])
subplot(2,2,4)
surf(theta, lambda,phase3layerS)
shading flat
colorbar
view([0 90])
title('\phi^S')
xlabel('\theta')
ylabel('\lambda (nm)')
xlim([0 80])
% 
% subplot(4,2,5)
% surf(theta, lambda, amplitude4layer5nmP)
% shading flat
% colorbar
% view([0 90])
% subplot(4,2,6)
% surf(theta, lambda,phase4layer5nmP)
% shading flat
% colorbar
% view([0 90])
% subplot(4,2,7)
% surf(theta, lambda,amplitude4layer5nmS)
% shading flat
% colorbar
% view([0 90])
% subplot(4,2,8)
% surf(theta, lambda,phase4layer5nmS)
% shading flat
% colorbar
% view([0 90])

diffPhi = diff(phase3layerP);
thisIsMax = find(diffPhi == max(max(diffPhi)));
rowMax = mod(thisIsMax, length(diffPhi(:,1)));
colMax = ceil(thisIsMax/length(diffPhi(:,1)));

phase3layerP_showMaxGrad = phase3layerP;
phase3layerP_showMaxGrad(rowMax,:) = max(max(phase3layerP_showMaxGrad));
phase3layerP_showMaxGrad(:,colMax) = max(max(phase3layerP_showMaxGrad));

figure(4)
subplot(1,2,1)
surf(theta, lambda,phase3layerP_showMaxGrad)
shading flat
colorbar
title('\phi^P')
xlabel('\theta')
ylabel('\lambda (nm)')
xlim([0 80])
view([0 90])
subplot(1,2,2)
plot(theta, max(diff(phase3layerP)))
title('Maximum value of d\phi^P/d\lambda')
ylabel('a.u.')
xlabel('\theta')
end

