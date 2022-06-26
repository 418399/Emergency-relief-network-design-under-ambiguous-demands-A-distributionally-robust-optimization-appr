clc;clear;
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

 
column = 100;
A = zeros(size(B,1), column);
for i = 1:size(B,1)
    TEMP  = B(i,1)+(B(i,2)-B(i,1))*rand(1,column) ;
    A(i,:) = TEMP;
end

recordnum = 0;
for ii = 100:2000:20000
a = A(:,1:ii)   ;
recordnum = recordnum +1;

AVEa = mean(a,2);
%AVEb = mean(b,2);
MADa = zeros(size(a,1),1);
%MADb = zeros(size(b,1),1);
for i = 1:size(a,1)
    for j = 1:size(a,2)
        MADa(i) = MADa(i) + abs(a(i,j) - AVEa(i))    ;
    end
end

MADa = MADa/size(a,2);


MADSAVE(:,recordnum) = MADa;
AVESAVE(:,recordnum) = AVEa;
end

sumAVE = sum(AVESAVE,1)  ;
sumMAD = sum(MADSAVE,1)  ;

[X,Y] = sort(sumAVE,'descend');
[W,S] = sort( sumMAD, 'descend')  ;
 





% for k = 1: size(sumMAD,2 )-1
%     minuAVE(k) = sumAVE(k) - sumAVE(k+1)  ;
%     minuMAD(k) = sumMAD(k) - sumMAD(k+1)  ;
% end
% 
% tempave = minuAVE >=0;
% tempmad = minuMAD >=0;
% 
% if sum(tempave) ==  length(tempave) && sum(tempmad) == length(tempmad)
%     stop = 1;
% end

 

% for i = 1:size(b,1)
%     for j = 1:size(b,2)
%         MADb(i) = MADb(i) + abs(b(i,j) - AVEb(i));
%     end
% end
% MADb = MADb/size(b,2);

%sum(MADb)  - sum(MADa) 

% save('BaseVictimsNum', 'A')
% save('AVEb',  'AVEb');
% save('MADb','MADb');
% save('AVEa',  'AVEa');
% save('MADa','MADa');
