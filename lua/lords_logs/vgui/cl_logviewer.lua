local function Text(panel, text, font)
    local label = panel:Add("DButton")
    label:Dock(TOP)
    label:DockMargin(PIXEL.Scale(6), PIXEL.Scale(6), 0, 0)
    label:SetText("")
    label.Paint = function(s, w, h)
        PIXEL.DrawSimpleText(text, font, 0, h/2, color_white, 0, 1)        
    end
    label.DoClick = function()
        SetClipboardText(text)
        notification.AddLegacy("Copied to clipboard!", 0, 3)
    end
end

local PANEL = {}
function PANEL:Init()
    self.margin = PIXEL.Scale(6)

    self.Scroll = self:Add("PIXEL.ScrollPanel")
    self.Scroll:Dock(FILL)
end

function PANEL:PlayerInfo(data)
    local panel = self.Scroll:Add("DPanel")
    panel:Dock(TOP)
    panel:DockMargin(0, 0, 0, self.margin)
    panel:SetTall(PIXEL.Scale(100))
    panel.Paint = function(s, w, h)
        PIXEL.DrawRoundedBox(self.margin, 0, 0, w, h, PIXEL.Colors.Header)
    end

    local avatar = panel:Add("AvatarImage")
    avatar:Dock(LEFT)
    avatar:DockMargin(self.margin, self.margin, 0, self.margin)
    avatar:SetSteamID(data.SteamID64, 128)

    if data.Title and data.Title ~= "" then
        Text(panel, data.Title, "LLogs:20:Bold")
    end
    Text(panel, data.Name.." ("..data.SteamID..")", "LLogs:17")
    Text(panel, data.SteamID, "LLogs:17")

    panel.PerformLayout = function(s, w, h)
        avatar:SetWide(h - (self.margin*2))
    end
end

function PANEL:GetWeaponModel(class)
    for k, v in ipairs(weapons.GetList()) do
        if v.ClassName == class then
            return v.ViewModel
        end
    end
end

function PANEL:EntInfo(data)
    local panel = self.Scroll:Add("DPanel")
    panel:Dock(TOP)
    panel:DockMargin(0, 0, 0, self.margin)
    panel:SetTall(PIXEL.Scale(100))
    panel.Paint = function(s, w, h)
        PIXEL.DrawRoundedBox(self.margin, 0, 0, w, h, PIXEL.Colors.Header)
    end

    local modelpanel = panel:Add("DModelPanel")
    modelpanel:Dock(LEFT)
    modelpanel:DockMargin(self.margin, self.margin, 0, self.margin)
    modelpanel:SetModel(data.Model)
    modelpanel.LayoutEntity = function() return end
    if modelpanel.Entity then
        local mn, mx = modelpanel.Entity:GetRenderBounds()
        local size = 0
        size = math.max( size, math.abs(mn.x) + math.abs(mx.x) )
        size = math.max( size, math.abs(mn.y) + math.abs(mx.y) )
        size = math.max( size, math.abs(mn.z) + math.abs(mx.z) )
        modelpanel:SetFOV( 45 )
        modelpanel:SetCamPos( Vector( size, size, size ) )
        modelpanel:SetLookAt( (mn + mx) * 0.5 )
    end

    if data.Title and data.Title ~= "" then
        Text(panel, data.Title, "LLogs:20:Bold")
    end
    Text(panel, data.Class, "LLogs:17")
end

function PANEL:SetData(data)
    for k, v in ipairs(data) do
        if v.Type == "Player" then
            self:PlayerInfo(v)
        elseif v.Type == "Entity" then
            self:EntInfo(v)
        end
    end
end
vgui.Register("LLogs:LogViewer", PANEL, "EditablePanel")