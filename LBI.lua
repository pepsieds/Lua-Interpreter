--[[
	Credit to einsteinK.
	Credit to Stravant for LBI.

	Credit to the creators of all the other modules used in this.

	Sceleratis was here and decided modify some things.

	einsteinK was here again to fix a bug in LBI for if-statements

	Aries was here to convert Lua 5.0 -> Lua 5.1 | Executor Env
--]]
warn("[LBI TEST] loaded")

return function()
	warn("[LBI TEST] compile requested")

	return function()
		warn("[LBI TEST] execution requested")
	end
end
