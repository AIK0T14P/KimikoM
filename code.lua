-- Services
local Players = game:GetService("Players")
local UserInputService = game:GetService("UserInputService")
local TweenService = game:GetService("TweenService")
local RunService = game:GetService("RunService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Lighting = game:GetService("Lighting")

-- Variables principales
local LocalPlayer = Players.LocalPlayer
local Character = LocalPlayer.Character or LocalPlayer.CharacterAdded:Wait()
local Humanoid = Character:WaitForChild("Humanoid")
local HumanoidRootPart = Character:WaitForChild("HumanoidRootPart")
local Camera = workspace.CurrentCamera

-- Sistema de idiomas
local Languages = {
    ["English"] = {
        categories = {
            Annoy = "Annoy"
        },
        features = {
            SpamChat = "Spam Chat",
            FollowPlayer = "Follow Random Player",
            DanceSpam = "Dance Spam",
            JumpSpam = "Jump Spam",
            SpinAround = "Spin Around",
            RandomTeleport = "Random Teleport",
            LoudSounds = "Loud Sounds",
            SpamEquipTools = "Spam Equip Tools",
            RainbowCharacter = "Rainbow Character",
            SpamRemotes = "Spam Remotes",
            TeleportToPlayer = "Teleport to Player",
            FakeVIP = "Fake VIP",
            InvisibleTroll = "Invisible Troll",
            FakeLag = "Fake Lag",
            SpamBubbles = "Spam Chat Bubbles",
            GlitchCharacter = "Glitch Character",
            FakeKill = "Fake Kill Everyone",
            SpamParticles = "Spam Particles",
            MimicPlayer = "Mimic Player",
            ServerLagger = "Server Lagger"
        },
        loading = "Loading..."
    },
    ["Español"] = {
        categories = {
            Annoy = "Molestar"
        },
        features = {
            SpamChat = "Spam de Chat",
            FollowPlayer = "Seguir Jugador Aleatorio",
            DanceSpam = "Spam de Baile",
            JumpSpam = "Spam de Saltos",
            SpinAround = "Girar Alrededor",
            RandomTeleport = "Teletransporte Aleatorio",
            LoudSounds = "Sonidos Fuertes",
            SpamEquipTools = "Spam de Equipar Herramientas",
            RainbowCharacter = "Personaje Arcoíris",
            SpamRemotes = "Spam de Remotos",
            TeleportToPlayer = "Teletransportarse a Jugador",
            FakeVIP = "VIP Falso",
            InvisibleTroll = "Troll Invisible",
            FakeLag = "Lag Falso",
            SpamBubbles = "Spam de Burbujas de Chat",
            GlitchCharacter = "Personaje Glitcheado",
            FakeKill = "Matar a Todos (Falso)",
            SpamParticles = "Spam de Partículas",
            MimicPlayer = "Imitar Jugador",
            ServerLagger = "Lagear Servidor"
        },
        loading = "Cargando..."
    }
}

local CurrentLanguage = "English"
local Texts = Languages[CurrentLanguage]

-- Crear pantalla de carga
local LoadingGui = Instance.new("ScreenGui")
LoadingGui.Name = "LoadingGui"
LoadingGui.ResetOnSpawn = false
LoadingGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
LoadingGui.Parent = game.CoreGui

local LoadingFrame = Instance.new("Frame")
LoadingFrame.Size = UDim2.new(1, 0, 1, 0)
LoadingFrame.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
LoadingFrame.Parent = LoadingGui

local LoadingBar = Instance.new("Frame")
LoadingBar.Size = UDim2.new(0.4, 0, 0.02, 0)
LoadingBar.Position = UDim2.new(0.3, 0, 0.5, 0)
LoadingBar.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
LoadingBar.BorderSizePixel = 0
LoadingBar.Parent = LoadingFrame

local LoadingFill = Instance.new("Frame")
LoadingFill.Size = UDim2.new(0, 0, 1, 0)
LoadingFill.BackgroundColor3 = Color3.fromRGB(147, 112, 219)
LoadingFill.BorderSizePixel = 0
LoadingFill.Parent = LoadingBar

local LoadingText = Instance.new("TextLabel")
LoadingText.Size = UDim2.new(0, 200, 0, 30)
LoadingText.Position = UDim2.new(0.5, -100, 0.45, -15)
LoadingText.BackgroundTransparency = 1
LoadingText.Font = Enum.Font.GothamBold
LoadingText.Text = Texts.loading
LoadingText.TextColor3 = Color3.fromRGB(255, 255, 255)
LoadingText.TextSize = 18
LoadingText.Parent = LoadingFrame

-- Animación de carga
local loadingTween = TweenService:Create(LoadingFill, TweenInfo.new(3), {Size = UDim2.new(1, 0, 1, 0)})
loadingTween:Play()
loadingTween.Completed:Wait()

-- GUI Principal
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "EnhancedGui"
ScreenGui.ResetOnSpawn = false
ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
ScreenGui.Parent = game.CoreGui

-- Botón para mostrar/ocultar
local ToggleButton = Instance.new("ImageButton")
ToggleButton.Size = UDim2.new(0, 40, 0, 40)
ToggleButton.Position = UDim2.new(0, 10, 0.5, -20)
ToggleButton.BackgroundColor3 = Color3.fromRGB(147, 112, 219)
ToggleButton.Image = "rbxassetid://3926305904"
ToggleButton.ImageRectOffset = Vector2.new(764, 244)
ToggleButton.ImageRectSize = Vector2.new(36, 36)
ToggleButton.Parent = ScreenGui

local ToggleCorner = Instance.new("UICorner")
ToggleCorner.CornerRadius = UDim.new(1, 0)
ToggleCorner.Parent = ToggleButton

-- Frame Principal con borde morado y gradiente
local MainBorder = Instance.new("Frame")
MainBorder.Name = "MainBorder"
MainBorder.Size = UDim2.new(0, 610, 0, 410)
MainBorder.Position = UDim2.new(0.5, -305, 0.5, -205)
MainBorder.BackgroundColor3 = Color3.fromRGB(157, 122, 229)
MainBorder.BorderSizePixel = 0
MainBorder.Visible = false
MainBorder.Parent = ScreenGui

-- Añadir gradiente al borde
local UIGradient = Instance.new("UIGradient")
UIGradient.Rotation = 90
UIGradient.Transparency = NumberSequence.new({
    NumberSequenceKeypoint.new(0, 0),
    NumberSequenceKeypoint.new(0.8, 0),
    NumberSequenceKeypoint.new(1, 1)
})
UIGradient.Parent = MainBorder

local MainBorderCorner = Instance.new("UICorner")
MainBorderCorner.CornerRadius = UDim.new(0, 12)
MainBorderCorner.Parent = MainBorder

-- Frame Principal
local MainFrame = Instance.new("Frame")
MainFrame.Name = "MainFrame"
MainFrame.Size = UDim2.new(1, -4, 1, -4)
MainFrame.Position = UDim2.new(0, 2, 0, 2)
MainFrame.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
MainFrame.BackgroundTransparency = 0.1
MainFrame.BorderSizePixel = 0
MainFrame.Parent = MainBorder

local MainCorner = Instance.new("UICorner")
MainCorner.CornerRadius = UDim.new(0, 10)
MainCorner.Parent = MainFrame

-- Título "Kimiko HUD Beta"
local Title = Instance.new("TextLabel")
Title.Size = UDim2.new(1, 0, 0, 40)
Title.Position = UDim2.new(0, 0, 0, 10)
Title.BackgroundTransparency = 1
Title.Font = Enum.Font.GothamBold
Title.Text = "Kimiko HUD Beta"
Title.TextColor3 = Color3.fromRGB(147, 112, 219)
Title.TextSize = 24
Title.Parent = MainFrame

-- Sidebar
local Sidebar = Instance.new("Frame")
Sidebar.Name = "Sidebar"
Sidebar.Size = UDim2.new(0, 150, 1, -50)
Sidebar.Position = UDim2.new(0, 0, 0, 50)
Sidebar.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
Sidebar.BackgroundTransparency = 0.1
Sidebar.BorderSizePixel = 0
Sidebar.Parent = MainFrame

-- Contenedor principal
local ContentFrame = Instance.new("Frame")
ContentFrame.Name = "ContentFrame"
ContentFrame.Size = UDim2.new(1, -150, 1, -50)
ContentFrame.Position = UDim2.new(0, 150, 0, 50)
ContentFrame.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
ContentFrame.BackgroundTransparency = 0.1
ContentFrame.BorderSizePixel = 0
ContentFrame.Parent = MainFrame

-- Función para crear categorías en el sidebar
local function CreateCategory(name, icon, position)
    local CategoryButton = Instance.new("TextButton")
    CategoryButton.Name = name.."Category"
    CategoryButton.Size = UDim2.new(1, -20, 0, 40)
    CategoryButton.Position = UDim2.new(0, 10, 0, position + 20)
    CategoryButton.BackgroundColor3 = Color3.fromRGB(45, 45, 45)
    CategoryButton.BorderSizePixel = 0
    CategoryButton.Font = Enum.Font.GothamSemibold
    CategoryButton.TextSize = 14
    CategoryButton.Parent = Sidebar
    
    local IconImage = Instance.new("ImageLabel")
    IconImage.Size = UDim2.new(0, 20, 0, 20)
    IconImage.Position = UDim2.new(0, 2, 0.5, -10)
    IconImage.BackgroundTransparency = 1
    IconImage.Image = icon
    IconImage.Parent = CategoryButton
    
    CategoryButton.Text = Texts.categories[name]
    CategoryButton.TextXAlignment = Enum.TextXAlignment.Left
    CategoryButton.TextColor3 = Color3.fromRGB(255, 255, 255)
    CategoryButton.AutoButtonColor = false
    
    local TextPadding = Instance.new("UIPadding")
    TextPadding.PaddingLeft = UDim.new(0, 25)
    TextPadding.Parent = CategoryButton
    
    local Corner = Instance.new("UICorner")
    Corner.CornerRadius = UDim.new(0, 6)
    Corner.Parent = CategoryButton
    
    return CategoryButton
end

-- Función para crear secciones de contenido
local function CreateSection(name)
    local Section = Instance.new("ScrollingFrame")
    Section.Name = name.."Section"
    Section.Size = UDim2.new(1, -40, 1, -20)
    Section.Position = UDim2.new(0, 20, 0, 10)
    Section.BackgroundTransparency = 1
    Section.BorderSizePixel = 0
    Section.ScrollBarThickness = 4
    Section.ScrollBarImageColor3 = Color3.fromRGB(147, 112, 219)
    Section.Visible = false
    Section.Parent = ContentFrame
    
    local UIListLayout = Instance.new("UIListLayout")
    UIListLayout.SortOrder = Enum.SortOrder.LayoutOrder
    UIListLayout.Padding = UDim.new(0, 10)
    UIListLayout.Parent = Section
    
    return Section
end

-- Función para crear botones de toggle
local function CreateToggle(name, section, callback)
    local ToggleFrame = Instance.new("Frame")
    ToggleFrame.Size = UDim2.new(1, 0, 0, 40)
    ToggleFrame.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
    ToggleFrame.Parent = section
    
    local Corner = Instance.new("UICorner")
    Corner.CornerRadius = UDim.new(0, 6)
    Corner.Parent = ToggleFrame
    
    local Label = Instance.new("TextLabel")
    Label.Size = UDim2.new(1, -60, 1, 0)
    Label.Position = UDim2.new(0, 10, 0, 0)
    Label.BackgroundTransparency = 1
    Label.Font = Enum.Font.GothamSemibold
    Label.Text = Texts.features[name]
    Label.TextColor3 = Color3.fromRGB(255, 255, 255)
    Label.TextSize = 14
    Label.TextXAlignment = Enum.TextXAlignment.Left
    Label.Parent = ToggleFrame
    
    local Switch = Instance.new("TextButton")
    Switch.Size = UDim2.new(0, 40, 0, 20)
    Switch.Position = UDim2.new(1, -50, 0.5, -10)
    Switch.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
    Switch.BorderSizePixel = 0
    Switch.Text = ""
    Switch.Parent = ToggleFrame
    
    local SwitchCorner = Instance.new("UICorner")
    SwitchCorner.CornerRadius = UDim.new(1, 0)
    SwitchCorner.Parent = Switch
    
    local Circle = Instance.new("Frame")
    Circle.Size = UDim2.new(0, 16, 0, 16)
    Circle.Position = UDim2.new(0, 2, 0.5, -8)
    Circle.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    Circle.Parent = Switch
    
    local CircleCorner = Instance.new("UICorner")
    CircleCorner.CornerRadius = UDim.new(1, 0)
    CircleCorner.Parent = Circle
    
    local Enabled = false
    
    local function Toggle()
        Enabled = not Enabled
        local Goal = {
            BackgroundColor3 = Enabled and Color3.fromRGB(147, 112, 219) or Color3.fromRGB(60, 60, 60),
            Position = Enabled and UDim2.new(0, 22, 0.5, -8) or UDim2.new(0, 2, 0.5, -8)
        }
        TweenService:Create(Circle, TweenInfo.new(0.2), {Position = Goal.Position}):Play()
        TweenService:Create(Switch, TweenInfo.new(0.2), {BackgroundColor3 = Goal.BackgroundColor3}):Play()
        callback(Enabled)
    end
    
    Switch.MouseButton1Click:Connect(Toggle)
    
    return Toggle
end

-- Función para crear sliders
local function CreateSlider(name, section, callback, min, max, default)
    local SliderFrame = Instance.new("Frame")
    SliderFrame.Size = UDim2.new(1, 0, 0, 60)
    SliderFrame.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
    SliderFrame.Parent = section
    
    local Corner = Instance.new("UICorner")
    Corner.CornerRadius = UDim.new(0, 6)
    Corner.Parent = SliderFrame
    
    local Label = Instance.new("TextLabel")
    Label.Size = UDim2.new(1, -20, 0, 20)
    Label.Position = UDim2.new(0, 10, 0, 5)
    Label.BackgroundTransparency = 1
    Label.Font = Enum.Font.GothamSemibold
    Label.Text = Texts.features[name] .. ": " .. default
    Label.TextColor3 = Color3.fromRGB(255, 255, 255)
    Label.TextSize = 14
    Label.TextXAlignment = Enum.TextXAlignment.Left
    Label.Parent = SliderFrame
    
    local SliderBar = Instance.new("TextButton")
    SliderBar.Name = "SliderBar"
    SliderBar.Size = UDim2.new(1, -20, 0, 20)
    SliderBar.Position = UDim2.new(0, 10, 0, 30)
    SliderBar.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
    SliderBar.BorderSizePixel = 0
    SliderBar.AutoButtonColor = false
    SliderBar.Text = ""
    SliderBar.Parent = SliderFrame
    
    local SliderCorner = Instance.new("UICorner")
    SliderCorner.CornerRadius = UDim.new(1, 0)
    SliderCorner.Parent = SliderBar
    
    local SliderFill = Instance.new("Frame")
    SliderFill.Size = UDim2.new((default - min) / (max - min), 0, 1, 0)
    SliderFill.BackgroundColor3 = Color3.fromRGB(147, 112, 219)
    SliderFill.BorderSizePixel = 0
    SliderFill.Parent = SliderBar
    
    local SliderFillCorner = Instance.new("UICorner")
    SliderFillCorner.CornerRadius = UDim.new(1, 0)
    SliderFillCorner.Parent = SliderFill
    
    local Value = default
    local Dragging = false
    
    local function UpdateSlider(input)
        local sizeX = math.clamp((input.Position.X - SliderBar.AbsolutePosition.X) / SliderBar.AbsoluteSize.X, 0, 1)
        Value = math.floor(min + ((max - min) * sizeX))
        SliderFill.Size = UDim2.new(sizeX, 0, 1, 0)
        Label.Text = Texts.features[name] .. ": " .. Value
        callback(Value)
    end
    
    SliderBar.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
            Dragging = true
            UpdateSlider(input)
        end
    end)
    
    SliderBar.InputEnded:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
            Dragging = false
        end
    end)
    
    UserInputService.InputChanged:Connect(function(input)
        if Dragging and (input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch) then
            UpdateSlider(input)
        end
    end)
    
    return function()
        return Value
    end
