local MODULE = {}
MODULE.Category = "General"
MODULE.Name = "Connections"
MODULE.Color = Color(255, 100, 100)

hook.Add("PlayerConnect", "LLogs:Connected:"..MODULE.Name, function(name)
    local str = "%s has joined the game!"
    str = string.format(str, name)
    LLogs.Log(MODULE.Name, str)
end)
LLogs.AddModule(MODULE)

local MODULE = {}
MODULE.Category = "General"
MODULE.Name = "Connections"
MODULE.Color = Color(255, 100, 100)

hook.Add("PlayerDisconnected", "LLogs:Disconnected:"..MODULE.Name, function(ply)
    local str = "%s (%s) has left the game!"
    str = string.format(str, ply:Nick(), ply:SteamID())
    LLogs.Log(MODULE.Name, str, LLogs.FormatPlayer(ply))
end)
LLogs.AddModule(MODULE)