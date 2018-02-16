function [dose1, doseResponse1,dose2, doseResponse2,dose3, doseResponse3, zeroPoint] = doseResponse(dataFull,columnNumber,maxTimePosition)

%dataFull = table2array(dataFull);

%Pick starting point for data file depending on max time
%37 data points per time
startingPoint = 1 + (maxTimePosition-1)*37;

%IL6 Data (stored in dose1 and doseResponse1)
%Grab 3 points with only [IL6]
dose1 = dataFull(startingPoint+3:11:startingPoint + 25,2);
%Grab 0 0 0 concentration point
dose1 = [dose1;dataFull(startingPoint+33,2)];

%Grab corresponding response points
doseResponse1 = dataFull(startingPoint+3:11:startingPoint + 25,columnNumber);
doseResponse1 = [doseResponse1;dataFull(startingPoint+33,columnNumber)];

% Display Dose vs Dose Reponse data to screen
doseResponseData = [dose1,  doseResponse1];
%disp('   IL6 Dose   Response');
disp(doseResponseData);


%INFG Data (stored in dose2 and doseResponse2)
%Grab 3 points with only [INFG]
dose2 = dataFull(startingPoint+10:11:startingPoint + 32,3);
%Grab 0 0 0 concentration point
dose2 = [dose2;dataFull(startingPoint+33,3)];

%Grab corresponding response points
doseResponse2 = dataFull(startingPoint+10:11:startingPoint + 32,columnNumber);
doseResponse2 = [doseResponse2;dataFull(startingPoint+33,columnNumber)];

%Display Dose vs Dose Reponse data to screen
doseResponseData = [dose2,  doseResponse2];
%disp('   INFG Dose  Response');
disp(doseResponseData);


%OS-M Data (stored in dose3 and doseResponse3)
%Grab 3 points with only [OS-M]
dose3 = dataFull(startingPoint+34:1:startingPoint + 36,4);
%Grab 0 0 0 concentration point
dose3 = [dose3;dataFull(startingPoint+33,4)];
%Grab corresponding response points
doseResponse3 = dataFull(startingPoint+34:1:startingPoint + 36,columnNumber);
doseResponse3 = [doseResponse3;dataFull(startingPoint+33,columnNumber)];

%Display Dose vs Dose Reponse data to screen
doseResponseData = [dose3,  doseResponse3];
%disp('   OS-M Dose  Response');
disp(doseResponseData);


%Store concentration of the 0 0 0 point
zeroPoint  = doseResponse1(4,1);

zeroPoint = table2array(zeroPoint);
dose1 = table2array(dose1);
dose2 = table2array(dose2);
dose3 = table2array(dose3);
doseResponse1 = table2array(doseResponse1);
doseResponse2 = table2array(doseResponse2);
doseResponse3 = table2array(doseResponse3);


%Subtract 0 0 0 point from response to start all plots at 0 0
doseResponse1 = doseResponse1 - zeroPoint;
doseResponse2 = doseResponse2 - zeroPoint;
doseResponse3 = doseResponse3 - zeroPoint;


%set negative values to 0 minimum?
for i = 1:4
   if doseResponse1(i) < 0 
       doseResponse1(i) = 0;
   end
   if doseResponse2(i) < 0 
       doseResponse2(i) = 0;
   end
   if doseResponse3(i) < 0 
       doseResponse3(i) = 0;
   end
end


end