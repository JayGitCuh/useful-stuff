local dwRunservice = game:GetService("RunService");
local dwLocalPlayer = game.Players.LocalPlayer;
local dwMouse = dwLocalPlayer:GetMouse();
local dwWorkspace = game:GetService("Workspace");
local dwCamera = dwWorkspace.CurrentCamera;
local dwPlayers = game:GetService("Players");
local dwUserInputService = game:GetService("UserInputService");
local module = loadstring(game:HttpGet("https://raw.githubusercontent.com/JayGitCuh/useful-stuff/main/main.lua"))():GetApi()
local visual_module = {
    ["Player_Cache"] = {}, --player cache for esp no laggy
    ["Items"] = {},
};
function visual_module:draw_visual(main_table: table, playerammount: number)
    local function create_player(index)
        table.insert(visual_module.Player_Cache, index)
        local newtable = {};
        local esp = {
            Line = {SnapOutline = Drawing.new("Line"), Snapline = Drawing.new("Line")},
            Box = {Filledbox = Drawing.new("Square"), Outline = Drawing.new("Square"), Main = Drawing.new("Square"), HealthboxOutline = Drawing.new("Square"), Healthbox = Drawing.new("Square")},
            Text = {Distance = Drawing.new("Text"), Name = Drawing.new("Text")},
            Highlight = {Chams = Instance.new("Highlight")},
        };
        esp.Highlight.Parent = nil
        for _index, v in pairs(esp.Box) do
            v.Visible = false
            v.Position = Vector2.new(20, 20);
            v.Size = Vector2.new(20, 20);
            v.Color = Color3.fromRGB(0, 0, 0);
            v.Filled = false;
            v.Transparency = 0.9;
            v.Thickness = 1
        end
        for _index, v in pairs(esp.Line) do
            v.From = Vector2.new(20, 20); -- origin
            v.To = Vector2.new(50, 50); -- destination
            v.Color = Color3.new(0,0,0);
            v.Thickness = 1;
            v.Transparency = 0.9;
            v.Visible = false
        end
        for _index, v in pairs(esp.Highlight) do
            v.FillTransparency = 0.9
            v.OutlineTransparency = 0.4
            v.OutlineColor = Color3.fromRGB(255, 0, 4)
        end
        for _index, v in pairs(esp.Text) do
            v.Text = ""
            v.Color = Color3.new(1, 1, 1)
            v.OutlineColor = Color3.new(0, 0, 0)
            v.Center = true
            v.Outline = true
            v.Position = Vector2.new(100, 100)
            v.Size = 15
            v.Font = 1 -- 'UI', 'System', 'Plex', 'Monospace'
            v.Transparency = 0.9
            v.Visible = false
        end
        local function toggledrawing(value)
            for _index, v in pairs(esp.Box) do
                v.Visible = value
            end
            for _index, v in pairs(esp.Text) do
                v.Visible = value
            end
            for _index, v in pairs(esp.Line) do
                v.Visible = value
            end
            for _index, v in pairs(esp.Highlight) do
                v.Enabled = value
                if value == false then
                    v.Parent = nil
                end
            end
        end
        local function changedrawingcolor(color)
            esp.Box["Main"].Color = color
            esp.Box["Healthbox"].Color = color
            for i,v in pairs(esp.Text) do
                v.Color = color
            end
            for i,v in pairs(esp.Highlight) do
                v.OutlineColor = color
                v.FillColor = color
            end
            for i,v in pairs(esp.Line) do
                if i ~= "SnapOutline" then
                    v.Color = color
                end
            end
        end
        local orientation, sizee
        local width
        local height
        local size
        local rootPos
        local magnitude
        local character, mainpart, health, max
        print("player cache group created", index)
        dwRunservice.Heartbeat:Connect(function()
            newtable = main_table
            if game.Players:GetChildren()[index] ~= nil then
                visual_module.Player_Cache[index] = {Player = game.Players:GetChildren()[index]}
                character, mainpart, health, maxhealth = module:getCharacter(visual_module.Player_Cache[index].Player)
                    if visual_module.Player_Cache[index].Player ~= nil and character ~= nil and mainpart and health ~= nil and health > 0 then
                        local displayEsp = character
                        if displayEsp then
                            local _,onscreen = dwCamera:WorldToScreenPoint(mainpart.Position)
                            displayEsp = onscreen
                        end
                        orientation, sizee = character:GetBoundingBox()
                        width = (dwCamera.CFrame - dwCamera.CFrame.p) * Vector3.new((math.clamp(sizee.X, 1, 10) + 0.5) / 2, 0, 0)
                        height = (dwCamera.CFrame - dwCamera.CFrame.p) * Vector3.new(0, (math.clamp(sizee.X, 1, 10) + 2) / 2, 0)
                        width = math.abs(dwCamera:WorldToViewportPoint(orientation.Position + width).X - dwCamera:WorldToViewportPoint(orientation.Position - width).X)
                        height = math.abs(dwCamera:WorldToViewportPoint(orientation.Position + height).Y - dwCamera:WorldToViewportPoint(orientation.Position - height).Y)
                        size = Vector2.new(math.floor(width), math.floor(height))
                        size = Vector2.new(size.X % 2 == 0 and size.X or size.X + 1, size.Y % 2 == 0 and size.Y or size.Y + 1)
                        rootPos = dwCamera:WorldToViewportPoint(mainpart.Position)
                        magnitude = (mainpart.Position - dwCamera.CFrame.p).Magnitude
                        if newtable.Enabled and displayEsp and magnitude < newtable.ShowDistance then
                            --Highlight
                            esp['Highlight'].Chams.Enabled = newtable.Highlight.Enabled
                            esp['Highlight'].Chams.FillTransparency = newtable.Highlight.FillOpacity
                            esp['Highlight'].Chams.OutlineTransparency = newtable.Highlight.OutlineOpacity
                            esp['Highlight'].Chams.Parent = character
                            --Filledbox
                            esp.Box["Filledbox"].Visible = newtable.Filledbox and newtable.Box
                            esp.Box["Filledbox"].Size = size
                            esp.Box["Filledbox"].Filled = newtable.Filledbox
                            esp.Box["Filledbox"].Transparency = newtable.FilledOpacity
                            esp.Box["Filledbox"].Position = Vector2.new(math.floor(rootPos.X), math.floor(rootPos.Y)) - (esp.Box["Main"].Size / 2)
                            --Box
                            esp.Box["Outline"].Visible = newtable.Box and newtable.ShowTeam
                            esp.Box["Outline"].Size = size
                            esp.Box["Outline"].Position = Vector2.new(math.floor(rootPos.X), math.floor(rootPos.Y)) - (esp.Box["Outline"].Size / 2)
                            esp.Box["Main"].Visible = newtable.Box and newtable.ShowTeam
                            esp.Box["Main"].Size = size
                            esp.Box["Main"].Position = Vector2.new(math.floor(rootPos.X), math.floor(rootPos.Y)) - (esp.Box["Main"].Size / 2)
                            --Healthbox
                            esp.Box["HealthboxOutline"].Visible = newtable.Healthbox
                            esp.Box["HealthboxOutline"].Size = Vector2.new(2, size.Y * (1-((health - health) / maxhealth)))
                            esp.Box["HealthboxOutline"].Position = Vector2.new(math.floor(rootPos.X) - 5, math.floor(rootPos.Y) + (size.Y - math.floor(esp.Box["HealthboxOutline"].Size.Y))) - size / 2
                            esp.Box["Healthbox"].Visible = newtable.Healthbox and newtable.ShowTeam
                            esp.Box["Healthbox"].Size = Vector2.new(2, size.Y * (1-((health - health) / maxhealth)))
                            esp.Box["Healthbox"].Position = Vector2.new(math.floor(rootPos.X) - 5, math.floor(rootPos.Y) + (size.Y - math.floor(esp.Box["Healthbox"].Size.Y))) - size / 2
                            --Name
                            esp.Text["Name"].Visible = newtable.Name
                            esp.Text["Name"].Position = Vector2.new(math.floor(rootPos.X), math.floor(rootPos.Y) - size.Y / 2 - 16)
                            esp.Text["Name"].Text = visual_module.Player_Cache[index].Player.Name
                            --Distance
                            esp.Text["Distance"].Visible = newtable.Distance
                            esp.Text["Distance"].Position = Vector2.new(math.floor(rootPos.X),math.floor(rootPos.Y + height * 0.5))
                            esp.Text["Distance"].Text = tostring(math.ceil(magnitude)).." studs"
                            --Snapline
                            esp.Line["Snapline"].Visible = newtable.Snaplines
                            esp.Line["Snapline"].From = Vector2.new(dwCamera.ViewportSize.X/2, 120)
                            esp.Line["Snapline"].To = Vector2.new(math.floor(rootPos.X), math.floor(rootPos.Y))
                            esp.Line["SnapOutline"].Visible = esp.Line["Snapline"].Visible
                            esp.Line["SnapOutline"].From = esp.Line["Snapline"].From
                            esp.Line["SnapOutline"].Thickness = 3
                            esp.Line["SnapOutline"].To = esp.Line["Snapline"].To
                            changedrawingcolor(newtable.TeamColor)
                        else
                            toggledrawing(false)
                        end
                    else
                        toggledrawing(false)
                    end
                wait(0.9)
            else
                toggledrawing(false)
            end
        end)
    end
    if playerammount == nil then
        for i = 1, game.Players.MaxPlayers do
            create_player(i) --creates new drawing group and caches it to be used again
        end
    else
        for i = 1, playerammount do
            create_player(i) --creates new drawing group and caches it to be used again
        end
    end
