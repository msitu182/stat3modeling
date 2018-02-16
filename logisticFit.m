function [f1] = logisticFit(dose,doseResponse);
%returns [L k x0 b]

plot(dose,doseResponse,'o','MarkerSize',5);
hold on
%% 
% %%
% %T dose
% %M doseResponse
% 
%function y = f(x) = L/(1+e^(-k(x-x0)))
% %L: limit, k: steepness of curve, x0: sigmoid midpoint
% 
% L = max(doseResponse);
% slopex0 = (doseResponse(3)-doseResponse(2))/(dose(3)-dose(2)); %m'(t0)
% k = 4*slopex0/L; %r = 4*m'(t0)/K 
% 
% %m'(t0) = K*r/4; %slope at point of inflection
% x0 = 0; %point of inflection
% 
% syms x 
% y = 2*L/(1+exp(-k*(x-x0)))-L; %y = m(t) 
% 
% SSE = 0;
% for i=1:length(doseResponse)
%     predictedValue = 2*L./(1+exp(-k*(dose(i)-x0)))-L;
%     residual = doseResponse(i) - predictedValue;
%     resSquare = residual^2;
%     SSE = SSE + resSquare;
% end
% 
% fplot(y, [0,60]);
% 
% %str = ['y=' num2str(L) '/(1 + e^{-' num2str(k) '*(x- ' num2str(x0) ')})'];
% 
% str = ['y=' num2str(2*L) '/(1 + e^{' num2str(-k) 'x' '}) - ' num2str(L)];
% 
% str2 = ['SSE = ' num2str(SSE)];
% text(0.5,1.8,str);
% text(0.5,1.6,str2);
% axis([0 60 0 2]);
%% new

[nrow,~] = size(dose); %~ = ?

%define function
%y = f(x) = L/(1+e^(-k(x-x0)))+b;

%anonymous function: f = @(argslist)expression
f = @(x,xdata) x(1)./(1+exp(-x(2)*(xdata-x(3))))+x(4);

%initial values
L = 2*max(doseResponse);
b = -max(doseResponse);
k = 2/doseResponse(1)*(doseResponse(nrow-1)-doseResponse(nrow))/dose(nrow-1)-dose(nrow); %?

%initial parameters
f0 = [L k 0 b];

%fit parameters
[f1, SSE] = lsqcurvefit(f,f0, dose,doseResponse);

x = linspace(dose(nrow),dose(1));

%R^2
SST = sum((doseResponse-mean(doseResponse)).^2);
%rSquared = 1 - (SSE/SST);

%plot
plot(x, f(f1,x));
axis([0 max(dose) 0 2]);
%str = ['y=' num2str(L) '/(1 + e^{' num2str(-k) '*(x- ' num2str(x0) ')}) +' num2str(b)];
%str = ['y=' num2str(2*L) '/(1 + e^{' num2str(-k) 'x' '}) - ' num2str(L)];
%str2 = ['R^2 = ' num2str(rSquared)];
%text(0.5,1.8,str);
%text(0.5,1.6,str2);

str =['y = ' num2str(f1(1)) '/(1+e^{' num2str(f1(2)) '*(x-(' num2str(f1(3)) '))}) + ' num2str(f1(4))];
disp(str);


rSquared = 1 - (SSE/SST);




end