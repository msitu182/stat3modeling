function predictFit(dataFull,dose1,doseResponse1,dose2,doseResponse2,dose3,doseResponse3,zeroPoint,atanSol1,atanSol2,atanSol3);

disp('Predict dual response');

disp('1 - IL6 & OSM (using responses from IL6 & IFNg and IFNg & OSM)'); %13 from 12, 23
disp('2 - IFNg & OSM (using responses from IL6 & IFNg and IL6 & OSM)'); %23 from 12, 13
disp('3 - IL6 & IFNg (using responses from IFNg & OSM and IL6 & OSM)'); %12 from 23, 13

choice = 0;
while(choice < 1 || choice > 3)
    choice = input('');
end

if (choice == 1)  %predict il6, osm
    w12 = dualResponseFit3(dataFull,dose1,doseResponse1,dose2,doseResponse2,dose3,doseResponse3,zeroPoint,1,2,atanSol1,atanSol2,atanSol3);
    w23 = dualResponseFit3(dataFull,dose1,doseResponse1,dose2,doseResponse2,dose3,doseResponse3,zeroPoint,2,3,atanSol1,atanSol2,atanSol3);
    
    a = atanSol1(1);
    b = atanSol1(2);
    c = atanSol3(1);
    d = atanSol3(2);
    
    dataFull = table2array(dataFull);
    doseResponse13 = [dataFull(selectDose(1,0,1),6); dataFull(selectDose(1,0,2),6); dataFull(selectDose(1,0,3),6); ...
        dataFull(selectDose(2,0,1),6); dataFull(selectDose(2,0,2),6); dataFull(selectDose(2,0,3),6); ...
        dataFull(selectDose(3,0,1),6); dataFull(selectDose(3,0,2),6); dataFull(selectDose(3,0,3),6);];
    doseResponse13 = doseResponse13 - zeroPoint;
    tempd1 = [dose1(3); dose1(3); dose1(3); dose1(2); dose1(2); dose1(2); dose1(1); dose1(1); dose1(1);];
    tempd3 = [dose3(3); dose3(2); dose3(1); dose3(3); dose3(2); dose3(1); dose3(3); dose3(2); dose3(1);];
    d1 = [0; 0; 0; 0; dose1; tempd1];
    d3 = [dose3; 0; 0; 0; 0; tempd3];
    dualdr = [doseResponse3; doseResponse1; doseResponse13];
    scatter3(d1,d3,dualdr,'filled','MarkerEdgeColor','k');
    
    xL = '[IL6] (ng/mL)';
    yL = '[OSM] (ng/mL)';
%     xRange = dose1(1);
%     yRange = dose3(1);
    
    xdata = d1;
    ydata = d3;
    zdata = dualdr;
    
    n1 = w12(1)/(w12(1)+w12(2));
    n2 = w23(2)/(w23(2)+w23(1));   
    
elseif (choice == 2) %predict ifng,osm
    w12 = dualResponseFit3(dataFull,dose1,doseResponse1,dose2,doseResponse2,dose3,doseResponse3,zeroPoint,1,2,atanSol1,atanSol2,atanSol3);
    w13 = dualResponseFit3(dataFull,dose1,doseResponse1,dose2,doseResponse2,dose3,doseResponse3,zeroPoint,1,3,atanSol1,atanSol2,atanSol3);
    
    a = atanSol2(1);
    b = atanSol2(2);
    c = atanSol3(1);
    d = atanSol3(2);

    dataFull = table2array(dataFull);
    doseResponse23 = [dataFull(selectDose(0,1,1),6); dataFull(selectDose(0,1,2),6); dataFull(selectDose(0,1,3),6); ...
        dataFull(selectDose(0,2,1),6); dataFull(selectDose(0,2,2),6); dataFull(selectDose(0,2,3),6); ...
        dataFull(selectDose(0,3,1),6); dataFull(selectDose(0,3,2),6); dataFull(selectDose(0,3,3),6)];
    doseResponse23 = doseResponse23 - zeroPoint;
    tempd2 = [dose2(3); dose2(3); dose2(3); dose2(2); dose2(2); dose2(2); dose2(1); dose2(1); dose2(1);];
    tempd3 = [dose3(3); dose3(2); dose3(1); dose3(3); dose3(2); dose3(1); dose3(3); dose3(2); dose3(1);];
    d2 = [dose2; 0; 0; 0; 0; tempd2];
    d3 = [0; 0; 0; 0; dose3; tempd3];
    dualdr = [doseResponse2; doseResponse3; doseResponse23];
    scatter3(d2,d3,dualdr,'filled','MarkerEdgeColor','k');
    
    xL = '[IFNg] (ng/mL)';
    yL = '[OSM] (ng/mL)';
