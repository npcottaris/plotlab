function t_areaPlot
     % Get the demo data to plot
    [L_absorbance, M_absorbance, S_absorbance, lambda] = getData();
    
    % Colors for the L-, M-, and S-cone nomograms
    LMSconeColors = [...
        1.0 0.2 0.4; ...
        0.1 1.0 0.4; ...
        0.5 0.1 0.8];
            
    % Instantiate a plotlab object
    plotlabOBJ = plotlab();
    
    % Apply the default plotlab recipe overriding 
    % the color order and the figure size
    plotlabOBJ.applyRecipe(...
        'colorOrder', LMSconeColors, ...
        'figureWidthInches', 6, ...
        'figureHeightInches', 6);
    
    % New figure
    hFig = figure(1); clf; hold on;

    % Area plots (data)
    minAbsorbance = 0.01;
    area(lambda, L_absorbance, minAbsorbance);
    area(lambda, M_absorbance, minAbsorbance);
    area(lambda, S_absorbance, minAbsorbance);
    
    % Legend
    legend({'L cone', 'M cone', 'S cone'}, 'Location', 'NorthEast');

    % Title
    title(sprintf('Stockman-Sharpe nomograms'));

    % Labels
    xlabel('\it wavelength (nm)'); ylabel('\it normalized absorbance');

    set(gca, 'XLim', [400 700], 'XTick', 350:50:850, ...
        'YLim', [minAbsorbance 1.0], 'YTick', [0.01 0.03 0.1 0.3 1], ...
        'YScale', 'log');
    
    % Export the figure to the gallery directory in PNG format
    plotlabOBJ.exportFig(hFig, 'png', 'SSnomograms', 'gallery');
end

function [L_absorbance, M_absorbance, S_absorbance, lambda] = getData()
    load('nomograms.mat', 'L_absorbance', 'M_absorbance', 'S_absorbance', 'lambda');
end