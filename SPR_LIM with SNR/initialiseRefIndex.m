function [ output_args ] = initialiseRefIndex( layersRefIndex, lambda )


%   When adding new material data remeber to check if n is completely real
%   (in which case use %f%f for importing) or complex (in which case use
%   %f%f%f). Also always check what units the wavelength is given in!

refIndexArray = zeros(length(lambda),length(layersRefIndex));
uniqueIndices = unique(layersRefIndex);
uniqueIndexArray = zeros(length(lambda),length(uniqueIndices));

%import and resample all the required n values
for counter = 1:length(uniqueIndices)
    if uniqueIndices(counter) == 1 % prism n = 1.774
        uniqueIndexArray(:,counter) = 1.774*ones(1,length(lambda));
    elseif uniqueIndices(counter) == 2
        fid_Au = fopen('n_Au.txt'); % Gold from RefractiveIndexInfo
        import_nAu = textscan(fid_Au, '%f%f%f');
        import_nAu = cell2mat(import_nAu);
        fclose(fid_Au);
        inRangeAu = import_nAu(:,1)*1E3 <= max(lambda)+100;
        import_nAu = [import_nAu(inRangeAu,1)*1E3 import_nAu(inRangeAu,2)+1i*import_nAu(inRangeAu,3)];
        uniqueIndexArray(:,counter) = interp1(import_nAu(:,1),import_nAu(:,2),lambda);
    elseif uniqueIndices(counter) == 3 % water = 1.33
        uniqueIndexArray(:,counter) = 1.33*ones(1,length(lambda));
    elseif uniqueIndices(counter) == 4 % water from RefractiveIndexInfo
        fid_H2O = fopen('n_H2O.txt');
        import_nH2O = textscan(fid_H2O, '%f%f%f');
        import_nH2O = cell2mat(import_nH2O);
        fclose(fid_H2O);
        inRangeH2O = import_nH2O(:,1)*1E3 <= max(lambda)+100;
        import_nH2O = [import_nH2O(inRangeH2O,1)*1E3 import_nH2O(inRangeH2O,2)+1i*import_nH2O(inRangeH2O,3)];
        uniqueIndexArray(:,counter) = interp1(import_nH2O(:,1),import_nH2O(:,2),lambda);
    elseif uniqueIndices(counter) == 5 % Aluminium from RefractiveIndexInfo
        fid_Al = fopen('n_Al.txt');
        import_nAl = textscan(fid_Al, '%f%f%f');
        import_nAl = cell2mat(import_nAl);
        fclose(fid_Al);
        inRangeAl = import_nAl(:,1)*1E3 <= max(lambda)+100;
        import_nAl = [import_nAl(inRangeAl,1)*1E3 import_nAl(inRangeAl,2)+1i*import_nAl(inRangeAl,3)];
        uniqueIndexArray(:,counter) = interp1(import_nAl(:,1),import_nAl(:,2),lambda);
    elseif uniqueIndices(counter) == 6 % Silver from RefractiveIndexInfo
        fid_Ag = fopen('n_Ag.txt');
        import_nAg = textscan(fid_Ag, '%f%f%f');
        import_nAg = cell2mat(import_nAg);
        fclose(fid_Ag);
        inRangeAg = import_nAg(:,1)*1E3 <= max(lambda)+100;
        import_nAg = [import_nAg(inRangeAg,1)*1E3 import_nAg(inRangeAg,2)+1i*import_nAg(inRangeAg,3)];
        uniqueIndexArray(:,counter) = interp1(import_nAg(:,1),import_nAg(:,2),lambda);
    elseif uniqueIndices(counter) == 7 %SiO2 from RefractiveIndexInfo
        fid_SiO2 = fopen('n_SiO2.txt');
        import_nSiO2 = textscan(fid_SiO2, '%f%f');
        import_nSiO2 = cell2mat(import_nSiO2);
        fclose(fid_SiO2);
        inRangeSiO2 = import_nSiO2(:,1)*1E3 <= max(lambda)+100;
        import_nSiO2 = [import_nSiO2(inRangeSiO2,1)*1E3 import_nSiO2(inRangeSiO2,2)];
        uniqueIndexArray(:,counter) = interp1(import_nSiO2(:,1),import_nSiO2(:,2),lambda);
    else
        display('Refractive Index not found!')
        return
    end
end

% fill RefIndexArray (above was done to not duplicate any importing)
for counter2 = 1:length(layersRefIndex)
    fillingIndex = uniqueIndices == layersRefIndex(counter2);
    refIndexArray(:,counter2) = uniqueIndexArray(:,fillingIndex);
end

output_args = refIndexArray;
end