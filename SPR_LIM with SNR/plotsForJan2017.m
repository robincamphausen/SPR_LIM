function [  ] = plotsForJan2017( phase, intensity, theta )
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here
phaseDiff = zeros(length(phase(:,1))-1,length(phase(1,:)));
intensityDiff = zeros(length(phase(:,1))-1,length(phase(1,:)));

for m = 1:length(phase(:,1))
% for m = 1:2
    figure(1)
    subplot(1,2,2)
    hold on
    plot(theta,phase(m,:))
    subplot(1,2,1)
    hold on
    plot(theta,intensity(m,:))
    
end

for n = 1:length(phase(:,1))-1
% for n = 1:2
    phaseDiff(n,:) = phase(n+1,:) - phase(1,:);
    intensityDiff(n,:) = intensity(n+1,:) - intensity(1,:);
    
    figure(2)
    subplot(1,2,2)
    hold on
    plot(theta,phaseDiff(n,:))
    subplot(1,2,1)
    hold on
    plot(theta,intensityDiff(n,:))
    
end

figure(1)
subplot(1,2,1)
title('Intensity')
xlabel('Exterior Angle')
ylabel('Intensity (a.u.)')
legend('0nm','1nm','2.5nm','5nm')
% axis([theta(1) theta(end) -inf inf])
axis([20 60 -inf inf])
subplot(1,2,2)
title('Phase')
xlabel('Exterior Angle')
ylabel('Phase (rad)')
legend('0nm','1nm','2.5nm','5nm')
% axis([theta(1) theta(end) -inf inf])
axis([20 60 -inf inf])

figure(2)
subplot(1,2,1)
title('Difference in Intensity')
xlabel('Exterior Angle')
ylabel('\Delta I (a.u.)')
legend('1nm','2.5nm','5nm')
% axis([theta(1) theta(end) -inf inf])
axis([20 60 -inf inf])
subplot(1,2,2)
title('Difference in Phase')
xlabel('Exterior Angle')
ylabel('\Delta \phi (rad)')
legend('1nm','2.5nm','5nm')
% axis([theta(1) theta(end) -inf inf])
axis([20 60 -inf inf])
end

