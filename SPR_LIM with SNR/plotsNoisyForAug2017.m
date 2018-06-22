function [  ] = plotsNoisyForAug2017( phase, intensity, theta, intensityExact, phaseExact, PsiSin, PsiCos )
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here
% phaseDiff = zeros(length(phase(:,1))-1,length(phase(1,:)));
% intensityDiff = zeros(length(phase(:,1))-1,length(phase(1,:)));

% figure 1 ____________________________________________________________
for m = 1:length(phase(1,1,:))
    figure(1)
    subplot(5,2,2)
    hold on
    plot(theta,phase(1,:,m))
    subplot(5,2,1)
    hold on
    plot(theta,intensity(1,:,m))
    
    subplot(5,2,6)
    hold on
    plot(theta,phase(4,:,m))
    subplot(5,2,5)
    hold on
    plot(theta,intensity(4,:,m))
end

figure(1)
subplot(5,2,1)
hold on
% plot(theta, intensityExact(1,:),'LineWidth',3)
title('Intensity')
% xlabel('Exterior Angle')
ylabel('I(0nm)')
axis([theta(1) theta(end) -inf inf])
% set(gca, 'XTickLabelMode', 'manual', 'XTickLabel', []);
subplot(5,2,2)
hold on
% plot(theta, phaseExact(1,:),'LineWidth',3)
title('Phase')
% xlabel('Exterior Angle')
% ylabel('Phase (rad)')
ylabel('\phi (0nm)')
% set(gca, 'XTickLabelMode', 'manual', 'XTickLabel', []);
axis([theta(1) theta(end) -inf inf])
subplot(5,2,5)
% set(gca, 'XTickLabelMode', 'manual', 'XTickLabel', []);
hold on
% plot(theta, intensityExact(4,:),'LineWidth',3)
% title('I_{noisy} for 5nm SiO_2')
% xlabel('Exterior Angle')
% ylabel('Intensity (a.u.)')
ylabel('I(5nm)')
axis([theta(1) theta(end) -inf inf])
subplot(5,2,6)
% set(gca, 'XTickLabelMode', 'manual', 'XTickLabel', []);
hold on
% plot(theta, phaseExact(4,:),'LineWidth',3)
% title('\phi_{noisy} for 5nm SiO_2')
% xlabel('Exterior Angle')
ylabel('\phi (5nm)')
% ylabel('Phase (rad)')
axis([theta(1) theta(end) -inf inf])

% end of figure 1 -------------------------------------------------

% figure 2____________________________________________________________
figure(1)
subplot(5,2,3)
plot(theta,std(intensity(1,:,:),0,3))
% title('sd(I) for 0nm SiO_2')
ylabel('SD(I(0nm))')
axis([theta(1) theta(end) -inf inf])
% set(gca, 'XTickLabelMode', 'manual', 'XTickLabel', []);
subplot(5,2,4)
plot(theta,std(phase(1,:,:),0,3))
% title('sd(\phi) for 0nm SiO_2')
ylabel('SD(\phi(0nm))')
axis([theta(1) theta(end) -inf inf])
% set(gca, 'XTickLabelMode', 'manual', 'XTickLabel', []);

subplot(5,2,7)
plot(theta,std(intensity(4,:,:),0,3))
% title('sd(I) for 5nm SiO_2')
ylabel('SD(I(5nm))')
axis([theta(1) theta(end) -inf inf])
% set(gca, 'XTickLabelMode', 'manual', 'XTickLabel', []);
subplot(5,2,8)
plot(theta,std(phase(4,:,:),0,3))
% title('sd(\phi) for 5nm SiO_2')
ylabel('SD(\phi(5nm))')
axis([theta(1) theta(end) -inf inf])
% set(gca, 'XTickLabelMode', 'manual', 'XTickLabel', []);

subplot(5,2,9)
plot(theta,std(intensity(4,:,:)-intensity(1,:,:),0,3))
% title('sd(\DeltaI) (for 5nm SiO_2)')
ylabel('SD(\DeltaI)')
xlabel('Exterior Angle (º)')
axis([theta(1) theta(end) -inf inf])
subplot(5,2,10)
plot(theta,std(phase(4,:,:)-phase(1,:,:),0,3))
% title('sd(\Delta\phi) (for 5nm SiO_2)')
xlabel('Exterior Angle (º)')
ylabel('SD(\Delta\phi)')
axis([theta(1) theta(end) -inf inf])








% normSD_DIntensity = std(intensity(4,:,:)-intensity(1,:,:),0,3)./...
%     max(abs(intensityExact(4,:)-intensityExact(1,:)));
% normSD_DPhase = std(phase(4,:,:)-phase(1,:,:),0,3)./...
%     max(abs(phaseExact(4,:)-phaseExact(1,:)));
% 
% for mn = 1:length(phase(1,1,:))
%     figure(2)
%     subplot(1,2,2)
%     hold on
%     plot(theta,phase(4,:,mn)-phase(1,:,mn))
%     
% title('\Delta\phi_{noisy} for 5nm SiO_2')
% xlabel('Exterior Angle')
% ylabel('\Delta\phi (rad)')
% axis([theta(1) theta(end) -inf inf])
%     subplot(1,2,1)
%     hold on
%     plot(theta,intensity(4,:,mn)-intensity(1,:,mn))
%         title('\DeltaI_{noisy} for 5nm SiO_2')
%     xlabel('Exterior Angle')
%     ylabel('\DeltaI (a.u.)')
%     axis([theta(1) theta(end) -inf inf])
%     
% end


