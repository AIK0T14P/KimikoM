-- Services
local Players = game:GetService("Players")
local UserInputService = game:GetService("UserInputService")
local TweenService = game:GetService("TweenService")
local RunService = game:GetService("RunService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Lighting = game:GetService("Lighting")
local Debris = game:GetService("Debris")
local PhysicsService = game:GetService("PhysicsService")
local SoundService = game:GetService("SoundService")
local MarketplaceService = game:GetService("MarketplaceService")

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
        Servidor = "Servidor",
        Ambiente = "Ambiente",
        Jugadores = "Jugadores",
        Física = "Física",
        Efectos = "Efectos",
        Herramientas = "Herramientas"
    },
    features = {
        -- Molestar
        SpamChat = "Spam de Chat",
        FollowPlayer = "Seguir Jugador Aleatorio",
        DanceSpam = "Spam de Baile",
        JumpSpam = "Spam de Saltos",
        EmoteSpam = "Spam de Emotes",
        BubbleSpam = "Spam de Burbujas de Chat",
        FakeKick = "Falsa Expulsión",
        FakeBan = "Falso Baneo",
        AnnoyingSound = "Sonido Molesto",
        PopupSpam = "Spam de Ventanas Emergentes",
        
        -- Movimiento
        SpinAround = "Girar Alrededor",
        RandomTeleport = "Teletransporte Aleatorio",
        SuperSpeed = "Super Velocidad",
        Noclip = "Atravesar Paredes",
        Fly = "Volar",
        Moonwalk = "Caminar hacia atrás",
        Telekinesis = "Telequinesis",
        WallClimb = "Escalar Paredes",
        SuperJump = "Super Salto",
        Glide = "Planear",
        
        -- Apariencia
        RainbowCharacter = "Personaje Arcoíris",
        ChangeSize = "Cambiar Tamaño",
        FakeVIP = "VIP Falso",
        InvisibleTroll = "Troll Invisible",
        CloneCharacter = "Clonar Personaje",
        GhostMode = "Modo Fantasma",
        CustomOutfit = "Atuendo Personalizado",
        AnimationChanger = "Cambiar Animaciones",
        BodyPartRemover = "Remover Partes del Cuerpo",
        FakeHeadless = "Cabeza Falsa Invisible",
        
        -- Sonido
        LoudSounds = "Sonidos Fuertes",
        EarRape = "Sonidos Extremos",
        DiscoMode = "Modo Disco",
        MutePlayers = "Silenciar Jugadores",
        SoundSpammer = "Spammer de Sonidos",
        PitchChanger = "Cambiar Tono de Voz",
        EchoEffect = "Efecto de Eco",
        ReverseSounds = "Invertir Sonidos",
        CustomMusicPlayer = "Reproductor de Música Personalizado",
        SoundDistorter = "Distorsionador de Sonido",
        
        -- Servidor
        SpamRemotes = "Spam de Remotos",
        FakeAdmin = "Admin Falso",
        ServerLagger = "Lagear Servidor",
        CrashServer = "Intentar Crashear Servidor",
        FakeServerMessage = "Mensaje de Servidor Falso",
        RemoteSpyLogger = "Espía de Remotos",
        AntiKick = "Anti-Expulsión",
        AntiBan = "Anti-Baneo",
        ServerSideExecutor = "Ejecutor del Lado del Servidor",
        BackdoorScanner = "Escáner de Backdoors",
        
        -- Ambiente
        TimeChanger = "Cambiar Hora del Día",
        WeatherController = "Controlar Clima",
        GravityManipulator = "Manipular Gravedad",
        FogController = "Controlar Niebla",
        SkyboxChanger = "Cambiar Cielo",
        TerrainDestroyer = "Destruir Terreno",
        LightingEffects = "Efectos de Iluminación",
        MapFlooder = "Inundar Mapa",
        PartReplicator = "Replicador de Partes",
        TextureChanger = "Cambiar Texturas",
        
        -- Jugadores
        TeleportToPlayer = "Teletransportarse a Jugador",
        CopyAppearance = "Copiar Apariencia",
        Forcefield = "Campo de Fuerza",
        GodMode = "Modo Dios",
        SpectatePlayer = "Espectar Jugador",
        FreezePlayer = "Congelar Jugador",
        PushPlayers = "Empujar Jugadores",
        PlayerMagnet = "Imán de Jugadores",
        ClickTeleport = "Teletransporte con Click",
        PlayerTracer = "Trazador de Jugadores",
        
        -- Física
        ExplodeCharacter = "Explotar Personaje",
        AntiGravity = "Anti-Gravedad",
        SuperStrength = "Super Fuerza",
        RagdollCharacter = "Convertir en Muñeco de Trapo",
        VelocityMultiplier = "Multiplicador de Velocidad",
        PhysicsGun = "Pistola de Física",
        BlackHole = "Agujero Negro",
        FreezePhysics = "Congelar Física",
        ElasticCharacter = "Personaje Elástico",
        GravityZones = "Zonas de Gravedad",
        
        -- Efectos
        ParticleSpammer = "Spammer de Partículas",
        ScreenShake = "Sacudir Pantalla",
        BlurEffect = "Efecto de Desenfoque",
        ColorCorrectionEffect = "Efecto de Corrección de Color",
        SunRaysEffect = "Efecto de Rayos de Sol",
        BloomEffect = "Efecto de Resplandor",
        ThermalVision = "Visión Térmica",
        MatrixEffect = "Efecto Matrix",
        SlowMotion = "Cámara Lenta",
        SpeedLines = "Líneas de Velocidad",
        
        -- Herramientas
        BrickSpammer = "Spammer de Ladrillos",
        BuildingTool = "Herramienta de Construcción",
        DeleteTool = "Herramienta de Eliminación",
        CopyTool = "Herramienta de Copiado",
        TeleportTool = "Herramienta de Teletransporte",
        GrabTool = "Herramienta de Agarre",
        PaintTool = "Herramienta de Pintura",
        ResizeTool = "Herramienta de Redimensionamiento",
        ScriptInserter = "Insertador de Scripts",
        InstanceLogger = "Registrador de Instancias"
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
MainFrame.Size = UDim2.new(0, 800, 0, 500)
MainFrame.Position = UDim2.new(0.5, -400, 0.5, -250)
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
    {name = "Servidor", icon = "rbxassetid://3926305904"},
    {name = "Ambiente", icon = "rbxassetid://3926307971"},
    {name = "Jugadores", icon = "rbxassetid://3926305904"},
    {name = "Física", icon = "rbxassetid://3926307971"},
    {name = "Efectos", icon = "rbxassetid://3926305904"},
    {name = "Herramientas", icon = "rbxassetid://3926307971"}
}

