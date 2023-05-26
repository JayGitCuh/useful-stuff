--repeat task.wait() until game:IsLoaded()
-- Localization
local fromRGB = Color3.fromRGB
local newUDim2 = UDim2.new
local newVector2 = Vector2.new
local newDrawing = Drawing.new
local newInstance = Instance.new
local remove = table.remove
local spawn = task.spawn
local genv = getgenv()
local getupvalue = debug.getupvalue
local Camera = workspace.CurrentCamera;
local ToScreen = Camera.WorldToViewportPoint;
local nVector3 = Vector3.new;
local nVector2 = Vector2.new;
local nDrawing = Drawing.new;
local nColor   = Color3.fromRGB;
local nCFrame = CFrame.new;
local nCFAngles = CFrame.Angles;
local rad = math.rad;
local pi = math.pi;
local round = math.round;
local Insert = table.insert;
local Char = string.char;
local Random = math.random;
local Seed = math.randomseed;
local Time = os.time;
--
local Signal={}local Connection={}Signal.__index=Signal;Connection.__index=Connection;function Connection.new(signal,callback)local connection=signal._signal:Connect(callback)signal._count+=1;signal.Active=true;return setmetatable({Connected=true,_signal=signal,_connection=connection},Connection)end;function Connection:Disconnect()self._connection:Disconnect()self.Connected=false;self._signal._count-=1;self._signal.Active=self._signal._count>0 end;function Signal.new()local bindableEvent=newInstance("BindableEvent")return setmetatable({Active=false,_bindableEvent=bindableEvent,_signal=bindableEvent.Event,_count=0},Signal)end;function Signal:OnConnect(callback)self._onConnect=callback end;function Signal:Fire(...)self._bindableEvent:Fire(...)end;function Signal:Connect(callback)if self._onConnect then self._onConnect()end;return Connection.new(self,callback)end;function Signal:Wait()return self._signal:Wait()end;function Signal:Destroy()self._bindableEvent:Destroy()self.Active=false;setmetatable(self,nil)end;Signal.DisconnectAll=Signal.Destroy;Signal.Disconnect=Signal.Destroy
local List={}do List.__index=List;function List.new(object,padding)return setmetatable({_contentSize=0,_padding=padding,_positions={},_object=object,_objects={},_indexes={},_sizes={}},List)end;function List:AddObject(object)local size=object.AbsoluteSize.Y;local idx=#self._objects+1;local padding=#self._objects*self._padding;local position=self._contentSize;if object.Parent~=self._object then object.Parent=self._object end;object.Position=newUDim2(0,0,0,position)self._objects[idx]=object;self._positions[object]=position;self._indexes[object]=idx;self._sizes[object]=size;self._contentSize+=size+self._padding end;function List:RemoveObject(object)local size=self._sizes[object]+self._padding;local idx=self._indexes[object]for i,obj in next,self._objects do if i>idx then self._indexes[obj]-=1;self._positions[obj]-=size;obj.Position=newUDim2(0,0,0,self._positions[obj])end end;remove(self._objects,idx)self._contentSize-=size end;function List:UpdateObject(object)local diff=object.AbsoluteSize.Y-self._sizes[object]local idx=self._indexes[object]for i,obj in next,self._objects do if i>idx then self._positions[obj]+=diff;obj.Position=newUDim2(0,0,0,self._positions[obj])end end;self._sizes[object]+=diff;self._contentSize+=diff end end
local Tween={}do Tween.__index=Tween;local render=game:GetService("RunService").RenderStepped;local sqrt,sin,pi,halfpi,doublepi=math.sqrt,math.sin,math.pi,math.pi/2,math.pi*2;local type=type;local wait=task.wait;local s=1.70158;local s1=2.5949095;local p=0.3;local p1=0.45;local EasingStyle={[Enum.EasingStyle.Linear]={[Enum.EasingDirection.In]=function(delta)return delta end,[Enum.EasingDirection.Out]=function(delta)return delta end,[Enum.EasingDirection.InOut]=function(delta)return delta end},[Enum.EasingStyle.Cubic]={[Enum.EasingDirection.In]=function(delta)return delta^3 end,[Enum.EasingDirection.Out]=function(delta)return(delta-1)^3+1 end,[Enum.EasingDirection.InOut]=function(delta)if delta<=0.5 then return(4*delta)^3 else return(4*(delta-1))^3+1 end end},[Enum.EasingStyle.Quad]={[Enum.EasingDirection.In]=function(delta)return delta^2 end,[Enum.EasingDirection.Out]=function(delta)return-(delta-1)^2+1 end,[Enum.EasingDirection.InOut]=function(delta)if delta<=0.5 then return(2*delta)^2 else return(-2*(delta-1))^2+1 end end},[Enum.EasingStyle.Quart]={[Enum.EasingDirection.In]=function(delta)return delta^4 end,[Enum.EasingDirection.Out]=function(delta)return-(delta-1)^4+1 end,[Enum.EasingDirection.InOut]=function(delta)if delta<=0.5 then return(8*delta)^4 else return(-8*(delta-1))^4+1 end end},[Enum.EasingStyle.Quint]={[Enum.EasingDirection.In]=function(delta)return delta^5 end,[Enum.EasingDirection.Out]=function(delta)return(delta-1)^5+1 end,[Enum.EasingDirection.InOut]=function(delta)if delta<=0.5 then return(16*delta)^5 else return(16*(delta-1))^5+1 end end},[Enum.EasingStyle.Sine]={[Enum.EasingDirection.In]=function(delta)return sin(halfpi*delta-halfpi)end,[Enum.EasingDirection.Out]=function(delta)return sin(halfpi*delta)end,[Enum.EasingDirection.InOut]=function(delta)return 0.5*sin(pi*delta-pi/2)+0.5 end},[Enum.EasingStyle.Exponential]={[Enum.EasingDirection.In]=function(delta)return 2^(10*delta-10)-0.001 end,[Enum.EasingDirection.Out]=function(delta)return 1.001*-2^(-10*delta)+1 end,[Enum.EasingDirection.InOut]=function(delta)if delta<=0.5 then return 0.5*2^(20*delta-10)-0.0005 else return 0.50025*-2^(-20*delta+10)+1 end end},[Enum.EasingStyle.Back]={[Enum.EasingDirection.In]=function(delta)return delta^2*(delta*(s+1)-s)end,[Enum.EasingDirection.Out]=function(delta)return(delta-1)^2*((delta-1)*(s+1)+s)+1 end,[Enum.EasingDirection.InOut]=function(delta)if delta<=0.5 then return(2*delta*delta)*((2*delta)*(s1+1)-s1)else return 0.5*((delta*2)-2)^2*((delta*2-2)*(s1+1)+s1)+1 end end},[Enum.EasingStyle.Bounce]={[Enum.EasingDirection.In]=function(delta)if delta<=0.25/2.75 then return-7.5625*(1-delta-2.625/2.75)^2+0.015625 elseif delta<=0.75/2.75 then return-7.5625*(1-delta-2.25/2.75)^2+0.0625 elseif delta<=1.75/2.75 then return-7.5625*(1-delta-1.5/2.75)^2+0.25 else return 1-7.5625*(1-delta)^2 end end,[Enum.EasingDirection.Out]=function(delta)if delta<=1/2.75 then return 7.5625*(delta*delta)elseif delta<=2/2.75 then return 7.5625*(delta-1.5/2.75)^2+0.75 elseif delta<=2.5/2.75 then return 7.5625*(delta-2.25/2.75)^2+0.9375 else return 7.5625*(delta-2.625/2.75)^2+0.984375 end end,[Enum.EasingDirection.InOut]=function(delta)if delta<=0.125/2.75 then return 0.5*(-7.5625*(1-delta*2-2.625/2.75)^2+0.015625)elseif delta<=0.375/2.75 then return 0.5*(-7.5625*(1-delta*2-2.25/2.75)^2+0.0625)elseif delta<=0.875/2.75 then return 0.5*(-7.5625*(1-delta*2-1.5/2.75)^2+0.25)elseif delta<=0.5 then return 0.5*(1-7.5625*(1-delta*2)^2)elseif delta<=1.875/2.75 then return 0.5+3.78125*(2*delta-1)^2 elseif delta<=2.375/2.75 then return 3.78125*(2*delta-4.25/2.75)^2+0.875 elseif delta<=2.625/2.75 then return 3.78125*(2*delta-5/2.75)^2+0.96875 else return 3.78125*(2*delta-5.375/2.75)^2+0.9921875 end end},[Enum.EasingStyle.Elastic]={[Enum.EasingDirection.In]=function(delta)return-2^(10*(delta-1))*sin(doublepi*(delta-1-p/4)/p)end,[Enum.EasingDirection.Out]=function(delta)return 2^(-10*delta)*sin(doublepi*(delta-p/4)/p)+1 end,[Enum.EasingDirection.InOut]=function(delta)if delta<=0.5 then return-0.5*2^(20*delta-10)*sin(doublepi*(delta*2-1.1125)/p1)else return 0.5*2^(-20*delta+10)*sin(doublepi*(delta*2-1.1125)/p1)+1 end end},[Enum.EasingStyle.Circular]={[Enum.EasingDirection.In]=function(delta)return-sqrt(1-delta^2)+1 end,[Enum.EasingDirection.Out]=function(delta)return sqrt(-(delta-1)^2+1)end,[Enum.EasingDirection.InOut]=function(delta)if delta<=0.5 then return-sqrt(-delta^2+0.25)+0.5 else return sqrt(-(delta-1)^2+0.25)+0.5 end end}}local function lerp(value1,value2,alpha)if type(value1)=="number"then return value1+((value2-value1)*alpha)end;return value1:lerp(value2,alpha)end;function Tween.new(object,info,properties)return setmetatable({Completed=Signal.new(),_object=object,_time=info.Time,_easing=EasingStyle[info.EasingStyle][info.EasingDirection],_properties=properties},Tween)end;function Tween:Play()for property,value in next,self._properties do local start_value=self._object[property]spawn(function()local elapsed=0;while elapsed<=self._time and not self._cancelled do local delta=elapsed/self._time;local alpha=self._easing(delta)spawn(function()self._object[property]=lerp(start_value,value,alpha)end)elapsed+=render:Wait()end;if not self._cancelled then self._object[property]=value end end)end;spawn(function()wait(self._time)if not self._cancelled then self.Completed:Fire()end end)end;function Tween:Cancel()self._cancelled=true end end
-- Library
genv.render_cache = render_cache or {}
genv.clear_renders = clear_renders or function()
    for _, render in next, render_cache do
        render:Destroy(true)
    end
    genv.render_cache = {}
