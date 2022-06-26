clc;
clear;
load DemandAve;
load DemandMAD;
DemandAve = [DemandAve(1:4,:);DemandAve;DemandAve]  ;
DemandMAD = [DemandMAD(1:4,:);DemandMAD;DemandMAD]  ;

for j = 1:size(DemandAve,1)
    
    STOP = 1;
    while STOP ==1
        SPDemand(j,:) = DemandAve(j,:) + DemandMAD(j,:) .* randn(1,4);
        a = sum( abs(SPDemand(j,:) - DemandAve(j,:)) <=DemandMAD(j,:) );
        if a ==4
            STOP = 0;
        end
    end
    
   % SPDemand(j,:) = aaa;
end
%save aaa
save('SPDemand50','SPDemand');