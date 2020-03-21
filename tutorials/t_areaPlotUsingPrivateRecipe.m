function t_areaPlotUsingPrivateRecipe

    [space, centerRFprofile, surroundRFprofile, subunits] = getData();
    
    colors = [1 0 0; 0 1 0];
    colors = cat(1, colors, repmat([0.2 0.2 0.2], [size(subunits,2) 1]));
    
    % Apply the recipe included in this file
    plotlab.applyRecipe(...
        'customRecipeFunction', @()internalRecipe(colors), ...
        'figureWidthInches', 6, ...
        'figureHeightInches', 6);
    
    % New figure
    hFig = figure(1); clf; hold on;

    % Area plots
    area(space, centerRFprofile, 'LineStyle', '-');
    area(space, surroundRFprofile,  'LineStyle', '-');
    for k = 1:size(subunits,2)
        area(space, subunits(:,k), 'LineStyle', '-', 'LineWidth', 1.5);             
    end
    plot(space, centerRFprofile, 'LineStyle', '-');
    plot(space, surroundRFprofile,  'LineStyle', '-');
    
    % Legend
    legend({'center', 'surround', 'subunits'}, 'Location', 'NorthWest');

    % Title
    title(sprintf('pRGC RF profile'));

    % Labels
    xlabel('\it space (degs)'); ylabel('\it sensitivity');

    % Limits
    set(gca, 'XLim', [-1.5 1.5], 'XTick', -1.5:0.5:1.5, ...
        'YLim', [-0.2 1], 'YTick', -1:0.2:1);
    
    % Box and grid
    box off; grid on
    
    % Offset the axes 
    plotlab.offsetAxes(gca);
    
    % Get gallery directory
    p = getpref('plotlab');
    fName = fullfile(p.galleryDir, 'RFprofile');
    
    % Export to PDF
    print(hFig, fName, '-dpdf', '-r300');
    
    % Export to PNG
    print(hFig, fName, '-dpng', '-r300');
end

function internalRecipe(colors)

   set(groot, 'defaultLineMarkerFaceColor', [0.75 0.75 0.75]);
   set(groot, 'defaultScatterMarkerFaceColor', [0.75 0.75 0.75]);
    
   % Figure renderer: Painters for better 2D graphics
   set(groot, 'defaultFigureRenderer', 'painters');
   
   % Figure color
   set(groot, 'defaultFigureColor', [1 1 1]);
   
   % Color order
   set(groot, 'defaultAxesColorOrder', colors);
   
   % Line plot
   set(groot, 'defaultLineLineWidth', 1.0);
   set(groot, 'defaultLineMarkerSize',12);
   
   set(groot, 'defaultAreaLineStyle', '--');
   set(groot, 'defaultAreaFaceAlpha', 0.3);
   set(groot, 'defaultAreaFaceColor', 'flat');
   set(groot, 'defaultAreaEdgeColor', [0 0 0]);
   set(groot, 'defaultAreaEdgeAlpha', 1);
   set(groot, 'defaultAreaLineWidth', 2);
   
   % Fonts
   set(groot, 'defaultAxesFontSize', 16);
   set(groot, 'defaultAxesFontName', 'Helvetica');
   set(groot, 'defaultAxesTitleFontWeight', 'normal');
   set(groot, 'defaultAxesLabelFontSizeMultiplier', 1.25);
   
   % Ticks
   set(groot, 'defaultAxesTickLength', [0.015 0.01]);
   set(groot, 'defaultAxesTickDir', 'both');
   set(groot, 'defaultAxesTickDirMode', 'manual');
   
   % Axes line width
   set(groot, 'defaultAxesLineWidth', 1.0);
   
   % Grids
   set(groot, 'defaultAxesXGrid', 'on');
   set(groot, 'defaultAxesYGrid', 'on');

   % Legend
   set(groot, 'defaultLegendLocation', 'NorthOutside');
   
   % Boxes
   set(groot, 'defaultAxesBox', 'on');
   set(groot, 'defaultLegendBox', 'off');
   
   % Figure size
   plotlab.setDefaultFigureSize(...
       'units','inches', ...
       'width', 6, ...
       'height',6 ...
       );
      
end

function [space, centerRFprofile, surroundRFprofile, subunits] = getData()
    space = -1.5:0.005:1.5;
    sigma = [0.1 0.5];
    centerRFprofile = exp(-0.5*(space/sigma(1)).^2);
    subunits = [];
    subunitCenters = -0.5:0.056:0.5;
    subunitSigma = 0.04;
    for k = 1:numel(subunitCenters)
        gain = 0.5*exp(-0.5*(subunitCenters(k)/sigma(1)).^2);
        subunits(:,k) = gain * exp(-0.5*((space-subunitCenters(k))/subunitSigma).^2);
    end
    surroundRFprofile = -0.1*exp(-0.5*(space/sigma(2)).^2);
end