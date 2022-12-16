clc; clear; close all;
%% data
% function
%{
grado = 3;
f = @(z) z.^grado-1;
df = @(z) grado*z.^(grado-1);
fzeros = exp(2i*pi/grado*(1:grado));
%}
%{
f = @(z) cos(z);
df = @(z) -sin(z);
fzeros = pi*(-5:5)+pi/2;
%}
grado = 5;
f = @(z) z.^grado-1;
df = @(z) grado*z.^(grado-1);
fzeros = exp(2i*pi/grado*(1:grado));

% grid
hm = 1e3;
XXmin = min(real(fzeros))-1;
XXmax = max(real(fzeros))+1;
YYmin = min(imag(fzeros))-1;
YYmax = max(real(fzeros))+1;
dx = (XXmax-XXmin)/hm/1;
dy = (YYmax-YYmin)/hm/1;
xx = XXmin:dx:XXmax; 
yy = YYmin:dy:YYmax;

% initial guess
XXminplot = .4019; XXmaxplot = .4022;
YYminplot = .5815; YYmaxplot = .5818;
dxplot = (XXmaxplot-XXminplot)/hm;
dyplot = (YYmaxplot-YYminplot)/hm;
xp = XXminplot:dxplot:XXmaxplot; yp = YYminplot:dyplot:YYmaxplot;
p0 = reshape(xp'+(yp*1i),1,(hm+1)^2);

% tollerance
tol = 1;

%% loop
pp = p0;
mm = 20;
for inst = 1:mm
    
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
ylim([YYminplot YYmaxplot])
xlim([XXminplot XXmaxplot])
grid on
set(gca,'fontsize',18)
xlabel('Real(z)')
ylabel('Imag(z)')
