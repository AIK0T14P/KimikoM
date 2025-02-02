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

-- Textos en español
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
        TeleportToPlayer = "Teletransportarse a Jugador",
        SpinPlayers = "Girar Jugadores",
        JumpScare = "Susto Repentino",
        ForceDance = "Forzar Baile",
        InvisibleTroll = "Troll Invisible",
        SpamBubbles = "Spam de Burbujas",
        FakeVIP = "VIP Falso",
        CopyOutfit = "Copiar Atuendo",
        MimicPlayer = "Imitar Jugador",
        FakeExplode = "Explosión Falsa",
        LaunchPlayers = "Lanzar Jugadores",
        GlitchCharacter = "Personaje Glitcheado",
        RainbowCharacter = "Personaje Arcoíris",
        GiantCharacter = "Personaje Gigante",
        TinyCharacter = "Personaje Diminuto",
        SpamEquipTools = "Spam de Equipar Herramientas",
        ServerLagger = "Lagear Servidor",
        FakeAdmin = "Admin Falso"
    }
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

-- Función para crear un menú desplegable para seleccionar jugadores
local function CreatePlayerDropdown(name, section, callback)
    local DropdownFrame = Instance.new("Frame")
    DropdownFrame.Size = UDim2.new(1, 0, 0, 30)
    DropdownFrame.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
    DropdownFrame.Parent = section
    
    local DropdownButton = Instance.new("TextButton")
    DropdownButton.Size = UDim2.new(1, -10, 1, -5)
    DropdownButton.Position = UDim2.new(0, 5, 0, 2.5)
    DropdownButton.BackgroundColor3 = Color3.fromRGB(80, 80, 80)
    DropdownButton.Text = Texts.features[name]
    DropdownButton.TextColor3 = Color3.new(1, 1, 1)
    DropdownButton.Parent = DropdownFrame
    
    local DropdownList = Instance.new("ScrollingFrame")
    DropdownList.Size = UDim2.new(1, 0, 0, 100)
    DropdownList.Position = UDim2.new(0, 0, 1, 5)
    DropdownList.BackgroundColor3 = Color3.fromRGB(70, 70, 70)
    DropdownList.Visible = false
    DropdownList.Parent = DropdownFrame
    
    local UIListLayout = Instance.new("UIListLayout")
    UIListLayout.Parent = DropdownList
    
    local function UpdateDropdown()
        for i, v in pairs(DropdownList:GetChildren()) do
            if v:IsA("TextButton") then
                v:Destroy()
            end
        end
        
        for _, player in pairs(game.Players:GetPlayers()) do
            if player ~= LocalPlayer then
                local PlayerButton = Instance.new("TextButton")
                PlayerButton.Size = UDim2.new(1, 0, 0, 20)
                PlayerButton.BackgroundColor3 = Color3.fromRGB(80, 80, 80)
                PlayerButton.Text = player.Name
                PlayerButton.TextColor3 = Color3.new(1, 1, 1)
                PlayerButton.Parent = DropdownList
                
                PlayerButton.MouseButton1Click:Connect(function()
                    callback(player)
                    DropdownList.Visible = false
                end)
            end
        end
    end
    
    DropdownButton.MouseButton1Click:Connect(function()
        UpdateDropdown()
        DropdownList.Visible = not DropdownList.Visible
    end)
end

