function coeff = dualResponseFit3(dataFull,dose1,doseResponse1,dose2,doseResponse2,dose3,doseResponse3,zeroPoint,choice1,choice2,atanSol1,atanSol2,atanSol3);
%fits 2 parameters c1, c2 in @(c1,c2,x,y) c1*(a*atan(b*x)) + c2*(c*atan(d*y));


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

%set negative values to 0 minimum?
[sizeDualData,~] = size(doseResponse12);
for i = 1:sizeDualData
   if doseResponse12(i) < 0 
       doseResponse12(i) = 0;
   end
   if doseResponse13(i) < 0 
       doseResponse13(i) = 0;
   end
   if doseResponse23(i) < 0 
       doseResponse23(i) = 0;
   end
end


xdata = 0;
ydata = 0;
zdata = 0;

a = 0;
b = 0;
c = 0;
d = 0;
choice = 0;

if (choice1 == 1 && choice2 == 2 || choice2 == 1 && choice1 == 2) %if d1 & d2
    
    %110 120 130 210 220 230 310 320 330
    tempd1 = [dose1(3); dose1(3); dose1(3); dose1(2); dose1(2); dose1(2); dose1(1); dose1(1); dose1(1);];
    tempd2 = [dose2(3); dose2(2); dose2(1); dose2(3); dose2(2); dose2(1); dose2(3); dose2(2); dose2(1);];
    
    d1 = [0; 0; 0; 0; dose1; tempd1];
    d2 = [dose2; 0; 0; 0; 0; tempd2];
    
    dualdr = [doseResponse2; doseResponse1; doseResponse12];
    
    xdata = d1;
    ydata= d2;
    zdata = dualdr;
    xL = '[IL6] (ng/mL)';
    yL = '[IFN-g] (ng/mL)';
    zL = 'Response (STAT3 Avg Nuc-Cyt)';
    
    a = atanSol1(1);
    b = atanSol1(2);
    c = atanSol2(1);
    d = atanSol2(2);
    choice = 1;
    
elseif (choice1 == 1 && choice2 == 3 || choice2 == 1 && choice1 == 3)    %if d1 & d3
    
    %101 102 103 201 202 203 301 302 303
    tempd1 = [dose1(3); dose1(3); dose1(3); dose1(2); dose1(2); dose1(2); dose1(1); dose1(1); dose1(1);];
    tempd3 = [dose3(3); dose3(2); dose3(1); dose3(3); dose3(2); dose3(1); dose3(3); dose3(2); dose3(1);];
    
    d1 = [0; 0; 0; 0; dose1; tempd1];
    d3 = [dose3; 0; 0; 0; 0; tempd3];
    
    dualdr = [doseResponse3; doseResponse1; doseResponse13];
    
    xdata = d1;
    ydata = d3;
    zdata = dualdr;
    xL = '[IL6] (ng/mL)';
    yL = '[OSM](ng/mL)';
    zL = 'Response (STAT3 Avg Nuc-Cyt)';
    
    a = atanSol1(1);
    b = atanSol1(2);
    c = atanSol3(1);
    d = atanSol3(2);
    choice = 2;
    
elseif (choice1 == 2 && choice2 == 3 || choice1 == 3 && choice2 == 2) %if d2 & d3
    
    %011 012 013 021 022 023 031 032 033
    tempd2 = [dose2(3); dose2(3); dose2(3); dose2(2); dose2(2); dose2(2); dose2(1); dose2(1); dose2(1);];
    tempd3 = [dose3(3); dose3(2); dose3(1); dose3(3); dose3(2); dose3(1); dose3(3); dose3(2); dose3(1);];
    
    d2 = [dose2; 0; 0; 0; 0; tempd2];
    %if d2 & d3
    d3 = [0; 0; 0; 0; dose3; tempd3];
    
    dualdr = [doseResponse2; doseResponse3; doseResponse23];
    
    xdata = d2;
    ydata = d3;
    zdata = dualdr;
    yL = '[OSM] (ng/mL)';
    xL = '[IFN-g] (ng/mL)';
    zL = 'Response (STAT3 Avg Nuc-Cyt)';
    
    a = atanSol2(1);
    b = atanSol2(2);
    c = atanSol3(1);
    d = atanSol3(2);
    choice = 3;
    
end

dualFun = @(c1,c2,x,y) c1*(a*atan(b*x)) + c2*(c*atan(d*y));

%[sf,gof] = fit([xdata,ydata],zdata,dualFun, 'StartPoint', [0, 0]); %original
[sf,gof] = fit([xdata,ydata],zdata,dualFun, 'StartPoint', [0, 0],'Lower',[0, 0]);
plot(sf,[xdata,ydata],zdata);
xlabel(xL);
ylabel(yL);
zlabel(zL);

rsquared = gof.rsquare;

coeff = coeffvalues(sf);

if (choice == 1)
    %     disp('x = [IL6]');
    %     disp('y = [IFN-g]');
    %    str = ['f(x,y) = ', num2str(coeff(1)), '*(', num2str(a), '*atan(', num2str(b), '*x)) + ', num2str(coeff(2)), '*(', num2str(c), '*atan(', num2str(d), '*y))'];
    str = ['f(x_i,y_j) = ', num2str(coeff(1)), '*(', num2str(a), '*atan(', num2str(b), '*x_i)) + ', num2str(coeff(2)), '*(', num2str(c), '*atan(', num2str(d), '*y_j))'];
    title(str);
    disp('Dual response fit of IL6 and IFN-g');
    disp(str);
elseif (choice == 2)
    %     disp('x = [IL6]');
    %     disp('z = [OSM]');
    %    str = ['f(x,z) = ', num2str(coeff(1)), '*(', num2str(a), '*atan(', num2str(b), '*x)) + ', num2str(coeff(2)), '*(', num2str(c), '*atan(', num2str(d), '*z))'];
    str = ['f(x_i,y_k) = ', num2str(coeff(1)), '*(', num2str(a), '*atan(', num2str(b), '*x_i)) + ', num2str(coeff(2)), '*(', num2str(c), '*atan(', num2str(d), '*y_k))'];
    title(str);
    disp('Dual response fit of IL6 and OSM');
    disp(str);
elseif (choice == 3)
    %     disp('y = [IFN-g]');
    %     disp('z = [OSM]');
    %str = ['f(y,z) = ', num2str(coeff(1)), '*(', num2str(a), '*atan(', num2str(b), '*y)) + ', num2str(coeff(2)), '*(', num2str(c), '*atan(', num2str(d), '*z))'];
    str = ['f(x_j,y_k) = ', num2str(coeff(1)), '*(', num2str(a), '*atan(', num2str(b), '*x_j)) + ', num2str(coeff(2)), '*(', num2str(c), '*atan(', num2str(d), '*y_k))'];
    title(str);
    disp('Dual response fit of IFN-g and OSM');
    disp(str);
end

disp(['R^2 = ' num2str(rsquared)]);

end