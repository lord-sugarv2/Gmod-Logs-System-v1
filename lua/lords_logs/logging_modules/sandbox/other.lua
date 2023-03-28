local MODULE = {}
MODULE.Category = "General"
MODULE.Name = "Chat"
MODULE.Color = Color(255, 100, 100)

hook.Add("PlayerSay", "LLogs:"..MODULE.Name, function(ply, text)
    local str = "%s (%s) (%s)"
    str = string.format(str, ply:Nick(), ply:SteamID(), text)
    LLogs.Log(MODULE.Name, str, LLogs.FormatPlayer(ply))
end)
LLogs.AddModule(MODULE)