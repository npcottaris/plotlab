function t_contourPlot
    [coneMosaicStruct, psfStruct] = getData();
    
    zLevels = 0.01:0.01:0.99;
    outlinedLevels = 0.05:0.1:0.95;
    
    cMap = brewermap(numel(zLevels), 'greys');
    plotlab.applyRecipe(...
        'figureWidthInches', 6.2, ...
        'figureHeightInches', 6.2);
    
    set(groot, 'defaultPatchEdgeColor', [0 0 0]);
    set(groot, 'defaultPatchEdgeAlpha',1);
    set(groot, 'defaultPatchFaceAlpha', 0.05);
    set(groot, 'defaultPatchLineStyle', '-');
    set(groot, 'defaultPatchLineWidth', 1.0);
    set(groot, 'defaultAxesColor', cMap(1,:));
    set(groot, 'defaultAxesTickDir', 'out');
    
    % New figure
    hFig = figure(1); clf; hold on;
    
    for coneIndex = 1:numel(coneMosaicStruct.coneTypes)
        cp = coneMosaicStruct.coneLocs(coneIndex,:);
        x = cp(1) + coneMosaicStruct.coneApertures(coneIndex)/2*cosd(0:10:360);
        y = cp(2) + coneMosaicStruct.coneApertures(coneIndex)/2*sind(0:10:360);
        switch (coneMosaicStruct.coneTypes(coneIndex))
            case 2
                color = [1 0 0];
            case 3
                color = [0 0.8 0];
            case 4
                color = [0 0 1];
        end
        fill(x,y, color, 'EdgeColor', color, 'FaceAlpha', 0.3);
    end
    
    transparentContourPlot(...
        psfStruct.xSupport, psfStruct.ySupport,...
        psfStruct.psf, zLevels, outlinedLevels, cMap);
    
    
    % Title
    title(sprintf('point spread function & cone mosaic'));

    % Labels
    xlabel('\it space (arc min)'); 
    ylabel('\it space (arc min)'); 

    set(gca, 'CLim', [0 1], 'XLim', [-30 30], 'XTick', -30:10:30, ...
        'YLim', [-30 30], 'YTick', -30:10:30);
    
    % No box, add grid
    box off; grid on; axis 'square';
 
    % Get gallery directory
    p = getpref('plotlab');
    fName = fullfile(p.galleryDir, 'PointSpreadFunction');
    
    % Export to PDF
    print(hFig, fName, '-dpdf', '-r300');
    
    % Export to PNG
    print(hFig, fName, '-dpng', '-r300');
end


function [coneMosaicStruct, psfStruct] = getData()
    load('mosaicPSFdata', 'coneMosaicStruct', 'wavePSF', 'xSupportMinutes', 'ySupportMinutes');
    psfStruct.psf = wavePSF/max(wavePSF(:));
    psfStruct.xSupport = xSupportMinutes*1e6;
    psfStruct.ySupport = ySupportMinutes*1e6;
    coneMosaicStruct.coneLocs = coneMosaicStruct.coneLocs*300;
    coneMosaicStruct.coneApertures = coneMosaicStruct.coneApertures*1500;
end
 
function transparentContourPlot(xSupport, ySupport, zData, zLevels, outlinedLevels, cmap)
    C = contourc(xSupport, ySupport, zData, zLevels);
    dataPoints = size(C,2);
    startPoint = 1;
    hold on;
    while (startPoint < dataPoints)
        theLevel = C(1,startPoint);
        theLevelVerticesNum = C(2,startPoint);
        x = C(1,startPoint+(1:theLevelVerticesNum));
        y = C(2,startPoint+(1:theLevelVerticesNum));
        v = [x(:) y(:)];
        f = 1:numel(x);
       patch('Faces', f, 'Vertices', v, ...
                'FaceColor', cmap(round(theLevel*size(cmap,1)),:), ...
                'EdgeColor', 'none');
        
        startPoint = startPoint + theLevelVerticesNum+1;                                                                                                                                                                                                                                                                                                                                                                                                                                                                                        
    end
    
    startPoint = 1;
    hold on;
    while (startPoint < dataPoints)
        theLevel = C(1,startPoint);
        theLevelVerticesNum = C(2,startPoint);
        x = C(1,startPoint+(1:theLevelVerticesNum));
        y = C(2,startPoint+(1:theLevelVerticesNum));
        v = [x(:) y(:)];
        f = 1:numel(x);
        if (any(outlinedLevels == theLevel))
            patch('Faces', f, 'Vertices', v, ...
                'FaceColor', 'none');
        end
        startPoint = startPoint + theLevelVerticesNum+1;                                                                                                                                                                                                                                                                                                                                                                                                                                                                                        
    end
    
end
