include("shared.lua")

local imgui = include("imgui.lua")

surface.CreateFont( "MoneyFont", {
	font = "Arial", --  Use the font-name which is shown to you by your operating system Font Viewer, not the file name
	extended = false,
	size = 44,
	weight = 500,
	antialias = true,
} )

ENT.RenderGroup = RENDERGROUP_TRANSLUCENT
local upgradePrice = 10000

function ENT:DrawTranslucent()
    self:DrawModel()
    if imgui.Entity3D2D(self, Vector(0, -12, 11), Angle(0, 90, 0), 0.1) then
        draw.RoundedBox(0, -32, -162, 310, 320, Color(30,30,30))
        if imgui.xTextButton("Collect", "!Roboto@24", -32, 110, 310, 40, 1, Color(255,255,255), Color(155, 155,155), Color(255,0,0)) then
            
            net.Start("CollectMoney")
            net.WriteEntity(self)
            net.WriteEntity(LocalPlayer())
            net.SendToServer()
        end
        if imgui.xTextButton("Upgrade $" .. self:GetChangeAmount() * 200, "!Roboto@24", -32, 70, 310, 40, 1, Color(255,255,255), Color(155, 155,155), Color(255,0,0)) then
                print(upgradePrice)
                net.Start("UpgradePrintAmount")
                net.WriteEntity(LocalPlayer())
                net.WriteEntity(self)
                net.SendToServer()
        end

        draw.WordBox(2, -20, -150,"$" .. self:GetMoneyAmount(), "MoneyFont", Color(66, 66, 66, 100), Color(255,255,255,255))
            
        imgui.End3D2D()
    end
end
