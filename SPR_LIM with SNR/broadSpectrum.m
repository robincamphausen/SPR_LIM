function [ output_args ] = broadSpectrum(intensity, LED, lambda )
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here
% global lambda

if LED ==625
% import source spectrum - note that wavelength is in nm
fid_mightex625 = fopen('mightex625.txt');
mightex625 = textscan(fid_mightex625, '%f%f');
mightex625 = cell2mat(mightex625);
fclose(fid_mightex625);
% mightex625(:,1) = mightex625(:,1)*1E-9;
mightex625(:,1) = mightex625(:,1);%*1E-9;
% Resample and normalise wavelength data
range625 = lambda >= min(mightex625(:,1)) & lambda <= max(mightex625(:,1));
mightex625 = interp1(mightex625(:,1),mightex625(:,2), lambda(range625));
mightex625 = mightex625-min(mightex625)/(max(mightex625)-min(mightex625));
mightex625 = mightex625/(trapz(abs(mightex625)));

broad625Int = zeros(1,length(intensity(1,:,1)),length(intensity(1,1,:)));
% size(intensity(range625,:,1))
% size(mightex625)
for alphaCounter_625 = 1:length(intensity(1,1,:))
%     mightex625* abs(intensity(range625,:,alphaCounter_625))
    broad625Int(:,:,alphaCounter_625) = mightex625* abs(intensity(range625,:,alphaCounter_625));
end

output_args = broad625Int;
    

else
% import source spectrum - note that wavelength is in nm
fid_mightex850 = fopen('mightex850.txt');
mightex850 = textscan(fid_mightex850, '%f%f');
mightex850 = cell2mat(mightex850);
fclose(fid_mightex850);
% mightex850(:,1) = mightex850(:,1)*1E-9;
mightex850(:,1) = mightex850(:,1);
% Resample and normalise wavelength data
range850 = lambda >= min(mightex850(:,1)) & lambda <= max(mightex850(:,1));
mightex850 = interp1(mightex850(:,1),mightex850(:,2), lambda(range850));
mightex850 = mightex850-min(mightex850)/(max(mightex850)-min(mightex850));
mightex850 = mightex850/(trapz(abs(mightex850)));

broad850Int = zeros(1,length(intensity(1,:,1)),length(intensity(1,1,:)));
% size(intensity(range850,:,1))
% size(mightex850)
for alphaCounter_850 = 1:length(intensity(1,1,:))
%     mightex850* abs(intensity(range850,:,alphaCounter_850))
    broad850Int(:,:,alphaCounter_850) = mightex850* abs(intensity(range850,:,alphaCounter_850));
end

output_args = broad850Int;

end

end


