local PANEL = {}
function PANEL:Init()
    self.margin = PIXEL.Scale(6)

    self.Scroll = self:Add("PIXEL.ScrollPanel")
    self.Scroll:Dock(FILL)

    local title = self.Scroll:Add("DLabel")
    title:Dock(TOP)
    title:SetWide(PIXEL.Scale(150))
    title:SetText("USE %s TO REFERENCE SERVER NAME")
    title:SetFont(PIXEL.GetRealFont("LLogs:20:Bold"))
    title:SetContentAlignment(5)

    local m2 = (self.margin/2)
    local col = PIXEL.OffsetColor(PIXEL.Colors.Header, 10)
    for k, v in pairs(LLogs.ServerConfig) do
        local panel = self.Scroll:Add("DPanel")
        panel:Dock(TOP)
        panel:DockMargin(self.margin, self.margin, self.margin, 0)
        panel:SetTall(PIXEL.Scale(40))
        panel.Paint = function(s, w, h)
            PIXEL.DrawRoundedBox(6, 0, 0, w, h, col)
        end

        local title = panel:Add("DLabel")
        title:Dock(LEFT)
        title:DockMargin(self.margin, 0, 0, 0)
        title:SetWide(PIXEL.Scale(150))
        title:SetText(v[1])
        title:SetFont(PIXEL.GetRealFont("LLogs:20"))
        title:SetContentAlignment(0)

        surface.SetFont(PIXEL.GetRealFont("LLogs:20"))
        local tw, th = surface.GetTextSize(v[1])
        local infobutton = panel:Add("PIXEL.Button")
        infobutton:SetPos(self.margin + tw + m2, PIXEL.Scale(5))
        infobutton:SetSize(PIXEL.Scale(12), PIXEL.Scale(12))
        infobutton.Paint = function(s, w, h)
            PIXEL.DrawCircle(0, 0, w, h, Color(0, 110, 255))
        end
        infobutton.DoClick = function()
            chat.AddText(color_white, v[2])
        end
    
        local submit = panel:Add("PIXEL.TextButton")
        submit:Dock(RIGHT)
        submit:DockMargin(0, m2, m2, m2)
        submit:SetWide(PIXEL.Scale(100))
        submit:SetText("Submit")
        submit.DoClick = function(s)
            panel.SubmitValue()
        end

        if v[4] == "STRING" then
            local textbox = panel:Add("PIXEL.TextEntry")
            textbox:Dock(FILL)
            textbox:DockMargin(self.margin*4, m2, self.margin, m2)
            textbox:SetValue(v[3])
            panel.SubmitValue = function()
                net.Start("LLogs:SubmitSetting")
                net.WriteString(k)
                net.WriteUInt(1, 3)
                net.WriteString(textbox:GetValue())
                net.SendToServer()
            end
        elseif v[4] == "BOOL" then
            local box = panel:Add("PIXEL.Checkbox")
            box:Dock(RIGHT)
            box:DockMargin(self.margin*4, m2, self.margin, m2)
            box:SetToggle(v[3])
            box:SetWide(panel:GetTall()-self.margin)
            panel.SubmitValue = function()
                net.Start("LLogs:SubmitSetting")
                net.WriteString(k)
                net.WriteUInt(2, 3)
                net.WriteBool(box:GetToggle())
                net.SendToServer()
            end
        elseif v[4] == "NUMBER" then
            local textbox = panel:Add("PIXEL.TextEntry")
            textbox:Dock(FILL)
            textbox:DockMargin(self.margin*4, m2, self.margin, m2)
            textbox:SetValue(v[3])
            textbox:SetNumeric(true)
            panel.SubmitValue = function()
                net.Start("LLogs:SubmitSetting")
                net.WriteString(k)
                net.WriteUInt(3, 3)
                net.WriteUInt(textbox:GetValue(), 32)
                net.SendToServer()
            end
        end
    end
end

function PANEL:PerformLayout(w, h)

end

function PANEL:Paint(w, h)
    PIXEL.DrawRoundedBox(6, 0, 0, w, h, PIXEL.Colors.Header)
end
vgui.Register("LLogs:AdminPanel", PANEL, "EditablePanel")