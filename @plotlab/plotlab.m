% Create a plotlab object
%
% Syntax:
%   plotlabOBJ = plotlab();
%
% Description:
%    Instantiates a plotlab object
%
% Inputs:
%    None.
%
% Outputs:
%    None.

% History:
%    03/21/29  NPC  Wrote it

% Examples:
%{
    t_lineMarkerPlot()
    t_histogramPlotUsingExternalRecipe()
    t_contourPlot()
    t_areaPlotUsingPrivateRecipe()
%}

classdef plotlab < handle

    properties (Constant)
        % Line/area/marker color of sequentials plots if none is specified
        defaultColorOrder = [
            0.8941    0.1020    0.1098;
            0.2157    0.4941    0.7216;
            0.3020    0.6863    0.2902;
            0.5961    0.3059    0.6392;
            1.0000    0.4980         0;
            1.0000    1.0000    0.2000;
            0.6510    0.3373    0.1569;
            0.9686    0.5059    0.7490;
            0.6000    0.6000    0.6000;
            0.8941    0.1020    0.1098
            ];
    end
    
    properties (SetAccess=private)
        % The light theme to be applied, either 'light' (white background),
        % or 'dark' (black background, inverted colors
        lightTheme;
    end
    
    methods
        % Constructor
        function obj = plotlab()
            obj.lightTheme = 'light';
        end
        
        %% Geteway to different plotting recipes which alter the default graphics root object properties
        applyRecipe(obj, varargin);
        
        %% Method for rendering a semitrasparent contour plot
        transparentContourPlot(obj,axesHandle, xSupport, ySupport, zData, zLevels, outlinedLevels, contourLineColor, cmap);
    
        %% Method to export figure
        exportFig(obj, hFig, graphicFormat, fileName, fileDir);
    end
    
    
    methods (Static)
        %% Method to reset all default properties to their factory values
        resetAllDefaults();
        
        %% Method to display all default&factory graphics root object properties (and their values) that contain the refString in their name
        displayPropertiesReferringTo(refString);
 
        %% Methods for setting individual graphics root properties
        % Set the default color order
        setDefaultColorOrder(varargin); 
        
        % Set the default figure size
        setDefaultFigureSize(varargin);
        
        %% Methods to achieve effects not controlled by the different properties of the graphics root object
        % Offset the axes
        offsetAxes(axesHandle, varargin);
        
        % Draw the outlines of a bar plot
        barOutline(x,y);
        
        % Return the property names of type = {'default', 'factory'}, that
        % contain the refString in their name
        matchingPropertyNames = findGraphicsProperties(type, refString, printNamesAndValues);
    end

end

