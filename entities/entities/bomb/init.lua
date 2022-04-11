AddCSLuaFile("shared.lua")
AddCSLuaFile("cl_init.lua")

include("shared.lua")

function ENT:Initialize()
    self:SetModel("models/dynamite/dynamite.mdl")
    self:PhysicsInit(SOLID_VPHYSICS)
    self:SetMoveType(MOVETYPE_NONE)
    self:SetSolid(SOLID_VPHYSICS)

    local phys = self:GetPhysicsObject()
    if(IsValid(phys)) then phys:Wake() end

    self:SetCollisionGroup(COLLISION_GROUP_WEAPON)

    self:SetTrigger(true)
end

function ENT:Explode(ply)
    timer.Simple(2, function()
        if !IsValid(self) then return end
        local radius = 300

        util.BlastDamage( self, ply, self:GetPos(), radius, 1500 )

        local effectdata = EffectData()
        effectdata:SetOrigin( self:GetPos() )
        util.Effect( "Explosion", effectdata, true, true )
        self:Remove()
    end)
end