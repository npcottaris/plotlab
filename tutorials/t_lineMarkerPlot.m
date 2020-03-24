function t_lineMarkerPlot()
% Generate a combined line/scatter plot using the default plotlab recipe.
%
% Syntax:
%   t_lineMarkerPlot
%
% Description:
%    Demonstrates how to generate a combined line/scatter plot using the
%    default plotlab recipe with a light theme, and only overriding a few 
%    plot parameters (colorOrder, lineMarkerSize, and figure size). 
%
% Inputs:
%    None.
%
% Outputs:
%    None.
%
% Optional key/value pairs:
%    None.
%

% History:
%    03/21/20  NPC  Wrote it

    % Get the demo data to plot
    [sf, s, c, r, sfModel, sModel, cModel, rModel, b] = getData();
    
    % Instantiate a plotlab object
    plotlabOBJ = plotlab();
    
    % Apply the default plotlab recipe overriding 
    % the color order and the figure size
    plotlabOBJ.applyRecipe(...
        'colorOrder', [1 0 0; 0 0 1; 0 0 0], ...
        'lightTheme', 'light', ...
        'lineMarkerSize', 12, ...
        'figureWidthInches', 5, ...
        'figureHeightInches', 5);
    
    % New figure
    hFig = figure(1); clf; hold on;

    % Scatter plots (data)
    scatter(sf,c);
    scatter(sf,s);
    scatter(sf,r);

    % Line plots (model)
    plot(sfModel, cModel, '-'); 
    plot(sfModel, sModel, '-'); 
    plot(sfModel, rModel, '-'); 
    
    % Baserate
    plot(sfModel, b, '--', 'Color', [0.5 0.5 0.5]);

    % Axes limits and ticks
    set(gca, 'XLim', [0.1 100], 'XTick', [0.1 0.3 1 3 10 30 100], ...
        'YLim', [0 1.5], 'YTick', 0:0.25:1.5, 'XScale', 'log');
    
    % Labels
    xlabel('\it spatial frequency (c/deg)'); ylabel('\it sensitivity');
    
    % Legend
    legend({'center', 'surround', 'RGC'}, 'Location', 'NorthEast');

    % Title
    title('mRGC sf tuning');
 
    % Export the figure to the gallery directory in PNG format
    plotlabOBJ.exportFig(hFig, 'png', 'mRGCsf', 'gallery');
end

function [sf, s, c, r, sfModel, sModel, cModel, rModel, b] = getData()
    sfModel = logspace(log10(0.1), log10(100), 40);
    b = 0.15*ones(size(sfModel));
    sModel = 0.4*exp(-0.5*(sfModel/2).^2) + b;
    cModel = exp(-0.5*(sfModel/10).^2) + b;
    rModel = cModel - sModel + b;
    
    % Set the random seed
    rng(1);
    
    idx = 1:2:numel(sfModel);
    sf = sfModel(idx);
    c = cModel(idx) + 0.03*randn(size(idx));
    s = sModel(idx) + 0.03*randn(size(idx));
    r = rModel(idx) + 0.03*randn(size(idx));
end
