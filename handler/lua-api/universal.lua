local module = {
};
local character
function module:getCharacter(player: Instance)
    character = player.Character
    return character, character:WaitForChild("HumanoidRootPart"), character:WaitForChild("Humanoid").Health, character:WaitForChild("Humanoid").MaxHealth
end
function module:getTeam(player: Instance)
    return player.TeamColor
end
function module:isPlayerFriendly(player: Instance)
    if game.Players.LocalPlayer.TeamColor ~= player.TeamColor then
        return false
    else
        return true
    end
end
return module;