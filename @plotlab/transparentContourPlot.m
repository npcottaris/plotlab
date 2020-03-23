function transparentContourPlot(obj, axesHandle, xSupport, ySupport, zData, ...
    zLevels, outlinedLevels, contourLineColor, cmap)
% Generate a semi-transparent contour plot
%
% Syntax:
%   transparentContourPlot(obj, axesHandle, xSupport, ySupport, zData, ...
%    zLevels, outlinedLevels, contourLineColor, cmap)
%
% Description:
%    Generate a custom contour plot in which contours are filled with a 
%    semitransparent color using a user-specified colormap, and outlined 
%    using a user-specified color, possibly at a different set of levels
%
% Inputs:
%    obj                - the plotlab object
%    axesHandle         - the axes on which the contour is to be rendered
%    xSupport           - the x-axis support
%    ySupport           - the y-axis support
%    zData              - the zData
%    zLevels            - levels for the filled contours
%    outlinedLevels     - levels for the outlined contours
%    contoutLineColor   - color for the outlined contours
%    cmap               - colormap for the filled contours
%
% Outputs:
%    None.
%
% Optional key/value pairs:
%    None.
%
% For usage see:
%   t_contourPlot()
%

% History:
%    03/21/20  NPC  Wrote it


    if (strcmp(obj.lightTheme, 'dark'))
        cmap = 1 - cmap;
        contourLineColor = 1-contourLineColor;
    end
    
    minZ = min(zLevels);
    maxZ = max(zLevels);
    cmapLength = size(cmap,1);
    hold(axesHandle, 'on');
    
    % Compute contours at all levels
    C = contourc(xSupport, ySupport, zData, zLevels);
    dataPoints = size(C,2);

    % Faces for all zLevels
    startPoint = 1;
    while (startPoint < dataPoints)
        theLevel = C(1,startPoint);
        theCMapIndex = round((theLevel-minZ)/(maxZ-minZ)*cmapLength);
        theCMapIndex = min([cmapLength max([1 theCMapIndex])]);
        theLevelVerticesNum = C(2,startPoint);
        x = C(1,startPoint+(1:theLevelVerticesNum));
        y = C(2,startPoint+(1:theLevelVerticesNum));
        v = [x(:) y(:)];
        f = 1:numel(x);
        patch(axesHandle, 'Faces', f, 'Vertices', v, ...
                'FaceColor', cmap(theCMapIndex,:), ...
                'EdgeColor', 'none');
        
        startPoint = startPoint + theLevelVerticesNum+1;                                                                                                                                                                                                                                                                                                                                                                                                                                                                                        
    end
    
    % Compute contours at all levels
    C = contourc(xSupport, ySupport, zData, outlinedLevels);
    dataPoints = size(C,2);
    
    % Edges for the outlined levels only
    startPoint = 1;
    while (startPoint < dataPoints)
        theLevelVerticesNum = C(2,startPoint);
        x = C(1,startPoint+(1:theLevelVerticesNum));
        y = C(2,startPoint+(1:theLevelVerticesNum));
        v = [x(:) y(:)];
        f = 1:numel(x);
        patch(axesHandle, 'Faces', f, 'Vertices', v, ...
                  'FaceColor', 'none', 'EdgeColor', contourLineColor);
        startPoint = startPoint + theLevelVerticesNum+1;                                                                                                                                                                                                                                                                                                                                                                                                                                                                                        
    end
    
end
