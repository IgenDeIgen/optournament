function RoundStart()
    local alive = 0
    for k, v in pairs( player.GetAll() ) do
        if (v:Alive()) then
            alive = alive + 1
        end
    end
    if(alive >= table.Count(player.GetAll()) && table.Count(player.GetAll()) > 1) then
        roundActive = true
    end
    print("Round started: " .. roundActive)
end