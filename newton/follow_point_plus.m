clc; clear; close all;
%% data
% function
f = @(z) z.^3-1;
df = @(z) 3*z.^2;
fzeros = [1 + 0i;...
          -.5 + 3^.5/2*1i;...
          -.5 - 3^.5/2*1i];

% grid
hm = 1e3;
LL = 2; dz = LL/hm/10;
xx = -LL:dz:LL; yy = -LL:dz:LL;

% initial guess
xp = -LL:LL/hm:LL; yp = -LL:LL/hm:LL;
p0 = reshape(xp'+(yp*1i),1,(hm*2+1)^2);

% tollerance
tol = 1;

%% loop
pp = p0;
mm = 20;
%{
xcol = (real(p0')/2+LL)/LL/2;
ycol = (imag(p0')/2+LL)/LL/2;
ncol = zeros(hm,1);
col = [xcol ycol 1-(xcol+ycol)/2];
hold on
%}
for inst = 1:mm
    %{
    plot(real(fzeros),imag(fzeros),'ko','markersize',10,'markerfacecolor','r')
    for jp = 1:length(p0)
        plot(real(p0(jp)),imag(p0(jp)),'ko','markersize',6,...
            'markerfacecolor',col(jp,:))
    end
    drawnow
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
    %}
    
    p0 = p0 - f(p0)./df(p0);
end

%% where did they go
mindist = zeros(1,size(p0,2));
dist = zeros(length(fzeros),size(p0,2));
pp(isnan(pp)) = 0;
for jz = 1:length(fzeros)
    zz = p0-fzeros(jz);
    dist(jz,:) = sqrt(real(zz).^2+imag(zz).^2);
end
[~,mindist] = min(dist);
for jz = 1:length(fzeros)
    mindist(dist(jz,mindist==jz) > tol) = -1;
end

%% post
% final configuration
%{
figure
xcol = (real(p0')/2+LL)/LL/2;
ycol = (imag(p0')/2+LL)/LL/2;
ncol = zeros(hm,1);
col = [xcol ycol 1-(xcol+ycol)/2];
hold on
plot(real(fzeros),imag(fzeros),'ko','markersize',10,'markerfacecolor','r')
for jp = 1:length(p0)
    plot(real(pp(jp)),imag(pp(jp)),'ko','markersize',6,...
        'markerfacecolor',col(jp,:))
end
ylim([-2 2])
xlim([-2 2])
grid on
set(gca,'fontsize',18)
xlabel('Real(z)')
ylabel('Imag(z)')
%}

% starting configuration
figure
hold on
plotcol = reshape(mindist,length(xp),length(xp));
h = pcolor(xp,yp,plotcol');
set(h, 'EdgeColor', 'none')
ylim([-2 2])
xlim([-2 2])
grid on
set(gca,'fontsize',18)
xlabel('Real(z)')
ylabel('Imag(z)')
