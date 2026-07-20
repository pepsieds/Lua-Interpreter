--[[
	Credit to einsteinK.
	Credit to Stravant for LBI.

	Credit to the creators of all the other modules used in this.

	Sceleratis was here and decided modify some things.

	einsteinK was here again to fix a bug in LBI for if-statements

	Aries was here to convert Lua 5.0 -> Lua 5.1 | Executor Env
--]]
for i = 1,20 do
	warn('lbi initilized')
end

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

local importCache = {}

local function import(file)
	if importCache[file] ~= nil then
		return importCache[file]
	end

	local ok, result = pcall(function()
		local source = game:HttpGet(url .. file)
		local chunk, compileErr = loadstring(source)

		if not chunk then
			error(("compile error in %s: %s"):format(file, tostring(compileErr)))
		end

		return chunk()
	end)

	if not ok then
		warn(("[IMPORT FAILED] %s: %s"):format(file, tostring(result)))
		return nil
	end

	importCache[file] = result
	return result
end

getgenv().import = import

local luaX = assert(import('/Dependencies/CodeX.lua'), "CodeX failed")
local luaY = assert(import('/Dependencies/CodeY.lua'), "CodeY failed")
local luaZ = assert(import('/Dependencies/CodeZ.lua'), "CodeZ failed")
local luaU = assert(import('/Dependencies/CodeU.lua'), "CodeU failed")
local fiOne = assert(import('/Core/FI.lua'), "FI failed")

local vEnv
do
	local vEnvFactory = import('/Core/VIR.lua')
	vEnv = vEnvFactory and vEnvFactory()
end

luaX:init()

local LuaState = {}

local function compile(str, env)
	env = if env ~= nil then env elseif vEnv ~= nil then vEnv else {}

	local zio = luaZ:init(luaZ:make_getS(str), nil)
	if not zio then
		error("failed to initialize input stream")
	end

	local func = luaY:parser(LuaState, zio, nil, "@input")
	local writer, buff = luaU:make_setS()
	luaU:dump(LuaState, func, writer, buff)

	return fiOne(buff.data, env), buff.data
end

return function(str, env)
	local thread = coroutine.create(compile)
	local ran, f, bytecode = coroutine.resume(thread, str, env)

	if ran then
		return f, bytecode
	end

	return nil, f
end
