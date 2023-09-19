local Syntax = {}

Syntax.cmds = "luachec"
Syntax.version = Syntax.command .. " --version"

function Syntax:execute(strCmd)
	return os.execute(strCmd)
end

function Syntax:checkLuacheck()
	local ret = self:execute(self.version)
end

function Syntax:
