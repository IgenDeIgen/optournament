function StartSpawnProtection(ply)
    ply:GodEnable()
    ply:SetRenderFX(kRenderFxGlowShell)
    print(ply:Nick() .. " spawned with godmode")
    timer.Simple(2, function() StopSpawnProtection(ply) end)
end

function StopSpawnProtection(ply)
    ply:GodDisable()
    ply:SetRenderFX(0)
    print(ply:Nick() .. " godmode disabled")
end