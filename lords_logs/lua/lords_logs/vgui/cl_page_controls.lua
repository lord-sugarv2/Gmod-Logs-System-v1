local PANEL = {}
function PANEL:Init()
    self.BackgroundCol = PIXEL.OffsetColor(PIXEL.Colors.Header, 10)
    self.margin, self.Col = PIXEL.Scale(6), PIXEL.OffsetColor(self.BackgroundCol, 15)

    self.CurrentPage = self:Add("DPanel")
    self.CurrentPage.Paint = function(s, w, h)
        PIXEL.DrawRoundedBox(6, 0, 0, w, h, self.Col)
        PIXEL.DrawSimpleText(self.Data and self.Data.currentPage or 0, "LLogs:20", w/2, h/2, color_white, 1, 1)
    end

    self.FilterBox = self:Add("DPanel")
    self.FilterBox:Dock(LEFT)
    self.FilterBox:DockMargin(self.margin, self.margin, 0, self.margin)
    self.FilterBox.Paint = nil

    self.FilterText = self.FilterBox:Add("PIXEL.TextEntry")
    self.FilterText:Dock(FILL)
    self.FilterText:DockMargin(0, 0, self.margin, 0)
    self.FilterText:SetPlaceholderText("Word Filter")

    self.FilterButton = self.FilterBox:Add("PIXEL.TextButton")
    self.FilterButton:Dock(RIGHT)
    self.FilterButton:SetWide(PIXEL.Scale(75))
    self.FilterButton:SetText("Filter")
    self.FilterButton.DoClick = function()
        net.Start("LLogs:RequestWithFilter")
        net.WriteString(self.Data.moduleName)
        net.WriteString(self.FilterText:GetValue())
        net.SendToServer()
    end

    self.Forward = self:Add("DButton")
    self.Forward:SetText("")
    self.Forward.Paint = function(s, w, h)
        PIXEL.DrawRoundedBox(6, 0, 0, w, h, self.Col)
        PIXEL.DrawSimpleText(">", "LLogs:20", w/2, h/2, color_white, 1, 1)
    end
    self.Forward.DoClick = function()
        net.Start("LLogs:ChangePage")
        net.WriteUInt(self.Data and self.Data.currentPage + 1 or 1, 32)
        net.SendToServer()
    end

    self.ForwardSkip = self:Add("DButton")
    self.ForwardSkip:SetText("")
    self.ForwardSkip.Paint = function(s, w, h)
        PIXEL.DrawRoundedBox(6, 0, 0, w, h, self.Col)
        PIXEL.DrawSimpleText(">>", "LLogs:20", w/2, h/2, color_white, 1, 1)
    end
    self.ForwardSkip.DoClick = function()
        net.Start("LLogs:ChangePage")
        net.WriteUInt(self.Data.pagesAmount, 32)
        net.SendToServer()
    end

    self.Backwards = self:Add("DButton")
    self.Backwards:SetText("")
    self.Backwards.Paint = function(s, w, h)
        PIXEL.DrawRoundedBox(6, 0, 0, w, h, self.Col)
        PIXEL.DrawSimpleText("<", "LLogs:20", w/2, h/2, color_white, 1, 1)
    end
    self.Backwards.DoClick = function()
        net.Start("LLogs:ChangePage")
        net.WriteUInt(self.Data and self.Data.currentPage - 1 or 1, 32)
        net.SendToServer()
    end

    self.BackwardsSkip = self:Add("DButton")
    self.BackwardsSkip:SetText("")
    self.BackwardsSkip.Paint = function(s, w, h)
        PIXEL.DrawRoundedBox(6, 0, 0, w, h, self.Col)
        PIXEL.DrawSimpleText("<<", "LLogs:20", w/2, h/2, color_white, 1, 1)
    end
    self.BackwardsSkip.DoClick = function()
        net.Start("LLogs:ChangePage")
        net.WriteUInt(1, 32)
        net.SendToServer()
    end
end

function PANEL:PerformLayout(w, h)
    local w2, h2 = PIXEL.Scale(40), PIXEL.Scale(30) - self.margin
    local size = w2 + (w2/1.5) + (w2) + (w2/1.5) + (self.margin*4)
    self.CurrentPage:SetSize(w2, h2)
    self.CurrentPage:SetPos((w/2) - (w2/2), (h/2) - (h2/2))

    self.Forward:SetSize(w2/1.5, h2)
    self.Forward:SetPos((w/2) + (w2/2) + self.margin, (h/2) - (h2/2))

    self.ForwardSkip:SetSize(w2, h2)
    self.ForwardSkip:SetPos((w/2) + (w2/2) + self.margin + (w2/1.5) + self.margin, (h/2) - (h2/2))

    self.Backwards:SetSize(w2/1.5, h2)
    self.Backwards:SetPos((w/2) - (w2/2) - (w2/1.5) - self.margin, (h/2) - (h2/2))

    local x = (w/2) - (w2/2) - (w2/1.5) - self.margin - w2 - self.margin
    self.BackwardsSkip:SetSize(w2, h2)
    self.BackwardsSkip:SetPos(x, (h/2) - (h2/2))

    self.FilterBox:SetWide((w/2) - (size/2) - (self.margin*6))
end

function PANEL:Paint(w, h)
    PIXEL.DrawRoundedBox(6, 0, 0, w, h, self.BackgroundCol)
end
vgui.Register("LLogs:PageControls", PANEL, "EditablePanel")