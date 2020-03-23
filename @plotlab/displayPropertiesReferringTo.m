function displayPropertiesReferringTo(refString) 
% Display all factory and default properties of the graphics root object
% that contain a specific string in their name
%
% Syntax:
%   displayPropertiesReferringTo(refString) 
%
% Description:
%    Display all factory and default properties of the graphics root object
%    whose name contains a user-specified substring
%
% Inputs:
%    refString  - the substring to be matched
%
% Outputs:
%    None.
%
% Optional key/value pairs:
%    None.
%

% History:
%    03/21/20  NPC  Wrote it

    fprintf('\nSearching for graphics properties referring to ''%s''...', refString);
    printNamesAndValues = true;
    plotlab.findGraphicsProperties('factory', refString, printNamesAndValues);
    plotlab.findGraphicsProperties('default', refString, printNamesAndValues);
end
