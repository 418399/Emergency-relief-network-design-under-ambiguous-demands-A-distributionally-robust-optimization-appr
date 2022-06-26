clc;
clear;
%tic
% load BaseVictimsNum;
% %% ALL CASES
% load AVEb;
% load MADb;

%% PART OF THE CASES
load AVESAVE;
load MADSAVE;
%%
load dij2020_11_29;
dij = dij*2;
price = [1,15,20,230];
volume = [0.001,0.1,0.005,0.2];
DemPerhead =  [10,5,6,1];
VL = [10000,20000,30000];
VL = VL*10 ;
VPrice = [500000,600000,700000];
% Pen = [80,500,400,4000];
Pen = [100,150,200,300];
Pen = Pen*2;
B = [
15453	42000
23000	24000
34583	59000
8183	20000
300	200000
49000	550000
7000	38000
339	2464
140000	240000
175	205000
12000	13010
7000	12000
4388	5000
5770	400000
16	2000
1351	450000
534	26000
420	2000
225	1133
83	13000
200	9483
9693	166732
21020	71805];		

%% 循环记录求解结果
for aaa = 1:size(AVESAVE,2)  %% 不同数据规模
    aaa=10
    DemandAve = AVESAVE(:,aaa) * [10 5 6 1]  ;
    DemandMAD = MADSAVE(:,aaa) * [10 5 6 1]  ;
    %% Model Building
    model = xprog('DRO');
    yil = model.decision(size(DemandAve,1),length(VL), 1 );
    rik = model.decision(size(DemandAve,1),length(price),0 );
    
    ojk = model.recourse(size(DemandAve,1),length(price),0);  % 辅助变量-代替取正函数
    
    xij1 = model.decision( size(DemandAve,1),size(DemandAve,1),0) ;
    xij2 = model.decision( size(DemandAve,1),size(DemandAve,1),0) ;
    xij3 = model.decision( size(DemandAve,1),size(DemandAve,1),0) ;
    xij4 = model.decision( size(DemandAve,1),size(DemandAve,1),0) ;
    
    cjk = model.random(size(DemandAve,1),length(price));  % random demand
    zjk = model.random(size(DemandAve,1),length(price));  % Auxiliary random demand
    
%     ojk.depend(cjk);
%     ojk.depend(zjk);
    
    for j = 1:size(DemandAve,1)
        for k = 1:length(price)
            aa = cjk(j,k);
            bb = DemandAve(j,k);
            cc = zjk(j,k);
            dd = DemandMAD(j,k);
            model.uncertain(expect( aa) == bb) ; % cjk的均值
            model.uncertain(expect( cc ) <= dd ); % 辅助变量的MAD
        end
    end
    
    
    for j = 1:size(DemandAve,1)
        for k = 1:length(price)
            model.uncertain(cjk(j,k) <= DemandAve(j,k) * 1.2);  % cjk的上下界
            model.uncertain(cjk(j,k)  >= DemandAve(j,k) * 0.8);
%             model.uncertain(cjk(j,k) <= B(j,2) * DemPerhead(k) );  % cjk的上下界
%               model.uncertain(cjk(j,k)  >= B(j,1) *DemPerhead(k) );
            model.uncertain( zjk(j,k) >= cjk(j,k) - DemandAve(j,k)); % zjk 引入的辅助变量
            model.uncertain( zjk(j,k) >= DemandAve(j,k) - cjk(j,k) );
        end
    end
    
    Obj = 0;
    %% Objctive Functions
    for i = 1:size(DemandAve,1)  % 目标函数-1
        Obj = Obj +  yil(i,:) * VPrice' + rik(i,:) * price';
    end
    
    for i = 1:size(DemandAve,1)  % 目标函数-2
        for j = 1:size(DemandAve,1)
            Obj = Obj + dij(i,j) * (  xij1(i,j) + xij2(i,j) + xij3(i,j) + xij4(i,j) );
        end
    end
    
    %% Constraints
    for i = 1:size(DemandAve,1)  % C4
        model.add(  sum(yil(i,:)) <=1   );
    end
    
    for i = 1:size(DemandAve,1) % C5
        model.add(  rik(i,:) * volume' <= yil(i,:) * VL'  );
    end
    
    for i = 1:size(DemandAve,1)  %C6
        model.add(sum(xij1(i,:)) <= rik(i,1)  );
        model.add(sum(xij2(i,:)) <= rik(i,2)  );
        model.add(sum(xij3(i,:)) <= rik(i,3)  );
        model.add(sum(xij4(i,:)) <= rik(i,4)  );
    end
    model.add(rik >= 0);  %C7-8
    model.add(xij1 >= 0);
    model.add(xij2 >= 0);
    model.add(xij3 >= 0);
    model.add(xij4 >= 0);
    
    model.add(ojk>= 0);
    
    for j = 1:size(DemandAve,1) % 引入辅助变量所需满足的条件
        model.add( ojk(j,1) >= cjk(j,1) - sum( xij1(:,j) ) );
        model.add( ojk(j,2) >= cjk(j,2) - sum( xij2(:,j) ) );
        model.add( ojk(j,3) >= cjk(j,3) - sum( xij3(:,j) ) );
        model.add( ojk(j,4) >= cjk(j,4) - sum( xij4(:,j) ) );
    end
    
    model.min( Obj + expect(sum(ojk) * Pen' )   )    ; % 目标函数
    model.Param.MIPGap = 10e-2;
    model.Param.DecRand = 1;
    model.solve;
    
    objective = model.get
    yil = yil.get;
    rik = rik.get;
    xij1 = xij1.get;
    xij2 = xij2.get;
    xij3 = xij3.get;
    xij4 = xij4.get;
    ojk = ojk.get;
 
    
OBJ_save(aaa) = objective;
Y_save(aaa) = {yil};
R_save(aaa) = {rik};
    
end
%     name = num2str(aaa);
%     save(name,'objective','TotalCost','yil','rik','xij1','xij2','xij3','xij4');
%     SAVEDATA(a,1) = aaa;
%     SAVEDATA(a,2) = objective;
%     SAVEDATA(a,3) = TotalCost;
% end
% save('SAVEDATA', 'SAVEDATA')
% yil = Y_save{1,10};
% rik = R_save{1,10};
% Obj = OBJ_save(1,10);
% save('Solution_AR', 'yil', 'rik', 'Obj'   )

