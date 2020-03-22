function transparentContourPlot(obj, axesHandle, xSupport, ySupport, zData, ...
    zLevels, outlinedLevels, contourLineColor, cmap)

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
