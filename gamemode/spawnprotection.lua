
local models = {}

/*
CreateMaterial("protectionsphere", "UnlitGeneric",
    ["$basetexture"] = "color/white",
    ["$model"] = 1,
    ["$translucent"] = 1,
    ["$vertexalpha"] = 1,
    ["$vertexcolor"] = 1
)
*/

function StartSpawnProtection(ply)
    if ply:HasGodMode() then return end
    ply:GodEnable()
    ply:SetRenderFX(kRenderFxGlowShell)
    print(ply:Nick() .. " spawned with godmode")
    
    local model = ents.Create("prop_dynamic")
    model:SetModel("models/hunter/misc/sphere2x2.mdl")
    model:SetMaterial("models/props_combine/portalball001_sheet")
    model:SetPos( ply:GetPos() + Vector(0, 0, 20) )
    model:SetParent(ply)
    model:Spawn()

    local i = #models+1
    models[i] = model
    ply:SetNWInt("protectionSphereIndex", i)

    timer.Simple(2, function() StopSpawnProtection(ply) end)
end

function StopSpawnProtection(ply)
    ply:GodDisable()
    ply:SetRenderFX(0)
    print(ply:Nick() .. " godmode disabled")

    models[ply:GetNWInt("protectionSphereIndex")]:Remove()
end

function ClearModels()
    models = {}
end

hook.Add("OnRoundEnd", "Clean up models after round ended", ClearModels)