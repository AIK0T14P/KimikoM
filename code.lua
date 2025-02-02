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

-- Idioma (solo español en esta versión)
local Texts = {
    categories = {
        Molestar = "Molestar",
        Movimiento = "Movimiento",
        Apariencia = "Apariencia",
        Sonido = "Sonido",
        Servidor = "Servidor"
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
        ServerLagger = "Lagear Servidor",
        SuperSpeed = "Super Velocidad",
        Noclip = "Atravesar Paredes",
        Fly = "Volar",
        ChangeSize = "Cambiar Tamaño",
        EarRape = "Sonidos Molestos",
        DiscoMode = "Modo Disco",
        FakeAdmin = "Admin Falso",
        CrashServer = "Intentar Crashear Servidor"
    },
    loading = "Cargando..."
}

-- GUI Principal
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "TrollGuiMejorado"
ScreenGui.ResetOnSpawn = false
ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
ScreenGui.Parent = game.CoreGui

-- Botón para mostrar/ocultar
local ToggleButton = Instance.new("TextButton")
ToggleButton.Size = UDim2.new(0, 50, 0, 50)
ToggleButton.Position = UDim2.new(0, 10, 0.5, -25)
ToggleButton.BackgroundColor3 = Color3.fromRGB(255, 0, 0)
ToggleButton.Text = "Troll"
ToggleButton.TextColor3 = Color3.new(1, 1, 1)
ToggleButton.Font = Enum.Font.SourceSansBold
ToggleButton.TextSize = 14
ToggleButton.Parent = ScreenGui

local ToggleCorner = Instance.new("UICorner")
ToggleCorner.CornerRadius = UDim.new(1, 0)
ToggleCorner.Parent = ToggleButton

-- Frame Principal
local MainFrame = Instance.new("Frame")
MainFrame.Name = "MainFrame"
MainFrame.Size = UDim2.new(0, 600, 0, 400)
MainFrame.Position = UDim2.new(0.5, -300, 0.5, -200)
MainFrame.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
MainFrame.BorderSizePixel = 0
MainFrame.Visible = false
MainFrame.Parent = ScreenGui

local MainCorner = Instance.new("UICorner")
MainCorner.CornerRadius = UDim.new(0, 10)
MainCorner.Parent = MainFrame

-- Título
local Title = Instance.new("TextLabel")
Title.Size = UDim2.new(1, 0, 0, 40)
Title.BackgroundTransparency = 1
Title.Font = Enum.Font.SourceSansBold
Title.Text = "Troll GUI Mejorado"
Title.TextColor3 = Color3.new(1, 1, 1)
Title.TextSize = 24
Title.Parent = MainFrame

-- Categorías
local Categories = {
    {name = "Molestar", icon = "rbxassetid://3926307971"},
    {name = "Movimiento", icon = "rbxassetid://3926305904"},
    {name = "Apariencia", icon = "rbxassetid://3926307971"},
    {name = "Sonido", icon = "rbxassetid://3926305904"},
    {name = "Servidor", icon = "rbxassetid://3926305904"}
}

-- Crear categorías y secciones
local Sidebar = Instance.new("Frame")
Sidebar.Name = "Sidebar"
Sidebar.Size = UDim2.new(0, 150, 1, -40)
Sidebar.Position = UDim2.new(0, 0, 0, 40)
Sidebar.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
Sidebar.Parent = MainFrame

local ContentFrame = Instance.new("Frame")
ContentFrame.Name = "ContentFrame"
ContentFrame.Size = UDim2.new(1, -150, 1, -40)
ContentFrame.Position = UDim2.new(0, 150, 0, 40)
ContentFrame.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
ContentFrame.Parent = MainFrame

local function CreateCategory(name, icon, position)
    local CategoryButton = Instance.new("TextButton")
    CategoryButton.Name = name.."Category"
    CategoryButton.Size = UDim2.new(1, 0, 0, 40)
    CategoryButton.Position = UDim2.new(0, 0, 0, position)
    CategoryButton.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
    CategoryButton.BorderSizePixel = 0
    CategoryButton.Font = Enum.Font.SourceSansBold
    CategoryButton.Text = Texts.categories[name]
    CategoryButton.TextColor3 = Color3.new(1, 1, 1)
    CategoryButton.TextSize = 14
    CategoryButton.Parent = Sidebar
    
    local IconImage = Instance.new("ImageLabel")
    IconImage.Size = UDim2.new(0, 20, 0, 20)
    IconImage.Position = UDim2.new(0, 10, 0.5, -10)
    IconImage.BackgroundTransparency = 1
    IconImage.Image = icon
    IconImage.Parent = CategoryButton
    
    return CategoryButton
