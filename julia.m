function julia(arg1,arg2,c,maxtime)
% use this values for example: 100,5e2,-1,10
% arg1>10
% arg2>100 arg2<1e3
tic
xaxis=0;
yaxis=0;
l=1.5;
x=linspace(xaxis-l,xaxis+l,arg2);
y=linspace(yaxis-l,yaxis+l,arg2);
[xtrans,ytrans]=meshgrid(x,y);
ztrans=xtrans+ytrans*1i;
for k=1:arg1
ztrans=ztrans.^2+c;
t=exp(-abs(ztrans).^2); %trucco per avere i colori aggiustati
if(toc>maxtime)
    disp('uscita per toc')
    break
end
end
pcolor(t);
shading flat;
axis('square','equal','off');
