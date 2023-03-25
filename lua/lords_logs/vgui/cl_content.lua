local PANEL = {}
function PANEL:Init()
    self.margin = PIXEL.Scale(6)
    self.Scroll = self:Add("PIXEL.ScrollPanel")
    self.Scroll:Dock(FILL)

    self.ContentBox = self:Add("LLogs:PageControls")
    self.ContentBox:Dock(BOTTOM)
    self.ContentBox:DockMargin(self.margin, self.margin, self.margin, self.margin)
    self.ContentBox:SetTall(PIXEL.Scale(40))

    hook.Add("LLogs:ReceivedModuleData", "LLogs:UpdateContent", function(moduleName, data)
        if not IsValid(self) then return end
        if self.HideControls then return end
        self.Data = data
        self.ContentBox.Data = data
        self:PopulateData(data)
    end)
end

function PANEL:HideControls(bool)
    self.HideControls = bool
    if not bool then return end
    self.ContentBox:Remove()
end

function PANEL:PopulateData(data)
    self.Scroll:Clear()
    local bool, col, col2 = false, PIXEL.OffsetColor(PIXEL.Colors.Header, 10), PIXEL.OffsetColor(PIXEL.Colors.Header, 5)
    for k, v in ipairs(data.Results) do
        local panel = self.Scroll:Add("DButton")
        panel:Dock(TOP)
        panel:DockMargin(self.margin, self.margin, self.margin, 0)
        panel:SetTall(PIXEL.Scale(25))
        panel:SetText("")
        panel.col = bool
        panel.Paint = function(s, w, h)
            local col = s.col and col2 or col
            col = s:IsHovered() and PIXEL.OffsetColor(col, 5) or col
            surface.SetDrawColor(col)
            surface.DrawRect(0, 0, w, h)

            local w2, h2 = PIXEL.DrawSimpleText(v.Date, "LLogs:20", self.margin, h/2, s:IsHovered() and PIXEL.OffsetColor(PIXEL.Colors.Primary, 10) or PIXEL.Colors.Primary, 0, 1)
            local w3, h3 = PIXEL.DrawSimpleText(os.date("%I:%M:%S", v.Timestamp), "LLogs:20", self.margin + w2 + 10, h/2, s:IsHovered() and PIXEL.OffsetColor(PIXEL.Colors.Positive, 10) or PIXEL.Colors.Positive, 0, 1)
            PIXEL.DrawSimpleText(v.Message, "LLogs:20", self.margin + w2 + 20 + w3, h/2, s:IsHovered() and PIXEL.OffsetColor(LLogs.Modules[v.Module].Color, 10) or LLogs.Modules[v.Module].Color, 0, 1)
        end
        panel.DoClick = function()
            net.Start("LLogs:RequestLog")
            net.WriteString(v.Date)
            net.WriteUInt(v.Timestamp, 32)
            net.WriteString(v.Message)
            net.SendToServer()
        end
        bool = not bool
    
        --local time = os.date("%H:%M:%S", v.Timestamp)
        --self.ListView:AddLine(v.Date, time, v.Message)
    end
    self.Scroll:Rebuild()
end
vgui.Register("LLogs:Content", PANEL, "EditablePanel")