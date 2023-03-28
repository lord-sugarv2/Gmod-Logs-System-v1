local PANEL = {}
function PANEL:Init()
    self.margin = PIXEL.Scale(6)
    self.Scroll = self:Add("PIXEL.ScrollPanel")
    self.Scroll:Dock(FILL)

    self.Categories = {}
    self.HoverCol = PIXEL.OffsetColor(PIXEL.Colors.Header, 20)
    self.NormalCol = PIXEL.OffsetColor(PIXEL.Colors.Header, 10)
end

function PANEL:SetActivePanel(str)
    self:GetParent():SetupContent()

    net.Start("LLogs:RequestModuleData")
    net.WriteString(str)
    net.WriteUInt(1, 32)
    net.SendToServer()
end

function PANEL:AddCategory(str)
    local category = self.Scroll:Add("PIXEL.Category")
    category:Dock(TOP)
    category:SetTall(30)
    category:SetTitle(str)

    local contents = vgui.Create("DPanel")
    contents.Paint = nil
    contents.SizeToChildren = function(s)
        local x = self.margin
        for k, v in ipairs(s:GetChildren()) do
            x = x + v:GetTall()
        end
        x = x + self.margin
        s:SetTall(x)
    end
    category:SetContents(contents)
    self.Categories[str] = contents 
end

function PANEL:AddPanel(str, col, category)
    local button = (category and self.Categories[category] or self.Scroll):Add("PIXEL.TextButton")
    button:SetText(str)
    button:Dock(TOP)
    button.DoClick = function(s)
        self:SetActivePanel(str)
    end
end

function PANEL:FullyLoaded()
    if not LLogs.CanAccess(LocalPlayer()) then return end

    local button = self.Scroll:Add("PIXEL.TextButton")
    button:SetText("Admin")
    button:Dock(TOP)
    button:DockMargin(self.margin, self.margin, self.margin, 0)
    button.DoClick = function(s)
        self:GetParent():SetupContent(true, "LLogs:AdminPanel")
    end
end

function PANEL:Paint(w, h)
    surface.SetDrawColor(PIXEL.Colors.Header)
    surface.DrawRect(0, 0, w, h)
end
vgui.Register("LLogs:Categories", PANEL, "EditablePanel")