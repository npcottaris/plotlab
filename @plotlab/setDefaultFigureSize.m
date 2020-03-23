function setDefaultFigureSize(varargin)
% Override the default figure size parameters
%
% Syntax:
%   setDefaultFigureSize(varargin)
%
% Description:
%    Override the default exported figure size parameters, and keep the
%    screen-rendering consistent with the figure size. 
%
% Inputs:
%    None.
%
% Outputs:
%    None.
%
% Optional key/value pairs:
%    'units'    - Units of figure size (inches, cm, or normalized)
%    'width'    - Width of figure
%    'height'   - Height of figure
%

% History:
%    03/21/20  NPC  Wrote it

    p = inputParser;
    p.addParameter('units','inches', @(x)((ischar(x))&&(ismember(x, {'inches', 'cm', 'normalized'}))));
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