%     xRange = dose2(1);
%     yRange = dose3(1);
    
    xdata = d2;
    ydata = d3;
    zdata = dualdr;
    
    n1 = w12(2)/(w12(1)+w12(2));
    n2 = w13(2)/(w13(1)+w13(2));
    
elseif (choice == 3) %predict il6,ifng
    w13 = dualResponseFit3(dataFull,dose1,doseResponse1,dose2,doseResponse2,dose3,doseResponse3,zeroPoint,1,3,atanSol1,atanSol2,atanSol3);
    w23 = dualResponseFit3(dataFull,dose1,doseResponse1,dose2,doseResponse2,dose3,doseResponse3,zeroPoint,2,3,atanSol1,atanSol2,atanSol3);
    
    a = atanSol1(1);
    b = atanSol1(2);
    c = atanSol2(1);
    d = atanSol2(2);

    dataFull = table2array(dataFull);
    doseResponse12 = [dataFull(selectDose(1,1,0),6); dataFull(selectDose(1,2,0),6); dataFull(selectDose(1,3,0),6); ...
        dataFull(selectDose(2,1,0),6); dataFull(selectDose(2,2,0),6); dataFull(selectDose(2,3,0),6); ...
        dataFull(selectDose(3,1,0),6); dataFull(selectDose(3,2,0),6); dataFull(selectDose(3,3,0),6);];
    doseResponse12 = doseResponse12 - zeroPoint;
    tempd1 = [dose1(3); dose1(3); dose1(3); dose1(2); dose1(2); dose1(2); dose1(1); dose1(1); dose1(1);];
    tempd2 = [dose2(3); dose2(2); dose2(1); dose2(3); dose2(2); dose2(1); dose2(3); dose2(2); dose2(1);];
    d1 = [0; 0; 0; 0; dose1; tempd1];
    d2 = [dose2; 0; 0; 0; 0; tempd2];
    dualdr = [doseResponse2; doseResponse1; doseResponse12];
    scatter3(d1,d2,dualdr,'filled','MarkerEdgeColor','k');
    
    xL = '[IL6] (ng/mL)';
    yL = '[IFNg] (ng/mL)';
%     xRange = dose1(1);
%     yRange = dose2(1);
    
    xdata = d1;
    ydata= d2;
    zdata = dualdr;
    
    n1 = w13(1)/(w13(1)+w13(2));
    n2 = w23(1)/(w23(1)+w23(2));

end


dualFun = @(cij,x,y) cij*(n1*(a*atan(b*x)) + n2*(c*atan(d*y)));

%[sf,gof] = fit([xdata,ydata],zdata,dualFun);
[sf,gof] = fit([xdata,ydata],zdata,dualFun,'StartPoint',0);

plot(sf,[xdata,ydata],zdata);

xlabel(xL);
ylabel(yL);
zlabel('Response (STAT3 Avg Nuc-Cyt)');
%title('Predict Fit');

%% rsquared

cf = coeffvalues(sf);
disp(' ');
if(choice ==1)
    disp('Predict Fit for IL6 and OSM');
    str = ['f(x_i,y_k) = ',num2str(cf(1)),'*(',num2str(n1),'*(',num2str(a),'*atan(',num2str(b),'*x_i) + ',num2str(n2),'*(',num2str(c),'*atan(',num2str(d),'*y_k)))'];
elseif(choice==2)
    disp('Predict Fit for IFN-g and OSM');
    str = ['f(x_j,y_k) = ',num2str(cf(1)),'*(',num2str(n1),'*(',num2str(a),'*atan(',num2str(b),'*x_j) + ',num2str(n2),'*(',num2str(c),'*atan(',num2str(d),'*y_k)))'];;%23
elseif(choice == 3)
    disp('Predict Fit for IL6 and IFN-g');
    str = ['f(x_i,y_j) = ',num2str(cf(1)),'*(',num2str(n1),'*(',num2str(a),'*atan(',num2str(b),'*x_i) + ',num2str(n2),'*(',num2str(c),'*atan(',num2str(d),'*y_j)))'];%12
end

disp(str);
title(['Prediction: ',str]);
rsquared = gof.rsquare;
disp(['R^2 = ' num2str(rsquared)]);
end