function setDefaultsForLineMarkerPlot(varargin)
   % Parse input
   p = inputParser;
   p.addParameter('lightTheme','light', @(x)((ischar(x))&&(ismember(x, {'light', 'dark'}))));
   p.addParameter('figureWidthInches',  6.0, @(x)(isnumeric(x)));
   p.addParameter('figureHeightInches', 4.0, @(x)(isnumeric(x)));
   p.parse(varargin{:});
   
   % New plotting params do not go into effect if there are open figures.
   close all;
   
   
   % Black, red, blue
   plotlab.setDefaultLineColors('rgbColors', ...
       [...
        0.8941    0.1020    0.1098;
        0.2157    0.4941    0.7216;
        0.3020    0.6863    0.2902;
        0.5961    0.3059    0.6392;
        1.0000    0.4980         0;
        1.0000    1.0000    0.2000;
        0.6510    0.3373    0.1569;
        0.9686    0.5059    0.7490;
        0.6000    0.6000    0.6000;
        0.8941    0.1020    0.1098...
       ]...
   );
   
   set(groot, 'defaultLineMarkerFaceColor', [0.75 0.75 0.75]);
   set(groot, 'defaultScatterMarkerFaceColor', [0.75 0.75 0.75]);
    
   % Figure renderer: Painters for better 2D graphics
   set(groot, 'defaultFigureRenderer', 'painters');
   
   % Figure color
   set(groot, 'defaultFigureColor', [1 1 1]);
   
   % Line plot
   set(groot, 'defaultLineLineWidth', 2);
   set(groot, 'defaultLineMarkerSize',12);
    
   % Scatter plot marker
   set(groot, 'defaultScatterMarkerFaceColor', 'flat');
   set(groot, 'defaultScatterMarkerFaceAlpha', 0.4);
   set(groot, 'defaultScatterLineWidth', 1.5);
   
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
   set(groot, 'defaultAxesMinorGridAlpha', 0);
   % Legend
   set(groot, 'defaultLegendLocation', 'NorthWest');
   
   legendOnWhiteBackground = ~true;
   if (legendOnWhiteBackground)
       set(groot, 'defaultLegendColor', [1 1 1]);
       set(groot, 'defaultLegendEdgeColor', [1 1 1])
       set(groot, 'defaultLegendBox', 'on');
   else
        % or no legend background
        set(groot, 'defaultLegendBox', 'off');
   end
   
   % Boxes
   set(groot, 'defaultAxesBox', 'off');
   
   % Figure size
   plotlab.setDefaultFigureSize(...
       'units','inches', ...
       'width', p.Results.figureWidthInches, ...
       'height',p.Results.figureHeightInches ...
       );
      
end