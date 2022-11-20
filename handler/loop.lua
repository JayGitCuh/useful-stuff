local module = {}
function module:doRenderstep(callback)
    local c
    c = game:GetService("RunService").RenderStepped:Connect(callback);
    local step = {}
    function step:Remove()
        c:Disconnect();
    end
    return step;
end
function module:doLoop(callback)
    local loop = {}
    local toggle = false
    function loop:Remove()
        toggle = true
    end
    while task.wait() do
        pcall(callback)
        if toggle then
            break
        end
    end
    return loop
end
return module;
