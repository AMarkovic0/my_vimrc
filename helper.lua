local Helper = {}

function Helper.insert(b, str, insertLine)
	local refline
	if insertLine then refline = insertLine else refline = #b end
	b:insert((string.match(b[refline] or "", "([\t]).+") or "" ) .. str, insertLine)
end

function Helper.getInsertLine(b, curline, arg)
	local insertLine = tonumber(arg) or tonumber(curline)
	if (insertLine == -1) or (#b < insertLine) then
		insertLine = nil
		if b[#b] ~= "" then b:insert("") end
	end
	return insertLine
end

function Helper.parseArguments(args)
	local arguments = {}
	if type(args) == "table" then
		arguments = args
	else
		for arg in string.gmatch(args .. " ", "(.-)%s") do
			table.insert(arguments, arg)
		end
	end
	return arguments
end

return Helper
