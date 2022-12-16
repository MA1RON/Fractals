function mymandelbrot(fine,iteraz,tmax,a1,a2,b,vel)
% for example use: mymandelbrot(1e2,100,2e2,1,10,1,.1)
xinit=-2; xfinal=2;
yinit=-1.6; yfinal=1.6;

[x,y] = meshgrid(linspace(xinit, xfinal,fine), linspace(yinit, yfinal,fine));
for t=a1:0.1:a2
    
    c=x+y*1i;
    z=zeros(size(c));
    zr=z;
    
    tic
    for j=1:iteraz
        z=z.^(t+b*c) + c;
        zr(zr==0 & abs(z) > 2) = iteraz - j;
        if (toc>tmax)
            disp('uscita per toc')
            break;
        end
    end

    imagesc(zr)
    colormap hot
    pause(vel)
end