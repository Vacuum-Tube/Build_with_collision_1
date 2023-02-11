
local tb = {}
tb.id = "bwc.toolTipContainer.toolButton"

function tb.createComp(text,onClick,tooltip)
	local textView = api.gui.comp.TextView.new(text)
	local button = api.gui.comp.Button.new(textView,true)
	if onClick then
		button:onClick(onClick)
	end
	local layout = api.gui.layout.BoxLayout.new("VERTICAL")
	layout:addItem(button)
	
	local toolTipComp = api.gui.comp.Component.new("")
	toolTipComp:setId(tb.id)
	toolTipComp:setLayout(layout)
	if tooltip then
		toolTipComp:setTooltip(tooltip)
	end
	
	return toolTipComp
end

function tb.ToolButtonCreate(text,onClick,tooltip,pos_offset)
	tb.destroy()
	local toolTipComp = tb.createComp(text,onClick,tooltip)
	local containerLayout = api.gui.util.getById("toolTipContainer"):getLayout()
	local mousePosition = game.gui.getMousePos()
	pos_offset = pos_offset or {x=0,y=0}
	containerLayout:addItem(toolTipComp, api.gui.util.Rect.new(
		mousePosition[1]+pos_offset.x,
		mousePosition[2]+pos_offset.y,
		0,0
	))
	tb.isOnMainButtonsLayout = false
end

function tb.MenuButtonCreate(text,onClick)
	tb.destroy()
	local comp = tb.createComp(text,onClick)
	local mainButtonsLayoutRight = api.gui.util.getById("mainButtonsLayout"):getItem(2)
	mainButtonsLayoutRight:addItem(comp)
	tb.isOnMainButtonsLayout = true
end

function tb.destroy(fromCallback)
	if api.gui then
		local elem = api.gui.util.getById(tb.id)
		if elem then
			local layout
			if tb.isOnMainButtonsLayout then
				layout = api.gui.util.getById("mainButtonsLayout"):getItem(2)
			else
				layout = api.gui.util.getById("toolTipContainer"):getLayout()
			end
			layout:removeItem(elem)
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