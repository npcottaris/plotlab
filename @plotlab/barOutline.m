function barOutline(x,y)
    nPoints = numel(x);
    xSequence = [];
    ySequence = [];
    dx = x(2)-x(1);
    for k = 1:nPoints-1
        xSequence(numel(xSequence)+1) = x(k);
        ySequence(numel(ySequence)+1) = y(k);
        xSequence(numel(xSequence)+1) = x(k+1);
        ySequence(numel(ySequence)+1) = y(k);
    end
    plot(xSequence-dx/2, ySequence, '-');
end

