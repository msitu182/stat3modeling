function dualResponseFit(dataFull,dose1,doseResponse1,dose2,doseResponse2,dose3,doseResponse3,zeroPoint);
%fits parameters a,b,c,d in @(a,b,c,d,x,y) a*atan(b*x) + c*atan(d*y);

choice = 0;
while(choice < 1 || choice > 3)
    choice = input('Select two cytokines for dual response: 1)IL6 & IFN-g  2)IL6 & OS-m  3)IFN-g & OS-m : ');
end

dataFull = table2array(dataFull);


%110 120 130 210 220 230 310 320 330
doseResponse12 = [dataFull(selectDose(1,1,0),6); dataFull(selectDose(1,2,0),6); dataFull(selectDose(1,3,0),6); ...
    dataFull(selectDose(2,1,0),6); dataFull(selectDose(2,2,0),6); dataFull(selectDose(2,3,0),6); ...
    dataFull(selectDose(3,1,0),6); dataFull(selectDose(3,2,0),6); dataFull(selectDose(3,3,0),6);];

doseResponse12 = doseResponse12 - zeroPoint;

%101 102 103 201 202 203 301 302 303
doseResponse13 = [dataFull(selectDose(1,0,1),6); dataFull(selectDose(1,0,2),6); dataFull(selectDose(1,0,3),6); ...
    dataFull(selectDose(2,0,1),6); dataFull(selectDose(2,0,2),6); dataFull(selectDose(2,0,3),6); ...
    dataFull(selectDose(3,0,1),6); dataFull(selectDose(3,0,2),6); dataFull(selectDose(3,0,3),6);];

doseResponse13 = doseResponse13 - zeroPoint;

%011 012 013 021 022 023 031 032 033
doseResponse23 = [dataFull(selectDose(0,1,1),6); dataFull(selectDose(0,1,2),6); dataFull(selectDose(0,1,3),6); ...
    dataFull(selectDose(0,2,1),6); dataFull(selectDose(0,2,2),6); dataFull(selectDose(0,2,3),6); ...
    dataFull(selectDose(0,3,1),6); dataFull(selectDose(0,3,2),6); dataFull(selectDose(0,3,3),6)];

doseResponse23 = doseResponse23 - zeroPoint;

xdata = 0;
ydata = 0;
zdata = 0;

if (choice == 1)
    %if d1 & d2
    
    %110 120 130 210 220 230 310 320 330
    tempd1 = [dose1(3); dose1(3); dose1(3); dose1(2); dose1(2); dose1(2); dose1(1); dose1(1); dose1(1);];
    tempd2 = [dose2(3); dose2(2); dose2(1); dose2(3); dose2(2); dose2(1); dose2(3); dose2(2); dose2(1);];

    d1 = [0; 0; 0; 0; dose1; tempd1];
    d2 = [dose2; 0; 0; 0; 0; tempd2];
    
    dualdr = [doseResponse2; doseResponse1; doseResponse12];
    
    scatter3(d1,d2,dualdr,'filled','MarkerEdgeColor','k');
    
    xlabel('[IL6]'); %IL6 %dose1
    ylabel('[IFN-g]'); %IFN-g %dose2
    zlabel('Dose Response');
    
    hold on
    
    xVar = '[IL6]';
    yVar = '[IFN-g]';
    
%    x = d1;
%    y = d2;
%    z = dualdr;
    
xdata = d1;
ydata= d2;
zdata = dualdr;


elseif (choice == 2)
    %if d1 & d3
    
    %101 102 103 201 202 203 301 302 303
    tempd1 = [dose1(3); dose1(3); dose1(3); dose1(2); dose1(2); dose1(2); dose1(1); dose1(1); dose1(1);];
    tempd3 = [dose3(3); dose3(2); dose3(1); dose3(3); dose3(2); dose3(1); dose3(3); dose3(2); dose3(1);];
    
    d1 = [0; 0; 0; 0; dose1; tempd1];
    d3 = [dose3; 0; 0; 0; 0; tempd3];

    dualdr = [doseResponse3; doseResponse1; doseResponse13];
    
    scatter3(d1,d3,dualdr,'filled','MarkerEdgeColor','k');
    
    xlabel('[IL6]');
    ylabel('[OS-m]'); 
    zlabel('Dose Response');
    
    hold on

    xdata = d1;
    ydata = d3;
    zdata = dualdr;
    
    xVar = '[IL6]';
    yVar = '[OS-m]';
    
elseif (choice == 3)
    
    %011 012 013 021 022 023 031 032 033
    tempd2 = [dose2(3); dose2(3); dose2(3); dose2(2); dose2(2); dose2(2); dose2(1); dose2(1); dose2(1);];
    tempd3 = [dose3(3); dose3(2); dose3(1); dose3(3); dose3(2); dose3(1); dose3(3); dose3(2); dose3(1);];
    
    d2 = [dose2; 0; 0; 0; 0; tempd2];
    %if d2 & d3
    d3 = [0; 0; 0; 0; dose3; tempd3];

    dualdr = [doseResponse2; doseResponse3; doseResponse23];
    
    scatter3(d2,d3,dualdr,'filled','MarkerEdgeColor','k');
    
    xlabel('[IFN-g]'); 
    ylabel('[OS-m]'); 
    zlabel('Dose Response');
    
    hold on
    
    xdata = d2;
    ydata = d3;
    zdata = dualdr;
    
    xVar = '[IFN-g]';
    yVar = '[OS-m]';
    
end

%sf = fit([xdata,ydata],zdata,'poly23'); 
%plot(sf,[xdata,ydata],zdata); %works...


dualFun = @(a,b,c,d,x,y) a*atan(b*x) + c*atan(d*y);

%[sf,gof] = fit([xdata,ydata],zdata,dualFun,'StartPoint', [1, 1, 1, 1]);
[sf,gof] = fit([xdata,ydata],zdata,dualFun)%,'StartPoint', [1, 1, 1, 1]);
plot(sf,[xdata,ydata],zdata);
axis([[0 inf, 0 inf] 0 inf]);


rsquared = gof.rsquare;
disp(gof);
c = coeffvalues(sf);

%str1 = {'f(x,y) = ', num2str(c(1)), '*atan(', num2str(c(2)), '*x) + ', num2str(c(3)), 'atan(', num2str(c(4)), '*y)';'xVar = ',xVar;'yVar = ',yVar};

str2 = ['f(x,y) = ', num2str(c(1)), '*atan(', num2str(c(2)), '*x) + ', num2str(c(3)), 'atan(', num2str(c(4)), '*y)'];
xs = ['x = ',xVar];
ys = ['y = ',yVar];
%disp(str2);
t = title({str2;xs;ys});
disp(t.String);

disp(['R^2 = ' num2str(rsquared)]);

end