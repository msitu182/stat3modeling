function [rowNumber] = selectDose(IL6Conc, IFNGConc, OSMConc);

    if (IL6Conc == 3 & IFNGConc == 3 & OSMConc == 0)
        rowNumber = 1;
    elseif (IL6Conc == 3 & IFNGConc == 2 & OSMConc == 0)
        rowNumber = 2;
    elseif (IL6Conc == 3 & IFNGConc == 1 & OSMConc == 0)
        rowNumber = 3;
    elseif (IL6Conc == 3 & IFNGConc == 0 & OSMConc == 0)
        rowNumber = 4;
    elseif (IL6Conc == 3 & IFNGConc == 0 & OSMConc == 3)
        rowNumber = 5;
    elseif (IL6Conc == 3 & IFNGConc == 0 & OSMConc == 2)
        rowNumber = 6;
    elseif (IL6Conc == 3 & IFNGConc == 0 & OSMConc == 1)
        rowNumber = 7;
    elseif (IL6Conc == 0 & IFNGConc == 3 & OSMConc == 3)
        rowNumber = 8;
    elseif (IL6Conc == 0 & IFNGConc == 3 & OSMConc == 2)
        rowNumber = 9;
    elseif (IL6Conc == 0 & IFNGConc == 3 & OSMConc == 1)
        rowNumber = 10;
    elseif (IL6Conc == 0 & IFNGConc == 3 & OSMConc == 0)
        rowNumber = 11;
    elseif (IL6Conc == 2 & IFNGConc == 3 & OSMConc == 0)
        rowNumber = 12;
    elseif (IL6Conc == 2 & IFNGConc == 2 & OSMConc == 0)
        rowNumber = 13;
    elseif (IL6Conc == 2 & IFNGConc == 1 & OSMConc == 0)
        rowNumber = 14;
    elseif (IL6Conc == 2 & IFNGConc == 0 & OSMConc == 0)
        rowNumber = 15;
    elseif (IL6Conc == 2 & IFNGConc == 0 & OSMConc == 3)
        rowNumber = 16;
    elseif (IL6Conc == 2 & IFNGConc == 0 & OSMConc == 2)
        rowNumber = 17;
    elseif (IL6Conc == 2 & IFNGConc == 0 & OSMConc == 1)
        rowNumber = 18;
    elseif (IL6Conc == 0 & IFNGConc == 2 & OSMConc == 3)
        rowNumber = 19;
    elseif (IL6Conc == 0 & IFNGConc == 2 & OSMConc == 2)
        rowNumber = 20;
    elseif (IL6Conc == 0 & IFNGConc == 2 & OSMConc == 1)
        rowNumber = 21;
    elseif (IL6Conc == 0 & IFNGConc == 2 & OSMConc == 0)
        rowNumber = 22;
    elseif (IL6Conc == 1 & IFNGConc == 3 & OSMConc == 0)
        rowNumber = 23;
    elseif (IL6Conc == 1 & IFNGConc == 2 & OSMConc == 0)
        rowNumber = 24;
    elseif (IL6Conc == 1 & IFNGConc == 1 & OSMConc == 0)
        rowNumber = 25;
    elseif (IL6Conc == 1 & IFNGConc == 0 & OSMConc == 0)
        rowNumber = 26;
    elseif (IL6Conc == 1 & IFNGConc == 0 & OSMConc == 3)
        rowNumber = 27;
    elseif (IL6Conc == 1 & IFNGConc == 0 & OSMConc == 2)
        rowNumber = 28;
    elseif (IL6Conc == 1 & IFNGConc == 0 & OSMConc == 1)
        rowNumber = 29;
    elseif (IL6Conc == 0 & IFNGConc == 1 & OSMConc == 3)
        rowNumber = 30;
    elseif (IL6Conc == 0 & IFNGConc == 1 & OSMConc == 2)
        rowNumber = 31;
    elseif (IL6Conc == 0 & IFNGConc == 1 & OSMConc == 1)
        rowNumber = 32;
    elseif (IL6Conc == 0 & IFNGConc == 1 & OSMConc == 0)
        rowNumber = 33;
    elseif (IL6Conc == 0 & IFNGConc == 0 & OSMConc == 0)
        rowNumber = 34;
    elseif (IL6Conc == 0 & IFNGConc == 0 & OSMConc == 3)
        rowNumber = 35;
    elseif (IL6Conc == 0 & IFNGConc == 0 & OSMConc == 2)
        rowNumber = 36;
    elseif (IL6Conc == 0 & IFNGConc == 0 & OSMConc == 1)
        rowNumber = 37;
    else
        disp('Invalid concentration(s).');
    end
end