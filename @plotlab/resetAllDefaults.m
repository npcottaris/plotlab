function resetAllDefaults()

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
        set(groot, setDefaultProperties{k}, p.(factoryPropertyName));
        %fprintf('Overwrote value of ''%s'' with value of ''%s''.\n', defaultPropertyName, factoryPropertyName);
    end
end

