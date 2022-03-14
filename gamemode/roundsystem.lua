ROUNDSYS = {}

ROUNDSYS.roundActive = false
ROUNDSYS.duration = 30 --  Length of one round in seconds
ROUNDSYS.waitTime = 10
ROUNDSYS.roundBeforeMapChange = 3
ROUNDSYS.startTime = 0
ROUNDSYS.curRound = 0

util.AddNetworkString("RoundStarted")
util.AddNetworkString("RoundEnded")

function ROUNDSYS.RoundStart()
    if !ROUNDSYS.roundActive then
        if(#player.GetAll() >= 2) then
            ROUNDSYS.roundActive = true

            ROUNDSYS.curRound = ROUNDSYS.curRound + 1

            game.CleanUpMap()
            hook.Run("OnRoundStart")

            ROUNDSYS.startTime = CurTime()

            for k, v in ipairs( player.GetAll() ) do
                v:Spawn()
                v:SetFrags(0)
                v:UnLock()
            end

            print("Round #" .. tostring(ROUNDSYS.curRound) .. "started: " .. tostring(ROUNDSYS.roundActive))

            net.Start("RoundStarted")
                net.WriteUInt(ROUNDSYS.curRound, 8)
                net.WriteUInt(ROUNDSYS.startTime, 18)
                net.WriteUInt(ROUNDSYS.duration, 11)
            net.Broadcast()
        end
    end
end

function ROUNDSYS.RoundEnd()
    local winner = nil
    for k, v in ipairs(player.GetAll()) do
        v:Lock()
        if (winner == nil || winner:Frags() < v:Frags()) then
            winner = v
        end
    end
    print("Round #" .. tostring(ROUNDSYS.curRound) .. "started: " .. tostring(ROUNDSYS.roundActive))
    print("Winner is " .. winner:Nick())
    for k, v in ipairs(player.GetAll()) do
        v:KillSilent()
    end
    net.Start("RoundEnded")
        net.WriteString(winner:Nick())
        net.WriteUInt(winner:Frags(), 8)
    net.Broadcast()

    timer.Simple(ROUNDSYS.waitTime, ROUNDSYS.RoundStart)
end

function ROUNDSYS.RoundCheck()
    if ROUNDSYS.roundActive then
        if CurTime() >= ROUNDSYS.startTime + ROUNDSYS.duration then
            ROUNDSYS.roundActive = false
            hook.Run("OnRoundEnd")
        end
    end
end

hook.Add("OnRoundEnd", "End round, prepare next", ROUNDSYS.RoundEnd)
hook.Add("Think", "Check for round end conditions", ROUNDSYS.RoundCheck)
hook.Add("PlayerInitialSpawn", "Try to start the round if conditions are met", ROUNDSYS.RoundStart)