end

local function CreateSection(name)
    local Section = Instance.new("ScrollingFrame")
    Section.Name = name.."Section"
    Section.Size = UDim2.new(1, -20, 1, -20)
    Section.Position = UDim2.new(0, 10, 0, 10)
    Section.BackgroundTransparency = 1
    Section.BorderSizePixel = 0
    Section.ScrollBarThickness = 6
    Section.Visible = false
    Section.Parent = ContentFrame
    
    local UIListLayout = Instance.new("UIListLayout")
    UIListLayout.SortOrder = Enum.SortOrder.LayoutOrder
    UIListLayout.Padding = UDim.new(0, 10)
    UIListLayout.Parent = Section
    
    return Section
end

local Sections = {}
for i, category in ipairs(Categories) do
    local button = CreateCategory(category.name, category.icon, (i-1) * 40)
    Sections[category.name] = CreateSection(category.name)
end

-- Función para crear toggles
local function CreateToggle(name, section, callback)
    local ToggleFrame = Instance.new("Frame")
    ToggleFrame.Size = UDim2.new(1, 0, 0, 30)
    ToggleFrame.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
    ToggleFrame.Parent = section
    
    local ToggleButton = Instance.new("TextButton")
    ToggleButton.Size = UDim2.new(0, 20, 0, 20)
    ToggleButton.Position = UDim2.new(0, 5, 0.5, -10)
    ToggleButton.BackgroundColor3 = Color3.fromRGB(200, 200, 200)
    ToggleButton.Text = ""
    ToggleButton.Parent = ToggleFrame
    
    local ToggleLabel = Instance.new("TextLabel")
    ToggleLabel.Size = UDim2.new(1, -30, 1, 0)
    ToggleLabel.Position = UDim2.new(0, 30, 0, 0)
    ToggleLabel.BackgroundTransparency = 1
    ToggleLabel.Font = Enum.Font.SourceSans
    ToggleLabel.Text = Texts.features[name]
    ToggleLabel.TextColor3 = Color3.new(1, 1, 1)
    ToggleLabel.TextSize = 14
    ToggleLabel.TextXAlignment = Enum.TextXAlignment.Left
    ToggleLabel.Parent = ToggleFrame
    
    local toggled = false
    ToggleButton.MouseButton1Click:Connect(function()
        toggled = not toggled
        ToggleButton.BackgroundColor3 = toggled and Color3.fromRGB(0, 255, 0) or Color3.fromRGB(200, 200, 200)
        callback(toggled)
    end)
end

