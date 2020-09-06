function toggleAxesVisibility(theAxes)
% Hide the axes
%
% Syntax:
%   hideAxes(theAxes)
%
% Description:
%    Hide the axes
%
% Inputs:
%    theAxes         - the axes handle to hide
%
% Outputs:
%    None
%

% History:
%    08/21/20  NPC  Wrote it

    if (strcmp(theAxes.XAxis.Visible, 'off'))
        theAxes.XAxis.Visible = 'on';
    else
        theAxes.XAxis.Visible = 'off';
    end
    
    if (strcmp(theAxes.YAxis.Visible, 'off'))
        theAxes.YAxis.Visible = 'on';
    else
        theAxes.YAxis.Visible = 'off';
    end
    
    if (strcmp(theAxes.XGrid, 'off'))
        theAxes.XGrid = 'on';
    else
        theAxes.XGrid = 'off';
    end
    
    if (strcmp(theAxes.YGrid, 'off'))
        theAxes.YGrid = 'on';
    else
        theAxes.YGrid = 'off';
    end
end
