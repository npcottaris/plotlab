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
        
        %% Recipe methods that set a number of properties to achieve a desired type of plot
        applyRecipe(recipeName, varargin);
        
        %% Methods for setting individual properties
        % Set the default color order
        setDefaultColorOrder(varargin); 
        
        % Set the default figure size
        setDefaultFigureSize(varargin);
        
        % Offset the axes
        offsetAxes(axesHandle, varargin);
        
        % Draw the outlines of a bar plot
        barOutline(x,y);
        
        % Display all default&factory properties (and their values)
        % that contain the refString in their name
        displayPropertiesReferringTo(refString);
        
        % Return the property names of type = {'default', 'factory'}, that
        % contain the refString in their name
        matchingPropertyNames = findGraphicsProperties(type, refString, printNamesAndValues);
    end
    

end

