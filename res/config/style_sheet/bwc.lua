local ssu = require "stylesheetutil"

function data()
    local result = {}
    local a = ssu.makeAdder(result)
	
	a("#bwc.toolTipContainer.toolButton", {
		-- backgroundColor = ssu.makeColor(15, 35, 50, 000),
		borderColor = ssu.makeColor(50, 50, 50, 255),
		borderWidth = {2, 2, 2, 2},
		gravity = { .0, .0 },
		blurRadius = 8,
	})
	
	a("#bwc.toolTipContainer.toolButton TextView", {
		backgroundColor = ssu.makeColor(50, 125, 200, 200),
		fontSize = 18,
	})
	a("#bwc.toolTipContainer.toolButton TextView:hover", {
		backgroundColor = ssu.makeColorOffset(50, 125, 200, 200, 50),
	})
	
    return result
end
