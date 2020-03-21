function applyRecipe(varargin)

   % Parse input
   p = inputParser;
   p.addParameter('customRecipeFunction', [], @(x)((isempty(x))||(isa(x,'function_handle'))));
   p.addParameter('colorOrder', plotlab.defaultColorOrder, @isnumeric);
   p.addParameter('lightTheme','light', @(x)((ischar(x))&&(ismember(x, {'light', 'dark'}))));
   p.addParameter('legendOnWhiteBackground', false, @islogical);
   p.addParameter('figureWidthInches',  6.0, @(x)(isnumeric(x)));
   p.addParameter('figureHeightInches', 4.0, @(x)(isnumeric(x)));
   p.parse(varargin{:});
   
   % New plotting params do not go into effect if there are open figures.
   close all;
   
   % Reset all default graphics parameters
   plotlab.resetAllDefaults();
 
   % Apply plotlab's default recipe

   % Figure renderer: Painters for better 2D graphics
   set(groot, 'defaultFigureRenderer', 'painters');
   
   % Figure backround color default
   set(groot, 'defaultFigureColor', [1 1 1]);
   
   % Color order
   plotlab.setDefaultColorOrder('rgbColors', p.Results.colorOrder);
   
   % Line plot defaults
   set(groot, 'defaultLineLineWidth', 2);
   set(groot, 'defaultLineMarkerSize',12);
   set(groot, 'defaultLineMarkerFaceColor', [0.75 0.75 0.75]);
   
   % Scatter plot defaults
   set(groot, 'defaultScatterMarker', 'o');
   set(groot, 'defaultScatterMarkerFaceColor', 'flat');
   set(groot, 'defaultScatterMarkerFaceAlpha', 0.4);
   set(groot, 'defaultScatterLineWidth', 1.5);
     
   % Area plot defaults
   set(groot, 'defaultAreaFaceAlpha', 0.3);
   set(groot, 'defaultAreaFaceColor', 'flat');
   set(groot, 'defaultAreaEdgeColor', [0 0 0]);
   set(groot, 'defaultAreaEdgeAlpha', 0.5);
   set(groot, 'defaultAreaLineWidth', 1.5);
   
   % Font defaults
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
   
   % Grid defaults
   set(groot, 'defaultAxesXGrid', 'on');
   set(groot, 'defaultAxesYGrid', 'on');
   set(groot, 'defaultAxesMinorGridAlpha', 0);
   
   % Legend location & apparance
   set(groot, 'defaultLegendLocation', 'NorthWest');
   if (p.Results.legendOnWhiteBackground)
       set(groot, 'defaultLegendColor', [1 1 1]);
       set(groot, 'defaultLegendEdgeColor', [1 1 1])
       set(groot, 'defaultLegendBox', 'on');
   else
        % or no legend background
        set(groot, 'defaultLegendBox', 'off');
   end
   
   % Box default
   set(groot, 'defaultAxesBox', 'off');
   
   % Figure size defaults
   plotlab.setDefaultFigureSize(...
       'units','inches', ...
       'width', p.Results.figureWidthInches, ...
       'height',p.Results.figureHeightInches ...
       );
      
   % If a customRecipeFunction is passed, execute that function handle
   if (isa(p.Results.customRecipeFunction,'function_handle'))
       p.Results.customRecipeFunction();
       return;
   end
end