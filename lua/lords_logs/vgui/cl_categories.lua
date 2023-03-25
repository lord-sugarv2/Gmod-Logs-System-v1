local PANEL = {}
function PANEL:Init()
    self.margin = PIXEL.Scale(6)
    self.Scroll = self:Add("PIXEL.ScrollPanel")
    self.Scroll:Dock(FILL)

    self.Categories = {}
    self.HoverCol = PIXEL.OffsetColor(PIXEL.Colors.Header, 20)
    self.NormalCol = PIXEL.OffsetColor(PIXEL.Colors.Header, 10)

    self.Sidebar = self:Add("PIXEL.Sidebar")
    self.Sidebar:Dock(FILL)
end

function PANEL:SetActivePanel(str)
    self:GetParent():SetupContent()
    self.Sidebar:SelectItem(str)

    net.Start("LLogs:RequestModuleData")
    net.WriteString(str)
    net.WriteUInt(1, 32)
    net.SendToServer()
end

function PANEL:AddCategory(str)
    local textCol = PIXEL.Colors.SecondaryText
    local btn = self.Sidebar:AddItem("category"..str, str, nil, function() end)
    btn.DoClick = function() end
    btn.Paint = function(s, w, h)
        PIXEL.DrawSimpleText(s:GetName(), "SidebarItem", PIXEL.Scale(10), h / 2, textCol, TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER)
        surface.SetDrawColor(255, 100, 100)
        surface.DrawRect(5, h-2, w-10, 2)
        surface.DrawRect(5, 0, w-10, 2)
    end
end

function PANEL:AddPanel(str, col, category)
    self.Sidebar:AddItem(str, str, nil, function()
        self:SetActivePanel(str)
    end)
end

function PANEL:FullyLoaded()
    if not LLogs.CanAccess(LocalPlayer()) then return end
    self:AddCategory("Admin")
    self.Sidebar:AddItem("Config", "Config", nil, function()
        self:GetParent():SetupContent(true, "LLogs:AdminPanel")
    end)
end

function PANEL:Paint(w, h)
    surface.SetDrawColor(PIXEL.Colors.Header)
    surface.DrawRect(0, 0, w, h)
end
vgui.Register("LLogs:Categories", PANEL, "EditablePanel")