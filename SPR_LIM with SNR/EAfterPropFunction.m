function [ Ex_afterSP2, Ey_afterSP2 ] = EAfterPropFunction( inputPol, SP1, SP2, refP, refS, alpha1, alpha2)
% EAfterPropFunction gives Ex and Ey, lambda*theta*alpha1*alpha2 (length of
% all) sized array of x and y electric fields after SP2

if length(alpha1) == 1
    E_beforeSPR = SP1*inputPol;
    Ex_afterSPR = refP*E_beforeSPR(1);
    Ey_afterSPR = refS*E_beforeSPR(2);
else
    E_beforeSPR = zeros(2,1,length(alpha1));
    for loop1 = 1:length(alpha1)
        E_beforeSPR(:,:,loop1) = SP1(:,:,loop1)*inputPol;
    end
    Ex_afterSPR = repmat(E_beforeSPR(1,:,:),[length(refP(:,1)),length(refP(1,:)),1])...
        .*repmat(refP,[1,1,length(alpha1)]);
    Ey_afterSPR = repmat(E_beforeSPR(2,:,:),[length(refS(:,1)),length(refS(1,:)),1])...
        .*repmat(refS,[1,1,length(alpha1)]);
end

if length(alpha2) == 1
     Ex_afterSP2 = SP2(1,1)*Ex_afterSPR + SP2(1,2)*Ey_afterSPR;
     Ey_afterSP2 = SP2(2,1)*Ex_afterSPR + SP2(2,2)*Ey_afterSPR;
else
    SP2forMulti = zeros(2,2,1,length(alpha2));
    SP2forMulti(:,:,1,:) = SP2(:,:,:);
    Ex_afterSP2 = repmat(SP2forMulti(1,1,:,:), [length(refP(:,1)),length(refP(1,:)),length(alpha1),1])...
        .*repmat(Ex_afterSPR,[1,1,1,length(alpha2)])...
        + repmat(SP2forMulti(1,2,:,:), [length(refP(:,1)),length(refP(1,:)),length(alpha1),1])...
        .*repmat(Ey_afterSPR,[1,1,1,length(alpha2)]);
    Ey_afterSP2 = repmat(SP2forMulti(2,1,:,:), [length(refP(:,1)),length(refP(1,:)),length(alpha1),1])...
        .*repmat(Ex_afterSPR,[1,1,1,length(alpha2)])...
        + repmat(SP2forMulti(2,2,:,:), [length(refP(:,1)),length(refP(1,:)),length(alpha1),1])...
        .*repmat(Ey_afterSPR,[1,1,1,length(alpha2)]);
end
end

