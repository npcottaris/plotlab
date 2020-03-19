function displayPropertiesReferringTo(refString)   
    fprintf('\nSearching for graphics properties referring to ''%s''...', refString);
    printNamesAndValues = true;
    plotlab.findGraphicsProperties('factory', refString, printNamesAndValues);
    plotlab.findGraphicsProperties('default', refString, printNamesAndValues);
end