end

-- Categorías actualizadas
local Categories = {
    {name = "Annoy", icon = "rbxassetid://3926307971"}
}

-- Crear categorías y secciones
local Sections = {}
local ActiveCategory = nil

for i, category in ipairs(Categories) do
    local button = CreateCategory(category.name, category.icon, (i-1) * 50)
    Sections[category.name] = CreateSection(category.name)
end

-- Características actualizadas
local AnnoyFeatures = {
    {name = "SpamChat", callback = function(enabled)
        if enabled then
            spawn(function()
                while enabled do
                    game:GetService("ReplicatedStorage").DefaultChatSystemChatEvents.SayMessageRequest:FireServer("😂😂😂", "All")
                    wait(1)
                end
            end)
        end
    end},
    {name = "FollowPlayer", callback = function(enabled)
        if enabled then
            spawn(function()
                while enabled do
                    local players = game.Players:GetPlayers()
                    local randomPlayer = players[math.random(1, #players)]
                    if randomPlayer.Character and randomPlayer.Character:FindFirstChild("HumanoidRootPart") then
                        LocalPlayer.Character.Humanoid:MoveTo(randomPlayer.Character.HumanoidRootPart.Position)
                    end
                    wait(3)
                end
            end)
        end
    end},
    {name = "DanceSpam", callback = function(enabled)
        if enabled then
            spawn(function()
                while enabled do
                    game:GetService("Players"):Chat("/e dance")
                    wait(1)
                    game:GetService("Players"):Chat("/e wave")
                    wait(1)
                end
            end)
        end
    end},
    {name = "JumpSpam", callback = function(enabled)
        if enabled then
            spawn(function()
                while enabled do
                    LocalPlayer.Character.Humanoid.Jump = true
                    wait(0.1)
                end
            end)
        end
    end},
    {name = "SpinAround", callback = function(enabled)
        if enabled then
            spawn(function()
                local spinSpeed = 10
                while enabled do
                    LocalPlayer.Character.HumanoidRootPart.CFrame = LocalPlayer.Character.HumanoidRootPart.CFrame * CFrame.Angles(0, math.rad(spinSpeed), 0)
                    RunService.Heartbeat:Wait()
                end
            end)
        end
    end},
    {name = "RandomTeleport", callback = function(enabled)
        if enabled then
            spawn(function()
                while enabled do
                    local randomX = math.random(-100, 100)
                    local randomZ = math.random(-100, 100)
                    LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(Vector3.new(randomX, LocalPlayer.Character.HumanoidRootPart.Position.Y, randomZ))
                    wait(3)
                end
            end)
        end
    end},
    {name = "LoudSounds", callback = function(enabled)
        if enabled then
            spawn(function()
                while enabled do
                    for _, v in pairs(workspace:GetDescendants()) do
                        if v:IsA("Sound") then
                            v.Volume = 10
                            v:Play()
                        end
                    end
                    wait(5)
                end
            end)
        end
    end},
    {name = "SpamEquipTools", callback = function(enabled)
        if enabled then
            spawn(function()
                while enabled do
                    for _, tool in pairs(LocalPlayer.Backpack:GetChildren()) do
                        if tool:IsA("Tool") then
                            tool.Parent = LocalPlayer.Character
                            wait(0.1)
                            tool.Parent = LocalPlayer.Backpack
                        end
                    end
                    wait(0.5)
                end
            end)
        end
    end},
    {name = "RainbowCharacter", slider = true, min = 1, max = 10, default = 5, callback = function(speed)
        spawn(function()
            while true do
                for i = 0, 1, 0.001 * speed do
                    LocalPlayer.Character.Humanoid.Health = 100
                    for _, part in pairs(LocalPlayer.Character:GetChildren()) do
                        if part:IsA("BasePart") then
                            part.Color = Color3.fromHSV(i, 1, 1)
                        end
                    end
                    RunService.Heartbeat:Wait()
                end
            end
        end)
    end},
    {name = "SpamRemotes", callback = function(enabled)
        if enabled then
            spawn(function()
                while enabled do
                    for _, v in pairs(game:GetDescendants()) do
                        if v:IsA("RemoteEvent") then
                            v:FireServer()
                        elseif v:IsA("BindableEvent") then
                            v:Fire()
                        end
                    end
                    wait(1)
                end
            end)
        end
    end},
    {name = "TeleportToPlayer", callback = function()
        local playerList = {}
        for _, player in pairs(game.Players:GetPlayers()) do
            if player ~= LocalPlayer then
                table.insert(playerList, player.Name)
            end
        end
        
        local selectedPlayer = playerList[math.random(1, #playerList)]
        local targetPlayer = game.Players:FindFirstChild(selectedPlayer)
        
        if targetPlayer and targetPlayer.Character then
            LocalPlayer.Character.HumanoidRootPart.CFrame = targetPlayer.Character.HumanoidRootPart.CFrame
        end
    end},
    {name = "FakeVIP", callback = function(enabled)
        if enabled then
            local vipTag = Instance.new("BillboardGui")
            vipTag.Name = "VIPTag"
            vipTag.Size = UDim2.new(0, 100, 0, 30)
            vipTag.StudsOffset = Vector3.new(0, 3, 0)
            vipTag.Adornee = LocalPlayer.Character.Head
            vipTag.Parent = LocalPlayer.Character.Head
            
            local tagLabel = Instance.new("TextLabel")
            tagLabel.Size = UDim2.new(1, 0, 1, 0)
            tagLabel.BackgroundTransparency = 1
            tagLabel.TextScaled = true
            tagLabel.TextColor3 = Color3.new(1, 0.8, 0)
            tagLabel.Text = "VIP"
            tagLabel.Parent = vipTag
        else
            local vipTag = LocalPlayer.Character.Head:FindFirstChild("VIPTag")
            if vipTag then
                vipTag:Destroy()
            end
        end
    end},
    {name = "InvisibleTroll", callback = function(enabled)
        if enabled then
            LocalPlayer.Character.HumanoidRootPart.Transparency = 1
            for _, part in pairs(LocalPlayer.Character:GetDescendants()) do
                if part:IsA("BasePart") and part.Name ~= "HumanoidRootPart" then
                    part.Transparency = 1
                end
            end
        else
            LocalPlayer.Character.HumanoidRootPart.Transparency = 0
            for _, part in pairs(LocalPlayer.Character:GetDescendants()) do
                if part:IsA("BasePart") and part.Name ~= "HumanoidRootPart" then
                    part.Transparency = 0
                end
            end
        end
    end},
    {name = "FakeLag", callback = function(enabled)
        if enabled then
            spawn(function()
                while enabled do
                    LocalPlayer.Character.HumanoidRootPart.Anchored = true
                    wait(0.2)
                    LocalPlayer.Character.HumanoidRootPart.Anchored = false
                    wait(0.2)
                end
            end)
        end
    end},
    {name = "SpamBubbles", callback = function(enabled)
        if enabled then
            spawn(function()
                while enabled do
                    game:GetService("Chat"):Chat(LocalPlayer.Character.Head, "😂", Enum.ChatColor.Blue)
                    wait(0.5)
                end
            end)
        end
    end},
    {name = "GlitchCharacter", callback = function(enabled)
        if enabled then
            spawn(function()
                while enabled do
                    LocalPlayer.Character.Humanoid.HipHeight = math.random(2, 5)
                    wait(0.1)
                end
            end)
        else
            LocalPlayer.Character.Humanoid.HipHeight = 2
        end
    end},
    {name = "FakeKill", callback = function()
        for _, player in pairs(game.Players:GetPlayers()) do
            if player ~= LocalPlayer then
                local fakeBlood = Instance.new("Part")
                fakeBlood.Size = Vector3.new(1, 1, 1)
                fakeBlood.Color = Color3.new(1, 0, 0)
                fakeBlood.Material = Enum.Material.Neon
                fakeBlood.Position = player.Character.HumanoidRootPart.Position
                fakeBlood.Parent = workspace
                
                local bodyVelocity = Instance.new("BodyVelocity")
                bodyVelocity.Velocity = Vector3.new(math.random(-10, 10), 10, math.random(-10, 10))
                bodyVelocity.MaxForce = Vector3.new(1000, 1000, 1000)
                bodyVelocity.Parent = fakeBlood
                
                game.Debris:AddItem(fakeBlood, 2)
            end
        end
    end},
    {name = "SpamParticles", callback = function(enabled)
        if enabled then
            spawn(function()
                while enabled do
                    local particle = Instance.new("ParticleEmitter")
                    particle.Texture = "rbxassetid://241685484"
                    particle.Color = ColorSequence.new(Color3.new(1, 0, 0), Color3.new(0, 0, 1))
                    particle.Rate = 100
                    particle.Parent = LocalPlayer.Character.HumanoidRootPart
                    wait(1)
                    particle:Destroy()
                end
            end)
        end
    end},
    {name = "MimicPlayer", callback = function(enabled)
        if enabled then
            spawn(function()
                while enabled do
                    local players = game.Players:GetPlayers()
                    local randomPlayer = players[math.random(1, #players)]
                    if randomPlayer ~= LocalPlayer and randomPlayer.Character then
                        LocalPlayer.Character.Humanoid:MoveTo(randomPlayer.Character.HumanoidRootPart.Position)
                    end
                    wait(2)
                end
            end)
        end
    end},
    {name = "ServerLagger", callback = function(enabled)
        if enabled then
            spawn(function()
                while enabled do
                    for i = 1, 1000 do
                        Instance.new("Part", workspace)
                    end
                    wait(0.1)
                    for _, v in pairs(workspace:GetChildren()) do
                        if v:IsA("Part") then
                            v:Destroy()
                        end
                    end
                    wait(0.1)
                end
            end)
        end
    end},
}

-- Crear toggles y sliders para cada característica
for _, feature in ipairs(AnnoyFeatures) do
    if feature.slider then
        CreateSlider(feature.name, Sections.Annoy, feature.callback, feature.min, feature.max, feature.default)
    else
        CreateToggle(feature.name, Sections.Annoy, feature.callback)
    end
end

-- Manejar la visibilidad de las secciones y mantener el color morado
local function ShowSection(sectionName)
    for name, section in pairs(Sections) do
        section.Visible = (name == sectionName)
        local button = Sidebar:FindFirstChild(name.."Category")
        if button then
            button.BackgroundColor3 = (name == sectionName) and Color3.fromRGB(147, 112, 219) or Color3.fromRGB(45, 45, 45)
        end
    end
    ActiveCategory = sectionName
end

for _, category in ipairs(Categories) do
    local button = Sidebar:FindFirstChild(category.name.."Category")
    if button then
        button.MouseButton1Click:Connect(function()
            ShowSection(category.name)
        end)
    end
end

-- Animación del botón de toggle
ToggleButton.MouseButton1Click:Connect(function()
    MainBorder.Visible = not MainBorder.Visible
    local goal = {
        Rotation = MainBorder.Visible and 180 or 0,
        Size = MainBorder.Visible and UDim2.new(0, 610, 0, 410) or UDim2.new(0, 0, 0, 0)
    }
    TweenService:Create(ToggleButton, TweenInfo.new(0.3), {Rotation = goal.Rotation}):Play()
    TweenService:Create(MainBorder, TweenInfo.new(0.3), {Size = goal.Size}):Play()
end)

-- Manejar el respawn del personaje
LocalPlayer.CharacterAdded:Connect(function(newCharacter)
    Character = newCharacter
    Humanoid = Character:WaitForChild("Humanoid")
    HumanoidRootPart = Character:WaitForChild("HumanoidRootPart")
end)

-- Eliminar la GUI de carga
LoadingGui:Destroy()

-- Mostrar la primera sección por defecto
ShowSection("Annoy")

-- Mensaje de confirmación
print("Script mejorado cargado correctamente. Use el botón en la izquierda para mostrar/ocultar el menú.")
