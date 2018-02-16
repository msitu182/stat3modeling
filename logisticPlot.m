%% logistic fit for dose response vs dose
function logisticPlot(dataFull);
disp('Dose Response');

%%if only running this section
columnNumber = 6;
maxTimePosition = 1;
yAxisTitle = 'STAT3 Avg Nuc-Cyt';

%Plot dose response graphs
[dose1, doseResponse1,dose2, doseResponse2,dose3, doseResponse3, zeroPoint] = doseResponse(dataFull,columnNumber,maxTimePosition);

%Fit logistic curve to dose response for each cytokine and make plot of each
subplot(2,2,1);
logisticSol1 = logisticFit(dose1,doseResponse1);
%logisticFit(dose1,doseResponse1);
ylabel(yAxisTitle);
xlabel('Dose (ng/mL)');
title('IL6 Dose Response');

subplot(2,2,2);
logisticSol2 = logisticFit(dose2,doseResponse2);
%logisticFit(dose2,doseResponse2);
ylabel(yAxisTitle);
xlabel('Dose (ng/mL)');
title('IFN-G Dose Response');

subplot(2,2,3);
logisticSol3 = logisticFit(dose3,doseResponse3);
%logisticFit(dose3,doseResponse3);
ylabel(yAxisTitle);
title('OS-M Dose Response');
xlabel('Dose (ng/mL)');
end