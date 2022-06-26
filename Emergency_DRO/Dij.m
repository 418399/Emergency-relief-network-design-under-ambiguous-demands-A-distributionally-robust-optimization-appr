%%%������ľ������
% Distance from DC to shelters
clear;
Location = [105.23822	32.5841;
103.5903	31.47686;
103.85334	31.68163;
103.167	31.43659;
101.96254	30.04932;
101.70413	26.54639;
104.61947	28.76593;
104.85212	29.76416;
104.9211	28.58227;
104.3084544	33.38420315;
102.26746	27.88164;
106.54041	29.40268;
103.64662	30.98837;
103.95811	30.99018;
105.45636	30.35541;
103.10954	30.06982;
103.07879	29.24447;
104.67872	31.03304;
105.07459	29.59346;
104.7739	29.36371;
104.72458	31.75691;
104.56735	31.53465;
104.41702	31.14263];


DC = [
102 33;
102 32;
102.3 32.5;
102.7 32;
102 28.5;
103 28;
103.5 27.5;
104 26.5;
104.1 28.1;
104 33;
103.8 32.4;
105 27;
105.5 26.5;
105.5 27.5;
106 33;
106 29;
106.1 32;
106.5 32.5;
106.5 32.5;
106.3 28.5;
106.2 26.7;
106.5 33.1;
106.3 30;
] ;



%Location = [Location(1:end,:);Location(1:4,:);Location];
% DemandAve = [DemandAve(1:end,:);DemandAve(1:4,:);DemandAve];
% DemandMAD = [DemandMAD(1:end,:);DemandMAD(1:4,:);DemandMAD];


for i=1:size(Location,1)
    for j=1:size(Location,1)
        dist(i,j) = distance(Location(i,1),Location(i,2),DC(j,1),DC(j,2));
    end
end
dij  = 6371.004 * dist * pi/180;

save ( 'dij2020_11_29')


