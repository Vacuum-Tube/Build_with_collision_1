local tb = {}

local ttContainerID = "toolTipContainer"
local function getContainerLayout()
	local containerComp = api.gui.util.getById(ttContainerID)
	return containerComp:getLayout()
end

tb.id = "bwc.toolTipContainer.toolTip"

function tb.create(text,onClick,tooltip,pos_offset)
	tb.destroy()
	
	local textView = api.gui.comp.TextView.new(text)
	local button = api.gui.comp.Button.new(textView,true)
	if onClick then
		button:onClick(onClick)  -- function()
	end
	local layout = api.gui.layout.BoxLayout.new("VERTICAL")
	layout:addItem(button)
	
	local toolTipComp = api.gui.comp.Component.new("")
	toolTipComp:setId(tb.id)
	toolTipComp:setLayout(layout)
	if tooltip then
		toolTipComp:setTooltip(tooltip)
	end
	
	local containerLayout = getContainerLayout()
	local mousePosition = game.gui.getMousePos()
	pos_offset = pos_offset or {x=0,y=0}
	containerLayout:addItem(toolTipComp, api.gui.util.Rect.new(
		mousePosition[1]+pos_offset.x,
		mousePosition[2]+pos_offset.y,
		0,0
	))
	-- containerLayout:setPosition(0, mousePosition[1], mousePosition[2])  -- ITEM position!
end

function tb.destroy(fromCallback)
	if api.gui then
		local elem = api.gui.util.getById(tb.id)
		if elem then
			local containerLayout = getContainerLayout()
			containerLayout:removeItem(elem)
			if not fromCallback then
				elem:destroy()  -- Callback:  Warning: a UI component has destroyed itself during handling an event, this leads to undefined behaviour!
			else
				api.gui.util.destroyLater(elem)
			end
		end
	end
end

function tb.exists()
	return api.gui.util.getById(tb.id)~=nil
end

return tb