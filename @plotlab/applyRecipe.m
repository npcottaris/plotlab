function applyRecipe(obj, varargin)
% Gateway method for the matplot recipe to be applied
%
% Syntax:
%   applyRecipe(obj, varargin)
%
% Description:
%    Gateway method for the matplot recipe to be applied. This function
%    sets a number of plotting parameters to achieve a visually-engaging
%    plot appearance using the standard recipe. Further plot customization 
%    can be achieved by passing key-value pairs that alter the values of 
%    the parameters defined here, and complete customization can be achieved
%    by passing a handle to an external recipe function. The external recipe
%    function is applied after the standard recipe is applied.
%
% Inputs:
%    obj            - the plotlab object
%
% Outputs:
%    None.
%
% Optional key/value pairs:
%    'customRecipeFunction'    - handle to an external recipe function to
%                                be executed after the standard recipe
%     ....                     - a number of parameters overriding the
%                                standard recipe

% History:
%    03/21/20  NPC  Wrote it

   % Parse input
   p = inputParser;
   p.addRequired('obj', @(x)isa(x, 'plotlab'));
   p.addParameter('customRecipeFunction', [], @(x)((isempty(x))||(isa(x,'function_handle'))));
   
   % General figure properties
   p.addParameter('renderer', 'painters', @(x)(ismember(x, {'painters', 'opengl'})));
   p.addParameter('figureBackgroundColor', [1 1 1], @(x)(isnumeric(x)&&(numel(x) == 3)));
   p.addParameter('colorOrder', plotlab.defaultColorOrder, @isnumeric);
   p.addParameter('lightTheme','light', @(x)(ismember(x, {'light', 'dark'})));
   p.addParameter('legendOnWhiteBackground', false, @islogical);
   p.addParameter('figureWidthInches',  6.0, @(x)(isnumeric(x)));
   p.addParameter('figureHeightInches', 4.0, @(x)(isnumeric(x)));
   
   % Line plot properties
   p.addParameter('lineWidth', 2, @isscalar);
   p.addParameter('lineMarker', 'o', @ischar);
   p.addParameter('lineMarkerSize',12, @isscalar);
   p.addParameter('lineMarkerFaceColor', [0.75 0.75 0.75], @(x)( (isnumeric(x)&&(numel(x) == 3)) ) );
   p.addParameter('lineMarkerEdgeColor', [0 0 0], @(x)(isnumeric(x)&&(numel(x) == 3)));
   
   % Scatter plot properties
   p.addParameter('scatterLineWidth', 1.5, @isscalar);
   p.addParameter('scatterMarker', 'o', @ischar);
   p.addParameter('scatterMarkerFaceColor', 'flat', @(x)( (ismember(x, {'flat'})) || (isnumeric(x)&&(numel(x) == 3)) ) );
   p.addParameter('scatterMarkerEdgeColor', [0 0 0], @(x)(isnumeric(x)&&(numel(x) == 3)));
   p.addParameter('scatterMarkerFaceAlpha', 0.4, @isscalar);
   
   % Area plot properties
   p.addParameter('areaFaceColor', 'flat', @(x)( (ismember(x, {'flat'})) || (isnumeric(x)&&(numel(x) == 3)) ) );
   p.addParameter('areaFaceAlpha', 0.3, @isscalar);
   p.addParameter('areaEdgeColor', [0 0 0], @(x)(isnumeric(x)&&(numel(x) == 3)));
   p.addParameter('areaEdgeAlpha', 0.5, @isscalar);
   p.addParameter('areaLineWidth', 1.5, @isscalar);
   
   % Font  properties
   p.addParameter('axesFontSize', 16, @isscalar);
   p.addParameter('axesFontName', 'Helvetica', @ischar);
   p.addParameter('axesTitleFontWeight', 'normal', @(x)(ismember(x, {'normal', 'bold', 'italic'})));
   p.addParameter('axesLabelFontSizeMultiplier', 1.25, @isscalar);
   
   % Ticks
   p.addParameter('axesTickLength', [0.015 0.01], @(x)(isnumeric(x)&&(numel(x) == 2)));
   p.addParameter('axesTickDir', 'both',  @(x)(ismember(x, {'both', 'in', 'out'})));
   p.addParameter('axesTickDirMode', 'manual', @(x)(ismember(x, {'auto', 'manual'})));
   
   % Axes line width & box
   p.addParameter('axesLineWidth', 1.0, @isscalar);
   p.addParameter('axesBox', 'off', @(x)(ismember(x, {'on', 'off'})));
   
   % Grid defaults
   p.addParameter('axesXGrid', 'on', @(x)(ismember(x, {'on', 'off'})));
   p.addParameter('axesYGrid', 'on', @(x)(ismember(x, {'on', 'off'})));
   p.addParameter('axesMinorGridAlpha', 0, @isscalar);
   
   % Legend
   p.addParameter('legendLocation', 'NorthWest', @ischar);
   
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
   set(groot, 'defaultAreaFaceColor', p.Results.areaFaceColor);
   set(groot, 'defaultAreaFaceAlpha', p.Results.areaFaceAlpha);
   set(groot, 'defaultAreaEdgeColor', p.Results.areaEdgeColor);
   set(groot, 'defaultAreaEdgeAlpha', p.Results.areaEdgeAlpha);
   set(groot, 'defaultAreaLineWidth', p.Results.areaLineWidth);
   
   % Font defaults
   set(groot, 'defaultAxesFontSize', p.Results.axesFontSize);
   set(groot, 'defaultAxesFontName', p.Results.axesFontName);
   set(groot, 'defaultAxesTitleFontWeight', p.Results.axesTitleFontWeight);
   set(groot, 'defaultAxesLabelFontSizeMultiplier', p.Results.axesLabelFontSizeMultiplier);
   
   % Ticks
   set(groot, 'defaultAxesTickLength', p.Results.axesTickLength);
   set(groot, 'defaultAxesTickDir', p.Results.axesTickDir);
   set(groot, 'defaultAxesTickDirMode', p.Results.axesTickDirMode);
   
   % Axes line width & Box
   set(groot, 'defaultAxesLineWidth', p.Results.axesLineWidth);
   set(groot, 'defaultAxesBox', p.Results.axesBox);
   
   % Grid defaults
   set(groot, 'defaultAxesXGrid', p.Results.axesXGrid);
   set(groot, 'defaultAxesYGrid', p.Results.axesYGrid);
   set(groot, 'defaultAxesMinorGridAlpha', p.Results.axesMinorGridAlpha);
   
   % Legend location & apparance
   set(groot, 'defaultLegendLocation', p.Results.legendLocation);
   
   if (p.Results.legendOnWhiteBackground)
       set(groot, 'defaultLegendColor', [1 1 1]);
       set(groot, 'defaultLegendEdgeColor', [1 1 1])
       set(groot, 'defaultLegendBox', 'on');
   else
        % or no legend background
        set(groot, 'defaultLegendBox', 'off');
   end
   
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
   
   % Finally, invert the colors if we are using the dark theme.
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
