function repositionLegend(legendHandle, xyPos)
% Reposition the legend to xyPos
%
% Syntax:
%   repositionLegend(legendHandle, xyPos)
%
% Description:
%    Reposition the legend to xyPos
%
% Inputs:
%    legendHandle         - the legend to be offset
%    xyPos                - new [x y] position of the legend
%
% Outputs:
%    None.
%
% Optional key/value pairs:
%    None.
%
% For usage see:
%   t_areaPlot()
%

% History:
%    03/24/20  NPC  Wrote it

    p = get(legendHandle, 'position');
    set(legendHandle, 'position', [xyPos(1) xyPos(2) p(3) p(4)]);
end
