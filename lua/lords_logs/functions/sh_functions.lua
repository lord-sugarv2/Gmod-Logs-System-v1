function LLogs.FormatTime(str, timestamp)
    return LLogs.GetServerValue("UTCTime") and os.date("!"..str, timestamp) or os.date(str, timestamp)
end

LLogs.Modules = LLogs.Modules or {}
function LLogs.AddModule(MODULE)
    LLogs.Modules[MODULE.Name] = MODULE
end

function LLogs.CanAccess(ply)
    return table.HasValue(LLogs.Access, ply:GetUserGroup())
end