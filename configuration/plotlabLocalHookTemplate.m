% plotlabLocalHookTemplate
%
% Template for setting preferences and other configuration things, for
% plotlab

% 03/19/2020  NPC   Wrote it.

%% Define project
toolboxName = 'plotlab';

%% Clear out old preferences
if (ispref(toolboxName))
    rmpref(toolboxName);
end

%% Clear out prefs named 'ColorMaterialModel', if they exist
% 
% We used to have these, but decided not to anymore
if (ispref('ColorMaterialModel'))
    rmpref('ColorMaterialModel');
end

%% Specify project location
bltbBaseDir = tbLocateToolbox('BrainardLabToolbox');

% Figure out where baseDir for other kinds of data files is.
%
% Can only do this when we have GetComputerInfo available.
if (exist('GetComputerInfo','file'))
    sysInfo = GetComputerInfo();
    switch (sysInfo.localHostName)
        case 'eagleray'
            % DHB's desktop
            baseDir = fullfile(filesep,'Volumes','Users1','Dropbox (Aguirre-Brainard Lab)');
            
        case {'Manta', 'Manta-2'}
            % Nicolas's iMac
            baseDir = fullfile(filesep,'Volumes','DropBoxDisk/Dropbox','Dropbox (Aguirre-Brainard Lab)');
            
        otherwise
            % Some unspecified machine, try user specific customization
            switch(sysInfo.userShortName)
                % Could put user specific things in, but at the moment generic
                % is good enough.
                otherwise
                    baseDir = ['/Users/' sysInfo.userShortName '/Dropbox (Aguirre-Brainard Lab)'];
            end
    end
    
    % RadiometerChecks preferences
    %
    % These preferences have to do with the RadiometerChecks section of the
    % BrainardLabToolbox
    setpref(toolboxName,'RadiometerChecksDir',fullfile(baseDir,'MELA_admin','RadiometerChecks'));
end

%% ColorMaterialModel preferences
%
% These preferences have to do with the ColorMaterialModel section of the
% BrainardLabToolbox
setpref(toolboxName,'cmmCodeDir',fullfile(bltbBaseDir,'ColorMaterialModel'));
setpref(toolboxName,'cmmDemoDataDir', fullfile(bltbBaseDir,'ColorMaterialModel','DemoData'));

%% Add PTB PsychJava to the path, if we can find the Psychtoolbox.
%
% Find the toolbox location, the TbTb way.
ptbBaseDir = tbLocateToolbox('Psychtoolbox-3');
if (~isempty(ptbBaseDir))
    thePath = fullfile(ptbBaseDir,'Psychtoolbox','PsychJava');
    theMsg = 'Psychtoolbox/PsychJava';
    if exist('JavaAddToPath','file')
        JavaAddToPath(thePath,theMsg);
    end
end

%% RadiometerChecks need access to GetWithDefault, which is a PTB function
setpref(toolboxName, 'ptbBaseDir', ptbBaseDir);

%% Calibration prefs
% 
% If there is a PsychCalLocalData folder that tbLocate can find, 
% we point at that. Otherwise this is set to empty.
%
% Specific projects can override this to have the calibration files
% written to a project specific location.
psychCalLocalData = tbLocateToolbox('PsychCalLocalData');
setpref(toolboxName,'CalDataFolder',psychCalLocalData);