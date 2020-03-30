function theAxesGrid = axesGrid(figureHandle, varargin)
% Generate a 2D grid of axes
%
% Syntax:
%   theAxesGrid = generateAxesGrid(figureHandle, varargin)
%
% Description:
%    Generate a 2D grid of axes
%
% Inputs:
%    figureHandle         - the figure on which to generate the axes grid
%
% Outputs:
%    theAxesGrid          - 2D cell array with the generated axes
%
% Optional key/value pairs:
%   'rowsNum'        - number of grid rows
%   'colsNum',       - number of grid cols
%   'widthMargin'    - normalized margin along the horizontal axis
%   'heightMargin'   - normalized margin along the horizontal axis
%   'leftMargin'     - normalized margin in the left most axis
%   'rightMargin'    - normalized margin in the right most axis
%   'bottomMargin'   - normalized margin in the bottom axis
%   'topMargin'      - normalized margin in the top axis

% History:
%    03/25/20  NPC  Wrote it

    % parse inputs
    p = inputParser;
    p.addParameter('rowsNum',  2, @isscalar);
    p.addParameter('colsNum',  2, @isscalar);
    p.addParameter('widthMargin',  0.02, @isscalar);
    p.addParameter('heightMargin', 0.02, @isscalar);
    p.addParameter('leftMargin',  0.02, @isscalar);
    p.addParameter('rightMargin', 0.02, @isscalar);
    p.addParameter('bottomMargin', 0.02, @isscalar); 
    p.addParameter('topMargin',  0.01, @isscalar);
    p.addParameter('spacing', 'compact', @(x)(ismember(x, {'compact', 'normal', 'none'})));
    p.addParameter('padding', 'compact', @(x)(ismember(x, {'compact', 'normal', 'none'})));
    p.addParameter('method', 'default', @(x)(ismember(x, {'default', 'tile'})));
    p.parse(varargin{:});

    if (strcmp(p.Results.method, 'default'))
        figPos = get(figureHandle, 'Position');
        figWidth = figPos(3);
        figHeight = figPos(4);

        normalizedWidth  = ((1.0-p.Results.leftMargin-p.Results.rightMargin) - p.Results.widthMargin*(p.Results.colsNum-1) - 0.01)/p.Results.colsNum;
        normalizedHeight = ((1.0-p.Results.bottomMargin-p.Results.topMargin) - p.Results.heightMargin*(p.Results.rowsNum-1) - 0.01)/p.Results.rowsNum;

        theAxesGrid = cell(p.Results.rowsNum, p.Results.colsNum);
        for row = 1:p.Results.rowsNum
            yo = 0.99 - p.Results.topMargin - (row)*(normalizedHeight+p.Results.heightMargin) + p.Results.heightMargin;
            for col = 1:p.Results.colsNum
                xo = p.Results.leftMargin + (col-1)*(normalizedWidth+p.Results.widthMargin);
                theAxesGrid{row,col} = axes('Position', [xo*figWidth yo*figHeight normalizedWidth*figWidth normalizedHeight*figHeight]);
            end
        end
    else
        t = tiledlayout(figureHandle, p.Results.rowsNum,p.Results.colsNum);
        t.TileSpacing = p.Results.spacing;
        t.Padding = p.Results.padding;

        theAxesGrid = cell(p.Results.rowsNum, p.Results.colsNum);
        for row = 1:p.Results.rowsNum
        for col = 1:p.Results.colsNum
            theAxesGrid{row,col} = nexttile;
        end
        end
    end
end
