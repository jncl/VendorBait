
local _, ns = ...

ns.StartRepeatingTimer = _G.C_Timer.NewTicker

function ns.StartTimer(endtime, callback)
	local duration = endtime - _G.GetTime()
	_G.C_Timer.After(duration, callback)
end

function ns.StopRepeatingTimer(timer)
	timer:Cancel()
end
