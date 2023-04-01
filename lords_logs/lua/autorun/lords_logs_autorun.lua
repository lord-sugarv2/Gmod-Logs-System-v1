LLogs = LLogs or {}
local function Server(str)
    if SERVER then
        include(str)
    end
end

local function Client(str)
    if SERVER then
        AddCSLuaFile(str)
    else
        include(str)
    end
end

local function Shared(str)
    Server(str)
    Client(str)
end

local function IncludeDir(dir)
    dir = dir.."/"
    local File, Directory = file.Find(dir.."*", "LUA")
    for k, v in ipairs(File) do
        if string.EndsWith(v, ".lua") then
            Shared(dir..v)
        end
    end
    
    for k, v in ipairs(Directory) do
        IncludeDir(dir..v)
    end
end

hook.Add("PIXEL.UI.FullyLoaded", "LLogs:Load", function()
    Shared("lords_logs/sh_config.lua")
    Shared("lords_logs/config/sh_config_builder.lua")
    Shared("lords_logs/config/sh_base_server.lua")

    Shared("lords_logs/functions/sh_functions.lua")
    Server("lords_logs/functions/sv_functions.lua")
    Client("lords_logs/functions/cl_functions.lua")

    Server("lords_logs/databases/sv_sqlite.lua")
    Server("lords_logs/databases/sv_database.lua")

    Client("lords_logs/vgui/cl_categories.lua")
    Client("lords_logs/vgui/cl_main.lua")
    Client("lords_logs/vgui/cl_content.lua")
    Client("lords_logs/vgui/cl_page_controls.lua")
    Client("lords_logs/vgui/cl_admin_panel.lua")
    Client("lords_logs/vgui/cl_logviewer.lua")

    IncludeDir("lords_logs/logging_modules")
end)