function resetAllDefaults()
% Reset all the graphics root object parameters to their factory values
%
% Syntax:
%   resetAllDefaults()
%
% Description:
%    Reset all the graphics root object parameters to their factory values
%
% Inputs:
%    None.
%
% Outputs:
%    None.
%
% Optional key/value pairs:
%    None.
%

% History:
%    03/21/20  NPC  Wrote it

    % New plotting params do not go into effect if there are open figures.
    close all;
    
    printNamesAndValues = false;
    refString = '*';
    setDefaultProperties = plotlab.findGraphicsProperties('default', refString, printNamesAndValues);
    
    % Get struct with all the factory properties and their values
    p = get(groot, 'factory');
    
    for k = 1:numel(setDefaultProperties)
        defaultPropertyName = setDefaultProperties{k};
        factoryPropertyName = strrep(defaultPropertyName, 'default', 'factory');
        if (isfield(p, factoryPropertyName))
            set(groot, setDefaultProperties{k}, p.(factoryPropertyName));
        else
            fprintf(2,'plotlab.(%s): ''%s'' not found in groot.\n', mfilename(), factoryPropertyName);
        end
    end
end

