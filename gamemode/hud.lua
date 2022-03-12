local killFeedText = ""

net.Receive("Kill_feed", function()
    if timer.Exists("killfeed_timer") then timer.Remove("killfeed_timer") end
    killFeedText = net.ReadString()
    timer.Create("killfeed_timer", 4, 1, resetKillFeedText)
end)

function resetKillFeedText()
    killFeedText = ""
end

function HUD()

    local client = LocalPlayer()

    if !client:Alive() then return end

    --  Kill counter
    local width = 200
    local height = 100

    draw.RoundedBox(5, ScrW()/2 - width/2, 0, width, height, Color(30, 30, 30, 0))

    draw.SimpleText("Kills:", "ScoreboardDefault", ScrW()/2, 20, Color(255,255,255,255), TEXT_ALIGN_CENTER, TEXT_ALIGN_TOP)
    --draw.SimpleText(client:GetNWInt("KillTotal"), "ScoreboardDefaultTitle", ScrW()/2, 40, Color(255,255,255,255), TEXT_ALIGN_CENTER, TEXT_ALIGN_TOP)
    draw.SimpleText(client:Frags(), "ScoreboardDefaultTitle", ScrW()/2, 40, Color(255,255,255,255), TEXT_ALIGN_CENTER, TEXT_ALIGN_TOP)

    --  Crosshair
    local width = 2
    local height = 2

    draw.RoundedBox(50, ScrW()/2 - (width+2)/2, ScrH()/2 - (height+2)/2, width+2, height+2, Color(0, 0, 0, 255))
    draw.RoundedBox(50, ScrW()/2 - width/2, ScrH()/2 - height/2, width, height, Color(255, 255, 255, 255))

    -- KillFeed
    if killFeedText != nil then
        draw.SimpleText(killFeedText, "ScoreboardDefault", ScrW()/2, ScrH()/2+50, Color(255,255,255,255), TEXT_ALIGN_CENTER, TEXT_ALIGN_TOP)
    end
end

hook.Add("HUDPaint", "KillCounter", HUD)


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
    for k, v in pairs({"CHudHealth", "CHudBattery", "CHudAmmo", "CHudSecondaryAmmo", "CHudCrosshair"}) do
        if name == v then return false end
    end
end

hook.Add("HUDShouldDraw", "HideTheDefaultHUD", HideHUD)