local tb = require "bwc.toolbutton"

local function proposalIsEmpty(proposal)
	return 
		#proposal.proposal.addedSegments==0 and 
		#proposal.proposal.removedSegments==0 and
		#proposal.toAdd==0 and
		#proposal.toRemove==0
end

local function buildProposalEvent(param,stopActionAfterBuild,cbfunc)
	local cmd=api.cmd.make.buildProposal(api.type.SimpleProposal.new(),nil,true) --ignoreErrors
	cmd.proposal=param.proposal
	cmd.resultProposalData=param.data
	api.cmd.sendCommand(cmd,function(res, success)
		-- print("Success:",success)
		if success then
			game.gui.playSoundEffect("construct")
			-- game.gui.playSoundEffect("replaceVehicle")
			if stopActionAfterBuild then
				game.gui.stopAction()
			end
			tb.destroy()
		else
			print("===== Build With Collision - Build failed")
			print("Critical:",res.resultProposalData.errorState.critical)
			if #res.resultProposalData.collisionInfo.collisionEntities>0 then
				print("Collision:",toString(res.resultProposalData.collisionInfo.collisionEntities))
			end
		end
		-- if cbfunc then
			-- cbfunc()
		-- end
	end)
end


local function guiHandleEvent(id, name, param)
	if
		id=="trackBuilder" or
		id=="streetBuilder" or
		id=="streetTrackModifier" or
		-- id=="streetTerminalBuilder" or -- signals+bus stops , never collision
		id=="constructionBuilder" --or
		-- id=="bulldozer" -- produces errors
	then
		if name=="builder.proposalCreate" then
			local status, err = pcall(function()
				if --check collision but not critical
					not param.data.errorState.critical
				-- and 
					-- #param.data.collisionInfo.collisionEntities>0  -- only for collision not other issues
				and
					#param.data.errorState.messages>0
				and
					not proposalIsEmpty(param.proposal)
				then 
					-- proposalparam = param  -- gets empty if cancel proposal. pointer?
					local pos_offset
					if id=="trackBuilder" or id=="streetBuilder" or id=="constructionBuilder" then
						pos_offset = {x=30,y=-65}
					else
						pos_offset = {x=5,y=-38}
					end
					tb.create(_("Build Anyway"),function()  -- onClick
						if proposalIsEmpty(param.proposal) then
							print("===== Build With Collision - Proposal Empty !")
						else
							buildProposalEvent(param, id=="trackBuilder" or id=="streetBuilder")
						end
						tb.destroy(true)
					end,nil,pos_offset)
				else
					-- proposalparam = nil
					tb.destroy()
				end
			end)
			if status==false then
				print("===== Build With Collision - Error Handler:")
				debugPrint(param)
				print(err)
				print("===== Build With Collision - Please submit this message to the mod author")
				tb.create("Error - see console or stdout",nil,err,{x=30,y=-65})
			end
		end
	elseif (id=="menu.construction.railmenu" and name=="visibilityChange" and param==false) or
			(id=="menu.construction.roadmenu" and name=="visibilityChange" and param==false) or
			(id=="menu.construction.rail.tabs" and name=="tabWidget.currentChanged") or
			(id=="menu.construction.road.tabs" and name=="tabWidget.currentChanged") or
			(id=="menu.construction.terrain.tabs" and name=="tabWidget.currentChanged") or
			(id=="menu.construction" and name=="tabWidget.currentChanged")
	then
		tb.destroy()
	end
end

function data()
	return {
		--init = init,
		--update = update,
		--handleEvent = handleEvent,
		--save = save,
		--load = load,
		--guiInit = guiInit,
		--guiUpdate = guiUpdate,
		guiHandleEvent = guiHandleEvent,
	}
end