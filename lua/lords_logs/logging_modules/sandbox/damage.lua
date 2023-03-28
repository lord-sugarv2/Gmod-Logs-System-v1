local MODULE = {}
MODULE.Category = "General"
MODULE.Name = "Kills / Deaths"
MODULE.Color = Color(255, 100, 100)

hook.Add("PlayerDeath", "LLogs:"..MODULE.Name, function(victim, weapon, attacker)
    if not victim:IsPlayer() then return end -- If the victim isnt a player dont log as its not gonna be a bitch and report someone 🙄😁

    -- Suicide
    if victim == attacker then
        local str = "%s (%s) committed suicide"
        str = string.format(str, victim:Nick(), victim:SteamID())
        LLogs.Log(MODULE.Name, str, LLogs.FormatPlayer(victim))
        return
    end

    -- Player killed Player
    if attacker:IsPlayer() then
        local str = "%s (%s) killed %s (%s) with %s (%s)"
        local weapon = attacker:GetActiveWeapon()
        str = string.format(str, attacker:Nick(), attacker:SteamID(), victim:Nick(), victim:SteamID(), weapon:GetPrintName(), weapon:GetClass())
        LLogs.Log(MODULE.Name, str, LLogs.FormatPlayer(victim, "Victim"), LLogs.FormatPlayer(attacker, "Attacker"))
        return
    end

    -- Killed by the unknown 🙀
    local str = "%s (%s) killed by %s"
    str = string.format(str, victim:Nick(), victim:SteamID(), attacker:GetClass())
    LLogs.Log(MODULE.Name, str, LLogs.FormatPlayer(victim, "Victim"), LLogs.FormatEnt(attacker, "Attacker"))
end)
LLogs.AddModule(MODULE)

local MODULE = {}
MODULE.Category = "General"
MODULE.Name = "Damage"
MODULE.Color = Color(255, 100, 100)

hook.Add("EntityTakeDamage", "LLogs:"..MODULE.Name, function(victim, dmginfo)
    if not victim:IsPlayer() then return end -- If the victim isnt a player dont log as its not gonna be a bitch and report someone 🙄😁

    -- Damaged ourself
    local attacker = dmginfo:GetAttacker()
    if victim == attacker then
        local weapon = attacker:GetActiveWeapon()
        local str = "%s (%s) delt %s to themself"
        str = string.format(str, attacker:Nick(), attacker:SteamID(), math.Round(dmginfo:GetDamage()))
        LLogs.Log(MODULE.Name, str, LLogs.FormatPlayer(victim), LLogs.FormatEnt(weapon, "Inflictor"))
        return
    end

    -- Player damaged Player
    if attacker:IsPlayer() then
        local weapon = attacker:GetActiveWeapon()
        local str = "%s (%s) delt %s dmg to %s (%s) with %s (%s)"
        local weapon = attacker:GetActiveWeapon()
        str = string.format(str, attacker:Nick(), attacker:SteamID(), math.Round(dmginfo:GetDamage()), victim:Nick(), victim:SteamID(), weapon:GetPrintName(), weapon:GetClass())
        LLogs.Log(MODULE.Name, str, LLogs.FormatPlayer(victim, "Victim"), LLogs.FormatPlayer(attacker, "Attacker"), LLogs.FormatEnt(weapon, "Inflictor"))
        return
    end

    -- Killed by the unknown 🙀
    local str = "%s delt %s dmg to %s (%s)"
    str = string.format(str, attacker:GetClass(), math.Round(dmginfo:GetDamage()), victim:Nick(), victim:SteamID())
    LLogs.Log(MODULE.Name, str, LLogs.FormatPlayer(victim, "Victim"), LLogs.FormatEnt(attacker, "Attacker"))
end)
LLogs.AddModule(MODULE)