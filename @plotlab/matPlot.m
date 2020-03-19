classdef matPlot

    methods (Static)
        %% Method to reset all default properties to their factory values
        resetAllDefaults();
        
        %% Recipe methods that set a number of properties to achieve a desired type of plot
        % Recipe for a plot that contains lines and/or markers
        setDefaultsForLineMarkerPlot(varargin);
        
        %% Methods for setting individual properties
        % Set the default line color
        setDefaultLineColors(varargin); 
        
        % Set the default figure size
        setDefaultFigureSize(varargin);
        
        % Offset the axes
        offsetAxes(axesHandle, varargin);
        
        % Display all default&factory properties (and their values)
        % that contain the refString in their name
        displayPropertiesReferringTo(refString);
        
        % Return the property names of type = {'default', 'factory'}, that
        % contain the refString in their name
        matchingPropertyNames = findGraphicsProperties(type, refString, printNamesAndValues);
    end
    

end

