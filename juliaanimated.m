function juliaanimated(arg1,arg2,arg3,arg3i,c,maxtime)
% arg1>10
% arg2>100 arg2<1e3
% c complex
tic
frametime=.5;
xaxis=0;
yaxis=0;
l=1.5;
x=linspace(xaxis-l,xaxis+l,arg2);
y=linspace(yaxis-l,yaxis+l,arg2);
[xtrans,ytrans]=meshgrid(x,y);
ztrans=xtrans+ytrans*1i;
for kk=1:maxtime/frametime
    c=c+arg3+arg3i*1i;
for k=1:arg1
ztrans=ztrans.^2+c;
t=exp(-abs(ztrans).^2); %trucco per avere i colori aggiustati
if(toc>maxtime)
    break
end
end
pcolor(t);
shading flat;
axis('square','equal','off');
pause(frametime)
if(toc>maxtime)
    disp('uscita per toc')
    break
end
end