end
function visual_module:drawitem(model, name, table, debug)
    debug = debug or false
    local newtable = {};
    local esp = {
        Text = {Distance = Drawing.new("Text"), Name = Drawing.new("Text")},
        Line = {SnapOutline = Drawing.new("Line") ,Snapline = Drawing.new("Line")}
    };

    for index, v in pairs(esp.Line) do
        v.From = Vector2.new(20, 20); -- origin
        v.To = Vector2.new(50, 50); -- destination
        v.Color = Color3.new(0,0,0);
        v.Thickness = 1;
        v.Transparency = 0.9;
        v.Visible = false
    end

    for index, v in pairs(esp.Text) do
        v.Text = ""
        v.Color = Color3.new(1, 1, 1)
        v.OutlineColor = Color3.new(0, 0, 0)
        v.Center = true
        v.Outline = true
        v.Position = Vector2.new(100, 100)
        v.Size = 15
        v.Font = 1 -- 'UI', 'System', 'Plex', 'Monospace'
        v.Transparency = 0.9
        v.Visible = false
    end

    local function toggledrawing(value)
        for index, v in pairs(esp.Text) do
            v.Visible = value
        end
        for index, v in pairs(esp.Line) do
            v.Visible = value
        end
    end

    local function changedrawingcolor(color)
        for i,v in pairs(esp.Text) do
            v.Color = color
        end
        for i,v in pairs(esp.Line) do
            if i ~= "SnapOutline" then
                v.Color = color
            end
        end
    end

    local orientation, sizee
    local width
    local height
    local size
    local rootPos
    local magnitude

    if debug then
        print("DEBUG: Loaded")
    end

    task.spawn(function()
        if debug then
            print("DEBUG: Loop created")
        end
        while task.wait() do
            newtable = {
                Enabled = table.Enabled,
                Name = table.Name,
                Snaplines = table.Snaplines,
                Distance = table.Distance,
                ShowDistance = table.ShowDistance,
                Color = table.Color,
            };
            if model ~= nil and model ~= nil then
                local displayEsp = model
                if displayEsp then
                    local _,onscreen = dwCamera:WorldToScreenPoint(model.Position)
                    displayEsp = onscreen
                end

                rootPos = dwCamera:WorldToViewportPoint(model.Position)
                magnitude = (model.Position - dwCamera.CFrame.p).Magnitude

                if newtable.Enabled and displayEsp and magnitude < newtable.ShowDistance then
                    --Name
                    esp.Text["Name"].Visible = newtable.Name
                    esp.Text["Name"].Position = Vector2.new(math.floor(rootPos.X), math.floor(rootPos.Y) - 16)
                    esp.Text["Name"].Text = name

                    if debug then
                        print("DEBUG: Position"..tostring(esp.Text["Name"].Position))
                    end

                    --Distance
                    esp.Text["Distance"].Visible = newtable.Distance
                    esp.Text["Distance"].Position = Vector2.new(math.floor(rootPos.X),math.floor(rootPos.Y + 0.5))
                    esp.Text["Distance"].Text = tostring(math.ceil(magnitude)).." studs"

                    --Snapline
                    esp.Line["Snapline"].Visible = newtable.Snaplines
                    esp.Line["Snapline"].From = Vector2.new(dwCamera.ViewportSize.X/2, 120)
                    esp.Line["Snapline"].To = Vector2.new(math.floor(rootPos.X), math.floor(rootPos.Y))
                    esp.Line["SnapOutline"].Visible = esp.Line["Snapline"].Visible
                    esp.Line["SnapOutline"].Thickness = 3
                    esp.Line["SnapOutline"].From = esp.Line["Snapline"].From
                    esp.Line["SnapOutline"].To = esp.Line["Snapline"].To
                    changedrawingcolor(newtable.Color)
                else
                    toggledrawing(false)
                end
            else
                toggledrawing(false)
            end
        end
    end)
