AddCSLuaFile( "cl_init.lua" )
AddCSLuaFile( "shared.lua" )

AddCSLuaFile( "hud.lua" )
AddCSLuaFile( "roundsystem.lua" )
AddCSLuaFile( "spawnprotection.lua" )
--AddCSLuaFile( "scoreboard.lua" )

include( "shared.lua" )
include( "roundsystem.lua" )
include( "spawnprotection.lua" )

local killmessages = {
    "Double kill",
    "Triple kill",
    "Quadro kill",
    "Penta kill",
    "Monster kill",
    "Ultra kill",
    "Galaxy kill",
    "Unstoppable",
    "Godlike",
    "Savagery",
    "Bloodthirster",
    "wtf?!",
    "ur mom",
    "UR DAD",
    "@&˘;°!?%?!"
}

local killFeeds = {
    "ATTACKER stomped VICTIM's face into the ground",
    "ATTACKER eviscerated VICTIM",
    "ATTACKER hit VICTIM with the ol' stanky leg, and when that didn't work, he broke his neck",
    "ATTACKER committed genocide, but the only person murdered was VICTIM",
    "ATTACKER did some unspeakable things to VICTIM",
    "ATTACKER pounded some meat, only it wasn't meat, but VICTIM's organs",
    "ATTACKER demolished VICTIM",
    "ATTACKER ruined VICTIM's day and face",
    "ATTACKER turned VICTIM into an astronaut"
}

local firstKill = true

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

    if attacker != victim then
        if firstKill then
            firstKill = false
            attacker:Say("First blood!")
        end
        killFeed(attacker, victim)
    end

    for k, v in pairs(killmessages) do
        if attacker:GetNWInt("KillCount") == k+1 then
            attacker:Say(v)
        end
    end
end

function GM:PlayerSpawn(ply)
    self:PlayerSetModel(ply)
    self:PlayerLoadout(ply)
    ply:SetupHands()
    StartSpawnProtection(ply)
end

util.AddNetworkString("Kill_feed")

function killFeed(attacker, victim)
    local n = math.random(#killFeeds)
    local killFeed = string.gsub(string.gsub(killFeeds[n], "ATTACKER", attacker:Nick()), "VICTIM", victim:Nick())
    net.Start("Kill_feed")
    net.WriteString(killFeed)
    net.Broadcast()
end