% 
% normSD_DIntensity = std(intensity(4,:,:)-intensity(1,:,:),0,3);
% normSD_DPhase = std(phase(4,:,:)-phase(1,:,:),0,3)/pi;

% figure(4)
% subplot(1,2,1)
% plot(theta,normSD_DIntensity)
% title('sd(\DeltaI)/max(\DeltaI) (for 5nm SiO_2)')
% axis([theta(1) theta(end) -inf inf])
% subplot(1,2,2)
% plot(theta,normSD_DPhase)
% title('sd(\Delta\phi)/max(\Delta\phi) (for 5nm SiO_2)')
% axis([theta(1) theta(end) -inf inf])

% figure(5)
% subplot(2,4,1)
% plot(theta, abs(PsiSin(1,:)),theta,abs(PsiCos(1,:)),'r')%, theta, abs(PsiSin(1,:))./(PsiCos(1,:)), 'g')
% legend('\Psi_{sin}','\Psi_{cos}')
% subplot(2,4,2)
% plot(theta, abs(PsiSin(2,:)),theta,abs(PsiCos(2,:)),'r')
% legend('\Psi_{sin}','\Psi_{cos}')
% subplot(2,4,3)
% plot(theta, abs(PsiSin(3,:)),theta,abs(PsiCos(3,:)),'r')
% legend('\Psi_{sin}','\Psi_{cos}')
% subplot(2,4,4)
% plot(theta, abs(PsiSin(4,:)),theta,abs(PsiCos(4,:)),'r')
% legend('\Psi_{sin}','\Psi_{cos}')
% subplot(2,4,[5:8])
% plot(theta, abs(PsiSin(1,:)),theta,abs(PsiCos(1,:)),theta, abs(PsiSin(2,:)),theta,abs(PsiCos(2,:)),...
%     theta, abs(PsiSin(3,:)),theta,abs(PsiCos(3,:)),theta, abs(PsiSin(4,:)),theta,abs(PsiCos(4,:)))

% figure(6)
% subplot(2,2,1)
% % plot(theta, phaseExact(1,:), theta, phaseExact(4,:))
% plot(theta, phaseExact(1,:), theta, phaseExact(2,:))
% % legend('0nm SiO_2','5nm SiO_2')
% legend('0nm SiO_2','1nm SiO_2')
% title('\phi')
% axis([theta(1) theta(end) -inf inf])
% subplot(2,2,2)
% % plot(theta, phaseExact(4,:)- phaseExact(1,:))
% % title('\Delta\phi (for 5nm SiO_2)')
% plot(theta, phaseExact(2,:)- phaseExact(1,:))
% title('\Delta\phi (for 1nm SiO_2)')
% axis([theta(1) theta(end) -inf inf])
% subplot(2,2,3)
% % plot(theta,std(phase(1,:,:),0,3),theta,std(phase(4,:,:),0,3))
% % legend('0nm SiO_2','5nm SiO_2')
% plot(theta,std(phase(1,:,:),0,3),theta,std(phase(2,:,:),0,3))
% legend('0nm SiO_2','1nm SiO_2')
% title('sd(\phi)')
% 
% axis([theta(1) theta(end) -inf inf])
% subplot(2,2,4)
% % plot(theta,std(phase(4,:,:)-phase(1,:,:),0,3))
% % title('sd(\Delta\phi) (for 5nm SiO_2)')
% 
% plot(theta,std(phase(2,:,:)-phase(1,:,:),0,3))
% title('sd(\Delta\phi) (for 1nm SiO_2)')
% axis([theta(1) theta(end) -inf inf])
% % 
% for n = 1:length(phase(:,1))-1
%     phaseDiff(n,:) = phase(n+1,:) - phase(1,:);
%     intensityDiff(n,:) = intensity(n+1,:) - intensity(1,:);
%     
%     figure(2)
%     subplot(1,2,2)
%     hold on
%     plot(theta,phaseDiff(n,:))
%     subplot(1,2,1)
%     hold on
%     plot(theta,intensityDiff(n,:))
%     
% end
% 
% figure(1)
% subplot(1,2,1)
% title('Intensity')
% xlabel('Angle')
% ylabel('Intensity (a.u.)')
% legend('0nm','1nm','2.5nm','5nm')
% subplot(1,2,2)
% title('Phase')
% xlabel('Angle')
% ylabel('Phase (rad)')
% legend('0nm','1nm','2.5nm','5nm')
% 
% figure(2)
% subplot(1,2,1)
% title('Difference in Intensity')
% xlabel('Angle')
% ylabel('\Delta I (a.u.)')
% legend('1nm','2.5nm','5nm')
% subplot(1,2,2)
% title('Difference in Phase')
% xlabel('Angle')
% ylabel('\Delta \phi (rad)')
% legend('1nm','2.5nm','5nm')
end

