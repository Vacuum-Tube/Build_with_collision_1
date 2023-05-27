local ParamBuilder = require "parambuilder_v1_2"
local paramRightClickBuild = ParamBuilder.Checkbox("bwC_RightClickBuild", _("bwC_RightClickBuild"), false, _("bwC_RightClickBuild_TT"))

function data()
	return {
		info = {
			name = "Build with Collision",
			description = _("mod_desc"),
			minorVersion = 6,
			severityAdd = "NONE",
			severityRemove = "NONE",
			tags = {"Script Mod"},
			authors = {
				{
					name = "VacuumTube",
					role = "CREATOR",
					tfnetId = 29264,
				},
			},
			url = "https://www.transportfever.net/filebase/index.php?entry/6501-build-with-collision/",
			tfnetId = 6501,
			params = {
				paramRightClickBuild.params,
			},
		},
		runFn = function (settings, modparams)
			local params = modparams[getCurrentModId()]
			game.bwC = {
				optionRightClickBuild = paramRightClickBuild.getBool(params),
			}
		end,
	}
end