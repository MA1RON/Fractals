function mandelbrot(fine,iteraz,tmax)
% use this values for example: 1e3,1e2,1e3

xinit=-2; xfinal=0.6;
yinit=-1.2; yfinal=1.2;

[x,y] = meshgrid(linspace(xinit, xfinal,fine), linspace(yinit, yfinal,fine));

c=x+y*1i;
z=zeros(size(c));
zr=z;

tic
for j=1:iteraz
    z=z.^2 + c;
    zr(zr==0 & abs(z) > 2) = iteraz - j;
    if (toc>tmax)
        disp('uscita per toc')
        break;
    end
end

pcolor(zr)
shading flat;
axis('square','equal','off');