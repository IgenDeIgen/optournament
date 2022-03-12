function KillCounter()

    local client = LocalPlayer()

    if !client:Alive() then return end

    local width = 200
    local height = 100

    draw.RoundedBox(5, ScrW()/2 - width/2, 0, width, height, Color(30, 30, 30, 0))

    draw.SimpleText("Kills:", "ScoreboardDefault", ScrW()/2, 20, Color(255,255,255,255), TEXT_ALIGN_CENTER, TEXT_ALIGN_TOP)
    --draw.SimpleText(client:GetNWInt("KillTotal"), "ScoreboardDefaultTitle", ScrW()/2, 40, Color(255,255,255,255), TEXT_ALIGN_CENTER, TEXT_ALIGN_TOP)
    draw.SimpleText(client:Frags(), "ScoreboardDefaultTitle", ScrW()/2, 40, Color(255,255,255,255), TEXT_ALIGN_CENTER, TEXT_ALIGN_TOP)

end

hook.Add("HUDPaint", "KillCounter", KillCounter)

/*
function HealthMeter()
    local client = LocalPlayer()

    if !client:Alive() then return end

    local width = 800
    local height = 40

    draw.RoundedBox(5, ScrW()/2 - width/2, ScrH() - height, width, height, Color(255, 255, 255, 255))
    draw.RoundedBox(5, ScrW()/2 - width/2 + 5, ScrH() - height + 5, client:Health()*width/client:GetMaxHealth() - 10, height - 10, Color(255 - client:Health()*255/client:GetMaxHealth(), client:Health()*255/client:GetMaxHealth(), 0, 255))

    draw.SimpleText(client:Health(), "ScoreboardDefaultTitle", ScrW()/2, ScrH() - height, Color(255, 255, 0, 255), TEXT_ALIGN_CENTER, TEXT_ALIGN_BOTTOM)
end

hook.Add("HUDPaint", "HealthHUD", HealthMeter)
*/

function HideHUD(name)
    for k, v in pairs({"CHudHealth", "CHudBattery", "CHudAmmo", "CHudSecondaryAmmo"}) do
        if name == v then return false end
    end
end

hook.Add("HUDShouldDraw", "HideTheDefaultHUD", HideHUD)