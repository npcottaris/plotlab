function colorbar(axesHandle, colorbarLabel, colorbarLabelFontSize, varargin)
% Add a colorbar without changing the plot size
%
% Syntax:
%   colorbar(axesHandle, colorbarLabel, colorbarLabelFontSize, varargin)
%
% Description:
%    Add a colorbar without changing the plot size
%
% Inputs:
%    axesHandle             - the axes to be offset
%    colorbarLabel          - the label of the colorbar
%    colorbarLabelFontSize  - the font size of the colorbar
%
% Outputs:
%    None.
%
% Optional key/value pairs:
%    optional key/value pairs appropriate for Matlab's colorbar()
%

% History:
%    03/21/20  NPC  Wrote it

    op = get(axesHandle, 'Position');
    c = colorbar(axesHandle, varargin{:});
    c.Label.String = colorbarLabel;
	c.Label.FontSize = colorbarLabelFontSize;
    set(axesHandle, 'Position', op);   
end