end
local services = setmetatable({}, {
    __index = function(self, key)
        if not rawget(self, key) then
            local service = game:GetService(key)
            rawset(self, service, service)

            return service
        end
        return rawget(self, key)
    end
})
local is_synX = islclosure(newDrawing)
local line_mt = is_synX and getupvalue(newDrawing, 4)
local newrender = is_synX and getupvalue(newDrawing, 1) or newDrawing
local destroy = is_synX and getupvalue(line_mt.__index, 3) or function(drawing)
    drawing:Remove()
end
local setproperty = is_synX and getupvalue(line_mt.__newindex, 4) or function(object, property, value)
    object[property] = value
end
local getproperty = is_synX and getupvalue(line_mt.__index, 4) or function(object, property)  
    return object[property]
end
local function round_position(position)
    return newVector2(math.floor(position.X), math.floor(position.Y));
end
local function queue_property_set(object, property, value)
    if object.AbsoluteVisible then
        setproperty(object._render, property, value)
    else
        object._queue[property] = value
    end
end
local Render = {Fonts = Drawing.Fonts, ZIndex = 1000000}
local classes = {
    Text = {
        Parent = {nil, "table", "nil"},
        Visible = {true, "boolean"},
        ZIndex = {1, "number"},
        Transparency = {1, "number"},
        Ignored = {true, "boolean"},
        Color = {fromRGB(255, 255, 255), "Color3"},
        Text = {"Text", "string"},
        Font = {Render.Fonts.Plex, "number"},
        Center = {false, "boolean"},
        Size = {13, "number"},
        Outline = {true, "boolean"},
        OutlineColor = {fromRGB(0, 0, 0), "Color3"},
        Position = {newUDim2(0, 0, 0, 0), "UDim2"},
    },
    Image = {
        Parent = {nil, "table", "nil"},
        Visible = {true, "boolean"},
        ZIndex = {1, "number"},
        Transparency = {1, "number"},
        Ignored = {false, "boolean"},
        Data = {"", "string"},
        OutlineColor = {fromRGB(0, 0, 0), "Color3"},
        Outline = {false, "boolean"},
        Size = {newUDim2(0, 100, 0, 100), "UDim2"},
        Position = {newUDim2(0, 0, 0, 0), "UDim2"}
    },
    Square = {
        Parent = {nil, "table", "nil"},
        Visible = {true, "boolean"},
        ZIndex = {1, "number"},
        Transparency = {1, "number"},
        Ignored = {false, "boolean"},
        Color = {fromRGB(255, 255, 255), "Color3"},
        Size = {newUDim2(0, 100, 0, 100), "UDim2"},
        Position = {newUDim2(0, 0, 0, 0), "UDim2"},
        OutlineColor = {fromRGB(0, 0, 0), "Color3"},
        Outline = {false, "boolean"},
        Thickness = {1, "number"},
        Filled = {true, "boolean"}
    }
};
local objects = {}
local function calculate_udim2(position, size)
    local x = size.X * position.X.Scale
    local y = size.Y * position.Y.Scale
    local newposition = newVector2(x + position.X.Offset, y + position.Y.Offset)
    return newposition
