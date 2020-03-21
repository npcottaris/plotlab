% plotlabLocalHookTemplate
%
% Template for setting preferences and other configurations for plotlab.

% 03/19/2020  NPC   Wrote it.

%% Define project
toolboxName = 'plotlab';

%% Clear out old preferences
if (ispref(toolboxName))
    rmpref(toolboxName);
end

%% Specify project location
plotlabBaseDir = tbLocateToolbox('plotlab');

%% Specify useful directories location
setpref(toolboxName,'recipesDir',fullfile(plotlabBaseDir,'recipes'));
setpref(toolboxName,'tutorialsDir',fullfile(plotlabBaseDir,'tutorials'));
setpref(toolboxName,'galleryDir',fullfile(plotlabBaseDir,'gallery'));