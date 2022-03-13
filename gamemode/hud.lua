local killFeedText = ""

net.Receive("Kill_feed", function()
    if timer.Exists("killfeed_timer") then timer.Remove("killfeed_timer") end
    killFeedText = net.ReadString()
    timer.Create("killfeed_timer", 4, 1, resetKillFeedText)
end)

local curRound = 0
local roundStartTime = 0
local roundDuration = 0

net.Receive("RoundStarted", function()
    curRound = net.ReadUInt(8)
    roundStartTime = net.ReadUInt(18)
    roundDuration = net.ReadUInt(11)
end)

function resetKillFeedText()
    killFeedText = ""
end

function HUD()

    local client = LocalPlayer()

    if !client:Alive() then return end

    --  Kill counter
    local KillCounter = {}
    KillCounter.x = ScrW()/2
    KillCounter.y = 85
    KillCounter.width = 100
    KillCounter.height = 70

    draw.RoundedBox(5, KillCounter.x - KillCounter.width/2, KillCounter.y, KillCounter.width, KillCounter.height, Color(80, 80, 80, 120))

    draw.SimpleText("Kills:", "ScoreboardDefault", KillCounter.x, KillCounter.y + 5, Color(255,255,255,255), TEXT_ALIGN_CENTER, TEXT_ALIGN_TOP)
    --draw.SimpleText(client:GetNWInt("KillTotal"), "ScoreboardDefaultTitle", ScrW()/2, 40, Color(255,255,255,255), TEXT_ALIGN_CENTER, TEXT_ALIGN_TOP)
    draw.SimpleText(client:Frags(), "ScoreboardDefaultTitle", KillCounter.x, KillCounter.y + 30, Color(255,255,255,255), TEXT_ALIGN_CENTER, TEXT_ALIGN_TOP)

    --  Round Timer
    local RoundTimer = {}
    RoundTimer.x = ScrW()/2
    RoundTimer.y = 5
    RoundTimer.width = 200
    RoundTimer.height = 75
    RoundTimer.text = "No Round"
    
    if curRound > 0 then
        local remainingTime = (math.floor(roundStartTime) + roundDuration) - math.floor(CurTime())
        RoundTimer.text = tostring(math.floor(remainingTime / 60)) .. ":" .. tostring(remainingTime % 60)
    end

    draw.RoundedBox(5, RoundTimer.x - RoundTimer.width/2, RoundTimer.y, RoundTimer.width, RoundTimer.height, Color(80, 80, 80, 120))
    draw.SimpleText(RoundTimer.text, "ScoreboardDefaultTitle", RoundTimer.x, RoundTimer.y + RoundTimer.height/2, Color(255,255,255,255), TEXT_ALIGN_CENTER, TEXT_ALIGN_TOP)
    draw.SimpleText(tostring(curRound), "ScoreboardDefaultTitle", RoundTimer.x, RoundTimer.y + 5, Color(255,255,255,255), TEXT_ALIGN_CENTER, TEXT_ALIGN_TOP)

    --  Crosshair
    local Crosshair = {}
    Crosshair.width = 2
    Crosshair.height = 2

    draw.RoundedBox(50, ScrW()/2 - (Crosshair.width+2)/2, ScrH()/2 - (Crosshair.height+2)/2, Crosshair.width+2, Crosshair.height+2, Color(0, 0, 0, 255))
    draw.RoundedBox(50, ScrW()/2 - Crosshair.width/2, ScrH()/2 - Crosshair.height/2, Crosshair.width, Crosshair.height, Color(255, 255, 255, 255))

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