PIXEL.RegisterFont("LLogs:20:Bold", "Open Sans Bold", 20)
PIXEL.RegisterFont("LLogs:20", "Open Sans", 20)
PIXEL.RegisterFont("LLogs:17", "Open Sans", 17)

function LLogs:Open()
    if LLogs.Menu then LLogs.Menu:Remove() end
    LLogs.Menu = vgui.Create("PIXEL.Frame")
    LLogs.Menu:SetSize(PIXEL.Scale(1000), PIXEL.Scale(800))
    LLogs.Menu:MakePopup()
    LLogs.Menu:Center()
    LLogs.Menu:SetTitle(string.format(LLogs.GetServerValue("MenuTitle"), LLogs.GetServerValue("ServerName")))

    local panel = LLogs.Menu:Add("LLogs:Main")
    panel:Dock(FILL)
end

net.Receive("LLogs:Open", function()
    LLogs:Open()
end)

net.Receive("LLogs:SendsLogs", function()
    local data = {
        moduleName = net.ReadString(),
        pagesAmount = net.ReadUInt(32),
        currentPage = net.ReadUInt(32),
        resultsOnPage = net.ReadUInt(6),
        Results = {},
    }

    for i = 1, data.resultsOnPage do
        local tbl = {
            Date = net.ReadString(),
            Message = net.ReadString(),
            Timestamp = net.ReadUInt(32),
            Module = net.ReadString(),
        }
        table.Add(data.Results, {tbl})
    end
    hook.Run("LLogs:ReceivedModuleData", data.moduleName, data)
end)

net.Receive("LLogs:Notify", function()
    local int, seconds, message = net.ReadUInt(3), net.ReadUInt(8), net.ReadString()
    notification.AddLegacy(message, int, seconds)
end)

net.Receive("LLogs:NetworkConfig", function()
    local data = net.ReadTable()
    for k, v in pairs(data) do
        LLogs.ServerConfig[k][3] = v
    end
end)

net.Receive("LLogs:LogInfo", function()
    local data = net.ReadTable()
    data = util.JSONToTable(data.ExtraInfo)
    local frame = vgui.Create("PIXEL.Frame")
    frame:SetSize(PIXEL.Scale(400), PIXEL.Scale(250))
    frame:MakePopup()
    frame:Center()
    frame:SetTitle("Log Viewer")

    local panel = frame:Add("LLogs:LogViewer")
    panel:Dock(FILL)
    panel:SetData(data)
end)

hook.Add("InitPostEntity", "LLogs:CanReceive", function()
    net.Start("LLogs:RequestConfig")
    net.SendToServer()
end)