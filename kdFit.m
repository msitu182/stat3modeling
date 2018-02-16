function [f1] = kdFit(dose,doseResponse);

plot(dose,doseResponse,'o','MarkerSize',5);
hold on

[nrow,~] = size(dose);

%Kd = [R][L]/[RL]
%[RL] = (c*[L])/(Kd + [L])

f = @(x,xdata) x(1)*xdata./(x(2) + xdata);

[f1, sse] = lsqcurvefit(f,[1,1],dose,doseResponse);

x = linspace(dose(nrow),dose(1));

plot(x, f(f1,x));
axis([0 max(dose) 0 2]);

ssy = sum((doseResponse - mean(doseResponse)).^2);
rSquared = 1 - sse/ssy

end