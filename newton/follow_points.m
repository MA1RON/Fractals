clc; clear; close all;
%% data
% function
f = @(z) z.^3-1;
df = @(z) 3*z.^2;
fzeros = [1 + 0i;...
          -.5 + 3^.5/2*1i;...
          -.5 - 3^.5/2*1i];

% grid
hm = 1;
LL = 2; dz = LL/hm/10;
xx = -LL:dz:LL; yy = -LL:dz:LL;


% initial guess
% xp = -LL:LL/hm:LL; yp = -LL:LL/hm:LL;
% p0 = reshape(xp'+(yp*1i),1,(hm*2+1)^2);
p0 = -1;

%% loop
mm = 20;
xcol = (real(p0')/2+LL)/LL/2;
ycol = (imag(p0')/2+LL)/LL/2;
ncol = zeros(hm,1);
col = [xcol ycol 1-(xcol+ycol)/2];
hold on
for inst = 1:mm
    plot(real(fzeros),imag(fzeros),'ko','markersize',10,'markerfacecolor','r')
    for jp = 1:length(p0)
        plot(real(p0(jp)),imag(p0(jp)),'ko','markersize',6,...
            'markerfacecolor',col(jp,:))
    end
    drawnow
    pause(.5)
    if inst <mm
        clf
    end
    hold on
    ylim([-2 2])
    xlim([-2 2])
    grid on
    set(gca,'fontsize',18)
    xlabel('Real(z)')
    ylabel('Imag(z)')
    
    p0 = p0 - f(p0)./df(p0);
end