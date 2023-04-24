local tb = require "bwc.toolbutton"
local userdata2table = require"bwc.userdata2table"
local copy_userdata = require"bwc.copy_userdata"
require "serialize"

local tbSet

local function proposalIsEmpty(proposal)
	return 
		#proposal.proposal.addedSegments==0 and 
		#proposal.proposal.removedSegments==0 and
		#proposal.toAdd==0 and
		#proposal.toRemove==0
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
			-- if sendRoadtoolboxEvent then
				-- ScriptEvent("__roadtoolbox__", "build_sharp_external", userdata2table(res.proposal.proposal))  -- use res: param is no more valid here; but even res still contains negative entity ids
			-- end
		else
			print("===== Build With Collision - Build failed")
			print("Critical:",res.resultProposalData.errorState.critical)
			if #res.resultProposalData.collisionInfo.collisionEntities>0 then
				print("Collision:",toString(res.resultProposalData.collisionInfo.collisionEntities))
			end
		end
	end)
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
				if
					not param.data.errorState.critical --check collision but not critical
					-- and #param.data.collisionInfo.collisionEntities>0  -- only for collision not other issues
					and #param.data.errorState.messages>0
					and not proposalIsEmpty(param.proposal)
					-- and not proposalContainsParcels(param.proposal)  -- parcels cause crash
				then 
					local tb_text
					local pos_offset
					-- p=param
					local proposalparam = param -- = copy_userdata(param)
					-- if proposalIsEmpty(proposalparam.proposal) then
						-- print("===== Build With Collision - COPY Proposal Empty !")
						-- debugPrint(proposalparam.proposal)
					-- end
					if id=="trackBuilder" or id=="streetBuilder" then
						tb_text = _("Build Anyway")
						pos_offset = {x=30,y=-65}
						proposalparam = param  -- gets empty if cancel proposal
					elseif id=="constructionBuilder" then
						tb_text = _("Build Anyway")
						pos_offset = {x=30,y=-65}
						proposalparam = param  -- gets empty if cancel proposal
					elseif id=="streetTrackModifier" then
						tb_text = _("Upgrade Anyway")
						pos_offset = {x=5,y=-38}
						proposalparam = copy_userdata(param)  -- copy to make possible upgrading after hovering; copy not possible for upgrades with construction...
					elseif id=="bulldozer" then
						tb_text = _("Bulldoze Anyway")
						pos_offset = {x=30,y=-65}
						proposalparam = copy_userdata(param)  -- copy to prevent crash
					end
					local onClick = function()
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
							tbSet = nil
						end
						tb.destroy(true)
					end
					if id=="constructionBuilder" then  -- fix button to gamebar
						if not tbSet then
							tb.ToolButtonCreate(tb_text, onClick, nil, pos_offset )
							tbSet = true
						end
						--tb.MenuButtonCreate(tb_text, onClick)
					else  -- otherwise toolbutton next to cursor
						tb.ToolButtonCreate(tb_text, onClick, nil, pos_offset )
					end
				else
					tbSet = nil
					tb.destroy()
				end
			end)
			if status==false then
				print("===== Build With Collision - Error Handler:")
				debugPrint(param)
				print(err)
				print("===== Build With Collision - Please submit this message to the mod author - https://www.transportfever.net/filebase/index.php?entry/6501-build-with-collision/")
				tb.ToolButtonCreate("Error - see console or stdout",nil,err,{x=30,y=-65})
			end
		end
	elseif (id=="menu.construction.railmenu" and name=="visibilityChange" and param==false) or
			(id=="menu.construction.roadmenu" and name=="visibilityChange" and param==false) or
			(id=="menu.construction.rail.tabs" and name=="tabWidget.currentChanged") or
			(id=="menu.construction.road.tabs" and name=="tabWidget.currentChanged") or
			(id=="menu.construction.terrain.tabs" and name=="tabWidget.currentChanged") or
			(id=="menu.construction" and name=="tabWidget.currentChanged") or
			(id=="menu.bulldozer" and name=="toggleButton.toggle")
	then
		tb.destroy()
	end
end


function data()
	return {
		--init = init,
		--update = update,
		-- handleEvent = handleEvent,
		--save = save,
		--load = load,
		-- guiInit = guiInit,
		--guiUpdate = guiUpdate,
		guiHandleEvent = guiHandleEvent,
	}
end