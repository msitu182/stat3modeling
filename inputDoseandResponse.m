function [rowNumber,columnNumber] = inputDoseandResponse();

disp('Enter concentrations (0-3) for Response vs Time plot: ');
fprintf('\n');
disp('IL6 and IFNG concentrations: (0) 0 ng/mL, (1) 5.6 ng/mL, (2) 16.7 ng/mL, (3) 50 ng/mL');
disp('OS-M concentrations: (0) 0 ng/mL (1) 2.8 ng/mL (2) 8.3 ng/mL (3) 25 ng/mL');
IL6conc = input('\nEnter IL6 concentration: ');
%IL6conc = input('Enter IL6 concentration (0-3):');
while (IL6conc < 0 || IL6conc > 3)
    IL6conc = input('Invalid; enter IL6 concentration (0-3):');
end
IFNGconc = input('\nEnter IFNG concentration: ');
%IFNGconc = input('Enter IFNG concentration (0-3):');
while (IFNGconc < 0 || IFNGconc > 3)
    IFNGconc = input('Invalid; enter IFNG concentration (0-3):');
end
OSMconc = input('\nEnter OS-M concentration: ');
%OSMconc = input('Enter OS-M concentration (0-3):');
while (OSMconc < 0 || OSMconc > 3)
    OSMconc = input('Invalid; enter OS-M concentration (0-3):');
end

rowNumber = selectDose(IL6conc,IFNGconc,OSMconc);

fprintf('\n');
response = menu('Select response to plot.','STAT1 Avg Nuc-Cyt','STAT3 Avg Nuc-Cyt','STAT1 Nuc Avg','STAT3 Nuc Avg','Total DNA');
if (response == 1)
    columnNumber = 5;
elseif (response == 2)
    columnNumber = 6;
elseif (response == 3)
    columnNumber = 7;
elseif (response == 4)
    columnNumber = 8;
elseif (response == 5)
    columnNumber = 9
end
end