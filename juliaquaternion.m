function juliaquaternion(arg1,arg2,c,maxtime)
% arg1>50
% arg2<25
% c quaternion
% maxtime really big dude
tic
xaxis=0;
yaxis=0;
zaxis=0;
waxis=0;
l=1.5;
x=linspace(xaxis-l,xaxis+l,arg2);
y=linspace(yaxis-l,yaxis+l,arg2);
z=linspace(zaxis-l,zaxis+l,arg2);
w=linspace(waxis-l,waxis+l,arg2);
[xtrans,ytrans,ztrans,wtrans]=ndgrid(x,y,z,w);
itrans=quaternion(xtrans,ytrans,ztrans,wtrans);
for k=1:arg1
itrans=itrans.^2+c;
t=exp(-norm(itrans).^2); %trucco per avere i colori aggiustati
if(toc>maxtime)
    disp('uscita per toc')
    break
end
end
pcolor(t(:,:,15,15)); %taglio un piano che mi gusta
shading flat;
axis('square','equal','off');
