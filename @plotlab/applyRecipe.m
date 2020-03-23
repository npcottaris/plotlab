function applyRecipe(obj, varargin)

   % Parse input
   p = inputParser;
   p.addRequired('obj', @(x)isa(x, 'plotlab'));
   p.addParameter('customRecipeFunction', [], @(x)((isempty(x))||(isa(x,'function_handle'))));
   
   % General figure properties
   p.addParameter('renderer', 'painters', @(x)(ismember(x, {'painters', 'opengl'})));
   p.addParameter('figureBackgroundColor', [1 1 1], @(x)(isnumeric(x)&&(numel(x) == 3)));
   p.addParameter('colorOrder', plotlab.defaultColorOrder, @isnumeric);
   p.addParameter('lightTheme','light', @(x)((ischar(x))&&(ismember(x, {'light', 'dark'}))));
   p.addParameter('legendOnWhiteBackground', false, @islogical);
   p.addParameter('figureWidthInches',  6.0, @(x)(isnumeric(x)));
   p.addParameter('figureHeightInches', 4.0, @(x)(isnumeric(x)));
   
   % Line plot properties
   p.addParameter('lineWidth', 2, @isnumeric);
   p.addParameter('lineMarker', 'o', @ischar);
   p.addParameter('lineMarkerSize',12, @isnumeric);
   p.addParameter('lineMarkerFaceColor', [0.75 0.75 0.75], @(x)( (isnumeric(x)&&(numel(x) == 3)) ) );
   p.addParameter('lineMarkerEdgeColor', [0 0 0], @(x)(isnumeric(x)&&(numel(x) == 3)));
   
   % Scatter plot properties
   p.addParameter('scatterLineWidth', 1.5, @isnumeric);
   p.addParameter('scatterMarker', 'o', @ischar);
   p.addParameter('scatterMarkerFaceColor', 'flat', @(x)( (ismember(x, 'flat')) || (isnumeric(x)&&(numel(x) == 3)) ) );
   p.addParameter('scatterMarkerEdgeColor', [0 0 0], @(x)(isnumeric(x)&&(numel(x) == 3)));
   p.addParameter('scatterMarkerFaceAlpha', 0.4, @isnumeric);
   
   % Area plot properties
   p.addParameter('areaFaceColor', 'flat', @(x)( (ismember(x, 'flat')) || (isnumeric(x)&&(numel(x) == 3)) ) );
   p.addParameter('areaFaceAlpha', 0.3, @isnumeric);
   p.addParameter('areaEdgeColor', [0 0 0], @(x)(isnumeric(x)&&(numel(x) == 3)));
   p.addParameter('areaEdgeAlpha', 0.5, @isnumeric);
   p.addParameter('areaLineWidth', 1.5, @isnumeric);
   
   % Parse the input
   p.parse(obj, varargin{:});
   
   % New plotting params do not go into effect if there are open figures.
   close all;
   
   % Reset all default graphics parameters
   plotlab.resetAllDefaults();
 
   % Apply plotlab's default recipe

   % Figure renderer: Painters for better 2D graphics
   set(groot, 'defaultFigureRenderer',p.Results.renderer);
   
   % Figure backround color default
   set(groot, 'defaultFigureColor', p.Results.figureBackgroundColor);
   
   % Color order
   plotlab.setDefaultColorOrder('rgbColors', p.Results.colorOrder);
   
   % Line plot defaults
   set(groot, 'defaultLineLineWidth', p.Results.lineWidth);
   set(groot, 'defaultLineMarker', p.Results.lineMarker);
   set(groot, 'defaultLineMarkerSize',p.Results.lineMarkerSize);
   set(groot, 'defaultLineMarkerFaceColor', p.Results.lineMarkerFaceColor);
   set(groot, 'defaultLineMarkerEdgeColor', p.Results.lineMarkerEdgeColor);
   
   % Scatter plot defaults
   set(groot, 'defaultScatterMarker', p.Results.scatterMarker);
   set(groot, 'defaultScatterMarkerFaceColor', p.Results.scatterMarkerFaceColor);
   set(groot, 'defaultScatterMarkerFaceAlpha', p.Results.scatterMarkerFaceAlpha);
   set(groot, 'defaultScatterLineWidth', p.Results.scatterLineWidth);
     
   % Area plot defaults
   p.Results
   set(groot, 'defaultAreaFaceColor', p.Results.areaFaceColor);
   set(groot, 'defaultAreaFaceAlpha', p.Results.areaFaceAlpha);
   set(groot, 'defaultAreaEdgeColor', p.Results.areaEdgeColor);
   set(groot, 'defaultAreaEdgeAlpha', p.Results.areaEdgeAlpha);
   set(groot, 'defaultAreaLineWidth', p.Results.areaLineWidth);
   
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
   end
   
   if (strcmp(p.Results.lightTheme, 'dark'))
       invertColors(obj);
   end
end

function invertColors(obj)
    obj.lightTheme = 'dark';
    set(groot, 'defaultFigureInvertHardcopy', 'off');
     
    % Invert color-related default parameters 
    colorRelaredParameters = {...
        'AxesColorOrder' ...
        'FigureColor' ...
        'AxesColor' ...
        'AxesXColor' ...
        'AxesYColor' ...
        'AxesGridColor' ...
        'LineColor' ...
        'LegendTextColor' ...
        'ScatterMarkerEdgeColor' ...
        'ScatterMarkerFaceColor' ...
        'LineMarkerEdgeColor' ...
        'LineMarkerFaceColor' ...
        'LineColor' ...
        'PatchEdgeColor' ...
        'PatchFaceColor' ...
        'AreaEdgeColor' ...
        'AreaFaceColor' ...
        };
    
    for k = 1:numel(colorRelaredParameters)
        defaultParamName = sprintf('default%s', colorRelaredParameters{k});
        %fprintf('Inverting %s\n', defaultParamName);
        defaultValue = get(groot, defaultParamName);
        if (isnumeric(defaultValue))
            set(groot, defaultParamName, 1-defaultValue);
        end
    end
end