-- Crear categorías y secciones
local Sidebar = Instance.new("ScrollingFrame")
Sidebar.Name = "Sidebar"
Sidebar.Size = UDim2.new(0, 150, 1, -40)
Sidebar.Position = UDim2.new(0, 0, 0, 40)
Sidebar.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
Sidebar.BorderSizePixel = 0
Sidebar.ScrollBarThickness = 6
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
    CategoryButton.Size = UDim2.new(1, -10, 0, 40)
    CategoryButton.Position = UDim2.new(0, 5, 0, position)
    CategoryButton.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
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
    
    local ButtonCorner = Instance.new("UICorner")
    ButtonCorner.CornerRadius = UDim.new(0, 5)
    ButtonCorner.Parent = CategoryButton
    
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
    local button = CreateCategory(category.name, category.icon, (i-1) * 45)
    Sections[category.name] = CreateSection(category.name)
end

-- Función para crear toggles
local function CreateToggle(name, section, callback)
    local ToggleFrame = Instance.new("Frame")
    ToggleFrame.Size = UDim2.new(1, 0, 0, 30)
    ToggleFrame.BackgroundColor3 = Color3.fromRGB(70, 70, 70)
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
    
    local ToggleCorner = Instance.new("UICorner")
    ToggleCorner.CornerRadius = UDim.new(0, 5)
    ToggleCorner.Parent = ToggleFrame
    
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
        {name = "EmoteSpam", callback = function(enabled)
            if enabled then
                spawn(function()
                    local emotes = {"wave", "point", "dance", "laugh", "cheer"}
                    while enabled do
                        local randomEmote = emotes[math.random(1, #emotes)]
                        game:GetService("Players"):Chat("/e " .. randomEmote)
                        wait(0.5)
                    end
                end)
            end
        end},
        {name = "BubbleSpam", callback = function(enabled)
            if enabled then
                spawn(function()
                    while enabled do
                        game:GetService("Chat"):Chat(LocalPlayer.Character.Head, "😂", Enum.ChatColor.Blue)
                        wait(0.1)
                    end
                end)
            end
        end},
        {name = "FakeKick", callback = function(enabled)
            if enabled then
                local kickMessage = Instance.new("Message", workspace)
                kickMessage.Text = "Usted ha sido expulsado del servidor."
                wait(3)
                kickMessage:Destroy()
            end
        end},
        {name = "FakeBan", callback = function(enabled)
            if enabled then
                local banMessage = Instance.new("Message", workspace)
                banMessage.Text = "Su cuenta ha sido suspendida por 3 días."
                wait(3)
                banMessage:Destroy()
            end
        end},
        {name = "AnnoyingSound", callback = function(enabled)
            if enabled then
                local sound = Instance.new("Sound", workspace)
                sound.SoundId = "rbxassetid://5567523008" -- Sonido molesto
                sound.Looped = true
                sound:Play()
            else
                for _, v in pairs(workspace:GetDescendants()) do
                    if v:IsA("Sound") and v.SoundId == "rbxassetid://5567523008" then
                        v:Destroy()
                    end
                end
            end
        end},
        {name = "PopupSpam", callback = function(enabled)
            if enabled then
                spawn(function()
                    while enabled do
                        local popup = Instance.new("ScreenGui", LocalPlayer.PlayerGui)
                        local frame = Instance.new("Frame", popup)
                        frame.Size = UDim2.new(0, 200, 0, 100)
                        frame.Position = UDim2.new(math.random(), 0, math.random(), 0)
                        frame.BackgroundColor3 = Color3.fromRGB(255, 0, 0)
                        local text = Instance.new("TextLabel", frame)
                        text.Size = UDim2.new(1, 0, 1, 0)
                        text.Text = "¡Popup molesto!"
                        wait(1)
                        popup:Destroy()
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
        {name = "Moonwalk", callback = function(enabled)
            if enabled then
                local oldWalkSpeed = LocalPlayer.Character.Humanoid.WalkSpeed
                LocalPlayer.Character.Humanoid.WalkSpeed = -oldWalkSpeed
            else
                LocalPlayer.Character.Humanoid.WalkSpeed = math.abs(LocalPlayer.Character.Humanoid.WalkSpeed)
            end
        end},
        {name = "Telekinesis", callback = function(enabled)
            if enabled then
                local mouse = LocalPlayer:GetMouse()
                local tool = Instance.new("Tool")
                tool.RequiresHandle = false
                tool.Name = "Telekinesis"
                tool.Activated:Connect(function()
                    local target = mouse.Target
                    if target and target:IsA("BasePart") then
                        local bp = Instance.new("BodyPosition", target)
                        bp.Position = target.Position
                        bp.MaxForce = Vector3.new(math.huge, math.huge, math.huge)
                        bp.P = 1000000
                        bp.D = 100
                        
                        local function update(input)
                            if input.UserInputType == Enum.UserInputType.MouseMovement then
                                bp.Position = mouse.Hit.p
                            end
                        end
                        
                        UserInputService.InputChanged:Connect(update)
                    end
                end)
                tool.Parent = LocalPlayer.Backpack
            else
                for _, v in pairs(LocalPlayer.Backpack:GetChildren()) do
                    if v.Name == "Telekinesis" then
                        v:Destroy()
                    end
                end
            end
        end},
        {name = "WallClimb", callback = function(enabled)
            if enabled then
                local function onTouch(hit)
                    local character = LocalPlayer.Character
                    if hit and hit.Parent and character:FindFirstChild("Humanoid") then
                        local humanoid = character.Humanoid
                        humanoid:ChangeState(Enum.HumanoidStateType.Climbing)
                    end
                end
                
                for _, v in pairs(LocalPlayer.Character:GetDescendants()) do
                    if v:IsA("BasePart") then
                        v.Touched:Connect(onTouch)
                    end
                end
            else
                for _, v in pairs(LocalPlayer.Character:GetDescendants()) do
                    if v:IsA("BasePart") then
                        v.Touched:DisconnectAll()
                    end
                end
            end
        end},
        {name = "SuperJump", callback = function(enabled)
            if enabled then
                LocalPlayer.Character.Humanoid.JumpPower = 100
            else
                LocalPlayer.Character.Humanoid.JumpPower = 50
            end
        end},
        {name = "Glide", callback = function(enabled)
            if enabled then
                local glideForce = Instance.new("BodyForce", LocalPlayer.Character.HumanoidRootPart)
                glideForce.Force = Vector3.new(0, workspace.Gravity * LocalPlayer.Character.HumanoidRootPart.AssemblyMass, 0)
                RunService:BindToRenderStep("Glide", 0, function()
                    if not LocalPlayer.Character.Humanoid:GetState() == Enum.HumanoidStateType.Freefall then
                        glideForce.Force = Vector3.new(0, 0, 0)
                    else
                        glideForce.Force = Vector3.new(0, workspace.Gravity * LocalPlayer.Character.HumanoidRootPart.AssemblyMass, 0)
                    end
                end)
            else
                RunService:UnbindFromRenderStep("Glide")
                if LocalPlayer.Character.HumanoidRootPart:FindFirstChild("BodyForce") then
                    LocalPlayer.Character.HumanoidRootPart.BodyForce:Destroy()
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
        {name = "CloneCharacter", callback = function(enabled)
            if enabled then
                local clone = LocalPlayer.Character:Clone()
                clone.Parent = workspace
                clone:MoveTo(LocalPlayer.Character.HumanoidRootPart.Position + Vector3.new(0, 5, 0))
            else
                for _, v in pairs(workspace:GetChildren()) do
                    if v:IsA("Model") and v.Name == LocalPlayer.Name and v ~= LocalPlayer.Character then
                        v:Destroy()
                    end
                end
            end
        end},
        {name = "GhostMode", callback = function(enabled)
            if enabled then
                for _, part in pairs(LocalPlayer.Character:GetDescendants()) do
                    if part:IsA("BasePart") then
                        part.Transparency = 0.5
                    end
                end
            else
                for _, part in pairs(LocalPlayer.Character:GetDescendants()) do
                    if part:IsA("BasePart") then
                        part.Transparency = 0
                    end
                end
            end
        end},
        {name = "CustomOutfit", callback = function(enabled)
            if enabled then
                local shirt = Instance.new("Shirt", LocalPlayer.Character)
                shirt.ShirtTemplate = "rbxassetid://1234567890" -- Reemplaza con el ID de la camisa deseada
                local pants = Instance.new("Pants", LocalPlayer.Character)
                pants.PantsTemplate = "rbxassetid://0987654321" -- Reemplaza con el ID del pantalón deseado
            else
                for _, v in pairs(LocalPlayer.Character:GetChildren()) do
                    if v:IsA("Shirt") or v:IsA("Pants") then
                        v:Destroy()
                    end
                end
            end
        end},
        {name = "AnimationChanger", callback = function(enabled)
            if enabled then
                local anim = Instance.new("Animation")
                anim.AnimationId = "rbxassetid://507771019" -- Reemplaza con el ID de la animación deseada
                local track = LocalPlayer.Character.Humanoid:LoadAnimation(anim)
                track:Play()
            else
                for _, v in pairs(LocalPlayer.Character.Humanoid:GetPlayingAnimationTracks()) do
                    v:Stop()
                end
            end
        end},
        {name = "BodyPartRemover", callback = function(enabled)
            if enabled then
                for _, v in pairs(LocalPlayer.Character:GetChildren()) do
                    if v:IsA("BasePart") and v.Name ~= "Head" and v.Name ~= "HumanoidRootPart" then
                        v:Destroy()
                    end
                end
            else
                LocalPlayer.Character:BreakJoints()
                LocalPlayer.Character:Remove()
                LocalPlayer.CharacterAdded:Wait()
            end
        end},
        {name = "FakeHeadless", callback = function(enabled)
            if enabled then
                if LocalPlayer.Character:FindFirstChild("Head") then
                    LocalPlayer.Character.Head.Transparency = 1
                    for _, v in pairs(LocalPlayer.Character.Head:GetChildren()) do
                        if v:IsA("Decal") then
                            v:Destroy()
                        end
                    end
                end
            else
                if LocalPlayer.Character:FindFirstChild("Head") then
                    LocalPlayer.Character.Head.Transparency = 0
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
        {name = "MutePlayers", callback = function(enabled)
            if enabled then
                for _, player in pairs(Players:GetPlayers()) do
                    if player ~= LocalPlayer then
                        player.Character.Humanoid.DisplayDistanceType = Enum.HumanoidDisplayDistanceType.None
                    end
                end
            else
                for _, player in pairs(Players:GetPlayers()) do
                    player.Character.Humanoid.DisplayDistanceType = Enum.HumanoidDisplayDistanceType.Viewer
                end
            end
        end},
        {name = "SoundSpammer", callback = function(enabled)
            if enabled then
                spawn(function()
                    while enabled do
                        local sound = Instance.new("Sound", workspace)
                        sound.SoundId = "rbxassetid://" .. tostring(math.random(1000000, 9999999))
                        sound:Play()
                        wait(0.1)
                        sound:Destroy()
                    end
                end)
            end
        end},
        {name = "PitchChanger", callback = function(enabled)
            if enabled then
                for _, v in pairs(workspace:GetDescendants()) do
                    if v:IsA("Sound") then
                        v.PlaybackSpeed = 2 -- Cambia el tono
                    end
                end
            else
                for _, v in pairs(workspace:GetDescendants()) do
                    if v:IsA("Sound") then
                        v.PlaybackSpeed = 1 -- Restaura el tono original
                    end
                end
            end
        end},
        {name = "EchoEffect", callback = function(enabled)
            if enabled then
                local echo = Instance.new("EchoSoundEffect")
                echo.Delay = 1
                echo.Parent = SoundService
            else
                for _, v in pairs(SoundService:GetChildren()) do
                    if v:IsA("EchoSoundEffect") then
                        v:Destroy()
                    end
                end
            end
        end},
        {name = "ReverseSounds", callback = function(enabled)
            if enabled then
                for _, v in pairs(workspace:GetDescendants()) do
                    if v:IsA("Sound") then
                        v.TimePosition = v.TimeLength
                        v.PlaybackSpeed = -1
                    end
                end
            else
                for _, v in pairs(workspace:GetDescendants()) do
                    if v:IsA("Sound") then
                        v.TimePosition = 0
                        v.PlaybackSpeed = 1
                    end
                end
            end
        end},
        {name = "CustomMusicPlayer", callback = function(enabled)
            if enabled then
                local musicId = "rbxassetid://1234567890" -- Reemplaza con el ID de la música deseada
                local music = Instance.new("Sound", workspace)
                music.SoundId = musicId
                music.Looped = true
                music:Play()
            else
                for _, v in pairs(workspace:GetChildren()) do
                    if v:IsA("Sound") and v.SoundId:match("rbxassetid://1234567890") then
                        v:Destroy()
                    end
                end
            end
        end},
        {name = "SoundDistorter", callback = function(enabled)
            if enabled then
                local distortion = Instance.new("DistortionSoundEffect")
                distortion.Level = 1
                distortion.Parent = SoundService
            else
                for _, v in pairs(SoundService:GetChildren()) do
                    if v:IsA("DistortionSoundEffect") then
                        v:Destroy()
                    end
                end
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
        {name = "FakeServerMessage", callback = function(enabled)
            if enabled then
                local message = Instance.new("Message", workspace)
                message.Text = "El servidor se reiniciará en 60 segundos."
                wait(5)
                message:Destroy()
            end
        end},
        {name = "RemoteSpyLogger", callback = function(enabled)
            if enabled then
                local logFolder = Instance.new("Folder")
                logFolder.Name = "RemoteSpyLogs"
                logFolder.Parent = game:GetService("CoreGui")
                
                local function logRemote(remote, args)
                    local logLabel = Instance.new("TextLabel")
                    logLabel.Text = remote.Name .. " | Args: " .. tostring(args)
                    logLabel.Parent = logFolder
                end
                
                for _, v in pairs(game:GetDescendants()) do
                    if v:IsA("RemoteEvent") then
                        local oldFireServer = v.FireServer
                        v.FireServer = function(self, ...)
                            local args = {...}
                            logRemote(v, args)
                            return oldFireServer(self, ...)
                        end
                    end
                end
            else
                local logFolder = game:GetService("CoreGui"):FindFirstChild("RemoteSpyLogs")
                if logFolder then
                    logFolder:Destroy()
                end
            end
        end},
        {name = "AntiKick", callback = function(enabled)
            if enabled then
                local mt = getrawmetatable(game)
                local oldNamecall = mt.__namecall
                setreadonly(mt, false)
                mt.__namecall = newcclosure(function(self, ...)
                    local method = getnamecallmethod()
                    if method == "Kick" then
                        return wait(9e9)
                    end
                    return oldNamecall(self, ...)
                end)
                setreadonly(mt, true)
            else
                local mt = getrawmetatable(game)
                setreadonly(mt, false)
                mt.__namecall = oldNamecall
                setreadonly(mt, true)
            end
        end},
        {name = "AntiBan", callback = function(enabled)
            if enabled then
                local mt = getrawmetatable(game)
                local oldNamecall = mt.__namecall
                setreadonly(mt, false)
                mt.__namecall = newcclosure(function(self, ...)
                    local method = getnamecallmethod()
                    if method == "GetService" then
                        local service = ...
                        if service == "NetworkClient" then
                            return nil
                        end
                    end
                    return oldNamecall(self, ...)
                end)
                setreadonly(mt, true)
            else
                local mt = getrawmetatable(game)
                setreadonly(mt, false)
                mt.__namecall = oldNamecall
                setreadonly(mt, true)
            end
        end},
        {name = "ServerSideExecutor", callback = function(enabled)
            if enabled then
                local function serverExec(code)
                    local func, err = loadstring(code)
                    if func then
                        func()
                    else
                        warn("Error al ejecutar código del servidor:", err)
                    end
                end
                
                local textBox = Instance.new("TextBox")
                textBox.Size = UDim2.new(0, 200, 0, 100)
                textBox.Position = UDim2.new(0.5, -100, 0.5, -50)
                textBox.Parent = ScreenGui
                
                local execButton = Instance.new("TextButton")
                execButton.Size = UDim2.new(0, 100, 0, 30)
                execButton.Position = UDim2.new(0.5, -50, 0.5, 60)
                execButton.Text = "Ejecutar"
                execButton.Parent = ScreenGui
                
                execButton.MouseButton1Click:Connect(function()
                    serverExec(textBox.Text)
                end)
            else
                for _, v in pairs(ScreenGui:GetChildren()) do
                    if v:IsA("TextBox") or v:IsA("TextButton") then
                        v:Destroy()
                    end
                end
            end
        end},
        {name = "BackdoorScanner", callback = function(enabled)
            if enabled then
                local function scanForBackdoors()
                    local backdoors = {}
                    for _, v in pairs(game:GetDescendants()) do
                        if v:IsA("RemoteEvent") and v.Name:lower():match("backdoor") then
                            table.insert(backdoors, v)
                        end
                    end
                    return backdoors
                end
                
                local backdoors = scanForBackdoors()
                for _, backdoor in ipairs(backdoors) do
                    print("Posible backdoor encontrado:", backdoor:GetFullName())
                end
            end
        end},
    },
    Ambiente = {
        {name = "TimeChanger", callback = function(enabled)
            if enabled then
                spawn(function()
                    while enabled do
                        Lighting.ClockTime = (Lighting.ClockTime + 0.1) % 24
                        wait(0.1)
                    end
                end)
            else
                Lighting.ClockTime = 14 -- Restaura la hora por defecto
            end
        end},
        {name = "WeatherController", callback = function(enabled)
            if enabled then
                local atmosphere = Instance.new("Atmosphere")
                atmosphere.Parent = Lighting
                
                spawn(function()
                    while enabled do
                        atmosphere.Density = math.random(0, 1)
                        atmosphere.Offset = math.random(0, 1)
                        atmosphere.Color = Color3.new(math.random(), math.random(), math.random())
                        wait(5)
                    end
                end)
            else
                if Lighting:FindFirstChild("Atmosphere") then
                    Lighting.Atmosphere:Destroy()
                end
            end
        end},
        {name = "GravityManipulator", callback = function(enabled)
            if enabled then
                workspace.Gravity = 0
            else
                workspace.Gravity = 196.2
            end
        end},
        {name = "FogController", callback = function(enabled)
            if enabled then
                spawn(function()
                    while enabled do
                        Lighting.FogEnd = math.random(50, 500)
                        Lighting.FogColor = Color3.new(math.random(), math.random(), math.random())
                        wait(1)
                    end
                end)
            else
                Lighting.FogEnd = 100000
                Lighting.FogColor = Color3.new(0.75, 0.75, 0.75)
            end
        end},
        {name = "SkyboxChanger", callback = function(enabled)
            if enabled then
                local skybox = Instance.new("Sky")
                skybox.Parent = Lighting
                skybox.SkyboxBk = "rbxassetid://1012890"
                skybox.SkyboxDn = "rbxassetid://1012891"
                skybox.SkyboxFt = "rbxassetid://1012887"
                skybox.SkyboxLf = "rbxassetid://1012889"
                skybox.SkyboxRt = "rbxassetid://1012888"
                skybox.SkyboxUp = "rbxassetid://1014449"
            else
                if Lighting:FindFirstChild("Sky") then
                    Lighting.Sky:Destroy()
                end
            end
        end},
        {name = "TerrainDestroyer", callback = function(enabled)
            if enabled then
                workspace.Terrain:Clear()
            else
                workspace.Terrain:Clear()
                workspace.Terrain:PasteRegion(workspace.Terrain:CopyRegion(workspace.Terrain.MaxExtents), workspace.Terrain.MaxExtents.p1, true)
            end
        end},
        {name = "LightingEffects", callback = function(enabled)
            if enabled then
                local blur = Instance.new("BlurEffect")
                blur.Size = 10
                blur.Parent = Lighting
                
                local colorCorrection = Instance.new("ColorCorrectionEffect")
                colorCorrection.Brightness = 0.2
                colorCorrection.Contrast = 0.5
                colorCorrection.Saturation = 0.7
                colorCorrection.Parent = Lighting
            else
                for _, v in pairs(Lighting:GetChildren()) do
                    if v:IsA("BlurEffect") or v:IsA("ColorCorrectionEffect") then
                        v:Destroy()
                    end
                end
            end
        end},
        {name = "MapFlooder", callback = function(enabled)
            if enabled then
                spawn(function()
                    while enabled do
                        local water = Instance.new("Part")
                        water.Size = Vector3.new(10, 1, 10)
                        water.Position = Vector3.new(math.random(-100, 100), 0, math.random(-100, 100))
                        water.Anchored = true
                        water.BrickColor = BrickColor.new("Bright blue")
                        water.Transparency = 0.5
                        water.Parent = workspace
                        wait(0.1)
                    end
                end)
            else
                for _, v in pairs(workspace:GetChildren()) do
                    if v:IsA("Part") and v.BrickColor == BrickColor.new("Bright blue") and v.Transparency == 0.5 then
                        v:Destroy()
                    end
                end
            end
        end},
        {name = "PartReplicator", callback = function(enabled)
            if enabled then
                spawn(function()
                    while enabled do
                        for _, v in pairs(workspace:GetDescendants()) do
                            if v:IsA("BasePart") then
                                local clone = v:Clone()
                                clone.Position = v.Position + Vector3.new(0, 5, 0)
                                clone.Parent = workspace
                            end
                        end
                        wait(5)
                    end
                end)
            else
                for _, v in pairs(workspace:GetDescendants()) do
                    if v:IsA("BasePart") and v.Name:match("Clone") then
                        v:Destroy()
                    end
                end
            end
        end},
        {name = "TextureChanger", callback = function(enabled)
            if enabled then
                for _, v in pairs(workspace:GetDescendants()) do
                    if v:IsA("BasePart") then
                        v.Material = Enum.Material.Neon
                    end
                end
            else
                for _, v in pairs(workspace:GetDescendants()) do
                    if v:IsA("BasePart") then
                        v.Material = Enum.Material.Plastic
                    end
                end
            end
        end},
    },
    Jugadores = {
        {name = "TeleportToPlayer", callback = function(enabled)
            if enabled then
                local players = Players:GetPlayers()
                local randomPlayer = players[math.random(1, #players)]
                if randomPlayer.Character and randomPlayer.Character:FindFirstChild("HumanoidRootPart") then
                    LocalPlayer.Character.HumanoidRootPart.CFrame = randomPlayer.Character.HumanoidRootPart.CFrame
                end
            end
        end},
        {name = "CopyAppearance", callback = function(enabled)
            if enabled then
                local players = Players:GetPlayers()
                local randomPlayer = players[math.random(1, #players)]
                if randomPlayer ~= LocalPlayer then
                    LocalPlayer.Character:FindFirstChildOfClass("Humanoid"):ApplyDescription(Players:GetHumanoidDescriptionFromUserId(randomPlayer.UserId))
                end
            end
        end},
        {name = "Forcefield", callback = function(enabled)
            if enabled then
                local forcefield = Instance.new("ForceField")
                forcefield.Parent = LocalPlayer.Character
            else
                for _, v in pairs(LocalPlayer.Character:GetChildren()) do
                    if v:IsA("ForceField") then
                        v:Destroy()
                    end
                end
            end
        end},
        {name = "GodMode", callback = function(enabled)
            if enabled then
                local clone = LocalPlayer.Character:Clone()
                LocalPlayer.Character = clone
                clone.Parent = workspace
                camera.CameraSubject = clone:FindFirstChildOfClass("Humanoid")
            else
                LocalPlayer.Character:BreakJoints()
                LocalPlayer.CharacterAdded:Wait()
            end
        end},
        {name = "SpectatePlayer", callback = function(enabled)
            if enabled then
                local players = Players:GetPlayers()
                local randomPlayer = players[math.random(1, #players)]
                if randomPlayer ~= LocalPlayer and randomPlayer.Character then
                    camera.CameraSubject = randomPlayer.Character:FindFirstChildOfClass("Humanoid")
                end
            else
                camera.CameraSubject = LocalPlayer.Character:FindFirstChildOfClass("Humanoid")
            end
        end},
        {name = "FreezePlayer", callback = function(enabled)
            if enabled then
                LocalPlayer.Character.HumanoidRootPart.Anchored = true
            else
                LocalPlayer.Character.HumanoidRootPart.Anchored = false
            end
        end},
        {name = "PushPlayers", callback = function(enabled)
            if enabled then
                spawn(function()
                    while enabled do
                        for _, player in pairs(Players:GetPlayers()) do
                            if player ~= LocalPlayer and player.Character and player.Character:FindFirstChild("HumanoidRootPart") then
                                local direction = (player.Character.HumanoidRootPart.Position - LocalPlayer.Character.HumanoidRootPart.Position).Unit
                                player.Character.HumanoidRootPart.Velocity = direction * 50
                            end
                        end
                        wait(0.1)
                    end
                end)
            end
        end},
        {name = "PlayerMagnet", callback = function(enabled)
            if enabled then
                spawn(function()
                    while enabled do
                        for _, player in pairs(Players:GetPlayers()) do
                            if player ~= LocalPlayer and player.Character and player.Character:FindFirstChild("HumanoidRootPart") then
                                local direction = (LocalPlayer.Character.HumanoidRootPart.Position - player.Character.HumanoidRootPart.Position).Unit
                                player.Character.HumanoidRootPart.Velocity = direction * 50
                            end
                        end
                        wait(0.1)
                    end
                end)
            end
        end},
        {name = "ClickTeleport", callback = function(enabled)
            if enabled then
                local mouse = LocalPlayer:GetMouse()
                mouse.Button1Down:Connect(function()
                    if mouse.Target then
                        LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(mouse.Hit.p + Vector3.new(0, 3, 0))
                    end
                end)
            end
        end},
        {name = "PlayerTracer", callback = function(enabled)
            if enabled then
                for _, player in pairs(Players:GetPlayers()) do
                    if player ~= LocalPlayer then
                        local line = Instance.new("Beam")
                        line.Attachment0 = LocalPlayer.Character.HumanoidRootPart.RootAttachment
                        local attachment = Instance.new("Attachment", player.Character.HumanoidRootPart)
                        line.Attachment1 = attachment
                        line.Width0 = 0.1
                        line.Width1 = 0.1
                        line.Parent = workspace
                    end
                end
            else
                for _, v in pairs(workspace:GetChildren()) do
                    if v:IsA("Beam") then
                        v:Destroy()
                    end
                end
            end
        end},
    },
    Física = {
        {name = "ExplodeCharacter", callback = function(enabled)
            if enabled then
                for _, part in pairs(LocalPlayer.Character:GetDescendants()) do
                    if part:IsA("BasePart") then
                        local explosion = Instance.new("Explosion")
                        explosion.Position = part.Position
                        explosion.BlastRadius = 5
                        explosion.BlastPressure = 1000000
                        explosion.Parent = workspace
                    end
                end
            end
        end},
        {name = "AntiGravity", callback = function(enabled)
            if enabled then
                for _, part in pairs(LocalPlayer.Character:GetDescendants()) do
                    if part:IsA("BasePart") then
                        local bodyForce = Instance.new("BodyForce")
                        bodyForce.Force = Vector3.new(0, workspace.Gravity * part:GetMass(), 0)
                        bodyForce.Parent = part
                    end
                end
            else
                for _, part in pairs(LocalPlayer.Character:GetDescendants()) do
                    if part:IsA("BasePart") then
                        local bodyForce = part:FindFirstChild("BodyForce")
                        if bodyForce then
                            bodyForce:Destroy()
                        end
                    end
                end
            end
        end},
        {name = "SuperStrength", callback = function(enabled)
            if enabled then
                LocalPlayer.Character.Humanoid.JumpPower = 100
                for _, part in pairs(LocalPlayer.Character:GetDescendants()) do
                    if part:IsA("BasePart") then
                        part.CustomPhysicalProperties = PhysicalProperties.new(0.1, 0, 0, 100, 100)
                    end
                end
            else
                LocalPlayer.Character.Humanoid.JumpPower = 50
                for _, part in pairs(LocalPlayer.Character:GetDescendants()) do
                    if part:IsA("BasePart") then
                        part.CustomPhysicalProperties = PhysicalProperties.new(0.7, 0, 0.3, 1, 1)
                    end
                end
            end
        end},
        {name = "RagdollCharacter", callback = function(enabled)
            if enabled then
                LocalPlayer.Character.Humanoid.PlatformStand = true
                for _, joint in pairs(LocalPlayer.Character:GetDescendants()) do
                    if joint:IsA("Motor6D") then
                        local socket = Instance.new("BallSocketConstraint")
                        local a0 = Instance.new("Attachment")
                        local a1 = Instance.new("Attachment")
                        socket.Attachment0 = a0
                        socket.Attachment1 = a1
                        a0.Parent = joint.Part0
                        a1.Parent = joint.Part1
                        socket.Parent = joint.Parent
                        joint:Destroy()
                    end
                end
            else
                LocalPlayer.Character:BreakJoints()
                LocalPlayer.CharacterAdded:Wait()
            end
        end},
        {name = "VelocityMultiplier", callback = function(enabled)
            if enabled then
                spawn(function()
                    while enabled do
                        for _, part in pairs(LocalPlayer.Character:GetDescendants()) do
                            if part:IsA("BasePart") then
                                part.Velocity = part.Velocity * 2
                            end
                        end
                        wait(0.1)
                    end
                end)
            end
        end},
        {name = "
