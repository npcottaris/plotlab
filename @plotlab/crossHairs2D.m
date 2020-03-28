function crossHairs2D(axesHandle, varargin)
% Add crosshairs to a plot
%
% Syntax:
%   crossHairs2D(axesHandle, varargin)
%
% Description:
%    Add crosshairs to a plot
%
% Inputs:
%    axesHandle         - the axes on which to add the cross-hairs
%
% Outputs:
%    None.
%
% Optional key/value pairs:
%   'center'        - (x,y) center of the crosshairs
%   'xRange',       - [xMin xMax], xRange of the crosshairs
%   'yRange'        - [yMin yMax], yRange of the crosshairs
%   'lineWidth'     - the width of the crosshairs
%   'lineColor'     - the color of the crosshairs
%   'lineStyle'     - the line style of the crosshairs

% History:
%    03/25/20  NPC  Wrote it


    p = inputParser;
    p.addParameter('center', [0 0], @(x)(isnumeric(x)&&(numel(x)==2)));
    p.addParameter('xRange', [-1 1], @(x)(isnumeric(x)&&(numel(x)==2)));
    p.addParameter('yRange', [-1 1], @(x)(isnumeric(x)&&(numel(x)==2)));
    p.addParameter('lineWidth', [], @(x)( (isempty(x) || isscalar(x))));
    p.addParameter('lineColor', [0 0 0], @(x)( (isempty(x) || (isnumeric(x)&&(numel(x)==3)) )));
    p.addParameter('lineStyle', [], @(x)( (isempty(x) || ischar(x))));
    p.parse(varargin{:});
    
    hold(axesHandle, 'on');
    p1 = plot(axesHandle, p.Results.xRange, p.Results.center(2)*[1 1], '-');
    p2 = plot(axesHandle, p.Results.center(1)*[1 1], p.Results.yRange, '-');
    
    if (~isempty(p.Results.lineWidth))
        p1.LineWidth = p.Results.lineWidth;
        p2.LineWidth = p.Results.lineWidth;
    end
    
    if (~isempty(p.Results.lineStyle))
        p1.LineStyle = p.Results.lineStyle;
        p2.LineStyle = p.Results.lineStyle;
    end
    
    if (~isempty(p.Results.lineColor))
        p1.Color = p.Results.lineColor;
        p2.Color = p.Results.lineColor;
    end
    
    set(p1, 'HandleVisibility','off');
    set(p2, 'HandleVisibility','off');
    
end

