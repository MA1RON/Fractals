function tricorn(fine,iteraz,tmax)
% use this values for example: 1e3,5e2,10

xinit=-2; xfinal=1.5;
yinit=-1.4; yfinal=1.4;

[x,y] = meshgrid(linspace(xinit, xfinal,fine), linspace(yinit, yfinal,fine));

c=x+y*1i;
z=zeros(size(c));
zr=z;

tic
for j=1:iteraz
    z=(conj(z)).^2 + c;
    zr(zr==0 & abs(z) > 2) = iteraz - j;
    if (toc>tmax)
        disp('uscita per toc')
        break;
    end
end

imagesc(zr)
colormap hot