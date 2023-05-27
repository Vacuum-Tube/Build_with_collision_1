local tb = require "bwc.toolbutton"
local userdata2table = require"bwc.userdata2table"
local copy_userdata = require"bwc.copy_userdata"
require "serialize"
-- local timer = require"advanced_statistics.script.timer"

local newMouseListSolution = tonumber(getBuildVersion())>35200
local optionRightClickBuild = assert(game.bwC, "no game.bwC").optionRightClickBuild

local collisionProp = nil


local function proposalIsEmpty(proposal)
	return 
		#proposal.proposal.addedSegments==0 and 
		#proposal.proposal.removedSegments==0 and
		#proposal.toAdd==0 and
		#proposal.toRemove==0
end

local function isMouseOnUi()
	-- local start = timer.start()
	local mainView = api.gui.util.getById("mainView")
	local layer0 = mainView:getLayout():getItem(0)
	local layer2 = mainView:getLayout():getItem(2)
	local hud = layer0:getLayout():getItem(0):getLayout()
	local v = layer2:getLayout():getItem(0):getLayout():getItem(0):getLayout()
	 -- u = layer2:getLayout():getItem(1):getLayout()
	local w = layer2:getLayout():getItem(2):getLayout()
	 --commonapi.ui.inspect(w)
	local elements = {
		api.gui.util.getById("mainMenuTopBarBG"),
		api.gui.util.getById("mainMenuBottomBar"),
		api.gui.util.getById("menu.finances"),
		api.gui.util.getById("menu.layers"),
		api.gui.util.getById("menu.fileMenuButton"),
		api.gui.util.getById("menu.warningsButton"),
	 }
	local mouse = api.gui.util.getMouseScreenPos()
	 for i,elem in pairs(elements) do
		if elem:getContentRect():contains(mouse.x,mouse.y) and elem:isVisible() then
			-- print(elem:getId(),"contains")
			return true
		end
	end
	for i=0,hud:getNumItems()-1 do
		item = hud:getItem(i)
		if item:getContentRect():contains(mouse.x,mouse.y) and item:isVisible() then
			-- print("layer0",i,"contains")
			return true
		end
	end
	for i=0,v:getNumItems()-1 do
		item = v:getItem(i)
		-- print("layer2v",i,item:getId())
		if item:getContentRect():contains(mouse.x,mouse.y) and item:isVisible() then
			-- print("layer2v",i,"contains")
			return true
		end
	end
	-- print("isMouseOnUi",timer.stop())  -- max 1ms
	return false
end

