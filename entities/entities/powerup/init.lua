AddCSLuaFile("shared.lua")
AddCSLuaFile("cl_init.lua")

include("shared.lua")

function ENT:Initialize()
    self:SetModel("models/hunter/blocks/cube05x05x05.mdl")
    self:PhysicsInit(SOLID_VPHYSICS)
    self:SetMoveType(MOVETYPE_NONE)
    self:SetSolid(SOLID_VPHYSICS)

    local phys = self:GetPhysicsObject()
    if(IsValid(phys)) then phys:Wake() end

    self:SetCollisionGroup(COLLISION_GROUP_WEAPON)

    self:SetTrigger(true)
end

function ENT:StartTouch(eOtherEnt)
    if eOtherEnt:IsPlayer() then
        eOtherEnt:ChatPrint("Picked up a powerup!")
        self:EmitSound("AlyxEMP.Charge")
        self:Remove()
    end
end