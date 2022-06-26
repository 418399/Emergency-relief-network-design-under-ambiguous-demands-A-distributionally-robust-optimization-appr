clear;
clc;
%load TOTAL.mat;
load dij2020_11_29;
%% Location of diaster points
DP = [105.23822	32.5841;
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

% 
% load Save_Hybrid_Budget;
% HyDC = Save_Hybrid_Budget{1,2};
% HyShelter = Save_Hybrid_Budget{1,3};
% 
% load Save_PRob_Budget;
% PRDC = PureRobustData{1,2};
% PRShelter = PureRobustData{1,3};
% 
% load StochasticData;
% StoDC = StochasticData{1,2};
% StoShelter = StochasticData{1,3};
% 
% load DeterministicData;
% DetDC = DeterministicData{1,2};
% DetShelter = DeterministicData{1,3};

   figure;
hold on;

% xlim([-23, -22]);
% ylim([-44,-41]);
subplot(1,1,1)
[x1,y1] = find (yil ==1);
 

for a = 1:length(x1)
    if y1(a) == 1
       Dlevel1 =  plot(DC(x1(a),1), DC( x1(a),2  ), 'dk','MarkerSize',10 ,'MarkerFaceColor','k'  );
        hold on;
    end
    if y1(a) == 2
       Dlevel2 =  plot(DC(x1(a),1), DC( x1(a),2  ), 'sk','MarkerSize',10 ,'MarkerFaceColor','k'  );
        hold on;
    end
    if y1(a) == 3
       Dlevel3 = plot(DC(x1(a),1), DC( x1(a),2  ), 'vk'  ,'MarkerSize',10,'MarkerFaceColor','k' );
        hold on;
    end
end

for i = 1:size(yil,1)
    ss = plot(DP(i,1), DP(i,2  ), '.k' ,'MarkerSize',5,  'MarkerFaceColor','red');
    hold on;
end

% 
% for a1 = 1:length(x2)
%     if y2(a1) ==1
%      Slevel1 =    plot(Shelter(x2(a1),1), Shelter( x2(a1),2  ), 'dk','markerfacecolor' ,  'k'     );
%     end
%     
%     if y2(a1) == 2
%       Slevel2 =  plot(Shelter(x2(a1),1), Shelter( x2(a1),2  ), 'sk','markerfacecolor', 'k'     );
%     end
%     
%         if y2(a1) == 3
%      Slevel3 =    plot(Shelter(x2(a1),1), Shelter( x2(a1),2  ), 'vk','markerfacecolor', 'k'   );
%     end
%         
%         
% end
%axis([-22.9, -22 -44,-41]);
%title('设施选址决策');
xlabel('经度');
ylabel('纬度');
 set(gcf,'color','w')
legend([Dlevel1,Dlevel2,Dlevel3,ss], '等级 1', '等级 2', '等级 3','受灾点');

%ah=axes('position',get(gca,'position'),'visible','off');
%legend(ah,[Slevel1, Slevel2, Slevel3 ], 'Level 1','Level 2','Level 3'     );
% subplot(2,2,2)
% [x1,y1] = find (PRDC ==1);
% [x2,y2] = find (PRShelter ==1);
% 
% for a = 1:length(x1)
%     if y1(a) == 1
%         plot(DC(x1(a),1), DC( x1(a),2  ), 'dk'   );
%         hold on;
%     end
%     if y1(a) == 2
%         plot(DC(x1(a),1), DC( x1(1),2  ), 'sk'   );
%         hold on;
%     end
%     if y1(a) == 3
%         plot(DC(x1(a),1), DC( x1(1),2  ), 'vk'   );
%         hold on;
%     end
% end
% 
% for a1 = 1:length(x2)
%     if y2(a1) ==1
%         plot(Shelter(x2(a1),1), Shelter( x2(a1),2  ), 'dk','markerfacecolor','k'   );
%     end
%     
%     if y2(a1) == 2
%         plot(Shelter(x2(a1),1), Shelter( x2(a1),2  ), 'sk','markerfacecolor', 'k'   );
%     end
%     
%         if y2(a1) == 3
%         plot(Shelter(x2(a1),1), Shelter( x2(a1),2  ), 'vk','markerfacecolor','k'    );
%     end
% end
% axis([-22.9, -22 -44,-41]);
% title('Pure Robust');
% xlabel(' Longitude');
% ylabel('Latitude');
% 
% 
% subplot(2,2,3)
% [x1,y1] = find (StoDC ==1);
% [x2,y2] = find (StoShelter ==1);
% 
% for a = 1:length(x1)
%     if y1(a) == 1
%         plot(DC(x1(a),1), DC( x1(a),2  ), 'dk'   );
%         hold on;
%     end
%     if y1(a) == 2
%         plot(DC(x1(a),1), DC( x1(1),2  ), 'sk'   );
%         hold on;
%     end
%     if y1(a) == 3
%         plot(DC(x1(a),1), DC( x1(1),2  ), 'vk'   );
%         hold on;
%     end
% end
% 
% for a1 = 1:length(x2)
%     if y2(a1) ==1
%         plot(Shelter(x2(a1),1), Shelter( x2(a1),2  ), 'dk','markerfacecolor', 'k'      );
%     end
%     
%     if y2(a1) == 2
%         plot(Shelter(x2(a1),1), Shelter( x2(a1),2  ), 'sk','markerfacecolor', 'k'    );
%     end
%     
%         if y2(a1) == 3
%         plot(Shelter(x2(a1),1), Shelter( x2(a1),2  ), 'vk','markerfacecolor','k'    );
%     end
% end
% axis([-22.9, -22 -44,-41]);
% title('Stochastic');
% xlabel(' Longitude');
% ylabel('Latitude');
% 
% subplot(2,2,4)
% [x1,y1] = find (DetDC ==1);
% [x2,y2] = find (DetShelter ==1);
% 
% for a = 1:length(x1)
%     if y1(a) == 1
%         plot(DC(x1(a),1), DC( x1(a),2  ), 'dk'   );
%         hold on;
%     end
%     if y1(a) == 2
%         plot(DC(x1(a),1), DC( x1(1),2  ), 'sk'   );
%         hold on;
%     end
%     if y1(a) == 3
%         plot(DC(x1(a),1), DC( x1(1),2  ), 'vk'   );
%         hold on;
%     end
% end
% 
% for a1 = 1:length(x2)
%     if y2(a1) ==1
%         plot(Shelter(x2(a1),1), Shelter( x2(a1),2  ), 'dk','markerfacecolor', 'k'    );
%     end
%     
%     if y2(a1) == 2
%         plot(Shelter(x2(a1),1), Shelter( x2(a1),2  ), 'sk','markerfacecolor', 'k'     );
%     end
%     
%         if y2(a1) == 3
%         plot(Shelter(x2(a1),1), Shelter( x2(a1),2  ), 'vk','markerfacecolor','k'     );
%     end
% end
% axis([-22.9, -22 -44,-41]);
% title('Deterministic');
% xlabel(' Longitude');
% ylabel('Latitude');
% 
% 



%% penalty cost

cost = [6.19E+08	7.52E+08	7.60E+08	7.61E+08	7.61E+08
1.64E+09	3.49E+08	2.12E+08	0.00E+00	0.00E+00
4.70E+09	4.91E+09	4.97E+09	4.80E+09	4.80E+09] ;

penaltyfac = [0.6	0.8	1	1.2	1.4] ;
figure ()
hold on
Dlevel1 = plot(penaltyfac, cost(1,:) ,  '-vk') ;
Dlevel2 = plot(penaltyfac, cost(2,:),   '-ok') ;
Dlevel3 = plot(penaltyfac, cost(3,:),   '-sk') ;
xlabel('Penalty cost');
ylabel('Cost');
 set(gcf,'color','w')
legend([Dlevel1,Dlevel2,Dlevel3], 'Preparedness cost', 'Shortage cost', 'Total cost');



%% under test cases

data = [0	1	2	3	4	5	6
5.02E+09	5.02E+09	5.02E+09	5.02E+09	5.01E+09	5.01E+09	5.01E+09
2.12E+07	2.21E+07	1.85E+07	1.64E+07	1.32E+07	5.21E+06	4.73E+06] ;


y=[5.02E+09	2.12E+07;  5.02E+09	2.21E+07; 5.02E+09	1.85E+07;5.02E+09	1.64E+07;5.01E+09	1.32E+07;5.01E+09	5.21E+06;5.01E+09	4.73E+06   ];
b=bar(y);
grid on;
ch = get(b,'children');
set(gca,'XTickLabel',{'0','1','2','3','4','5','6'})
set(ch,'FaceVertexCData',[1 0 1;0 0 0;])
legend('基于XXX的算法','基于YYY的算法');
xlabel('x axis ');
ylabel('y axis');



