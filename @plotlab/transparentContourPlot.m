function transparentContourPlot(axesHandle, xSupport, ySupport, zData, zLevels, outlinedLevels, cmap)

    hold(axesHandle, 'on');
    
    % Compute contours at all levels
    C = contourc(xSupport, ySupport, zData, zLevels);
    dataPoints = size(C,2);

    % Faces for all zLevels
    startPoint = 1;
    while (startPoint < dataPoints)
        theLevel = C(1,startPoint);
        theLevelVerticesNum = C(2,startPoint);
        x = C(1,startPoint+(1:theLevelVerticesNum));
        y = C(2,startPoint+(1:theLevelVerticesNum));
        v = [x(:) y(:)];
        f = 1:numel(x);
        patch(axesHandle, 'Faces', f, 'Vertices', v, ...
                'FaceColor', cmap(round(theLevel*size(cmap,1)),:), ...
                'EdgeColor', 'none');
        
        startPoint = startPoint + theLevelVerticesNum+1;                                                                                                                                                                                                                                                                                                                                                                                                                                                                                        
    end
    
    % Compute contours at all levels
    C = contourc(xSupport, ySupport, zData, outlinedLevels);
    dataPoints = size(C,2);
    
    % Edges for the outlined levels only
    startPoint = 1;
    while (startPoint < dataPoints)
        theLevel = C(1,startPoint);
        theLevelVerticesNum = C(2,startPoint);
        x = C(1,startPoint+(1:theLevelVerticesNum));
        y = C(2,startPoint+(1:theLevelVerticesNum));
        v = [x(:) y(:)];
        f = 1:numel(x);
        patch(axesHandle, 'Faces', f, 'Vertices', v, ...
                  'FaceColor', 'none');
        startPoint = startPoint + theLevelVerticesNum+1;                                                                                                                                                                                                                                                                                                                                                                                                                                                                                        
    end
    
end