end
function visual_module:drawthrowable(model, name, timeleft, table, debug)
    debug = debug or false
    local newtable = {};
    local esp = {
        Text = {Distance = Drawing.new("Text"), Name = Drawing.new("Text")},
    };

    for index, v in pairs(esp.Text) do
        v.Text = ""
        v.Color = Color3.new(1, 1, 1)
        v.OutlineColor = Color3.new(0, 0, 0)
        v.Center = true
        v.Outline = true
        v.Position = Vector2.new(100, 100)
        v.Size = 15
        v.Font = 1 -- 'UI', 'System', 'Plex', 'Monospace'
        v.Transparency = 0.9
        v.Visible = false
    end

    local function toggledrawing(value)
        for index, v in pairs(esp.Text) do
            v.Visible = value
        end
    end

    local function changedrawingcolor(color)
        for i,v in pairs(esp.Text) do
            v.Color = color
        end
    end

    if debug then
        print("DEBUG: Loaded")
    end
    local startTime = os.clock()
    local a, b = 0, 1
    for i = 1, 5000000 do
        a, b = b, a
    end
    local deltaTime
    local blowuptime

    local rootPos
    local magnitude

    task.spawn(function()
        if debug then
            print("DEBUG: Loop created")
        end
        while task.wait() do
        deltaTime = os.clock() - startTime
        --blowuptime =  5 - (tick() - startTime)
            newtable = {
                Enabled = table.Enabled,
                Name = table.Name,
                Distance = table.Distance,
                ShowDistance = table.ShowDistance,
                Color = table.Color,
            };
            if model ~= nil and deltaTime < timeleft then
                local displayEsp = model
                if displayEsp then
                    local _,onscreen = dwCamera:WorldToScreenPoint(model.Position)
                    displayEsp = onscreen
                end

                rootPos = dwCamera:WorldToViewportPoint(model.Position)
                magnitude = (model.Position - dwCamera.CFrame.p).Magnitude

                if newtable.Enabled and displayEsp and magnitude < newtable.ShowDistance then
                    --Name
                    esp.Text["Name"].Visible = newtable.Name
                    esp.Text["Name"].Position = Vector2.new(math.floor(rootPos.X), math.floor(rootPos.Y) - 16)
                    esp.Text["Name"].Text = name

                    if debug then
                        print("DEBUG: Position"..tostring(esp.Text["Name"].Position))
                    end

                    --Distance
                    esp.Text["Distance"].Visible = newtable.Distance
                    esp.Text["Distance"].Position = Vector2.new(math.floor(rootPos.X),math.floor(rootPos.Y + 0.5))
                    esp.Text["Distance"].Text = tostring(math.ceil(magnitude)).." studs"
                    changedrawingcolor(newtable.Color)
                else
                    toggledrawing(false)
                end
            else
                toggledrawing(false)
                break
            end
        end
    end)
end
local Visuals = {
    ['Enabled'] = true,
    ['Box'] = true,
    ['Filledbox'] = false,
    ['Name'] = false,
    ['Snaplines'] = false,
    ['Distance'] = false,
    ['Healthbox'] = false,
    ['ShowTeam'] = true,
    ['Highlight'] = {
        ['Enabled'] = false,
        ['Pulse'] = false,
        ['OutlineOpacity'] = 0.4,
        ['FillOpacity'] = 0.7,
    },
    ['FilledOpacity'] = 0.4,
    ['ShowDistance'] = 1500,
    ['TeamColor'] = Color3.new(0, 255, 0),
    ['EnemyColor'] = Color3.new(255, 0, 0),
};

visual_module:draw_visual(Visuals)
--return visual_module;