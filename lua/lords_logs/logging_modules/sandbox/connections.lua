local MODULE = {}
MODULE.Category = "Connections"
MODULE.Name = "Connected"
MODULE.Color = Color(255, 100, 100)

hook.Add("PlayerConnect", "LLogs:"..MODULE.Name, function(name)
    local str = "%s has joined the game!"
    str = string.format(str, name)
    LLogs.Log(MODULE.Name, str)
end)
LLogs.AddModule(MODULE)

local MODULE = {}
MODULE.Category = "Connections"
MODULE.Name = "Disconnected"
MODULE.Color = Color(255, 100, 100)

hook.Add("PlayerDisconnected", "LLogs:"..MODULE.Name, function(ply)
    local str = "%s (%s) has left the game!"
    str = string.format(str, name, ply:Nick(), ply:SteamID())
    LLogs.Log(MODULE.Name, str, LLogs.FormatPlayer(ply))
end)
LLogs.AddModule(MODULE)