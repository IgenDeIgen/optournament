include("spawnprotection.lua")

/*

    powerups:
    - explosive diarrhea
    - invincibility
    - rocket fist
    - high jump

*/

function pw_bombs(ply)
    timer.Create("diarrhea_timer", 0.2, 5, function()
        local ENT = ents.Create("bomb")
        ENT:SetPos(ply:GetPos())
        ENT:GetPhysicsObject()
        ENT:Spawn()
        ENT:Explode(ply)
    end)
end

function pw_invincibility(ply)
    StartSpawnProtection(ply, 2)
end

local effects = {
    pw_bombs
}

hook.Add("OnPowerUp", "Add effect when powerup is picked up", effects[1])
