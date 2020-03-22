function exportFig(obj, hFig, graphicFormat, fileName, fileDir)

    if (strcmp(fileDir, 'gallery'))
        p = getpref('plotlab');
        fName = fullfile(p.galleryDir, fileName);
    else
        fName = fullfile(fileDir, fileName);
    end
    fName = sprintf('%s-%s', fName, obj.lightTheme);
    print(hFig, fName, sprintf('-d%s', lower(graphicFormat)), '-r300');
end