-- Características por categoría
local Features = {
    Molestar = {
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
    },
    Movimiento = {
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
        {name = "SuperSpeed", callback = function(enabled)
            if enabled then
                LocalPlayer.Character.Humanoid.WalkSpeed = 50
            else
                LocalPlayer.Character.Humanoid.WalkSpeed = 16
            end
        end},
        {name = "Noclip", callback = function(enabled)
            if enabled then
                RunService:BindToRenderStep("Noclip", 0, function()
                    if LocalPlayer.Character then
                        for _, part in pairs(LocalPlayer.Character:GetDescendants()) do
                            if part:IsA("BasePart") then
                                part.CanCollide = false
                            end
                        end
                    end
                end)
            else
                RunService:UnbindFromRenderStep("Noclip")
            end
        end},
        {name = "Fly", callback = function(enabled)
            if enabled then
                local bp = Instance.new("BodyPosition", LocalPlayer.Character.HumanoidRootPart)
                bp.MaxForce = Vector3.new(math.huge, math.huge, math.huge)
                bp.P = 10000
                bp.Position = LocalPlayer.Character.HumanoidRootPart.Position
                
                RunService:BindToRenderStep("Fly", 0, function()
                    if UserInputService:IsKeyDown(Enum.KeyCode.Space) then
                        bp.Position = bp.Position + Vector3.new(0, 1, 0)
                    end
                    if UserInputService:IsKeyDown(Enum.KeyCode.LeftControl) then
                        bp.Position = bp.Position - Vector3.new(0, 1, 0)
                    end
                end)
            else
                RunService:UnbindFromRenderStep("Fly")
                if LocalPlayer.Character.HumanoidRootPart:FindFirstChild("BodyPosition") then
                    LocalPlayer.Character.HumanoidRootPart.BodyPosition:Destroy()
                end
            end
        end},
    },
    Apariencia = {
        {name = "RainbowCharacter", callback = function(enabled)
            if enabled then
                spawn(function()
                    while enabled do
                        for i = 0, 1, 0.01 do
                            for _, part in pairs(LocalPlayer.Character:GetDescendants()) do
                                if part:IsA("BasePart") then
                                    part.Color = Color3.fromHSV(i, 1, 1)
                                end
                            end
                            wait(0.1)
                        end
                    end
                end)
            end
        end},
        {name = "ChangeSize", callback = function(enabled)
            if enabled then
                LocalPlayer.Character.Humanoid.BodyDepthScale.Value = 5
                LocalPlayer.Character.Humanoid.BodyWidthScale.Value = 5
                LocalPlayer.Character.Humanoid.BodyHeightScale.Value = 5
            else
                LocalPlayer.Character.Humanoid.BodyDepthScale.Value = 1
                LocalPlayer.Character.Humanoid.BodyWidthScale.Value = 1
                LocalPlayer.Character.Humanoid.BodyHeightScale.Value = 1
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
                for _, part in pairs(LocalPlayer.Character:GetDescendants()) do
                    if part:IsA("BasePart") and part.Name ~= "HumanoidRootPart" then
                        part.Transparency = 1
                    end
                end
            else
                for _, part in pairs(LocalPlayer.Character:GetDescendants()) do
                    if part:IsA("BasePart") and part.Name ~= "HumanoidRootPart" then
                        part.Transparency = 0
                    end
                end
            end
        end},
    },
    Sonido = {
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
        {name = "EarRape", callback = function(enabled)
            if enabled then
                local sound = Instance.new("Sound", workspace)
                sound.SoundId = "rbxassetid://142376088" -- Roblox death sound
                sound.Volume = 10
                sound.Looped = true
                sound:Play()
            else
                for _, v in pairs(workspace:GetDescendants()) do
                    if v:IsA("Sound") and v.SoundId == "rbxassetid://142376088" then
                        v:Destroy()
                    end
                end
            end
        end},
        {name = "DiscoMode", callback = function(enabled)
            if enabled then
                spawn(function()
                    while enabled do
                        Lighting.Ambient = Color3.new(math.random(), math.random(), math.random())
                        wait(0.1)
                    end
                end)
            else
                Lighting.Ambient = Color3.new(0.5, 0.5, 0.5)
            end
        end},
    },
    Servidor = {
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
        {name = "FakeAdmin", callback = function(enabled)
            if enabled then
                spawn(function()
                    while enabled do
                        game:GetService("ReplicatedStorage").DefaultChatSystemChatEvents.SayMessageRequest:FireServer(":kick all", "All")
                        wait(5)
                        game:GetService("ReplicatedStorage").DefaultChatSystemChatEvents.SayMessageRequest:FireServer(":ban all", "All")
                        wait(5)
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
        {name = "CrashServer", callback = function(enabled)
            if enabled then
                spawn(function()
                    while enabled do
                        for i = 1, 1000000 do
                            Instance.new("Part", workspace)
                        end
                    end
                end)
            end
        end},
    }
}

-- Crear toggles para cada característica
for category, features in pairs(Features) do
    for _, feature in ipairs(features) do
        CreateToggle(feature.name, Sections[category], feature.callback)
    end
end

-- Manejar la visibilidad de las secciones
local function ShowSection(sectionName)
    for name, section in pairs(Sections) do
        section.Visible = (name == sectionName)
    end
end

for _, category in ipairs(Categories) do
    local button = Sidebar:FindFirstChild(category.name.."Category")
    if button then
        button.MouseButton1Click:Connect(function()
            ShowSection(category.name)
        end)
    end
end

-- Mostrar/ocultar el menú principal
ToggleButton.MouseButton1Click:Connect(function()
    MainFrame.Visible = not MainFrame.Visible
end)

-- Mostrar la primera sección por defecto
ShowSection("Molestar")

-- Mensaje de confirmación
print("Script mejorado cargado correctamente. Use el botón rojo para mostrar/ocultar el menú.")
