--trident
local module = {};
local charList = {}
for i,v in ipairs(workspace:GetChildren()) do
    if v:FindFirstChild("Head") ~= nil and v.Head:FindFirstChild("Nametag") ~= nil and game.Players:FindFirstChild(v.Head.Nametag.tag.Text) ~= nil then
        charList[v.Head.Nametag.tag.Text] = v
    end
end
workspace.ChildAdded:connect(function(v)
    if v:FindFirstChild("Head") ~= nil and v.Head:FindFirstChild("Nametag") ~= nil and game.Players:FindFirstChild(v.Head.Nametag.tag.Text) ~= nil then
        charList[v.Head.Nametag.tag.Text] = v
    end
end)
local character
function module:getCharacter(player: Instance)
    character = charList[player.Name]
    return character, character:WaitForChild("HumanoidRootPart"), character:WaitForChild("Humanoid").Health, character:WaitForChild("Humanoid").MaxHealth
end
function module:getTeam(player: Instance)
    return player.TeamColor
end
function module:isPlayerFriendly(player: Instance)
    return false
end
return module;