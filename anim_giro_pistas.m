%%**************************ANIMACIÓN DE LAS PISTAS GIRANDO****************

xp1 = xpar{1};
yp1 = ypar{1};
xp2 = xpar{2};
yp2 = ypar{2};
xp3 = xpar{3};
yp3 = ypar{3};
xp4 = xpar{4};
yp4 = ypar{4};
xp5 = xpar{5};
yp5 = ypar{5};
xp6 = xpar{6};
yp6 = ypar{6};
xp7 = xpar{7};
yp7 = ypar{7};
giro_simu = X(:,5)';
xs = X(:,1);
ys = X(:,3);


%***********RECTAS******************
% mxl1=zeros(length(giro_simu),length(xl1));
% myl1=zeros(length(giro_simu),length(yl1));
% for i=1:length(giro_simu)
%     for j=1:length(xl1)
%         mxl1(i,j)=xl1(j)*ma(i)-yl1(j)*mb(i);
%         myl1(i,j)=xl1(j)*mb(i)+yl1(j)*ma(i);
%     end
% end
% 
% mxl2=zeros(length(giro_simu),length(xl2));
% myl2=zeros(length(giro_simu),length(yl2));
% for i=1:length(giro_simu)
%     for j=1:length(xl2)
%         mxl2(i,j)=xl2(j)*ma(i)-yl2(j)*mb(i);
%         myl2(i,j)=xl2(j)*mb(i)+yl2(j)*ma(i);
%     end
% end
% 
% mxl3=zeros(length(giro_simu),length(xl3));
% myl3=zeros(length(giro_simu),length(yl3));
% for i=1:length(giro_simu)
%     for j=1:length(xl3)
%         mxl3(i,j)=xl3(j)*ma(i)-yl3(j)*mb(i);
%         myl3(i,j)=xl3(j)*mb(i)+yl3(j)*ma(i);
%     end
% end
% 
% mxl4=zeros(length(giro_simu),length(xl4));
% myl4=zeros(length(giro_simu),length(yl4));
% for i=1:length(giro_simu)
%     for j=1:length(xl4)
%         mxl4(i,j)=xl4(j)*ma(i)-yl4(j)*mb(i);
%         myl4(i,j)=xl4(j)*mb(i)+yl4(j)*ma(i);
%     end
% end


%********PARABOLAS****************
% mx=zeros(length(giro_simu),length(xp));
% my=zeros(length(giro_simu),length(yp));
% for i=1:length(giro_simu)
%     ma(i) = cos(giro_simu);
%     mb(i) = sin(giro_simu);
%     for j=1:length(xp)
%         mx(i,j)=xp(j)*ma(i)-yp(j)*mb(i);
%         my(i,j)=xp(j)*mb(i)+yp(j)*ma(i);
%     end
% end


mx1=zeros(length(giro_simu),length(xp1));
my1=zeros(length(giro_simu),length(yp1));
for i=1:length(giro_simu)
    ma(i) = cos(giro_simu(i));
    mb(i) = sin(giro_simu(i));
    for j=1:length(xp1)
        mx1(i,j)=xp1(j)*ma(i)-yp1(j)*mb(i);
        my1(i,j)=xp1(j)*mb(i)+yp1(j)*ma(i);
    end
end

mx2=zeros(length(giro_simu),length(xp2));
my2=zeros(length(giro_simu),length(yp2));
for i=1:length(giro_simu)
    for j=1:length(xp2)
        mx2(i,j)=xp2(j)*ma(i)-yp2(j)*mb(i);
        my2(i,j)=xp2(j)*mb(i)+yp2(j)*ma(i);
    end
end

mx3=zeros(length(giro_simu),length(xp3));
my3=zeros(length(giro_simu),length(yp3));
for i=1:length(giro_simu)
    for j=1:length(xp3)
        mx3(i,j)=xp3(j)*ma(i)-yp3(j)*mb(i);
        my3(i,j)=xp3(j)*mb(i)+yp3(j)*ma(i);
    end
end

mx4=zeros(length(giro_simu),length(xp4));
my4=zeros(length(giro_simu),length(yp4));
for i=1:length(giro_simu)
    for j=1:length(xp4)
        mx4(i,j)=xp4(j)*ma(i)-yp4(j)*mb(i);
        my4(i,j)=xp4(j)*mb(i)+yp4(j)*ma(i);
    end
end

mx5=zeros(length(giro_simu),length(xp5));
my5=zeros(length(giro_simu),length(yp5));
for i=1:length(giro_simu)
    for j=1:length(xp5)
        mx5(i,j)=xp5(j)*ma(i)-yp5(j)*mb(i);
        my5(i,j)=xp5(j)*mb(i)+yp5(j)*ma(i);
    end
end

mx6=zeros(length(giro_simu),length(xp6));
my6=zeros(length(giro_simu),length(yp6));
for i=1:length(giro_simu)
    for j=1:length(xp6)
        mx6(i,j)=xp6(j)*ma(i)-yp6(j)*mb(i);
        my6(i,j)=xp6(j)*mb(i)+yp6(j)*ma(i);
    end
end

mx7=zeros(length(giro_simu),length(xp7));
my7=zeros(length(giro_simu),length(yp7));
for i=1:length(giro_simu)
    for j=1:length(xp7)
        mx7(i,j)=xp7(j)*ma(i)-yp7(j)*mb(i);
        my7(i,j)=xp7(j)*mb(i)+yp7(j)*ma(i);
    end
end

%***************ROTACION DE LA MONEDA**************************

mxp=zeros(1,length(xs));
for i=1:length(xs)
%     if flag_mov(i)==0
%       mxp(i)=xs(i)*ma(i)-ys(i)*mb(i);
%     else
         mxp(i)=xs(i);
%     end
end
myp=zeros(1,length(ys));
for i=1:length(ys)
%     if flag_mov(i)==0
%       myp(i)=xs(i)*mb(i)+ys(i)*ma(i);
%     else
        myp(i)=ys(i);
%     end
end


fig=figure(1);
for j=1:length(xs)
    plot(mxp(j),myp(j)+0.01,'r*','lineWidth',15)
    
    %*********RECTAS*********
%     plot(mxl1(j,:),myl1(j,:),'b','lineWidth',2);
%     plot(mxl2(j,:),myl2(j,:),'b','lineWidth',2);
%     plot(mxl3(j,:),myl3(j,:),'b','lineWidth',2);
%     plot(mxl4(j,:),myl4(j,:),'b','lineWidth',2); 
    %*******PARABOLAS***********
%     plot(mx(j,:),my(j,:),'b','lineWidth',2);
    plot(mx1(j,:),my1(j,:),'b','lineWidth',2);
    plot(mx2(j,:),my2(j,:),'b','lineWidth',2);
    plot(mx3(j,:),my3(j,:),'b','lineWidth',2);
    plot(mx4(j,:),my4(j,:),'b','lineWidth',2);
    plot(mx5(j,:),my5(j,:),'b','lineWidth',2);
    plot(mx6(j,:),my6(j,:),'b','lineWidth',2);
    plot(mx7(j,:),my7(j,:),'b','lineWidth',2);
      
    hold off;
    MM = getframe(fig);
    figure(1)
%     plot(r1,r2,'r');
%     hold on;
%     plot(r3,r4,'r');
%     hold on;
    %     CIRCULO
    plot(xcir,ycir{1},'k');
    hold on
    plot(xcir,ycir{2},'k');
    axis([-0.25 0.25 -0.25 0.25])
    title('SIMULADOR GRAFICO PLATAFORMA PARA PRUEBA Y ENSAYO DE CONTROLADORES')
end