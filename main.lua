local requestFunction = request or http and http.request or syn and syn.request or false 
local github = "https://raw.githubusercontent.com/JayGitCuh/useful-stuff/main/handler/"
local main = {
    ["hook"] = loadstring(game:HttpGet(github.."hook.lua")),
    ["visual"] = loadstring(game:HttpGet(github.."visual.lua")),
};
return main