end
local function mouse_over(object)
    local posX, posY = object.AbsolutePosition.X, object.AbsolutePosition.Y
    local size = object.AbsoluteSize or object.TextBounds
    local sizeX, sizeY = posX + size.X, posY + size.Y
    local position = services.UserInputService:GetMouseLocation()
    if position.X >= posX and position.Y >= posY and position.X <= sizeX and position.Y <= sizeY then
        return true
    end
    return false
end
local function mouse_over_higher_object(object)
    local position = services.UserInputService:GetMouseLocation()
    for obj, _ in next, objects do
        if obj.AbsoluteVisible and obj.Transparency >= object.Transparency and obj.ZIndex > object.ZIndex then
            local posX, posY = obj.AbsolutePosition.X, obj.AbsolutePosition.Y
            local size = obj.AbsoluteSize or obj.TextBounds
            local sizeX, sizeY = posX + size.X, posY + size.Y
            if position.X >= posX and position.Y >= posY and position.X <= sizeX and position.Y <= sizeY then
                return true
            end
        end
    end
end
Render.MouseOver = mouse_over
Render.MouseOverObject = mouse_over_higher_object
local function count_table(tbl)
    local count = 0
    for _, _ in next, tbl do
        count += 1
    end
    return count
end
local events = {}
local changed_events = {}
services.UserInputService.InputBegan:Connect(function(input, gpe)
    for object, events in next, events do
        if events.MouseButton1Down.Active or events.MouseButton1Click.Active or events.InputEnded.Active or events.InputBegan.Active then
            if object.AbsoluteVisible and mouse_over(object) and not mouse_over_higher_object(object) then
                if events.InputBegan.Active then
                    events._inputBegan[input] = true
                    events.InputBegan:Fire(input, gpe)
                end
                if input.UserInputType == Enum.UserInputType.MouseButton1 then
                    events._mouseDown = true
                    if events.MouseButton1Down.Active then
                        events.MouseButton1Down:Fire()
                    end
                end
            end
        end
    end
end)
local last_update = tick()
services.UserInputService.InputChanged:Connect(function(input, gpe)
    if tick() - last_update > 0.1 then
        last_update = tick()
        for object, events in next, changed_events do
            if events.MouseEnter.Active or events.MouseLeave.Active or events.InputChanged.Active then
                if object.AbsoluteVisible and mouse_over(object) then
                    if not events._mouseEntered and events.MouseEnter.Active then
                        events.MouseEnter:Fire(input)
                    end
                    events._mouseEntered = true
                    if events.InputChanged.Active then
                        events.InputChanged:Fire(input, gpe)
                    end
                elseif events._mouseEntered then
                    events._mouseEntered = false
                    if events.MouseLeave.Active then
                        events.MouseLeave:Fire()
                    end
                end
            end
        end
    end
end)
services.UserInputService.InputEnded:Connect(function(input, gpe)
    for object, events in next, events do
        if events.MouseButton1Up.Active or events.MouseButton1Click.Active or events.InputEnded.Active then
            if events._inputBegan[input] then
                events._inputBegan[input] = false
                if events.InputEnded.Active then
                    events.InputEnded:Fire(input, gpe)
                end
            end
            if object.AbsoluteVisible and mouse_over(object) and not mouse_over_higher_object(object) then
                if input.UserInputType == Enum.UserInputType.MouseButton1 then
                    if events.MouseButton1Up.Active then
                        events.MouseButton1Up:Fire()
                    end
                    if events._mouseDown and events.MouseButton1Click.Active then
                        events.MouseButton1Click:Fire()
                    end
                    events._mouseDown = false
                end
            end
        end
    end
end)
Render.__newindex = function(self, property, value)
    if self._exists then
        local properties = classes[self._class]
        if properties[property] and not properties[property].readonly and (typeof(value) == properties[property][2] or typeof(value) == properties[property][3]) then
            self:Set(property, value)
        end
    end