-- Características actualizadas
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
        {name = "TeleportToPlayer", callback = function(player)
            if player and player.Character then
                LocalPlayer.Character.HumanoidRootPart.CFrame = player.Character.HumanoidRootPart.CFrame
            end
        end},
        {name = "SpinPlayers", callback = function(enabled)
            if enabled then
                spawn(function()
                    while enabled do
                        for _, player in pairs(game.Players:GetPlayers()) do
                            if player ~= LocalPlayer and player.Character and player.Character:FindFirstChild("HumanoidRootPart") then
                                player.Character.HumanoidRootPart.CFrame = player.Character.HumanoidRootPart.CFrame * CFrame.Angles(0, math.rad(10), 0)
                            end
                        end
                        wait(0.1)
                    end
                end)
            end
        end},
        {name = "JumpScare", callback = function()
            for _, player in pairs(game.Players:GetPlayers()) do
                if player ~= LocalPlayer then
                    local jumpscareGui = Instance.new("ScreenGui")
                    jumpscareGui.Name = "JumpscareGui"
                    jumpscareGui.Parent = player.PlayerGui
                    
                    local jumpscareImage = Instance.new("ImageLabel")
                    jumpscareImage.Size = UDim2.new(1, 0, 1, 0)
                    jumpscareImage.Image = "rbxassetid://6864086702"
                    jumpscareImage.Parent = jumpscareGui
                    
                    local sound = Instance.new("Sound")
                    sound.SoundId = "rbxassetid://5567523008"
                    sound.Volume = 1
                    sound.Parent = jumpscareGui
                    sound:Play()
                    
                    wait(2)
                    jumpscareGui:Destroy()
                end
            end
        end},
        {name = "ForceDance", callback = function(enabled)
            if enabled then
                spawn(function()
                    while enabled do
                        for _, player in pairs(game.Players:GetPlayers()) do
                            if player ~= LocalPlayer then
                                game:GetService("Players"):Chat("/e dance")
                            end
                        end
                        wait(5)
                    end
                end)
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
        {name = "SpamBubbles", callback = function(enabled)
            if enabled then
                spawn(function()
                    while enabled do
                        for _, player in pairs(game.Players:GetPlayers()) do
                            if player ~= LocalPlayer and player.Character and player.Character:FindFirstChild("Head") then
                                game:GetService("Chat"):Chat(player.Character.Head, "😂", Enum.ChatColor.Blue)
                            end
                        end
                        wait(0.5)
                    end
                end)
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
        {name = "CopyOutfit", callback = function(player)
            if player and player.Character then
                for _, item in pairs(LocalPlayer.Character:GetChildren()) do
                    if item:IsA("Accessory") or item:IsA("Shirt") or item:IsA("Pants") or item:IsA("ShirtGraphic") then
                        item:Destroy()
                    end
                end
                
                for _, item in pairs(player.Character:GetChildren()) do
                    if item:IsA("Accessory") or item:IsA("Shirt") or item:IsA("Pants") or item:IsA("ShirtGraphic") then
                        local clone = item:Clone()
                        clone.Parent = LocalPlayer.Character
                    end
                end
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
        {name = "FakeExplode", callback = function()
            for _, player in pairs(game.Players:GetPlayers()) do
                if player ~= LocalPlayer and player.Character then
                    local explosion = Instance.new("Explosion")
                    explosion.Position = player.Character.HumanoidRootPart.Position
                    explosion.BlastPressure = 0
                    explosion.BlastRadius = 10
                    explosion.Parent = workspace
                end
            end
        end},
        {name = "LaunchPlayers", callback = function()
            for _, player in pairs(game.Players:GetPlayers()) do
                if player ~= LocalPlayer and player.Character and player.Character:FindFirstChild("HumanoidRootPart") then
                    local bodyVelocity = Instance.new("BodyVelocity")
                    bodyVelocity.Velocity = Vector3.new(0, 100, 0)
                    bodyVelocity.MaxForce = Vector3.new(math.huge, math.huge, math.huge)
                    bodyVelocity.Parent = player.Character.HumanoidRootPart
                    game.Debris:AddItem(bodyVelocity, 1)
                end
            end
        end},
    },
    -- ... (otras categorías sin cambios)
}

-- Crear toggles y dropdowns para cada característica
for category, features in pairs(Features) do
    for _, feature in ipairs(features) do
        if feature.name == "TeleportToPlayer" or feature.name == "CopyOutfit" then
            CreatePlayerDropdown(feature.name, Sections[category], feature.callback)
        else
            CreateToggle(feature.name, Sections[category], feature.callback)
        end
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
