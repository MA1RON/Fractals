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
f = @(z) z.^3 - 2*z + 2;
df = @(z) 3*z.^2-2;
fzeros = [-1.7693;...
          0.88465 - 0.58974i;...
          0.88465 + 0.58974i];

% grid
hm = 1e3;
XXminplot = -1;
XXmaxplot = 1;
YYminplot = -1;
YYmaxplot = 1;

%% solve it
% plot
figure
ylim([YYminplot YYmaxplot])
xlim([XXminplot XXmaxplot])
grid on
set(gca,'fontsize',18)
xlabel('Real(z)')
ylabel('Imag(z)')
% while
while true
    
    [xp,yp,plotcol] = newton_fun(f,df,fzeros,XXminplot,XXmaxplot,YYminplot,YYmaxplot);
    
    % plot
    h = pcolor(xp,yp,plotcol);
    set(h, 'EdgeColor', 'none')
    
    % find new points
    try
        [xu,yu] = getpts;
    catch
        fprintf('bye!\n')
        return
    end
    maxdz = max(abs(xu(1)-xu(2)),abs(yu(1)-yu(2)));
    XXmaxplot = max(xu(2),xu(1)); YYmaxplot = max(yu(2),yu(1));
    XXminplot = XXmaxplot-maxdz; YYminplot = YYmaxplot-maxdz;
end