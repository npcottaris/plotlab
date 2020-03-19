function setDefaultColorOrder(varargin)
    
    p = inputParser;
    p.addParameter('rgbColors', [0 0 0], @(x) (isnumeric(x))&&(size(x,2)==3));
    p.parse(varargin{:});
    
    % New plotting params do not go into effect if there are open figures.
    if (size(p.Results.rgbColors,1) == 1)
        defaultAxesColorOrder = get(groot, 'factoryAxesColorOrder');
        defaultAxesColorOrder = cat(1,p.Results.rgbColors, defaultAxesColorOrder);
        set(groot, 'defaultAxesColorOrder',defaultAxesColorOrder);
    else
        set(groot, 'defaultAxesColorOrder',p.Results.rgbColors);
    end
    
end