end
Render.__index = function(self, property)
    return rawget(self, "_properties")[property] == nil and (Render[property] or rawget(self, "_events")[property] or rawget(self, property)) or rawget(self, "_properties")[property]
end
local charset = {};
for i = 48,  57 do Insert(charset, Char(i)) end;
for i = 65,  90 do Insert(charset, Char(i)) end;
for i = 97, 122 do Insert(charset, Char(i)) end;
local function random_string(length)
    Seed(Time());

    if length > 0 then
        return random_string(length - 1) .. charset[Random(1, #charset)];
    else
        return "";
    end;
end;
local function checkCamView(pos)
    return ((pos - Camera.CFrame.Position).Unit):Dot(Camera.CFrame.LookVector) > 0;
end
function Render.new(class)
    if classes[class] then
        local object = {
            _render = newrender(class),
            _children = {},
            _events = {
                MouseButton1Click = Signal.new(),
                MouseButton1Down = Signal.new(),
                MouseButton1Up = Signal.new(),
                MouseEnter = Signal.new(),
                MouseLeave = Signal.new(),
                InputBegan = Signal.new(),
                InputChanged = Signal.new(),
                InputEnded = Signal.new(),
                _mouseEntered = false,
                _mouseDown = false,
                _inputBegan = {}
            },
            _properties = {},
            _cacheIndex = #genv.render_cache + 1,
            _exists = true,
            _queue = {},
            _childrenIndex = nil,
            _class = class,
            _outline = nil,
            _list = nil,
            _listConnection = nil,
            Changed = Signal.new()
        }

        genv.render_cache[object._cacheIndex] = object
        events[object] = object._events

        object._events.MouseEnter:OnConnect(function()
            changed_events[object] = object._events
        end)

        object._events.MouseLeave:OnConnect(function()
            changed_events[object] = object._events
        end)

        object._events.InputChanged:OnConnect(function()
            changed_events[object] = object._events
        end)

        setmetatable(object, Render)
        objects[object] = true

        for property, values in next, classes[class] do
            if not values.readonly then
                object:Set(property, values[1])
            end
        end
        return object
    end
end
function Render:Set(property, value)
    self.Changed:Fire(property)

    if property == "Parent" then
        if self._properties.Parent then
            remove(self.Parent._children, self._childrenIndex)
        end

        if value ~= nil then
            value._children[#value._children + 1] = self
            rawset(self, "_childrenIndex", #value._children)

            if value._list then
                value._list:AddObject(self)
            end
        end
        
        self._properties.Parent = value

        self:Set("Position", self.Position or newUDim2(0, 0, 0, 0))

        if self._class ~= "Text" then
            self:Set("Size", self.Size or newUDim2(0, 100, 0, 100))
        end

        self:Set("Visible", self.Visible == nil and true or self.Visible)
        
        return
    end

    if property == "Position" then
        local new_position

        if self.Parent then
            new_position = self.Parent.AbsolutePosition + calculate_udim2(value, self.Parent.AbsoluteSize)
        else
            new_position = calculate_udim2(value, workspace.CurrentCamera.ViewportSize)
        end

        new_position = round_position(new_position);
        self._properties.Position = value

        if self._outline and self.AbsoluteVisible then
            setproperty(self._outline, "Position", new_position - newVector2(1, 1))
        end

        self._properties.AbsolutePosition = new_position
        queue_property_set(self, "Position", new_position)

        self:UpdateChildren("Position")

        return
    end

    if property == "Size" then
        if typeof(value) == "UDim2" then
            local new_size

            if self.Parent then
                new_size = calculate_udim2(value, self.Parent.AbsoluteSize)
            else
                new_size = calculate_udim2(value, workspace.CurrentCamera.ViewportSize)
            end

            if self._outline and self.AbsoluteVisible then
                setproperty(self._outline, "Size", new_size + newVector2(2, 2))
            end
            
            self._properties.AbsoluteSize = new_size
            self._properties.Size = value

            if self.Parent and self.Parent._list then
                self.Parent._list:UpdateObject(self)
            end

            queue_property_set(self, "Size", new_size)

            self:UpdateChildren("Size")
            self:UpdateChildren("Position")

            return
        else
            self._properties.Size = value

            setproperty(self._render, "Size", value) 
            self._properties.TextBounds = getproperty(self._render, "TextBounds")
    
            return
        end
    end

    if property == "Font" then
        self._properties.Font = value

        setproperty(self._render, "Font", value) 
        self._properties.TextBounds = getproperty(self._render, "TextBounds")

        return
    end

    if property == "Ignored" then
        if value then
            objects[self] = nil
        else
            objects[self] = true
        end

        self._properties.Ignored = value
        return
    end

    if property == "Outline" and self._class ~= "Text" then
        if value then
            rawset(self, "_outline", newrender("Square"))
            setproperty(self._outline, "Visible", self._properties.AbsoluteVisible)
            setproperty(self._outline, "Color", self.OutlineColor or fromRGB(0, 0, 0))
            setproperty(self._outline, "Filled", true)
            setproperty(self._outline, "Size", self.AbsoluteSize + newVector2(2, 2))
            setproperty(self._outline, "Position", self.AbsolutePosition - newVector2(1, 1))
            setproperty(self._outline, "ZIndex", (self.ZIndex or 1) - 1)
        elseif self._outline then
            destroy(self._outline)
            rawset(self, "_outline", nil)
        end

        self._properties.Outline = value
        return
    end

    if property == "OutlineColor" and self._class ~= "Text" then
        if self._outline then
            setproperty(self._outline, "Color", value)
        end

        self._properties.OutlineColor = value
        return
    end

    if property == "Visible" then
        local new_visible

        if self.Parent then
            new_visible = value and self.Parent.AbsoluteVisible or false
        else
            new_visible = value
        end

        if self._outline then
            setproperty(self._outline, "Visible", new_visible)
        end

        self._properties.AbsoluteVisible = new_visible
        self._properties.Visible = value

        self:UpdateChildren("Visible")
        
        if new_visible then
            self:UpdateQueue()
        end

        setproperty(self._render, "Visible", new_visible)

        return
    end

    if property == "Transparency" then
        if value ~= value then
           value = 0 
        end
        
        if self._outline then
            setproperty(self._outline, "Transparency", value)
        end
    end

    if property == "ZIndex" then
        if self._outline and self.AbsoluteVisible then
            setproperty(self._outline, "ZIndex", value + Render.ZIndex - 1)
        end

        self._properties.ZIndex = value
        queue_property_set(self, "ZIndex", value + Render.ZIndex)

        return
    end

    if property == "Text" then
        self._properties.Text = value

        setproperty(self._render, "Text", value)
        self._properties.TextBounds = getproperty(self._render, "TextBounds")

        return
    end

    self._properties[property] = value
    queue_property_set(self, property, value) 
end
function Render:UpdateQueue()
    for property, value in next, self._queue do
        setproperty(self._render, property, value)

        if self._outline and (property == "Position" or property == "Size" or property == "ZIndex") then
            setproperty(self._outline, property, property == "ZIndex" and value - 1 or property == "Size" and value + newVector2(2, 2) or property == "Position" and value - newVector2(1, 1))
        end

        self:UpdateChildren(property)
    end

    self._queue = {}
end
function Render:UpdateChildren(property)
    if property == "Position" then
        for _, child in next, self._children do
            local new_position = round_position(self.AbsolutePosition + calculate_udim2(child.Position, self.AbsoluteSize));
            child._properties.AbsolutePosition = new_position

            queue_property_set(child, "Position", new_position)
            
            if child._outline and self.AbsoluteVisible then
                setproperty(child._outline, "Position", new_position - newVector2(1, 1))
            end

            if child._class ~= "Text" then
                child:UpdateChildren("Position")
            end
        end
    elseif property == "Visible" then
        for _, child in next, self._children do
            local new_visible = child._properties.Visible and self.AbsoluteVisible
            child._properties.AbsoluteVisible = new_visible

            setproperty(child._render, "Visible", new_visible)
                
            if child._outline then
                setproperty(child._outline, "Visible", new_visible)
            end

            if new_visible then
                child:UpdateQueue()
            end

            child:UpdateChildren("Visible")
        end
    elseif property == "Size" then
        for _, child in next, self._children do
            if child._class ~= "Text" then
                local new_size = calculate_udim2(child.Size, self.AbsoluteSize)
                child._properties.AbsoluteSize = new_size

                queue_property_set(child, "Size", new_size)
                
                if child._outline and self.AbsoluteVisible then
                    setproperty(child._outline, "Size", new_size + newVector2(2, 2))
                end

                child:UpdateChildren("Size")
            end
        end
    end
end
function Render:Destroy(from_clear)
    if self._exists then
        rawset(self, "_exists", false)
        destroy(self._render)
        if self._outline then
            destroy(self._outline)
        end
        for _, event in next, self._events do
            if typeof(event) == "table" and event.Destroy then
                event:Destroy()
            end
        end

        if not from_clear then
            remove(genv.render_cache, self._cacheIndex)

            for i, object in next, genv.render_cache do
                if i >= self._cacheIndex then
                    rawset(object, "_cacheIndex", object._cacheIndex - 1)
                end
            end

            local i, child = next(self._children)

            while child do
                remove(self._children, i)
                child:Destroy()
                
                i, child = next(self._children)
            end
        end

        objects[self] = nil

        if events[self] then
            events[self] = nil
        end

        if self.Parent then
            if self.Parent._children[self._childrenIndex] == self then
                remove(self.Parent._children, self._childrenIndex)
            end

            if self.Parent._list and self._class ~= "Text" then
                self.Parent._list:RemoveObject(self)
            end
        end

        if self._listConnection then
            self._listConnection:Disconnect()
        end
    end
end
function Render:GetChildren()
    return self._children
end
function Render:AddList(padding)
    if self._class == "Square" then
        rawset(self, "_list", List.new(self.AbsolutePosition, padding))

        for _, child in next, self._children do
            self._list:AddObject(child)
        end
    end
end
function Render:Tween(info, values)
    if self._currentTween then
        self._currentTween:Cancel()
    end

    local animation = Tween.new(self, info, values)
    animation:Play()

    rawset(self, "_currentTween", animation)

    return animation
end
-- library stuff
local upper = string.upper
local round, clamp, floor = math.round, math.clamp, math.floor
local newInfo = TweenInfo.new
local newColor3, fromHex, fromHSV = Color3.new, Color3.fromHex, Color3.fromHSV
local decode = (syn and syn.crypt.base64.decode) or (crypt and crypt.base64decode) or base64_decode
local unpack, clear, clone, find, concat = table.unpack, table.clear, table.clone, table.find, table.concat
local request = syn and syn.request or request
local inset = services.GuiService:GetGuiInset().Y
local RS = game:GetService("RunService");
local wait = task.wait
function Render:Create(class, properties)
    properties = properties or {}
    local object = Render.new(class)
    if self ~= Render then
        object.Parent = self
    end
    for property, value in next, properties do
        object[property] = value
    end
    return object
end
function Render:MakeCircle()
    local _circle = {
        Visible      = false;
        ZIndex       = 1;
        Transparency = 1;
        Color        = nColor(255, 255, 255);
        Thickness    = 1;
        Position     = nVector3(0,0,0);
        Radius       = 10;
        Rotation     = nVector2(0,0);
    };
    local _defaults = _circle;
    local _lines = {};
    local function makeNewLines(r)
        for l = 1, #_lines do
            _lines[l]:Remove();
        end;
        _lines = {};
        for l = 1, 1.5*r*pi do
            _lines[l] = nDrawing("Line");
        end;
    end;
    -- Update Step Function --
    local previousR = _circle.Radius or _defaults.Radius;
    makeNewLines(previousR);
    function _circle:Update()
        local rot = _circle.Rotation or _defaults.Rotation;
        local pos = _circle.Position or _defaults.Position;
        local _rotCFrame = nCFrame(pos) * nCFAngles(rad(rot.X), 0, rad(rot.Y));
        local _radius = _circle.Radius or _defaults.Radius;
        if previousR ~= _radius then makeNewLines(_radius) end;
        local _increm = 360/#_lines;
        if not _circle.Visible then 
            for ln = 1, #_lines do
                _lines[ln].Visible = false;
            end;
        else
            for l = 1, #_lines do
                if _lines[l] and rawget(_lines[l], "__OBJECT_EXISTS") then
                    _lines[l].Visible      = _circle.Visible      or _defaults.Visible;
                    _lines[l].ZIndex       = _circle.ZIndex       or _defaults.ZIndex;
                    _lines[l].Transparency = _circle.Transparency or _defaults.Transparency;
                    _lines[l].Color        = _circle.Color        or _defaults.Color;
                    _lines[l].Thickness    = _circle.Thickness    or _defaults.Thickness;
                    local p1 = (_rotCFrame * nCFrame(0, 0, -_radius)).p;
                    local _previousPosition, v1 = ToScreen(Camera, p1);
                    _rotCFrame = _rotCFrame * nCFAngles(0, rad(_increm), 0);
                    local p2 = (_rotCFrame * nCFrame(0, 0, -_radius)).p;
                    local _nextPosition, v2 = ToScreen(Camera, p2);
                    if (v1 and v2) or (checkCamView(p1) and checkCamView(p2)) then
                        _lines[l].From = nVector2(_previousPosition.x, _previousPosition.y);
                        _lines[l].To = nVector2(_nextPosition.x, _nextPosition.y);
                    else
                        _lines[l].Visible = false;
                    end;
                end;
            end;
        end;
        previousR = _circle.Radius or _defaults.Radius;
    end;
    --------------------------
    local step_Id = "3D_Circle"..random_string(10);
    RS:BindToRenderStep(step_Id, 1, _circle.Update);
    -- Remove Circle --
    function _circle:Remove()
        RS:UnbindFromRenderStep(step_Id)
        for ln = 1, #_lines do
            _lines[ln]:Remove();
        end;
    end;
    -----------------
    return _circle;
end;
return Render
