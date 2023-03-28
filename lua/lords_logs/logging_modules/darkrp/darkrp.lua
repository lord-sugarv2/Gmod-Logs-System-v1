local MODULE = {}
MODULE.Category = "DarkRP"
MODULE.Name = "Money"
MODULE.Color = Color(255, 100, 100)

hook.Add("playerDroppedMoney", "LLogs:"..MODULE.Name, function(ply, amount, ent)
    local str = "%s (%s) dropped %s"
    str = string.format(str, ply:Nick(), ply:SteamID(), DarkRP.formatMoney(amount))
    LLogs.Log(MODULE.Name, str, LLogs.FormatPlayer(ply), LLogs.FormatEnt(ent))
end)

hook.Add("playerGaveMoney", "LLogs:"..MODULE.Name, function(ply, otherplayer, amount)
    local str = "%s (%s) gave %s (%s) %s"
    str = string.format(str, ply:Nick(), ply:SteamID(), otherplayer:Nick(), otherplayer:SteamID(), DarkRP.formatMoney(amount))
    LLogs.Log(MODULE.Name, str, LLogs.FormatPlayer(ply))
end)

hook.Add("playerPickedUpMoney", "LLogs:"..MODULE.Name, function(ply, amount, ent)
    local str = "%s (%s) picked up %s"
    str = string.format(str, ply:Nick(), ply:SteamID(), DarkRP.formatMoney(amount))
    LLogs.Log(MODULE.Name, str, LLogs.FormatPlayer(ply), LLogs.FormatEnt(ent))
end)
LLogs.AddModule(MODULE)

local MODULE = {}
MODULE.Category = "DarkRP"
MODULE.Name = "Adverts"
MODULE.Color = Color(255, 100, 100)

hook.Add("playerAdverted", "LLogs:"..MODULE.Name, function(ply, text, ent)
    local str = "%s (%s) adverted: %s"
    str = string.format(str, ply:Nick(), ply:SteamID(), text)
    LLogs.Log(MODULE.Name, str, LLogs.FormatPlayer(ply))
end)
LLogs.AddModule(MODULE)

local MODULE = {}
MODULE.Category = "DarkRP"
MODULE.Name = "Agenda"
MODULE.Color = Color(255, 100, 100)

hook.Add("agendaUpdated", "LLogs:"..MODULE.Name, function(ply, tbl, text)
    local str = "%s (%s) updated thier agenda: %s"
    str = string.format(str, ply:Nick(), ply:SteamID(), text)
    LLogs.Log(MODULE.Name, str, LLogs.FormatPlayer(ply))
end)
LLogs.AddModule(MODULE)

local MODULE = {}
MODULE.Category = "DarkRP"
MODULE.Name = "Door"
MODULE.Color = Color(255, 100, 100)

hook.Add("onDoorRamUsed", "LLogs:"..MODULE.Name, function(success, ply, tr)
    if not IsValid(tr.Entity) then return end
    local str = "%s (%s) rammed a door with success: %s"
    str = string.format(str, ply:Nick(), ply:SteamID(), tostring(success))
    LLogs.Log(MODULE.Name, str, LLogs.FormatPlayer(ply), LLogs.FormatEnt(tr.Entity))
end)

hook.Add("playerSellDoor", "LLogs:"..MODULE.Name, function(ply, ent)
    local str = "%s (%s) sold a door!"
    str = string.format(str, ply:Nick(), ply:SteamID())
    LLogs.Log(MODULE.Name, str, LLogs.FormatPlayer(ply), LLogs.FormatEnt(ent))
end)

hook.Add("playerBoughtDoor", "LLogs:"..MODULE.Name, function(ply, ent)
    local str = "%s (%s) bought a door!"
    str = string.format(str, ply:Nick(), ply:SteamID())
    LLogs.Log(MODULE.Name, str, LLogs.FormatPlayer(ply), LLogs.FormatEnt(ent))
end)
LLogs.AddModule(MODULE)

local MODULE = {}
MODULE.Category = "DarkRP"
MODULE.Name = "Arrest / Unarrest"
MODULE.Color = Color(255, 100, 100)

hook.Add("playerUnArrested", "LLogs:"..MODULE.Name, function(criminal, police)
    local str = "%s (%s) unarrested %s (%s)"
    str = string.format(str, police:Nick(), police:SteamID(), criminal:Nick(), criminal:SteamID())
    LLogs.Log(MODULE.Name, str, LLogs.FormatPlayer(criminal, "Criminal"), LLogs.FormatPlayer(police, "Unarrester"))
end)

hook.Add("playerArrested", "LLogs:"..MODULE.Name, function(criminal, time, police)
    local str = "%s (%s) arrested %s (%s) for (%s)s"
    str = string.format(str, police:Nick(), police:SteamID(), criminal:Nick(), criminal:SteamID(), time)
    LLogs.Log(MODULE.Name, str, LLogs.FormatPlayer(criminal, "Criminal"), LLogs.FormatPlayer(police, "Arrestor"))
end)
LLogs.AddModule(MODULE)

local MODULE = {}
MODULE.Category = "DarkRP"
MODULE.Name = "Purchases"
MODULE.Color = Color(255, 100, 100)

hook.Add("playerBoughtCustomEntity", "LLogs:"..MODULE.Name, function(ply, tbl, ent, price)
    local str = "%s (%s) purchased %s for %s"
    str = string.format(str, ply:Nick(), ply:SteamID(), tbl.name, DarkRP.formatMoney(price))
    LLogs.Log(MODULE.Name, str, LLogs.FormatPlayer(ply))
end)

hook.Add("playerBoughtShipment", "LLogs:"..MODULE.Name, function(ply, tbl, ent, price)
    local str = "%s (%s) purchased %s for %s"
    str = string.format(str, ply:Nick(), ply:SteamID(), tbl.name, DarkRP.formatMoney(price))
    LLogs.Log(MODULE.Name, str, LLogs.FormatPlayer(ply))
end)
LLogs.AddModule(MODULE)