local function ScriptEvent(id,name,param)
	api.cmd.sendCommand(api.cmd.make.sendScriptEvent("build_with_collision.lua", id, name, param))
	-- game.interface.sendScriptEvent :  Assertion `!gameState.GetGameScriptStack().entries.empty()' failed.
end

local function cancelProposal()
	local mainView = assert(api.gui.util.getById("mainView"), "No mainView")
	local buildControlComp = mainView:getLayout():getItem(1):getLayout():getItem(0)
	if buildControlComp and buildControlComp:getName()=="BuildControlComp" then
		local bLayout = assert(buildControlComp:getLayout():getItem(1), "No buildControlComp Item1")
		for i=0,bLayout:getNumItems()-1 do
			local item = bLayout:getItem(i)
			if item:getName()=="BuildControlComp::CancelButton" then
				item:click()
				return
			end
		end
		-- error("No BuildControlComp::CancelButton")
	else
		-- print("===== Build With Collision - cancelProposal - No BuildControlComp")
	end
end

local function buildProposalEvent(param,stopActionAfterBuild,soundEffect,sendRoadtoolboxEvent)
	local cmd=api.cmd.make.buildProposal(api.type.SimpleProposal.new(),nil,true) --ignoreErrors
	cmd.proposal=param.proposal
	cmd.resultProposalData=param.data
	api.cmd.sendCommand(cmd, function(res, success)
		-- print("Success:",success)
		if success then
			game.gui.playSoundEffect(soundEffect)
			if stopActionAfterBuild then
				-- game.gui.stopAction()  -- removes Build Menu
				cancelProposal()
			end
			tb.destroy()
			collisionProp = nil
			-- if sendRoadtoolboxEvent then
				-- ScriptEvent("__roadtoolbox__", "build_sharp_external", userdata2table(res.proposal.proposal))  -- use res: param is no more valid here; but even res still contains negative entity ids
			-- end
		else
			print("===== Build With Collision - Build failed")
			print("Critical:",res.resultProposalData.errorState.critical)
			if #res.resultProposalData.collisionInfo.collisionEntities>0 then
				-- print("Collision:",toString(res.resultProposalData.collisionInfo.collisionEntities))
			end
		end
	end)
end

local function getOnClick(proposalparam,id)
	return function()
		if proposalIsEmpty(proposalparam.proposal) then
			print("===== Build With Collision - Proposal Empty !")
		else
			proposalparam.proposal.parcelsToRemove={}  -- parcels cause crash
			buildProposalEvent(
				proposalparam, 
				id=="trackBuilder" or id=="streetBuilder",  -- cancelProposal
				id~="bulldozer" and "construct" or "bulldozeMedium",  -- sound
				id=="streetBuilder"  -- roadtoolbox
			)
		end
		tb.destroy(true)
		collisionProp = nil
	end
end

local function guiHandleEvent(id, name, param)
	if
		id=="trackBuilder" or
		id=="streetBuilder" or
		id=="streetTrackModifier" or
		-- id=="streetTerminalBuilder" or -- signals+bus stops , never collision
		id=="constructionBuilder" or
		id=="bulldozer"
	then
		if name=="builder.proposalCreate" then
			local status, err = pcall(function()
				collisionProp = nil
				tb.destroy()
				if proposalIsEmpty(param.proposal) or param.data.errorState.critical then
					return
				end
				if #param.data.errorState.messages>0 then 
					-- p=param--debug
					-- pc=copy_userdata(param)--debug
					-- param.data.errorState.messages:clear()  -- interesting alternative approach: building seems possible but is not successful
					-- if proposalIsEmpty(param.proposal) then
						-- print("===== Build With Collision - COPY Proposal Empty !")
						-- debugPrint(param.proposal)
					-- end
					local tb_text
					local pos_offset
					local proposalparam
					if id=="trackBuilder" or id=="streetBuilder" then
						tb_text = _("Build Anyway")
						pos_offset = {x=30,y=-65}
						proposalparam = param  -- gets empty if cancel proposal
					elseif id=="constructionBuilder" then
						tb_text = _("Build Anyway")
						pos_offset = {x=30,y=-75}
						proposalparam = param  -- gets empty if cancel proposal
					elseif id=="streetTrackModifier" then
						tb_text = _("Upgrade Anyway")
						pos_offset = {x=30,y=-75}
						proposalparam = copy_userdata(param)  -- copy to make possible upgrading after hovering; copy not possible for upgrades with construction...
					elseif id=="bulldozer" then
						tb_text = _("Bulldoze Anyway")
						pos_offset = {x=30,y=-65}
						proposalparam = copy_userdata(param)  -- copy to prevent crash
					end
					if newMouseListSolution and (id=="constructionBuilder" or id=="streetTrackModifier") then
						if not isMouseOnUi() then
							collisionProp = {
								id = id,
								onClick = getOnClick(proposalparam,id),
							}
							tb_text = tb_text .. "\n" .. _("Click Right").." !"
							tb.ToolButtonCreate(tb_text, false, nil, pos_offset )
						end
					else
						tb.ToolButtonCreate(tb_text, getOnClick(proposalparam,id), nil, pos_offset )
					end
				end
				if optionRightClickBuild and (id=="trackBuilder" or id=="streetBuilder") then
					collisionProp = {
						id = id,
						onClick = getOnClick(param,id),
					}
					-- tb.ToolButtonCreate("Click Right to Build", false, nil, {x=30,y=-65} )
				end
			end)
			if status==false then
				print("===== Build With Collision - Error Handler:")
				debugPrint(param)
				print(err)
				print("===== Build With Collision - Please submit this message to the mod author - https://www.transportfever.net/filebase/index.php?entry/6501-build-with-collision/")
				tb.ToolButtonCreate("Error - see console or stdout",nil,err,{x=30,y=-65})
			end
		elseif name=="builder.apply" then
			tb.destroy()
			collisionProp = nil
		end
	elseif (id=="menu.construction" and name=="tabWidget.currentChanged") then
		tb.destroy(true)
		collisionProp = nil
	elseif (id=="menu.construction.railmenu" and name=="visibilityChange" and param==false) or
			(id=="menu.construction.roadmenu" and name=="visibilityChange" and param==false) or
			(id=="menu.construction.rail.tabs" and name=="tabWidget.currentChanged") or
			(id=="menu.construction.road.tabs" and name=="tabWidget.currentChanged") or
			(id=="menu.construction.terrain.tabs" and name=="tabWidget.currentChanged") or
			(id=="menu.bulldozer" and name=="toggleButton.toggle")
	then
		-- print("Destroy toolbutton",id,name,toString(param))
		tb.destroy()
		collisionProp = nil
	end
end

local guiInit = newMouseListSolution and function()
	local mainView = api.gui.util.getById("mainView")  -- apparently, there is no children holding ONLY the rendering without UI
	mainView:insertMouseListener( function (evt)
		if evt.type == 2 and evt.button == 2 and not isMouseOnUi() then
			-- print("right click mainView without UI")
			if collisionProp then
				-- print("collisionProp > exec onClick BwC")
				collisionProp.onClick()
				return true
			end
		end
		return false
	end )
end or nil


function data()
	return {
		--init = init,
		--update = update,
		-- handleEvent = handleEvent,
		--save = save,
		--load = load,
		guiInit = guiInit,
		--guiUpdate = guiUpdate,
		guiHandleEvent = guiHandleEvent,
	}
end