function [contractStart, contractEnd] = separateContraction( torqueData, timeIn,...
        torqueThreshold, sfreq)

plot(timeIn, torqueData)
axis([ timeIn(1) timeIn(end) 0 (1.2 * max(torqueData)) ])
hold on

i = 1;
while torqueData(i) < torqueThreshold
    i = i + 1;
end

iStart = i;
contractStart(1) = iStart;

i = iStart + sfreq;
while torqueData(i) > torqueThreshold
    i = i + 1;
end

iEnd = i;
contractEnd(1) = iEnd;

plot( [ timeIn( iStart ), timeIn( iStart ) ], [ 0, (1.2 * max(torqueData) ) ],':')
plot( [ timeIn( iEnd ),   timeIn( iEnd )   ], [ 0, (1.2 * max(torqueData) ) ],':')

% find end of last contraction
n = length(torqueData);
i = n;
while torqueData(i) < torqueThreshold
    i = i - 1;
end
trialEnd = i;

% loop around for all of the contractions
j = 1;

while iEnd < trialEnd
    j = j+ 1;
    
    i = iEnd;
    
    while torqueData(i) < torqueThreshold && i < trialEnd
        i = i + 1;
    end
    
    iStart = i;
    contractStart(j) = iStart;
    
    i = iStart + 1;
    
    while torqueData(i) > torqueThreshold && i < trialEnd
        i = i + 1;
    end
    iEnd = i;
    contractEnd(j) = iEnd;
    
    plot( [ timeIn( iStart ), timeIn( iStart ) ], [ 0, (1.2 * max(torqueData) ) ],':')
    plot( [ timeIn( iEnd ),   timeIn( iEnd )   ], [ 0, (1.2 * max(torqueData) ) ],':')
end

hold off
end

