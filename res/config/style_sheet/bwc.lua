local ssu = require "stylesheetutil"

function data()
    local result = {}
    local a = ssu.makeAdder(result)
	
	a("bwcToolButton", {
		-- backgroundColor = ssu.makeColor(15, 35, 50, 000),
		borderColor = ssu.makeColor(50, 50, 50, 255),
		borderWidth = {2, 2, 2, 2},
		gravity = { .0, .0 },
		blurRadius = 8,
	})
	a("bwcToolButton TextView", {
		backgroundColor = ssu.makeColor(50, 125, 200, 200),
		fontSize = 18,
	})
	a("bwcToolButton TextView:hover", {
		backgroundColor = ssu.makeColorOffset(50, 125, 200, 200, 50),
	})
	
	a("bwcToolTip", {
		backgroundColor = ssu.makeColor(15, 35, 50, 100),
		-- margin = ,
		gravity = { .0, .0 },
		blurRadius = 8,
	})
	a("bwcToolTip TextView", {
		fontSize = 18,
	})
	
	
	a("bwcMouseListenerComp", {
		-- backgroundColor = ssu.makeColor(255, 0, 0, 100),
		minSize = {"100vw", "100vh"},
		anchorPoint = {0.5, 0.5},
		gravity = {0, 0},
	})
	
	-- Note: Component Name must not contain . or _ !!
	
    return result
end
