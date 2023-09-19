Helper = require "helper"

vimComplete = {}

function vimComplete.setPath(vim)
	local paths = {}
	for path in string.gmatch(";" .. package.path .. ";", ";(%.?/.-/?)%?.lua;") do
		table.insert(paths, path)
	end
	for key, val in pairs(paths or {}) do
		vim.command("set path=+" .. val)
	end
end

function vimComplete.makeFun(b, curline, args)
	local arguments = Helper.parseArguments(args)
	local funName = arguments[1] or "foo"
	local insertLine = Helper.getInsertLine(b, curline, arguments[2])

	Helper.insert(b, string.format("function %s()", funName), insertLine)
	Helper.insert(b, "end", insertLine and (insertLine + 1) or insertLine)
end

function vimComplete.makeLoop(b, curline, args)
	local arguments = Helper.parseArguments(args)
	local tabName = arguments[1] or "tb"
	local insertLine = Helper.getInsertLine(b, curline, arguments[2])

	Helper.insert(b, string.format("for key, val in pairs(%s or {}) do", tabName), insertLine)
	Helper.insert(b, "end", insertLine and (insertLine + 1) or insertLine)
end

function vimComplete.makeIfStatement(b, curline, args)
	local arguments = Helper.parseArguments(args)
	local varName = arguments[1] or ""
	local insertLine = Helper.getInsertLine(b, curline, arguments[2])

	Helper.insert(b, string.format("if %s then", varName), insertLine)
	Helper.insert(b, "", insertLine and (insertLine + 1) or insertLine)
	Helper.insert(b, "end", insertLine and (insertLine + 2) or insertLine)
end
