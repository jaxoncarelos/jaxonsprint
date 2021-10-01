ENT.Type = "anim"
ENT.Base = "base_gmodentity"

ENT.PrintName = "Jaxons Printer"

ENT.Spawnable = true
ENT.RenderGroup = RENDERGROUP_TRANSLUCENT

function ENT:SetupDataTables()
    self:NetworkVar("Int", 1, "MoneyAmount")
    self:NetworkVar("Int", 2, "ChangeAmount")
end

moneyChangeConfig = {1200, 2000, 2300, 2600, 3000, 3500, 3900, 4000}
