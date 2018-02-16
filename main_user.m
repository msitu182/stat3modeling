%% file input
dataFull = readtable('dt-well_averages-log.txt');

%% arctan fit
%disp('Select 1 - STAT1 Avg Nuc-Cyt / 2 - STAT3 Avg Nuc-Cyt');
stat1_stat3 = 0;
while (stat1_stat3 ~= 1 && stat1_stat3 ~= 2)
    stat1_stat3 = input('Select 1 - STAT1 Avg Nuc-Cyt / 2 - STAT3 Avg Nuc-Cyt\n');
    
end

if (stat1_stat3 == 1)
    columnNumber = 5;
elseif (stat1_stat3 == 2)
    columnNumber = 6;
end

%% arctan fit

maxTimePosition = 0;

if stat1_stat3 == 1
    yAxisTitle = 'STAT1 Avg Nuc-Cyt';
    text_pl1 = 0.85;
    text_pl2 = 0.7;
elseif stat1_stat3 == 2
    yAxisTitle = 'STAT3 Avg Nuc-Cyt';
    text_pl1 = 1.75;
    text_pl2 = 1.6;
end

while (maxTimePosition < 1 || maxTimePosition > 6)
    maxTimePosition = input('Select a time for response:\n1 - 8 min\n2 - 15 min\n3 - 30 min\n4 - 45 min\n5 - 60 min\n6 - 120 min\n');
    
    disp('Arctan Fit');

    [dose1, doseResponse1,dose2, doseResponse2,dose3, doseResponse3, zeroPoint] = doseResponse(dataFull,columnNumber,maxTimePosition);
    
    %Fit arctan curve to dose response for each cytokine and make plot of each
    subplot(2,2,1);
    if (stat1_stat3 == 1)
        [arctanSol1,rSq] = arctanFit_stat1(dose1,doseResponse1);
    elseif (stat1_stat3 == 2)
        [arctanSol1,rSq] = arctanFit(dose1,doseResponse1);
    end
    ylabel(yAxisTitle);
    xlabel('Dose (ng/mL)');
    t = title('IL6 Dose Response');
    str = ['y = ',num2str(arctanSol1(1)),'*arctan(',num2str(arctanSol1(2)),'*x)'];
    text(2,text_pl1,str);
    str2 = ['R^2 = ',num2str(rSq)];
    text(2,text_pl2,str2);
    disp(t.String);
    disp(str);
    disp(str2);
    
    
    subplot(2,2,2);
    if (stat1_stat3 == 1)
        [arctanSol2,rSq] = arctanFit_stat1(dose2,doseResponse2);
    elseif (stat1_stat3 == 2)
        [arctanSol2,rSq] = arctanFit(dose2,doseResponse2);
    end
    ylabel(yAxisTitle);
    xlabel('Dose (ng/mL)');
    t = title('IFN-G Dose Response');
    str = ['y = ',num2str(arctanSol2(1)),'*arctan(',num2str(arctanSol2(2)),'*x)'];
    text(2,text_pl1,str);
    str2 = ['R^2 = ',num2str(rSq)];
    text(2,text_pl2,str2);
    disp(t.String);
    disp(str);
    disp(str2);
    
    subplot(2,2,3);
    if (stat1_stat3 == 1)
        [arctanSol3,rSq] = arctanFit_stat1(dose3,doseResponse3);
    elseif (stat1_stat3 == 2)
        [arctanSol3,rSq] = arctanFit(dose3,doseResponse3);
    end
    ylabel(yAxisTitle);
    t = title('OS-M Dose Response');
    xlabel('Dose (ng/mL)');
    str = ['y = ',num2str(arctanSol3(1)),'*arctan(',num2str(arctanSol3(2)),'*x)'];
    text(2,text_pl1,str);
    str2 = ['R^2 = ',num2str(rSq)];
    text(2,text_pl2,str2);
    disp(t.String);
    disp(str);
    disp(str2);
    disp(' ');
    yn = 2;
    while (yn < 0 || yn > 1)
        yn = input('Select another time? (0 - no / 1 - yes)\n');
    end
    
    if (yn == 0)
        break;
    elseif (yn == 1)
        maxTimePosition = 7;
    end
    
end

%% 

yn = 2;
while (yn < 0 || yn > 1)
    if (stat1_stat3 == 2)
        predictFit(dataFull,dose1,doseResponse1,dose2,doseResponse2,dose3,doseResponse3,zeroPoint,arctanSol1,arctanSol2,arctanSol3);
    elseif (stat1_stat3 == 1)
        predictFit_stat1(dataFull,dose1,doseResponse1,dose2,doseResponse2,dose3,doseResponse3,zeroPoint,arctanSol1,arctanSol2,arctanSol3);
    end
    disp(' ');
    yn = input('View a different model for this time point? (0 - no / 1 - yes)\n');
    if (yn == 0)
        break;
    elseif (yn == 1)
        yn = 2;
    end
end

