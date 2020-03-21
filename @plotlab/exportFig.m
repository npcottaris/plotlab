function exportFig(hFig, graphicFormat, fileName, fileDir)

    if (strcmp(fileDir, 'gallery'))
        p = getpref('plotlab');
        fName = fullfile(p.galleryDir, fileName);
    else
        fName = fullfile(fileDir, fileName);
    end
    print(hFig, fName, sprintf('-d%s', lower(graphicFormat)), '-r300');
end

