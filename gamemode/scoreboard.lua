local scoreboardD = nil

function GM:ScoreboardShow()
    if !IsValid(scoreboardD) then
        scoreboardD = vgui.Create("DFrame")
        scoreboardD:SetSize(750, 500)
        scoreboardD:SetPos(ScrW()/2-325, ScrH()/2-250)
        scoreboardD:SetTitle("One Punch Tournament - Scoreboard")
        scoreboardD:SetDraggable(false)
        scoreboardD:ShowCloseButton(false)
        scoreboardD.Paint = function()
            draw.RoundedBox(5, 0, 0, scoreboardD:GetWide(), scoreboardD:GetTall(), Color(60, 60, 60, 255))
        end
    else
        scoreboardD:Show()
        scoreboardD:MakePopup()
        scoreboardD:SetKeyBoardInputEnabled(false)
    end
end

function GM:ScoreboardHide()
    if IsValid(scoreboardD) then
        scoreboardD:Hide()
    end
end
