local ssu = require "stylesheetutil"

function data()
    local result = {}
    local a = ssu.makeAdder(result)
	
	a("#bwc.toolTipContainer.toolTip", {
		backgroundColor = ssu.makeColor(15, 35, 50, 100),
		-- margin = { -70, 0, 50, 30 },
		gravity = { .0, .0 },
		blurRadius = 16,
	})
	
	a("#bwc.toolTipContainer.toolTip TextView", {
		backgroundColor = ssu.makeColor(50, 125, 200, 200),
		fontSize = 18,
	})
	a("#bwc.toolTipContainer.toolTip TextView:hover", {
		backgroundColor = ssu.makeColorOffset(50, 125, 200, 200, 25),
	})
	a("#bwc.toolTipContainer.toolTip TextView:active", {
		backgroundColor = ssu.makeColorOffset(50, 125, 200, 200, 50),
	})
	a("#bwc.toolTipContainer.toolTip TextView:disabled", {
		color = ssu.makeColor(25, 25, 25, 100)
	})
	
    return result
end
