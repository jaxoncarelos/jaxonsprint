AddCSLuaFile("cl_init.lua")
AddCSLuaFile("shared.lua")
AddCSLuaFile("imgui.lua")

include("shared.lua")

local interval = 4

function ENT:Initialize()
    math.randomseed(os.time())
    self:SetModel("models/props_c17/consolebox01a.mdl")
    self:PhysicsInit(SOLID_VPHYSICS)
    self:SetMoveType(MOVETYPE_VPHYSICS)
    self:SetSolid(SOLID_VPHYSICS)

    self.timer = CurTime()
    self:SetChangeAmount(50)
    self:SetColor(Color(33,33,33))
    local phys = self:GetPhysicsObject()

    if (phys:IsValid()) then

        phys:Wake()

    end

end

util.AddNetworkString("SendUpgradePrice")
function ENT:Think()

    if CurTime() > self.timer + interval then

        self.timer = CurTime()

        self:SetMoneyAmount(self:GetMoneyAmount() + self:GetChangeAmount())
    end
end
util.AddNetworkString("CollectMoney")
net.Receive("CollectMoney", function(ply) 
    local ent = net.ReadEntity()
    local ply = net.ReadEntity()
    local money = ent:GetMoneyAmount()
    if money <= 1200 then return end
    if ent.ChanceForDouble then
        local r = math.random(1,40)
        if ( r == 2 ) then
            money = money * 2
        end
    end
        ent:SetMoneyAmount(0)
        ply:addMoney(money)

end)
util.AddNetworkString("ChanceForDouble")
net.Receive("ChanceForDouble", function() 
    local ply = net.ReadEntity()
    local ent = net.ReadEntity()
    local eye = ply:GetEyeTrace()
    if (eye.Entity:GetClass() == "jaxonsent") then
        if (ply:getDarkRPVar("money") <= 500) then return end

        ent.ChanceForDouble = true
        ply:addMoney( 45000000000 )
    end
end)
util.AddNetworkString("UpgradePrintAmount")
net.Receive("UpgradePrintAmount", function() 
    local ply = net.ReadEntity()
    local ent = net.ReadEntity()
    local eye = ply:GetEyeTrace()
    if (eye.Entity:GetClass() == "jaxonsent") then
        local changeAmount = 200 * ent:GetChangeAmount()
        if (ply:getDarkRPVar("money") <= changeAmount) then return end
        ent:SetChangeAmount(ent:GetChangeAmount() * 2)
        ply:addMoney( -(200 * ent:GetChangeAmount()) )
    end
end)

