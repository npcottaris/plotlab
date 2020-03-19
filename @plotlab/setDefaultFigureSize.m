function setDefaultFigureSize(varargin)
    p = inputParser;
    p.addParameter('units','inches', @(x)((ischar(x))&&(ismember(x, {'inches', 'normalized'}))));
    p.addParameter('width',  6.0, @(x)(isnumeric(x)));
    p.addParameter('height', 4.0, @(x)(isnumeric(x)));
    p.parse(varargin{:});
    
    set(groot, 'defaultFigureUnits', p.Results.units);
    set(groot, 'defaultFigurePaperUnits', p.Results.units);
    set(groot, 'defaultAxesUnits', p.Results.units);
    set(groot, 'defaultFigurePosition', [0 0 p.Results.width p.Results.height]);
    set(groot, 'defaultAxesOuterPosition', [0.05 0.05 p.Results.width p.Results.height]);
    set(groot, 'defaultFigurePaperPosition', [0 0 p.Results.width p.Results.height]);
    set(groot, 'defaultFigurePaperSize', [p.Results.width p.Results.height]);
    set(groot, 'defaultFigurePaperPositionMode', 'manual');
end

