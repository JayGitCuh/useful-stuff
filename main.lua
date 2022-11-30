local requestFunction = request or http and http.request or syn and syn.request or false 
local github = "https://raw.githubusercontent.com/JayGitCuh/useful-stuff/main/handler/"
local main = {
    ["hook"] = loadstring(game:HttpGet(github.."hook.lua"))(),
    ["visual"] = loadstring(game:HttpGet(github.."visual.lua"))(),
    ["lua-api"] = loadstring(game:HttpGet(github.."lua-api/"))(),
    ['supported'] = {
        8130299583, --trident
    };
};
function main:GetApi()
    if main.supported[game.PlaceId] then
        loadstring(game:HttpGet(main["lua-api"]..game.PlaceId..".lua"))()
    else
        loadstring(game:HttpGet(main["lua-api"].."universal.lua"))()
    end
end
return main