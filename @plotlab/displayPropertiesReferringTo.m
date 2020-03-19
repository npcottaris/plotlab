function displayPropertiesReferringTo(refString)   
    fprintf('\nSearching for graphics properties referring to ''%s''...', refString);
    printNamesAndValues = true;
    matPlot.findGraphicsProperties('factory', refString, printNamesAndValues);
    matPlot.findGraphicsProperties('default', refString, printNamesAndValues);
end
