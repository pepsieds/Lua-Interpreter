--!strict
--[[
	Description: A virtual enviroment implementation to replace the legacy function enviroments
	Author: github@ccuser44/ALE111_boiPNG
	Date: 15.2.2022
--]]

type dictionary = { [string]: any }
type func = (...any?) -> (...any?)

local function buildEnvironment()
    local globalEnv = {
        -- // Standard Libraries
        coroutine = coroutine,
        debug = debug,
        math = math,
        os = os,
        string = string,
        table = table,
        utf8 = utf8,
        bit32 = bit32,
        task = task,

        -- // Lua Globals
        assert = assert,
        collectgarbage = function(action: string): number
            assert(type(action) == "string", "invalid argument #1 to 'collectgarbage' (string expected, got "..type(action)..")")
            assert(action == "count", "collectgarbage must be called with 'count'; use gcinfo() instead")
            return gcinfo()
        end,
        error = error,
        getmetatable = getmetatable,
        ipairs = ipairs,
        newproxy = newproxy,
        next = next,
        pairs = pairs,
        pcall = pcall,
        print = print,
        rawequal = rawequal,
        rawget = rawget,
        rawset = rawset,
        select = select,
        setmetatable = setmetatable,
        tonumber = tonumber,
        tostring = tostring,
        type = type,
        unpack = unpack,
        xpcall = xpcall,
        warn = warn,
        gcinfo = gcinfo,
        _G = _G,
        _VERSION = _VERSION,

        -- // Roblox Globals
        settings = settings,
        time = time,
        typeof = typeof,
        UserSettings = UserSettings,
        require = require,
        game = game,
        workspace = workspace,
        shared = shared,

        -- // Deprecated Roblox Globals
        delay = task.delay,
        spawn = task.defer,
        wait = task.wait,
        elapsedTime = os.clock,
        stats = function(): Stats
            return game:GetService("Stats")
        end,
        tick = tick,

        -- // Roblox Datatypes
        Axes = Axes,
        BrickColor = BrickColor,
        CatalogSearchParams = CatalogSearchParams,
        CFrame = CFrame,
        Color3 = Color3,
        ColorSequence = ColorSequence,
        ColorSequenceKeypoint = ColorSequenceKeypoint,
        DateTime = DateTime,
        DockWidgetPluginGuiInfo = DockWidgetPluginGuiInfo,
        Enum = Enum,
        Faces = Faces,
        FloatCurveKey = FloatCurveKey,
        Instance = Instance,
        NumberRange = NumberRange,
        NumberSequence = NumberSequence,
        NumberSequenceKeypoint = NumberSequenceKeypoint,
        OverlapParams = OverlapParams,
        PathWaypoint = PathWaypoint,
        PhysicalProperties = PhysicalProperties,
        Random = Random,
        Ray = Ray,
        RaycastParams = RaycastParams,
        Rect = Rect,
        Region3 = Region3,
        Region3int16 = Region3int16,
        TweenInfo = TweenInfo,
        UDim = UDim,
        UDim2 = UDim2,
        Vector2 = Vector2,
        Vector2int16 = Vector2int16,
        Vector3 = Vector3,
        Vector3int16 = Vector3int16,
    }

    -- // Helper to safely add optional functions
    local function addOptional(key: string, value: any?)
        if value ~= nil then
            globalEnv[key] = value
        end
    end

    -- // Closure Library
    addOptional("getfunctionhash", getfunctionhash)
    addOptional("iscclosure", iscclosure)
    addOptional("isexecutorclosure", isexecutorclosure)
    addOptional("islclosure", islclosure)
    addOptional("isnewcclosure", isnewcclosure)
    addOptional("hookfunction", hookfunction)
    addOptional("isfunctionhooked", isfunctionhooked)
    addOptional("isourthread", isourthread)
    addOptional("loadstring", loadstring) -- Often overwritten by executors
    addOptional("newcclosure", newcclosure)
    addOptional("newlclosure", newlclosure)
    addOptional("restorefunction", restorefunction)
    addOptional("setstackhidden", setstackhidden)

    -- // Console Library
    addOptional("rconsoleclear", rconsoleclear)
    addOptional("rconsolecreate", rconsolecreate)
    addOptional("rconsoledestroy", rconsoledestroy)
    addOptional("rconsoleerror", rconsoleerror)
    addOptional("rconsoleinfo", rconsoleinfo)
    addOptional("rconsoleinput", rconsoleinput)
    addOptional("rconsoleprint", rconsoleprint)
    addOptional("rconsolesettitle", rconsolesettitle)
    addOptional("rconsolewarn", rconsolewarn)

    -- // Crypt Library (Added as table if exists)
    if crypt then globalEnv["crypt"] = crypt end

    -- // Drawing Library
    if Drawing then globalEnv["Drawing"] = Drawing end
    addOptional("cleardrawcache", cleardrawcache)
    addOptional("getrenderproperty", getrenderproperty)
    addOptional("isrenderobj", isrenderobj)
    addOptional("setrenderproperty", setrenderproperty)

    -- // DrawingImmediate Library
    if DrawingImmediate then globalEnv["DrawingImmediate"] = DrawingImmediate end

    -- // Environment Library
    addOptional("filtergc", filtergc)
    addOptional("getgc", getgc)
    addOptional("getgenv", getgenv)
    addOptional("getreg", getreg)
    addOptional("getrenv", getrenv)
    addOptional("getsenv", getsenv)
    addOptional("gettenv", gettenv)
	addOptional("Version", Version)

    -- // FileSystem Library
    addOptional("appendfile", appendfile)
    addOptional("delfile", delfile)
    addOptional("delfolder", delfolder)
    addOptional("dofile", dofile)
    addOptional("isfile", isfile)
    addOptional("isfolder", isfolder)
    addOptional("listfiles", listfiles)
    addOptional("loadfile", loadfile)
    addOptional("makefolder", makefolder)
    addOptional("readfile", readfile)
    addOptional("writefile", writefile)

    -- // Input Library
    addOptional("isrbxactive", isrbxactive)
    addOptional("keypress", keypress)
    addOptional("keyrelease", keyrelease)
    addOptional("keytap", keytap)
    addOptional("mouse1click", mouse1click)
    addOptional("mouse1press", mouse1press)
    addOptional("mouse1release", mouse1release)
    addOptional("mouse2click", mouse2click)
    addOptional("mouse2press", mouse2press)
    addOptional("mouse2release", mouse2release)
    addOptional("mousemoveabs", mousemoveabs)
    addOptional("mousemoverel", mousemoverel)
    addOptional("mousescroll", mousescroll)

    -- // Instance Library
    addOptional("fireclickdetector", fireclickdetector)
    addOptional("fireproximityprompt", fireproximityprompt)
    addOptional("firetouchinterest", firetouchinterest)
    addOptional("getcallbackvalue", getcallbackvalue)
    addOptional("getcustomasset", getcustomasset)
    addOptional("gethui", gethui)
    addOptional("getinstances", getinstances)
    addOptional("getnilinstances", getnilinstances)
    addOptional("getrendersteppedlist", getrendersteppedlist)

    -- // Metatable Library
    addOptional("getnamecallmethod", getnamecallmethod)
    addOptional("getrawmetatable", getrawmetatable)
    addOptional("hookmetamethod", hookmetamethod)
    addOptional("isreadonly", isreadonly)
    addOptional("makereadonly", makereadonly)
    addOptional("makewritable", makewritable)
    addOptional("setnamecallmethod", setnamecallmethod)
    addOptional("setrawmetatable", setrawmetatable)
    addOptional("setreadonly", setreadonly)

    -- // Miscellaneous Library
    addOptional("clearteleportqueue", clearteleportqueue)
    addOptional("getfpscap", getfpscap)
    addOptional("gethwid", gethwid)
    addOptional("getfflag", getfflag)
    addOptional("getfflagtype", getfflagtype)
    addOptional("getobjects", getobjects)
    addOptional("httpget", httpget)
    addOptional("identifyexecutor", identifyexecutor)
    addOptional("messagebox", messagebox)
    addOptional("queueonteleport", queueonteleport)
    addOptional("request", request)
    addOptional("decompile", decompile)
    addOptional("saveinstance", saveinstance)
    addOptional("setclipboard", setclipboard)
    addOptional("setfflag", setfflag)
    addOptional("setfpscap", setfpscap)
    addOptional("setrbxclipboard", setrbxclipboard)

    -- // Script Library
    addOptional("getloadedmodules", getloadedmodules)
    addOptional("getrunningscripts", getrunningscripts)
    addOptional("getscriptbytecode", getscriptbytecode)
    addOptional("getscriptclosure", getscriptclosure)
    addOptional("getscriptfromthread", getscriptfromthread)
    addOptional("getscriptthread", getscriptthread)
    addOptional("getcallingscript", getcallingscript)
    addOptional("getscripthash", getscripthash)
    addOptional("getscripts", getscripts)
    addOptional("getthreadidentity", getthreadidentity)
    addOptional("setthreadidentity", setthreadidentity)

    -- // Signal Library
    addOptional("cansignalreplicate", cansignalreplicate)
    addOptional("firesignal", firesignal)
    addOptional("getconnection", getconnection)
    addOptional("getconnections", getconnections)
    addOptional("getsignalarguments", getsignalarguments)
    addOptional("getsignalargumentsinfo", getsignalargumentsinfo)
    addOptional("getsignalwhitelist", getsignalwhitelist)
    addOptional("replicatesignal", replicatesignal)

    -- // Reflection Library
    addOptional("getbspval", getbspval)
    addOptional("gethiddenproperties", gethiddenproperties)
    addOptional("gethiddenproperty", gethiddenproperty)
    addOptional("getpcd", getpcd)
    addOptional("getproperties", getproperties)
    addOptional("getproximitypromptduration", getproximitypromptduration)
    addOptional("getsimulationradius", getsimulationradius)
    addOptional("isnetworkowner", isnetworkowner)
    addOptional("isscriptable", isscriptable)
    addOptional("sethiddenproperty", sethiddenproperty)
    addOptional("setproximitypromptduration", setproximitypromptduration)
    addOptional("setscriptable", setscriptable)
    addOptional("setsimulationradius", setsimulationradius)

    -- // Regex Library
    if Regex then globalEnv["Regex"] = Regex end

    -- // WebSocket Library
    if WebSocket then globalEnv["WebSocket"] = WebSocket end

    -- // Actor Library
    addOptional("create_comm_channel", create_comm_channel)
    addOptional("getactors", getactors)
    addOptional("getactorthreads", getactorthreads)
    addOptional("getdeletedactors", getdeletedactors)
    addOptional("get_comm_channel", get_comm_channel)
    addOptional("is_parallel", is_parallel)
    addOptional("run_on_actor", run_on_actor)
    addOptional("run_on_thread", run_on_thread)

    -- // Cache Library
    if cache then globalEnv["cache"] = cache end
    addOptional("cloneref", cloneref)
    addOptional("compareinstances", compareinstances)

    -- // Oth Library
    if oth then globalEnv["oth"] = oth end

    -- // PsmSignal Library
    if PsmSignal then globalEnv["PsmSignal"] = PsmSignal end

    -- // RakNet Library
    if raknet then globalEnv["raknet"] = raknet end

    return globalEnv
