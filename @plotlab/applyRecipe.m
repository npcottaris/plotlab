function applyRecipe(recipeName,varargin)

   
   % Parse input
   p = inputParser;
   p.addRequired('recipeName', @(x)(ischar(x) || (isa(x,'function_handle'))));
   p.addParameter('colorOrder', plotlab.defaultColorOrder, @isnumeric);
   p.addParameter('lightTheme','light', @(x)((ischar(x))&&(ismember(x, {'light', 'dark'}))));
   p.addParameter('legendOnWhiteBackground', false, @islogical);
   p.addParameter('figureWidthInches',  6.0, @(x)(isnumeric(x)));
   p.addParameter('figureHeightInches', 4.0, @(x)(isnumeric(x)));
   p.parse(recipeName, varargin{:});
   
   
   % New plotting params do not go into effect if there are open figures.
   close all;
   
   % Reset all default graphics parameters
   plotlab.resetAllDefaults();
   
   % If the recipe name is a function handle, execute that function handle
   if (isa(p.Results.recipeName,'function_handle'))
       p.Results.recipeName(varargin{:})
       return;
   end
   
   % Otherwise execute one of the builtin 
   % Set the color order
   plotlab.setDefaultColorOrder('rgbColors', p.Results.colorOrder);
   
   set(groot, 'defaultLineMarkerFaceColor', [0.75 0.75 0.75]);
   set(groot, 'defaultScatterMarkerFaceColor', [0.75 0.75 0.75]);
    
   % Figure renderer: Painters for better 2D graphics
   set(groot, 'defaultFigureRenderer', 'painters');
   
   % Figure color
   set(groot, 'defaultFigureColor', [1 1 1]);
   
   % Line plot
   set(groot, 'defaultLineLineWidth', 2);
   set(groot, 'defaultLineMarkerSize',12);
   
   switch (p.Results.recipeName)
       case {'LineMarkerPlot' }
            % Scatter plot marker
            set(groot, 'defaultScatterMarkerFaceColor', 'flat');
            set(groot, 'defaultScatterMarkerFaceAlpha', 0.4);
            set(groot, 'defaultScatterLineWidth', 1.5);
            
       case {'AreaPlot'}
            set(groot, 'defaultAreaFaceAlpha', 0.3);
            set(groot, 'defaultAreaFaceColor', 'flat');
            set(groot, 'defaultAreaEdgeColor', [0 0 0]);
            set(groot, 'defaultAreaEdgeAlpha', 0.5);
            set(groot, 'defaultAreaLineWidth', 1.5);
   end
   
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
   
   
   if (p.Results.legendOnWhiteBackground)
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