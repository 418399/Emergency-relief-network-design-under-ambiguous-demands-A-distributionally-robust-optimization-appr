clc;
clear;
load dij2020_11_29;
mad08 = [
    1 	0 	0
    0 	0 	0
    1 	0 	0
    1 	0 	0
    1 	0 	0
    0 	0 	0
    0 	1 	0
    0 	0 	0
    0 	0 	1
    0 	1 	0
    0 	1 	0
    0 	0 	1
    0 	0 	0
    0 	0 	0
    0 	1 	0
    1 	0 	0
    0 	0 	1
    0 	0 	0
    0 	0 	0
    0 	0 	0
    0 	0 	0
    0 	0 	0
    0 	0 	0];

mad1 = [  1 	0 	0
    0 	0 	0
    1 	0 	0
    1 	0 	0
    1 	0 	0
    0 	0 	0
    0 	1 	0
    0 	0 	0
    0 	0 	1
    0 	1 	0
    0 	1 	0
    0 	0 	1
    0 	0 	0
    0 	0 	0
    0 	0 	1
    0 	1 	0
    0 	0 	1
    0 	0 	0
    1 	0 	0
    0 	0 	0
    0 	0 	0
    0 	0 	0
    0 	0 	0];

mad12 = [1 	0 	0
    0 	0 	0
    1 	0 	0
    1 	0 	0
    0 	1 	0
    0 	0 	0
    0 	0 	1
    0 	0 	0
    0 	0 	1
    0 	1 	0
    0 	1 	0
    0 	0 	1
    0 	0 	0
    0 	0 	0
    0 	0 	1
    0 	0 	1
    0 	0 	1
    0 	0 	0
    1 	0 	0
    0 	0 	0
    0 	0 	0
    0 	0 	0
    0 	0 	0 ];


figure;
hold on;

[x1,y1] = find (mad08 ==1);
for a = 1:length(x1)
    if y1(a) == 1
        Dlevel1 =  plot(DC(x1(a),1), DC( x1(a),2  ), 'dk','MarkerSize', 25 ,'MarkerFaceColor','w');
        hold on;
    end
    if y1(a) == 2
        Dlevel2 =  plot(DC(x1(a),1), DC( x1(a),2  ), 'sk','MarkerSize', 25,'MarkerFaceColor','w' );
        hold on;
    end
    if y1(a) == 3
        Dlevel3 = plot(DC(x1(a),1), DC( x1(a),2  ), 'vk'  ,'MarkerSize', 25,'MarkerFaceColor','w'  );
        hold on;
    end
end

[x2,y2] = find (mad1 ==1);
for a = 1:length(x2)
    if y2(a) == 1
        mad21 =  plot(DC(x2(a),1), DC( x2(a),2  ), 'dk','MarkerSize',15,'MarkerFaceColor','k'   );
        hold on;
    end
    if y2(a) == 2
        mad22 =  plot(DC(x2(a),1), DC( x2(a),2  ), 'sk','MarkerSize',15,'MarkerFaceColor','k'  );
        hold on;
    end
    if y2(a) == 3
        mad23 = plot(DC(x2(a),1), DC( x2(a),2  ), 'vk'  ,'MarkerSize',15,'MarkerFaceColor','k' );
        hold on;
    end
end


[x3,y3] = find (mad12 ==1);
for a = 1:length(x3)
    if y3(a) == 1
        mad31 =  plot(DC(x3(a),1), DC( x3(a),2  ), 'dw','MarkerSize',7,'MarkerFaceColor','r'   );
        hold on;
    end
    if y3(a) == 2
        mad32 =  plot(DC(x3(a),1), DC( x3(a),2  ), 'sw','MarkerSize',7,'MarkerFaceColor','r'  );
        hold on;
    end
    if y3(a) == 3
        mad33 = plot(DC(x3(a),1), DC( x3(a),2  ), 'vw'  ,'MarkerSize',7,'MarkerFaceColor','r' );
        hold on;
    end
end





xlabel('¾­¶È');
ylabel('Î³¶È');
 set(gcf,'color','w')
%h1 = legend([Dlevel1,Dlevel2,Dlevel3], 'Level 1', 'Level 2', 'Level 3');
% axis([-22.9, -22] [-44,-41]);

 
h2 = legend([mad21,mad22,mad23], 'Level 1', 'Level 2', 'Level 3');


%h3 =  legend([mad31,mad32,mad33], 'Level 1', 'Level 2', 'Level 3');







