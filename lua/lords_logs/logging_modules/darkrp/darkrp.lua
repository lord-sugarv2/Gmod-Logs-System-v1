local MODULE = {}
MODULE.Category = "DarkRP"
MODULE.Name = "Drop Money"
MODULE.Color = Color(255, 100, 100)

hook.Add("playerDroppedMoney", "LLogs:"..MODULE.Name, function(ply, amount, ent)
    local str = "%s (%s) dropped %s"
    str = string.format(str, ply:Nick(), ply:SteamID(), DarkRP.formatMoney(amount))
    LLogs.Log(MODULE.Name, str, LLogs.FormatPlayer(ply), LLogs.FormatEnt(ent))
end)
LLogs.AddModule(MODULE)

local MODULE = {}
MODULE.Category = "DarkRP"
MODULE.Name = "Gave Money"
MODULE.Color = Color(255, 100, 100)

hook.Add("playerGaveMoney", "LLogs:"..MODULE.Name, function(ply, otherplayer, amount)
    local str = "%s (%s) gave %s (%s) %s"
    str = string.format(str, ply:Nick(), ply:SteamID(), otherplayer:Nick(), otherplayer:SteamID(), DarkRP.formatMoney(amount))
    LLogs.Log(MODULE.Name, str, LLogs.FormatPlayer(ply))
end)
LLogs.AddModule(MODULE)

local MODULE = {}
MODULE.Category = "DarkRP"
MODULE.Name = "Pickup Money"
MODULE.Color = Color(255, 100, 100)

hook.Add("playerPickedUpMoney", "LLogs:"..MODULE.Name, function(ply, amount, ent)
    local str = "%s (%s) picked up %s"
    str = string.format(str, ply:Nick(), ply:SteamID(), DarkRP.formatMoney(amount))
    LLogs.Log(MODULE.Name, str, LLogs.FormatPlayer(ply), LLogs.FormatEnt(ent))
end)
LLogs.AddModule(MODULE)