classdef plotlab

    properties (Constant)
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
    
    methods (Static)
        %% Method to reset all default properties to their factory values
        resetAllDefaults();
        
        %% Method to display all default&factory graphics root object properties (and their values) that contain the refString in their name
        displayPropertiesReferringTo(refString);
        
        %% Geteway to different plotting recipes which alter the default graphics root object properties
        applyRecipe(varargin);
        
        %% Method to export figure
        exportFig(hFig, graphicFormat, fileName, fileDir);
        
        %% Methods for setting individual graphics root properties
        % Set the default color order
        setDefaultColorOrder(varargin); 
        
        % Set the default figure size
        setDefaultFigureSize(varargin);
        
        %% Methods to achieve renderings not controlled by the different properties of the graphics root object
        % Offset the axes
        offsetAxes(axesHandle, varargin);
        
        % Draw the outlines of a bar plot
        barOutline(x,y);
        
        % Render a semitrasparent contour plot
        transparentContourPlot(axesHandle, xSupport, ySupport, zData, zLevels, outlinedLevels, cmap)
        
        % Return the property names of type = {'default', 'factory'}, that
        % contain the refString in their name
        matchingPropertyNames = findGraphicsProperties(type, refString, printNamesAndValues);
    end
    

end

