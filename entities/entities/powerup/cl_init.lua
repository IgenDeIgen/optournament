include("shared.lua")

function ENT:Initialize()
    self.csModel = ClientsideModel("models/xqm/rails/trackball_1.mdl")
    self.csModel:SetColor(Color( math.random(255), math.random(255), math.random(255), 255 ))
    self.csModel:SetRenderMode(RENDERMODE_GLOW)
end

function ENT:Draw()
    --self:DrawModel()
    self.csModel:SetPos(self:GetPos() + Vector(0, 0, 25))
    self.csModel:SetAngles(self:GetAngles())
end

function ENT:OnRemove()
    self.csModel:Remove()
end