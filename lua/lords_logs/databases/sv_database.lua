function LLogs.GetDatabase()
    return LLogs.Databases[LLogs.GetServerValue("Database")]
end

function LLogs.CreateDatabase(callback)
    callback = callback or function() end
    LLogs.GetDatabase().InitializeDatabase(function()
        callback()
    end)
end
LLogs.CreateDatabase()

function LLogs.DatabaseLog(ModuleName, date, timestamp, message, ExtraInfo, callback)
    callback = callback or function() end
    LLogs.GetDatabase().Log(ModuleName, date, timestamp, message, ExtraInfo, function()
        callback()
    end)
end

function LLogs.ResetDatabase(callback)
    callback = callback or function() end
    LLogs.GetDatabase().ResetDatabase(function()
        callback()
    end)
end

function LLogs.SearchDatabase(moduleName, callback)
    LLogs.GetDatabase().SearchModules(moduleName, function(results)
        callback(results, moduleName)
    end)
end

function LLogs.GetLogInfo(date, timestamp, message, callback)
    LLogs.GetDatabase().RequestLog(date, timestamp, message, function(data)
        callback(data)
    end)
end