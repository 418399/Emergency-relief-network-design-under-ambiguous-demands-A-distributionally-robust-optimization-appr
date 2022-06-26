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
%title('׼���׶γɱ�Ͷ�������δ����ͷ��ɱ���Ӱ��');
 
xlabel('Preparedness cost');
ylabel('Cost');

%subplot(1,2,2)
plot(PreparednessCost,TotalCost);
axis([0 2e+8 -2e+8 14e+8]);
xlabel('׼���׶γɱ�Ͷ��(Ԫ)');
ylabel('�ܾ�Ԯ�ɱ�(Ԫ)');



