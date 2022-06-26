clc; clear;
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
Pen = 240;
DemandAve = AVESAVE(:,1) * [10 5 6 1]  ;
DemandMAD = MADSAVE(:,1) * [10 5 6 1]  ;
dUp = DemandAve * 1.2;
dLo = DemandAve * 0.8;

yil = binvar(size(DemandAve,1),length(VL),'full' );
rik = sdpvar(size(DemandAve,1),length(price),'full');
xijk = sdpvar( size(DemandAve,1),size(DemandAve,1),length(price),'full') ;

n0jk = sdpvar(size(DemandAve,1),length(price),'full');
n1jk = sdpvar(size(DemandAve,1),length(price),'full');
n2jk = sdpvar(size(DemandAve,1),length(price),'full');

etajk = sdpvar(size(DemandAve,1),length(price),'full');
deltajk = sdpvar(size(DemandAve,1),length(price),'full');
theta = sdpvar(1,1,'full');

alpha0jk = sdpvar(size(DemandAve,1),length(price),'full');
beta0jk = sdpvar(size(DemandAve,1),length(price),'full');
gama0jk = sdpvar(size(DemandAve,1),length(price),'full');
theta0jk = sdpvar(size(DemandAve,1),length(price),'full');

alpha3jk = sdpvar(size(DemandAve,1),length(price),'full');
beta3jk = sdpvar(size(DemandAve,1),length(price),'full');
gama3jk = sdpvar(size(DemandAve,1),length(price),'full');
theta3jk = sdpvar(size(DemandAve,1),length(price),'full');


alpha1jk = sdpvar(size(DemandAve,1),length(price),'full');
beta1jk = sdpvar(size(DemandAve,1),length(price),'full');
gama1jk = sdpvar(size(DemandAve,1),length(price),'full');
theta1jk = sdpvar(size(DemandAve,1),length(price),'full');

%% Objctive Functions
Obj = 0;
for i = 1:size(DemandAve,1)
    Obj = Obj +  yil(i,:) * VPrice' + rik(i,:) * price';
end

for i = 1:size(DemandAve,1)
    for j = 1:size(DemandAve,1)
        Obj = Obj + dij(i,j) * sum(xijk(i,j,:) );
    end
end

Objtemp = 0;
for j = 1:size(DemandAve,1)
    for k = 1:size(price,2)
        Obj = Obj + Pen * ( etajk(j,k)*DemandAve(j,k) + deltajk(j,k)*DemandMAD(j,k) ) ;
    end
end
Obj = Obj + theta * Pen ;

%% Consttraints
F = [];
for i = 1:size(DemandAve,1)  % C4
    F = [F, sum(yil(i,:)) <=1  ]  ;
end

for i = 1:size(DemandAve,1) % C5
    F = [F, rik(i,:) * volume' <= yil(i,:) * VL' ] ;
end

for i = 1:size(DemandAve,1)  %C6
    for k = 1:size(price,2)
        F = [F, sum(xijk(i,:,k)) <= rik(i,k) ];
    end
end

for j = 1:size(DemandAve,1)
    for k = 1:size(price,2)
        F = [F, theta - n0jk(j,k) >= dUp(j,k)*alpha0jk(j,k) - dLo(j,k)*beta0jk(j,k) + DemandAve(j,k)*(gama0jk(j,k) - theta0jk(j,k))   ] ;
    end
end

for j = 1:size(DemandAve,1)
    for k = 1:size(price,2)
        F = [F, alpha0jk(j,k) - beta0jk(j,k) + gama0jk(j,k) - theta0jk(j,k) >= sum(sum( n1jk(j,k) - etajk(j,k) ))   ] ;
    end
end


for j = 1:size(DemandAve,1)
    for k = 1:size(price,2)
        F = [F,  gama0jk(j,k) + theta0jk(j,k) <= sum(sum( deltajk(j,k) - n2jk(j,k) ))  ] ;
    end
end

for j = 1:size(DemandAve,1)
    for k = 1:size(price,2)
        F = [F,  n0jk(j,k) + sum(xijk(:,j,k)) >= dUp(j,k)*alpha3jk(j,k) - dLo(j,k)*beta3jk(j,k) + DemandAve(j,k)*(gama3jk(j,k) - theta3jk(j,k))   ] ;
    end
end

for j = 1:size(DemandAve,1)
    for k = 1:size(price,2)
        F = [F, alpha3jk(j,k) - beta3jk(j,k) + gama3jk(j,k) - theta3jk(j,k) >= 1 - sum(sum( n1jk(j,k) ))   ] ;
    end
end

for j = 1:size(DemandAve,1)
    for k = 1:size(price,2)
        F = [F,  gama3jk(j,k) + theta3jk(j,k) >= sum(sum(n2jk(j,k) ))  ] ;
    end
end

for j = 1:size(DemandAve,1)
    for k = 1:size(price,2)
        F = [F, n0jk(j,k) >= dUp(j,k)*alpha1jk(j,k) - dLo(j,k)*beta1jk(j,k) + DemandAve(j,k)*(gama1jk(j,k) - theta1jk(j,k))   ] ;
    end
end



for j = 1:size(DemandAve,1)
    for k = 1:size(price,2)
        F = [F, alpha1jk(j,k) - beta1jk(j,k) + gama1jk(j,k) - theta1jk(j,k) >= 1 - sum(sum( n1jk(j,k) ))   ] ;
    end
end

for j = 1:size(DemandAve,1)
    for k = 1:size(price,2)
        F = [F,  gama1jk(j,k) + theta1jk(j,k) >= sum(sum(n2jk(j,k) ))  ] ;
    end
end

F = [F, rik >=0, xijk>=0, alpha0jk >=0,  beta0jk>=0,   gama0jk>=0,   theta0jk>=0, deltajk>=0 ]  ;
F = [F,  alpha3jk>=0,  beta3jk>=0,  gama3jk>=0,  theta3jk>=0, alpha1jk>=0,  beta1jk>=0,  gama1jk>=0,  theta1jk>=0 ]  ;


ops = sdpsettings('solver','gurobi','verbose',0);
solmp=solvesdp(F,Obj,ops );
solmp.info

Obj = value(Obj)  ;
yil = value(yil)  ;
rik = value(rik) ;





