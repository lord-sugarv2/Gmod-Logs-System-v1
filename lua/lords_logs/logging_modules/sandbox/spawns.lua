local MODULE = {}
MODULE.Category = "Spawns"
MODULE.Name = "Effects"
MODULE.Color = Color(255, 100, 100)

hook.Add("PlayerSpawnedEffect", "LLogs:"..MODULE.Name, function(ply, model, ent)
    local str = "%s (%s) spawned in %s"
    str = string.format(str, ply:Nick(), ply:SteamID(), model)
    LLogs.Log(MODULE.Name, str, LLogs.FormatPlayer(ply), LLogs.FormatEnt(ent))
end)
LLogs.AddModule(MODULE)

local MODULE = {}
MODULE.Category = "Spawns"
MODULE.Name = "NPCs"
MODULE.Color = Color(255, 100, 100)

hook.Add("PlayerSpawnedNPC", "LLogs:"..MODULE.Name, function(ply, ent)
    local str = "%s (%s) spawned in %s"
    str = string.format(str, ply:Nick(), ply:SteamID(), ent:GetClass())
    LLogs.Log(MODULE.Name, str, LLogs.FormatPlayer(ply), LLogs.FormatEnt(ent))
end)
LLogs.AddModule(MODULE)

local MODULE = {}
MODULE.Category = "Spawns"
MODULE.Name = "Props"
MODULE.Color = Color(255, 100, 100)

hook.Add("PlayerSpawnedProp", "LLogs:"..MODULE.Name, function(ply, model, ent)
    local str = "%s (%s) spawned in %s"
    str = string.format(str, ply:Nick(), ply:SteamID(), model)
    LLogs.Log(MODULE.Name, str, LLogs.FormatPlayer(ply), LLogs.FormatEnt(ent))
end)
LLogs.AddModule(MODULE)

local MODULE = {}
MODULE.Category = "Spawns"
MODULE.Name = "Ragdolls"
MODULE.Color = Color(255, 100, 100)

hook.Add("PlayerSpawnedRagdoll", "LLogs:"..MODULE.Name, function(ply, model, ent)
    local str = "%s (%s) spawned in %s"
    str = string.format(str, ply:Nick(), ply:SteamID(), ent:GetClass())
    LLogs.Log(MODULE.Name, str, LLogs.FormatPlayer(ply), LLogs.FormatEnt(ent))
end)
LLogs.AddModule(MODULE)

local MODULE = {}
MODULE.Category = "Spawns"
MODULE.Name = "SENTs"
MODULE.Color = Color(255, 100, 100)

hook.Add("PlayerSpawnedSENT", "LLogs:"..MODULE.Name, function(ply, ent)
    local str = "%s (%s) spawned in %s"
    str = string.format(str, ply:Nick(), ply:SteamID(), ent:GetClass())
    LLogs.Log(MODULE.Name, str, LLogs.FormatPlayer(ply), LLogs.FormatEnt(ent))
end)
LLogs.AddModule(MODULE)

local MODULE = {}
MODULE.Category = "Spawns"
MODULE.Name = "Vehicles"
MODULE.Color = Color(255, 100, 100)

hook.Add("PlayerSpawnedVehicle", "LLogs:"..MODULE.Name, function(ply, ent)
    local str = "%s (%s) spawned in %s"
    str = string.format(str, ply:Nick(), ply:SteamID(), ent:GetClass())
    LLogs.Log(MODULE.Name, str, LLogs.FormatPlayer(ply), LLogs.FormatEnt(ent))
end)
LLogs.AddModule(MODULE)

local MODULE = {}
MODULE.Category = "Spawns"
MODULE.Name = "SWEPs"
MODULE.Color = Color(255, 100, 100)

hook.Add("PlayerSpawnedSWEP", "LLogs:"..MODULE.Name, function(ply, ent)
    local str = "%s (%s) spawned in %s"
    str = string.format(str, ply:Nick(), ply:SteamID(), ent:GetPrintName())
    LLogs.Log(MODULE.Name, str, LLogs.FormatPlayer(ply), LLogs.FormatEnt(wep))
end)