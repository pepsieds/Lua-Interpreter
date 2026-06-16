--[[
	Credit to einsteinK.
	Credit to Stravant for LBI.

	Credit to the creators of all the other modules used in this.

	Sceleratis was here and decided modify some things.

	einsteinK was here again to fix a bug in LBI for if-statements
--]]

local waitDeps = {
	'FI';
	'CodeK';
	'CodeP';
	'CodeU';
	'CodeX';
	'CodeY';
	'CodeZ';
}

for i,v in pairs(waitDeps) do script:WaitForChild(v) end

local luaX = require(script.CodeX)
local luaY = require(script.CodeY)
local luaZ = require(script.CodeZ)
local luaU = require(script.CodeU)
local fiOne = require(script.FI)
local vEnv
do
	local vEnvModule = script:FindFirstChild("VIR")
	vEnv = vEnvModule and require(vEnvModule)()
end

luaX:init()
local LuaState = {}

return function(str, env)
	local f,writer,buff,name
	local env = if env ~= nil then env elseif vEnv ~= nil then vEnv else {}
	local name = (env and env.script and env.script:GetFullName())
	local ran,error = pcall(function()
		local zio = luaZ:init(luaZ:make_getS(str), nil)
		if not zio then return error() end
		local func = luaY:parser(LuaState, zio, nil, name or "@input")
		writer, buff = luaU:make_setS()
		luaU:dump(LuaState, func, writer, buff)
		f = fiOne(buff.data, env)
	end)

	if ran then
		return f,buff.data
	else
		return nil,error
	end
end
