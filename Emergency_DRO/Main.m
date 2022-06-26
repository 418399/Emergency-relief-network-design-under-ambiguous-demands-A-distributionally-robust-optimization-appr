clc;
clear;
load DemandAve3;
load DemandMAD3;
load dij;
dij = dij*2;
price = [1,15,20,230];
volume = [0.001,0.1,0.005,0.2];
DemPerhead =  [10,5,6,1];
VL = [10000,20000,30000];
VPrice = [2,3,4];
Pai = 1000;
%% Model Building
model = rsome('DRO');
cjk = model.random(size(DemandAve,1),length(price));  % random demand
zjk = model.random(size(DemandAve,1),length(price));  % Auxiliary random demand

yil = model.decision(size(DemandAve,1),length(VL), 'B' );
rik = model.decision(size(DemandAve,1),length(price),'C' );
xij1 = model.decision( size(DemandAve,1),size(DemandAve,1),'C') ;
xij2 = model.decision( size(DemandAve,1),size(DemandAve,1),'C') ;
xij3 = model.decision( size(DemandAve,1),size(DemandAve,1),'C') ;
xij4 = model.decision( size(DemandAve,1),size(DemandAve,1),'C') ;




%% Ambiguity set
P = model.ambiguity; % Creat an ambiguity set P
% P Supportset Upper and Lower bound
for j = 1:size(DemandAve,1)
    for k = 1:length(price)
        P.suppset(cjk(j,k) <= DemandAve(j,k) * 1.2);
        P.suppset(cjk(j,k)  >= DemandAve(j,k) * 0.2);
        P.suppset( zjk(j,k) >= cjk(j,k) - DemandAve(j,k));
        P.suppset( zjk(j,k) >= DemandAve(j,k) - cjk(j,k) );
    end
end
 
%% P Expectset         
%AVERAGE
for j = 1:size(DemandAve,1) 
    for k = 1:length(price)
         P.exptset(expect( cjk(j,k) ) == DemandAve(j,k)  );
    end
end
% MAD
for j = 1:size(DemandAve,1)
    for k = 1:length(price)
        P.exptset(  expect( zjk(j,k)) <= DemandMAD(j,k)    );
    end
end
 
%% Dependent on
 

%% Objctive Functions
Obj = 0;
for i = 1:size(DemandAve,1)
    Obj = Obj +  yil(i,:)*VPrice' + rik(i,:)*price';
end

 for i = 1:size(DemandAve,1)
     for j = 1:size(DemandAve,1)
         Obj = Obj + dij(i,j) * (  xij1(i,j) + xij2(i,j) + xij3(i,j) + xij4(i,j) );
     end
 end

for j = 1:size(DemandAve,1)  % Penalty cost
    loss(4*j-3,:) =  {cjk(j,1) - sum( xij1(:,j) ) , 0} ;
    loss(4*j-2,:) =  {cjk(j,2) - sum( xij2(:,j) ) , 0} ;
    loss(4*j-1,:) = {cjk(j,3) - sum( xij3(:,j) ) , 0} ;
    loss(4*j,:) =  {cjk(j,4) - sum( xij4(:,j) ) , 0} ;
end

 LOSS = maxfun(loss);
 %LOSS =maxfun( {cjk(1,1) - sum( xij1(:,1) ) , 0} );
%% Constraints
for i = 1:size(DemandAve,1) %C4
    model.append(  sum(yil(i,:)) <=1   );
end

for i = 1:size(DemandAve,1) %C5
    model.append(    rik(i,:)  * volume'  <= yil(i,:) * VL'  );
end

for i = 1:size(DemandAve,1)  %C6
    model.append(sum(xij1(i,:)) <= rik(i,1)  );
    model.append(sum(xij2(i,:)) <= rik(i,2)  );
    model.append(sum(xij3(i,:)) <= rik(i,3)  );
    model.append(sum(xij4(i,:)) <= rik(i,4)  );
end
model.append(rik >= 0);  %C7-8
model.append(xij1 >= 0);
model.append(xij2 >= 0);
model.append(xij3 >= 0);
model.append(xij4 >= 0);

 %% 
model.with(P);
model.min(  Obj + Pai * expect(LOSS)  );  %%%%%%%%%%%%


%% Paramters Setting
%model.Param.solver = 'gurobi';
% model.Param.solver = 'CPLEX';
% model.Param.display = 1;
% model.Param.mipgap = 1e-2;

model.solve;

% Obj = model.get
% yil = yil.get
% rik = rik.get
% xij1 = xij1.get
% xij2 = xij2.get
% xij3 = xij3.get
% xij4 = xij4.get





