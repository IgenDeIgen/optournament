AddCSLuaFile( "cl_init.lua" )
AddCSLuaFile( "shared.lua" )

AddCSLuaFile( "hud.lua" )
AddCSLuaFile( "roundsystem.lua" )
AddCSLuaFile( "spawnprotection.lua" )

include( "shared.lua" )
include( "roundsystem.lua" )
include( "spawnprotection.lua" )

function GM:PlayerInitialSpawn(ply)
    ply:SetPlayerColor( Vector( math.random(), math.random(), math.random() ) )

    ply:SetWalkSpeed(600)
    ply:SetRunSpeed(400)
    ply:SetCrouchedWalkSpeed(0.2)
end

function GM:PlayerSetModel( ply )
    ply:SetModel( "models/player/kleiner.mdl" )
 end

function GM:PlayerLoadout(ply)
    ply:Give("weapon_megafist")

    return true
end

function GM:PlayerDeath(victim, inflictor, attacker)
    if (victim:Frags() < 0) then
        victim:SetFrags(0)
    end
    attacker:SetNWInt("KillCount", attacker:GetNWInt("KillCount") + 1)
    victim:SetNWInt("KillCount", 0)
    if attacker:GetNWInt("KillCount") == 2 then
        attacker:Say("DOUBLE KILL!")
    elseif attacker:GetNWInt("KillCount") == 3 then
        attacker:Say("TRIPLE KILL!")
    end
end

function GM:PlayerSpawn(ply)
    self:PlayerSetModel(ply)
    self:PlayerLoadout(ply)
    ply:SetupHands()
    StartSpawnProtection(ply)
end