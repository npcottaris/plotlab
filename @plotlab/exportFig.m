function exportFig(obj, hFig, graphicFormat, fileName, fileDir)
% Export figure to a file with a specific graphic format
%
% Syntax:
%   exportFig(obj, hFig, graphicFormat, fileName, fileDir)
%
% Description:
%    Export figure to a file with a specific graphic format.
%
% Inputs:
%    obj            - the plotlab object
%    hFig           - the figure handle of the figure to be exported
%    graphicFormat  - the graphic format of the exported figure (e.g, pdf,png)
%    fileName       - the name of the exported figure
%    fileDir        - the directory of where the figure is to be exported
%
% Outputs:
%    None.
%
% Optional key/value pairs:
%    None.
%

% History:
%    03/21/20  NPC  Wrote it

    if (strcmp(fileDir, 'gallery'))
        p = getpref('plotlab');
        fName = fullfile(p.galleryDir, fileName);
    else
        fName = fullfile(fileDir, fileName);
    end
    fName = sprintf('%s-%s.%s', fName, obj.lightTheme, lower(graphicFormat));
    print(hFig, fName, sprintf('-d%s', lower(graphicFormat)), '-r300');
    fprintf('Figure exported to ''%s''.\n', fName);
end

