local copy_userdata

local function copy_userdata_map(old,new)
	for k,v in pairs(old) do
		if v then
			new:set(k, copy_userdata(v))
		else
			error("v: "..toString(v).." k:"..k)
		end
	end
end

local function copy_userdata_value(res,k,v)
	local mt = getmetatable(res[k])
	local name = mt and mt.__name or ""
	if
		name:starts("sol.std::vector")
		or name:starts("sol.std::array")
		or name:starts("sol.std::unordered_map")
		or name:starts("sol.std::unordered_set")
		or name:starts("sol.std::set")
		or name:starts("sol.std::map")
		or name:starts("sol.lua::Table")
	then
		copy_userdata_map(v, res[k])
	else
		local s,r = pcall( function() res[copy_userdata(k)] = copy_userdata(v) end)
		if not s then
			if r:ends("sol: cannot write to a readonly property") then
				return  -- for example proposal.toAdd.fileName and data.entity2tn[].geometry
			else
				print("res:",toString(res),"k:",toString(k),"v:",toString(v))
				error(r)
			end
		end
	end
end

copy_userdata = function (obj)
	if type(obj)=='table' then  -- tableutil.lua
		local res = { }
		for k,v in pairs(obj) do
			res[copy_userdata(k)] = copy_userdata(v)
		end
		return res
	elseif type(obj)=='userdata' then  -- serialize.lua
		local mt = getmetatable(obj)
		local res
		if mt.new then
			res = mt.new()
		else
			-- return nil
			return obj  -- some things are copied automatically
			-- error("No MT new: "..toString(obj).." "..toString(mt))
		end
		local pr, pairss = pcall(function() return mt.pairs end)
		local pr2, members = pcall(function() return mt.__members end)
		if mt and pr and pairss then 
			for k,v in pairs(obj) do
				copy_userdata_value(res,k,v)
			end
		elseif mt and pr2 and members then
			for i,k in pairs(members) do
				local s,v = pcall(function() return obj[k] end)
				if s and v then
					copy_userdata_value(res,k,v)
				end
			end
		end
		return res
	else
		return obj
	end
end

return copy_userdata