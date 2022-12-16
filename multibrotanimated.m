function multibrotanimated(fine,iteraz,tmax,gradoi,gradof)
%% MB making
% use this or this
% multibrotanimated(1e2,100,2e2,1,10)
% multibrotanimated(5e2,100,1e3,1,10)
% multibrotanimated(1e3,500,1e3,1,20)

xinit=-2; xfinal=1.5;
yinit=-1.2; yfinal=1.2;

[x,y] = meshgrid(linspace(xinit, xfinal,fine), linspace(yinit, yfinal,fine));
i = 1; figure('Position', [10 10 900 600])
for t=gradoi:0.05:gradof
    
    c=x+y*1i;
    z=zeros(size(c));
    zr=z;
    
    tic
    for j=1:iteraz
        z=z.^t + c;
        zr(zr==0 & abs(z) > 2) = iteraz - j;
        if (toc>tmax)
            disp('uscita per toc')
            break;
        end
    end

    imagesc(zr)
    colormap hot
    axis off
    drawnow
    F(i) = getframe(gcf);
    i = i + 1;
end

%% video making
writerObj = VideoWriter('MBVideo.avi');
writerObj.FrameRate = 10;
open(writerObj);
for i=1:length(F)
    % convert the image to a frame
    frame = F(i) ;    
    writeVideo(writerObj, frame);
end
close(writerObj);