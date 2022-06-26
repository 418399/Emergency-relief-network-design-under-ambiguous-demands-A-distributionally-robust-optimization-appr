clc;clear;
load SAVEDATA.mat;

PreparednessCost = SAVEDATA(:,1);
Objective = SAVEDATA(:,2);
TotalCost = SAVEDATA(:,3);
figure;
hold on;
%subplot(1,2,1)
plot(PreparednessCost,Objective);
plot(PreparednessCost,TotalCost);
%title('准备阶段成本投入对需求未满足惩罚成本的影响');
 
xlabel('Preparedness cost');
ylabel('Cost');

%subplot(1,2,2)
plot(PreparednessCost,TotalCost);
axis([0 2e+8 -2e+8 14e+8]);
xlabel('准备阶段成本投入(元)');
ylabel('总救援成本(元)');