end

-- Usage:
local globalEnv = buildEnvironment()   

table.freeze(globalEnv)

return function()
	local env: dictionary = {}

	for k, v in pairs(globalEnv) do
		env[k] = v
	end

	env._ENV = env :: dictionary

	env["getf".."env"] = function(target: (func | number)?): dictionary
		assert(type(target) == "number" or type(target) == "function" or type(target) == "nil", "invalid argument #1 to 'setf".."env' (number expected, got "..type(target)..")")
		assert(type(target) == "number" and target >= 0 or type(target) ~= "number", "invalid argument #1 to 'setf".."env' (level must be non-negative)")

		return env
	end

	env["setf".."env"] = function(target: func | number, newEnv: dictionary): ()
		assert(type(newEnv) == "table", "invalid argument #2 to 'setf".."env' (table expected, got "..type(newEnv)..")")
		assert(type(target) == "number" or type(target) == "function", "invalid argument #1 to 'setf".."env' (number expected, got "..type(target)..")")
		assert(type(target) == "number" and target >= 0, "invalid argument #1 to 'setf".."env' (level must be non-negative)")

		table.clear(env)

		for k: string, v: any in pairs(newEnv) do
			if type(k) == "string" then
				env[k] = v
			end
		end
	end

	-- // Stupid luau linter cant even recognise a metatable
	setmetatable(env, table.freeze({
		__index = globalEnv,
		__metatable = "The metatable is locked"
	}))

	return env
end
