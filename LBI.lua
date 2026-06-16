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

local url = "https://raw.githubusercontent.com/pepsieds/Lua-Interpreter/refs/heads/main"

local function import(file)
	local x, a = pcall(function()
		return loadstring(game:HttpGet(url .. file))()
	end)
	if not x then
		return warn('failed to import', file)
	end
end

getgenv().import = import

local luaX = import('/Dependencies/CodeX.lua')
local luaY = import('/Dependencies/CodeY.lua')
local luaZ = import('/Dependencies/CodeZ.lua')
local luaU = import('/Dependencies/CodeU.lua')
local fiOne = import('/Core/FI.lua')
local vEnv
do
	local vEnvModule = import('/Core/VIR.lua')
	vEnv = vEnvModule and require(vEnvModule)()
end

luaX:init()
local LuaState = {}

return function(str, env)
	local f,writer,buff,name
	local env = if env ~= nil then env elseif vEnv ~= nil then vEnv else {}
	local name = "?"
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
