function [f1, rSquared] = arctanFit_stat1(dose,doseResponse);
%returns solution [f1] which is [a b] in f(x) = a*arctan(b*x)

plot(dose,doseResponse,'o','MarkerSize',5);
hold on

[nrow,~] = size(dose);

%f(x) = a*arctan(bx)+c?
%f(x) = a*arctan(bx) c=intercept=0
f = @(x,xdata) x(1)*atan(x(2)*xdata);

%[f1, sse] = lsqcurvefit(f,[1,1],dose,doseResponse);
[f1, sse] = lsqcurvefit(f,[1,1],dose,doseResponse,[0,0]);

x = linspace(dose(nrow),dose(1));

plot(x, f(f1,x));
axis([0 max(dose) 0 1]);

ssy = sum((doseResponse - mean(doseResponse)).^2);
rSquared = 1 - sse/ssy;


end