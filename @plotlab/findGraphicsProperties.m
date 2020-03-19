function matchingPropertyNames = findGraphicsProperties(type, refString, printNamesAndValues)
    theGraphicsRootObj = groot;
    theGraphicsRootObj.ShowHiddenHandles = 'on';
    
    % Find all properties
    propsFactoryDefaults = get(theGraphicsRootObj,type);
    propertyNames = fieldnames(propsFactoryDefaults);
    
    if (strcmp(refString, '*'))
        matchingPropertyNames = propertyNames;
        return;
    end
    
    % Determine which of these contain the refString
    index = strfind(lower(propertyNames),lower(refString));
    index = find(~cellfun(@isempty,index));
    propertiesFound = numel(index);
    
    % Print their names and values
    fprintf('\nFound %d <strong>*%s*</strong> properties with a reference to ''%s''.\n', propertiesFound, type, refString);
    matchingPropertyNames = cell(1,numel(index));
    for k = 1:propertiesFound
        thePropertyName = propertyNames{index(k)};
        matchingPropertyNames{k} = thePropertyName;
        thePropertyValue = propsFactoryDefaults.(thePropertyName);
        if (printNamesAndValues)
            displayPropertyNameAndValue(k, thePropertyName, thePropertyValue, type);
        end
    end
    
end


function displayPropertyNameAndValue(k, thePropertyName, thePropertyValue, type)
    if (ischar(thePropertyValue))
        fprintf(' %4d. %-53s with value: %s\n', k, strrep(thePropertyName, type, ''), thePropertyValue);
    elseif (islogical(thePropertyValue))
        fprintf(' %4d. %-53s with value: %d\n', k, strrep(thePropertyName, type, ''), thePropertyValue);
    elseif isnumeric(thePropertyValue)
        fprintf(' %4d. %-53s with values: ',k,  strrep(thePropertyName, type, ''));
        for kk = 1:min(3, numel(thePropertyValue))
            fprintf('%g ', thePropertyValue(kk));
        end
        if (numel(numel(thePropertyValue))>3)
            fprintf(' ... ');
        end
        fprintf('\n');
    else
        thePropertyValue
    end
end

