-- Services
local Players = game:GetService("Players")
local UserInputService = game:GetService("UserInputService")
local RunService = game:GetService("RunService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local TweenService = game:GetService("TweenService")
local Lighting = game:GetService("Lighting")

-- Variables
local LocalPlayer = Players.LocalPlayer
local Mouse = LocalPlayer:GetMouse()
local Camera = workspace.CurrentCamera

-- GUI Creation
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Parent = game.CoreGui

-- Main Frame
local MainFrame = Instance.new("Frame")
MainFrame.Size = UDim2.new(0, 300, 0, 350)
MainFrame.Position = UDim2.new(0.5, -150, 0.5, -175)
MainFrame.BackgroundColor3 = Color3.new(0.1, 0.1, 0.1)
MainFrame.BorderSizePixel = 0
MainFrame.Active = true
MainFrame.Draggable = true
MainFrame.Parent = ScreenGui

-- Title
local Title = Instance.new("TextLabel")
Title.Size = UDim2.new(1, 0, 0, 30)
Title.BackgroundColor3 = Color3.new(0.2, 0.2, 0.2)
Title.TextColor3 = Color3.new(1, 1, 1)
Title.TextSize = 18
Title.Font = Enum.Font.SourceSansBold
Title.Text = "Roblox Exploit GUI"
Title.Parent = MainFrame

-- Content Frame
local ContentFrame = Instance.new("Frame")
ContentFrame.Size = UDim2.new(1, -20, 1, -40)
ContentFrame.Position = UDim2.new(0, 10, 0, 35)
ContentFrame.BackgroundTransparency = 1
ContentFrame.Parent = MainFrame

-- Categories
local Categories = {"Movement", "Combat", "Visuals", "Player", "World", "Optimization", "Misc", "Settings"}
local CategoryButtons = {}
local CategoryFrames = {}

for i, category in ipairs(Categories) do
    local Button = Instance.new("TextButton")
    Button.Size = UDim2.new(1/#Categories, -5, 0, 25)
    Button.Position = UDim2.new((i-1)/#Categories, 0, 0, 0)
    Button.BackgroundColor3 = Color3.new(0.2, 0.2, 0.2)
    Button.TextColor3 = Color3.new(1, 1, 1)
    Button.TextSize = 14
    Button.Font = Enum.Font.SourceSans
    Button.Text = category
    Button.Parent = ContentFrame
    
    local Frame = Instance.new("Frame")
    Frame.Size = UDim2.new(1, 0, 1, -30)
    Frame.Position = UDim2.new(0, 0, 0, 30)
    Frame.BackgroundTransparency = 1
    Frame.Visible = false
    Frame.Parent = ContentFrame
    
    CategoryButtons[category] = Button
    CategoryFrames[category] = Frame
    
    Button.MouseButton1Click:Connect(function()
        for _, frame in pairs(CategoryFrames) do
            frame.Visible = false
        end
        Frame.Visible = true
    end)
end

-- Functions
local function CreateToggle(parent, text, callback)
    local Toggle = Instance.new("TextButton")
    Toggle.Size = UDim2.new(1, 0, 0, 30)
    Toggle.BackgroundColor3 = Color3.new(0.2, 0.2, 0.2)
    Toggle.TextColor3 = Color3.new(1, 1, 1)
    Toggle.TextSize = 14
    Toggle.Font = Enum.Font.SourceSans
    Toggle.Text = text
    Toggle.Parent = parent
    
    local Enabled = false
    
    Toggle.MouseButton1Click:Connect(function()
        Enabled = not Enabled
        Toggle.BackgroundColor3 = Enabled and Color3.new(0, 0.5, 0) or Color3.new(0.2, 0.2, 0.2)
        callback(Enabled)
    end)
end

local function CreateSlider(parent, text, min, max, default, callback)
    local SliderFrame = Instance.new("Frame")
    SliderFrame.Size = UDim2.new(1, 0, 0, 50)
    SliderFrame.BackgroundTransparency = 1
    SliderFrame.Parent = parent

    local SliderText = Instance.new("TextLabel")
    SliderText.Size = UDim2.new(1, 0, 0, 20)
    SliderText.BackgroundTransparency = 1
    SliderText.Text = text
    SliderText.TextColor3 = Color3.new(1, 1, 1)
    SliderText.TextSize = 14
    SliderText.Font = Enum.Font.SourceSans
    SliderText.Parent = SliderFrame

    local SliderBar = Instance.new("Frame")
    SliderBar.Size = UDim2.new(1, 0, 0, 5)
    SliderBar.Position = UDim2.new(0, 0, 0, 25)
    SliderBar.BackgroundColor3 = Color3.new(0.2, 0.2, 0.2)
    SliderBar.Parent = SliderFrame

    local SliderButton = Instance.new("TextButton")
    SliderButton.Size = UDim2.new(0, 10, 0, 20)
    SliderButton.Position = UDim2.new((default - min) / (max - min), -5, 0, 15)
    SliderButton.Text = ""
    SliderButton.BackgroundColor3 = Color3.new(1, 1, 1)
    SliderButton.Parent = SliderBar

    local dragging = false
    local value = default

    SliderButton.MouseButton1Down:Connect(function()
        dragging = true
    end)

    UserInputService.InputEnded:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 then
            dragging = false
        end
    end)

    SliderBar.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 then
            local relativeX = math.clamp((input.Position.X - SliderBar.AbsolutePosition.X) / SliderBar.AbsoluteSize.X, 0, 1)
            value = min + (max - min) * relativeX
            SliderButton.Position = UDim2.new(relativeX, -5, 0, 15)
            callback(value)
        end
    end)

    RunService.RenderStepped:Connect(function()
        if dragging then
            local relativeX = math.clamp((Mouse.X - SliderBar.AbsolutePosition.X) / SliderBar.AbsoluteSize.X, 0, 1)
            value = min + (max - min) * relativeX
            SliderButton.Position = UDim2.new(relativeX, -5, 0, 15)
            callback(value)
        end
    end)
end

-- Aimbot Variables
local AimbotEnabled = false
local AimbotKey = Enum.KeyCode.E
local FOVRadius = 50 -- Reduced FOV radius

-- Aimbot Functions
local function DrawFOVCircle()
    local Circle = Drawing.new("Circle")
    Circle.Visible = false
    Circle.Radius = FOVRadius
    Circle.Color = Color3.new(1, 1, 1)
    Circle.Thickness = 1
    Circle.Filled = false
    Circle.Transparency = 1
    Circle.NumSides = 50
    Circle.Position = Vector2.new(Camera.ViewportSize.X / 2, Camera.ViewportSize.Y / 2)
    
    RunService.RenderStepped:Connect(function()
        Circle.Visible = AimbotEnabled
    end)
    
    return Circle
end

local FOVCircle = DrawFOVCircle()

local function IsWithinFOV(part)
    local pos = Camera:WorldToViewportPoint(part.Position)
    local center = Vector2.new(Camera.ViewportSize.X / 2, Camera.ViewportSize.Y / 2)
    return (Vector2.new(pos.X, pos.Y) - center).Magnitude <= FOVRadius
end

local function IsPartVisible(part)
    local character = LocalPlayer.Character
    local origin = character and character:FindFirstChild("Head")
    if not origin then return false end
    
    local direction = (part.Position - origin.Position).Unit
    local rayParams = RaycastParams.new()
    rayParams.FilterDescendantsInstances = {character}
    rayParams.FilterType = Enum.RaycastFilterType.Blacklist
    
    local result = workspace:Raycast(origin.Position, direction * 1000, rayParams)
    return result and result.Instance:IsDescendantOf(part.Parent)
end

local function GetVisibleBodyPart(character)
    local bodyParts = {"Head", "Torso", "UpperTorso", "LowerTorso", "HumanoidRootPart"}
    for _, partName in ipairs(bodyParts) do
        local part = character:FindFirstChild(partName)
        if part and IsPartVisible(part) and IsWithinFOV(part) then
            return part
        end
    end
    return nil
end

local function GetClosestPlayer()
    local closestPlayer = nil
    local shortestDistance = math.huge

    for _, player in pairs(Players:GetPlayers()) do
        if player ~= LocalPlayer and player.Character and player.Character:FindFirstChild("Humanoid") and player.Character.Humanoid.Health > 0 then
            local visiblePart = GetVisibleBodyPart(player.Character)
            if visiblePart then
                local pos = Camera:WorldToViewportPoint(visiblePart.Position)
                local magnitude = (Vector2.new(pos.X, pos.Y) - Vector2.new(Mouse.X, Mouse.Y)).Magnitude
                if magnitude < shortestDistance then
                    closestPlayer = player
                    shortestDistance = magnitude
                end
            end
        end
    end

    return closestPlayer
end

-- Aimbot Logic
RunService.RenderStepped:Connect(function()
    if AimbotEnabled and UserInputService:IsKeyDown(AimbotKey) then
        local target = GetClosestPlayer()
        if target and target.Character then
            local aimPart = GetVisibleBodyPart(target.Character)
            if aimPart then
                local pos = Camera:WorldToViewportPoint(aimPart.Position)
                mousemoverel(pos.X - Mouse.X, pos.Y - Mouse.Y)
            end
        end
    end
end)

-- ESP Functions
local ESPEnabled = false
local ESPSettings = {
    BoxesEnabled = false,
    NamesEnabled = false,
    DistanceEnabled = false,
    TeamCheckEnabled = false,
    BoxColor = Color3.new(1, 0, 0),
    NameColor = Color3.new(1, 1, 1),
    DistanceColor = Color3.new(1, 1, 0)
}

local function CreateESPPart(part, settings)
    local Box = Drawing.new("Square")
    Box.Visible = false
    Box.Color = settings.BoxColor
    Box.Thickness = 1
    Box.Transparency = 1
    Box.Filled = false

    local Name = Drawing.new("Text")
    Name.Visible = false
    Name.Color = settings.NameColor
    Name.Size = 18
    Name.Center = true
    Name.Outline = true

    local Distance = Drawing.new("Text")
    Distance.Visible = false
    Distance.Color = settings.DistanceColor
    Distance.Size = 16
    Distance.Center = true
    Distance.Outline = true

    RunService.RenderStepped:Connect(function()
        if not ESPEnabled or not part or not part:IsDescendantOf(workspace) then
            Box.Visible = false
            Name.Visible = false
            Distance.Visible = false
            return
        end

        local pos, onScreen = Camera:WorldToViewportPoint(part.Position)
        if not onScreen then
            Box.Visible = false
            Name.Visible = false
            Distance.Visible = false
            return
        end

        local size = part.Size * Vector3.new(1, 1.5, 0)
        local height = (Camera.CFrame - Camera.CFrame.Position) * Vector3.new(0, size.Y/2, 0)
        local width = (Camera.CFrame - Camera.CFrame.Position) * Vector3.new(size.X/2, 0, 0)
        
        local topleft = Camera:WorldToViewportPoint((part.CFrame * CFrame.new(-size.X/2, size.Y/2, 0)).Position)
        local topright = Camera:WorldToViewportPoint((part.CFrame * CFrame.new(size.X/2, size.Y/2, 0)).Position)
        local bottomleft = Camera:WorldToViewportPoint((part.CFrame * CFrame.new(-size.X/2, -size.Y/2, 0)).Position)
        local bottomright = Camera:WorldToViewportPoint((part.CFrame * CFrame.new(size.X/2, -size.Y/2, 0)).Position)

        Box.PointA = Vector2.new(topleft.X, topleft.Y)
        Box.PointB = Vector2.new(topright.X, topright.Y)
        Box.PointC = Vector2.new(bottomright.X, bottomright.Y)
        Box.PointD = Vector2.new(bottomleft.X, bottomleft.Y)
        Box.Visible = settings.BoxesEnabled

        Name.Position = Vector2.new(pos.X, pos.Y - size.Y * 0.5 - 20)
        Name.Visible = settings.NamesEnabled

        Distance.Position = Vector2.new(pos.X, pos.Y + size.Y * 0.5 + 20)
        Distance.Visible = settings.DistanceEnabled

        local player = Players:GetPlayerFromCharacter(part.Parent)
        if player then
            Name.Text = player.Name
            Distance.Text = math.floor((LocalPlayer.Character.HumanoidRootPart.Position - part.Position).Magnitude) .. " studs"
            
            if settings.TeamCheckEnabled and player.Team == LocalPlayer.Team then
                Box.Visible = false
                Name.Visible = false
                Distance.Visible = false
            end
        end
    end)
end

-- Movement Functions
local SpeedEnabled = false
local SpeedMultiplier = 2

local function EnableSpeed()
    if not SpeedEnabled then return end
    local character = LocalPlayer.Character
    if not character then return end
    local humanoid = character:FindFirstChildOfClass("Humanoid")
    if not humanoid then return end
    humanoid.WalkSpeed = 16 * SpeedMultiplier
end

local function DisableSpeed()
    local character = LocalPlayer.Character
    if not character then return end
    local humanoid = character:FindFirstChildOfClass("Humanoid")
    if not humanoid then return end
    humanoid.WalkSpeed = 16
end

RunService.Stepped:Connect(function()
    if SpeedEnabled then
        EnableSpeed()
    else
        DisableSpeed()
    end
end)

-- Fly Function
local FlyEnabled = false
local FlySpeed = 50

local function ToggleFly()
    FlyEnabled = not FlyEnabled
    local character = LocalPlayer.Character
    if not character then return end
    local humanoid = character:FindFirstChildOfClass("Humanoid")
    if not humanoid then return end
    
    if FlyEnabled then
        local bodyVelocity = Instance.new("BodyVelocity")
        bodyVelocity.Velocity = Vector3.new(0, 0, 0)
        bodyVelocity.MaxForce = Vector3.new(math.huge, math.huge, math.huge)
        bodyVelocity.Parent = character.HumanoidRootPart
        bodyVelocity.Name = "FlyVelocity"
        
        RunService:BindToRenderStep("Fly", Enum.RenderPriority.Character.Value, function()
            local camera = workspace.CurrentCamera
            local moveDirection = character.Humanoid.MoveDirection
            
            local lookVector = camera.CFrame.LookVector
            local rightVector = camera.CFrame.RightVector
            
            local flyVector = (lookVector * moveDirection.Z + rightVector * moveDirection.X).Unit
            bodyVelocity.Velocity = flyVector * FlySpeed
        end)
    else
        RunService:UnbindFromRenderStep("Fly")
        local bodyVelocity = character.HumanoidRootPart:FindFirstChild("FlyVelocity")
        if bodyVelocity then
            bodyVelocity:Destroy()
        end
    end
end

-- GUI Elements
CreateToggle(CategoryFrames["Movement"], "Speed Hack", function(enabled)
    SpeedEnabled = enabled
end)

CreateSlider(CategoryFrames["Movement"], "Speed Multiplier", 1, 10, 2, function(value)
    SpeedMultiplier = value
end)

CreateToggle(CategoryFrames["Movement"], "Fly", function(enabled)
    ToggleFly()
end)

CreateSlider(CategoryFrames["Movement"], "Fly Speed", 1, 100, 50, function(value)
    FlySpeed = value
end)

CreateToggle(CategoryFrames["Combat"], "Aimbot", function(enabled)
    AimbotEnabled = enabled
end)

CreateToggle(CategoryFrames["Visuals"], "ESP", function(enabled)
    ESPEnabled = enabled
    for _, player in pairs(Players:GetPlayers()) do
        if player ~= LocalPlayer and player.Character then
            CreateESPPart(player.Character.HumanoidRootPart, ESPSettings)
        end
    end
end)

CreateToggle(CategoryFrames["Visuals"], "ESP Boxes", function(enabled)
    ESPSettings.BoxesEnabled = enabled
end)

CreateToggle(CategoryFrames["Visuals"], "ESP Names", function(enabled)
    ESPSettings.NamesEnabled = enabled
end)

CreateToggle(CategoryFrames["Visuals"], "ESP Distance", function(enabled)
    ESPSettings.DistanceEnabled = enabled
end)

CreateToggle(CategoryFrames["Visuals"], "ESP Team Check", function(enabled)
    ESPSettings.TeamCheckEnabled = enabled
end)

-- Language Support
local Languages = {
    ["English"] = {
        Movement = "Movement",
        Combat = "Combat",
        Visuals = "Visuals",
        Player = "Player",
        World = "World",
        Optimization = "Optimization",
        Misc = "Misc",
        Settings = "Settings",
        Aimbot = "Aimbot",
        ESP = "ESP",
        ["Speed Hack"] = "Speed Hack",
        ["Speed Multiplier"] = "Speed Multiplier",
        Fly = "Fly",
        ["Fly Speed"] = "Fly Speed",
        ["ESP Boxes"] = "ESP Boxes",
        ["ESP Names"] = "ESP Names",
        ["ESP Distance"] = "ESP Distance",
        ["ESP Team Check"] = "ESP Team Check",
    },
    ["Español"] = {
        Movement = "Movimiento",
        Combat = "Combate",
        Visuals = "Visuales",
        Player = "Jugador",
        World = "Mundo",
        Optimization = "Optimización",
        Misc = "Varios",
        Settings = "Ajustes",
        Aimbot = "Puntería automática",
        ESP = "ESP",
        ["Speed Hack"] = "Hack de velocidad",
        ["Speed Multiplier"] = "Multiplicador de velocidad",
        Fly = "Volar",
        ["Fly Speed"] = "Velocidad de vuelo",
        ["ESP Boxes"] = "Cajas ESP",
        ["ESP Names"] = "Nombres ESP",
        ["ESP Distance"] = "Distancia ESP",
        ["ESP Team Check"] = "Comprobación de equipo ESP",
    },
}

local function UpdateLanguage(lang)
    local texts = Languages[lang]
    for category, button in pairs(CategoryButtons) do
        button.Text = texts[category] or category
    end
    for _, frame in pairs(CategoryFrames) do
        for _, child in pairs(frame:GetChildren()) do
            if child:IsA("TextButton") or child:IsA("TextLabel") then
                child.Text = texts[child.Text] or child.Text
            end
        end
    end
    Title.Text = lang == "English" and "Roblox Exploit GUI" or "GUI de Exploit para Roblox"
end

-- Language Dropdown
local LanguageDropdown = Instance.new("TextButton")
LanguageDropdown.Size = UDim2.new(0, 100, 0, 30)
LanguageDropdown.Position = UDim2.new(1, -110, 0, 5)
LanguageDropdown.BackgroundColor3 = Color3.new(0.2, 0.2, 0.2)
LanguageDropdown.TextColor3 = Color3.new(1, 1, 1)
LanguageDropdown.TextSize = 14
LanguageDropdown.Font = Enum.Font.SourceSans
LanguageDropdown.Text = "English"
LanguageDropdown.Parent = MainFrame

LanguageDropdown.MouseButton1Click:Connect(function()
    local newLang = LanguageDropdown.Text == "English" and "Español" or "English"
    LanguageDropdown.Text = newLang
    UpdateLanguage(newLang)
end)

-- Initial language setup
UpdateLanguage("English")

-- Player Joined/Left Connections
Players.PlayerAdded:Connect(function(player)
    if player.Character then
        CreateESPPart(player.Character.HumanoidRootPart, ESPSettings)
    end
    player.CharacterAdded:Connect(function(character)
        CreateESPPart(character.WaitForChild("HumanoidRootPart"), ESPSettings)
    end)
end)

Players.PlayerRemoving:Connect(function(player)
    -- Clean up ESP for removed player if necessary
end)

-- Warning Message
warn("This script is for educational purposes only. Using exploits in Roblox games may result in your account being banned. Use at your own risk.")

