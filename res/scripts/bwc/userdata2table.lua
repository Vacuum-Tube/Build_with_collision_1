local function userdata2table(obj)
	if type(obj)=='table' then  -- tableutil.lua
		local res = { }
		for k,v in pairs(obj) do
			res[userdata2table(k)] = userdata2table(v)
		end
		return res
	elseif type(obj)=='userdata' then  -- serialize.lua
		local res = { }
		local mt = getmetatable(obj)
		local pr, pairss = pcall(function() return mt.pairs end)
		local pr2, members = pcall(function() return mt.__members end)
		if mt and pr and pairss then 
			for k,v in pairs(obj) do
				res[userdata2table(k)] = userdata2table(v)
			end
		elseif mt and pr2 and members then
			for i,k in pairs(members) do
				local s,v = pcall(function() return obj[k] end)
				if s then
					res[userdata2table(k)] = userdata2table(v)
				end
			end
		end
		return res
	else
		return obj
	end
end

return userdata2table