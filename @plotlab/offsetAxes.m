function offsetAxes(axesHandle, varargin)
    p = inputParser;
    p.addParameter('offsetPercent',0.03, @(x)(isnumeric(x)));
    p.parse(varargin{:});
    
    XLim = get(axesHandle, 'XLim');
    YLim = get(axesHandle, 'YLim');

    XScale = get(axesHandle, 'XScale');
    YScale = get(axesHandle, 'YScale');
    
    if strcmp(get(groot, 'defaultAxesXaxisLocation'), 'bottom')
        signX = -1;
    else
        signX = 1;
    end
    if strcmp(get(groot, 'defaultAxesYaxisLocation'), 'left')
        signY = -1;
    else
        signY = 1;
    end
    
    XLim(1) = newMin(XLim, XScale,p.Results.offsetPercent, signX);
    YLim(1) = newMin(YLim, YScale,p.Results.offsetPercent, signY);
    
    set(axesHandle, 'XLim', XLim, 'YLim', YLim);
    get(axesHandle, 'XMinorTick'); 
    
end

function xMin = newMin(XLim, XScale,p, sign)
    if (strcmp(XScale, 'linear'))
        xRange = XLim(2)-XLim(1);
        deltaX = xRange * p;
        xMin = XLim(1)+sign*deltaX;
    else

        xRange = log10(XLim(2))-log10(XLim(1));
        deltaX = xRange * p;
        xMin = 10^(log10(XLim(1))+sign*deltaX);
    end
end

