local MODULE = {}
MODULE.Category = "Sandbox"
MODULE.Name = "Toolgun"
MODULE.Color = Color(255, 100, 100)

hook.Add("CanTool", "LLogs:"..MODULE.Name, function(ply, tr, toolname, tool, button)
    if CLIENT then return end
    local str = "%s (%s) used %s on %s"
    str = string.format(str, ply:Nick(), ply:SteamID(), toolname, tr.Entity)
    LLogs.Log(MODULE.Name, str, LLogs.FormatPlayer(ply, "Player"), LLogs.FormatEnt(tr.Entity, "Entity"))
end)
LLogs.AddModule(MODULE)

local MODULE = {}
MODULE.Category = "Sandbox"
MODULE.Name = "Undo"
MODULE.Color = Color(255, 100, 100)

hook.Add("PostUndo", "PostUndo:"..MODULE.Name, function(tbl, count)
    if CLIENT then return end
    local ply = tbl.Owner
    for k, v in ipairs(tbl.Entities) do
        local str = "%s (%s) undone %s"
        str = string.format(str, ply:Nick(), ply:SteamID(), v:GetClass() == "prop_physics" and v:GetModel() or v:GetClass())
        LLogs.Log(MODULE.Name, str, LLogs.FormatPlayer(ply), LLogs.FormatEnt(v))
    end
end)
LLogs.AddModule(MODULE)