function [xp,yp,plotcol] = newton_fun(f,df,fzeros,XXminplot,XXmaxplot,YYminplot,YYmaxplot)
% grid
hm = 5e2;
XXmin = min(real(fzeros))-1;
XXmax = max(real(fzeros))+1;
YYmin = min(imag(fzeros))-1;
YYmax = max(real(fzeros))+1;
dx = (XXmax-XXmin)/hm/1;
dy = (YYmax-YYmin)/hm/1;
xx = XXmin:dx:XXmax; 
yy = YYmin:dy:YYmax;

% initial guess
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
plotcol = reshape(mindist,length(xp),length(xp))';
end