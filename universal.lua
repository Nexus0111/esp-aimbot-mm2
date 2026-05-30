--[[
    SEXSDED Universal v3.0
    Fly | Noclip | ESP | Aimbot | Speed | MM2 ESP
    Fixed & Clean
]]

local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local UserInputService = game:GetService("UserInputService")
local RunService = game:GetService("RunService")
local Workspace = game:GetService("Workspace")

-- Create GUI
local gui = Instance.new("ScreenGui")
gui.Name = "SEXSDED"
gui.ResetOnSpawn = false
gui.Parent = game.CoreGui

-- Main window
local main = Instance.new("Frame")
main.Size = UDim2.new(0, 280, 0, 360)
main.Position = UDim2.new(0.5, -140, 0.5, -180)
main.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
main.BorderColor3 = Color3.fromRGB(255, 255, 255)
main.BorderSizePixel = 1
main.Active = true
main.Draggable = true
main.Parent = gui

-- Top bar
local topBar = Instance.new("Frame")
topBar.Size = UDim2.new(1, 0, 0, 30)
topBar.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
topBar.BorderSizePixel = 0
topBar.Parent = main

local title = Instance.new("TextLabel")
title.Size = UDim2.new(0, 150, 1, 0)
title.Position = UDim2.new(0, 8, 0, 0)
title.BackgroundTransparency = 1
title.Text = "SEXSDED v3.0"
title.TextColor3 = Color3.fromRGB(255, 255, 255)
title.TextSize = 14
title.Font = Enum.Font.SourceSansBold
title.TextXAlignment = Enum.TextXAlignment.Left
title.Parent = topBar

local closeBtn = Instance.new("TextButton")
closeBtn.Size = UDim2.new(0, 25, 0, 25)
closeBtn.Position = UDim2.new(1, -28, 0, 2)
closeBtn.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
closeBtn.BorderSizePixel = 0
closeBtn.Text = "X"
closeBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
closeBtn.TextSize = 12
closeBtn.Font = Enum.Font.SourceSansBold
closeBtn.Parent = topBar
closeBtn.MouseButton1Click:Connect(function()
    shutdown()
    gui:Destroy()
end)

-- Tab buttons
local tabFrame = Instance.new("Frame")
tabFrame.Size = UDim2.new(1, 0, 0, 25)
tabFrame.Position = UDim2.new(0, 0, 0, 31)
tabFrame.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
tabFrame.BorderSizePixel = 0
tabFrame.Parent = main

local pages = {}
local currentPage = nil

local function createTab(name, x, page)
    local btn = Instance.new("TextButton")
    btn.Size = UDim2.new(0.25, -1, 1, 0)
    btn.Position = UDim2.new(x, 0, 0, 0)
    btn.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
    btn.BorderSizePixel = 0
    btn.Text = name
    btn.TextColor3 = Color3.fromRGB(180, 180, 180)
    btn.TextSize = 10
    btn.Font = Enum.Font.SourceSansBold
    btn.Parent = tabFrame
    btn.MouseButton1Click:Connect(function()
        for _, p in pairs(pages) do p.Frame.Visible = false end
        for _, c in pairs(tabFrame:GetChildren()) do
            if c:IsA("TextButton") then
                c.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
                c.TextColor3 = Color3.fromRGB(180, 180, 180)
            end
        end
        page.Visible = true
        btn.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
        btn.TextColor3 = Color3.fromRGB(0, 0, 0)
        currentPage = page
    end)
    pages[#pages + 1] = {Frame = page, Button = btn}
    return btn
end

-- Pages
local flyPage = Instance.new("Frame")
flyPage.Size = UDim2.new(1, 0, 1, -58)
flyPage.Position = UDim2.new(0, 0, 0, 57)
flyPage.BackgroundTransparency = 1
flyPage.Visible = true
flyPage.Parent = main

local combatPage = Instance.new("Frame")
combatPage.Size = UDim2.new(1, 0, 1, -58)
combatPage.Position = UDim2.new(0, 0, 0, 57)
combatPage.BackgroundTransparency = 1
combatPage.Visible = false
combatPage.Parent = main

local visualPage = Instance.new("Frame")
visualPage.Size = UDim2.new(1, 0, 1, -58)
visualPage.Position = UDim2.new(0, 0, 0, 57)
visualPage.BackgroundTransparency = 1
visualPage.Visible = false
visualPage.Parent = main

local mm2Page = Instance.new("Frame")
mm2Page.Size = UDim2.new(1, 0, 1, -58)
mm2Page.Position = UDim2.new(0, 0, 0, 57)
mm2Page.BackgroundTransparency = 1
visualPage.Visible = false
mm2Page.Parent = main

currentPage = flyPage

createTab("FLY", 0, flyPage)
createTab("AIM", 0.25, combatPage)
createTab("ESP", 0.5, visualPage)
createTab("MM2", 0.75, mm2Page)

-- Select first tab
local firstTab = tabFrame:FindFirstChildOfClass("TextButton")
if firstTab then
    firstTab.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    firstTab.TextColor3 = Color3.fromRGB(0, 0, 0)
end

-- Create scroller for a page
local function makeScroller(parent)
    local sc = Instance.new("ScrollingFrame")
    sc.Size = UDim2.new(1, 0, 1, 0)
    sc.BackgroundTransparency = 1
    sc.ScrollBarThickness = 2
    sc.ScrollBarImageColor3 = Color3.fromRGB(255, 255, 255)
    sc.CanvasSize = UDim2.new(0, 0, 0, 500)
    sc.Parent = parent
    return sc
end

local flyScroller = makeScroller(flyPage)
local aimScroller = makeScroller(combatPage)
local espScroller = makeScroller(visualPage)
local mm2Scroller = makeScroller(mm2Page)

-- Notification
local function notify(msg)
    spawn(function()
        for _, v in pairs(main:GetChildren()) do
            if v.Name == "Notif" then v:Destroy() end
        end
        local n = Instance.new("TextLabel")
        n.Name = "Notif"
        n.Size = UDim2.new(0, 160, 0, 18)
        n.Position = UDim2.new(1, -168, 0, 33)
        n.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
        n.BorderColor3 = Color3.fromRGB(255, 255, 255)
        n.BorderSizePixel = 1
        n.Text = msg
        n.TextColor3 = Color3.fromRGB(255, 255, 255)
        n.TextSize = 9
        n.Font = Enum.Font.SourceSansBold
        n.Parent = main
        n.ZIndex = 10
        wait(2)
        n:Destroy()
    end)
end

-- UI helpers
local function addLabel(sc, text, y)
    local lbl = Instance.new("TextLabel")
    lbl.Size = UDim2.new(1, -16, 0, 16)
    lbl.Position = UDim2.new(0, 8, 0, y)
    lbl.BackgroundTransparency = 1
    lbl.Text = text
    lbl.TextColor3 = Color3.fromRGB(200, 200, 200)
    lbl.TextSize = 9
    lbl.Font = Enum.Font.SourceSansBold
    lbl.TextXAlignment = Enum.TextXAlignment.Left
    lbl.Parent = sc
    return lbl
end

local function addDivider(sc, y)
    local div = Instance.new("Frame")
    div.Size = UDim2.new(1, -16, 0, 1)
    div.Position = UDim2.new(0, 8, 0, y + 16)
    div.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
    div.BorderSizePixel = 0
    div.Parent = sc
end

local function addToggle(sc, text, y, callback)
    local state = false
    local btn = Instance.new("TextButton")
    btn.Size = UDim2.new(1, -16, 0, 26)
    btn.Position = UDim2.new(0, 8, 0, y)
    btn.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
    btn.BorderColor3 = Color3.fromRGB(100, 100, 100)
    btn.BorderSizePixel = 1
    btn.Text = "  " .. text .. ": OFF"
    btn.TextColor3 = Color3.fromRGB(220, 220, 220)
    btn.TextSize = 10
    btn.Font = Enum.Font.SourceSansBold
    btn.TextXAlignment = Enum.TextXAlignment.Left
    btn.Parent = sc

    btn.MouseButton1Click:Connect(function()
        state = not state
        if state then
            btn.Text = "  " .. text .. ": ON"
            btn.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
            btn.TextColor3 = Color3.fromRGB(0, 0, 0)
            btn.BorderColor3 = Color3.fromRGB(255, 255, 255)
        else
            btn.Text = "  " .. text .. ": OFF"
            btn.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
            btn.TextColor3 = Color3.fromRGB(220, 220, 220)
            btn.BorderColor3 = Color3.fromRGB(100, 100, 100)
        end
        callback(state)
    end)
end

local function addSlider(sc, text, min, max, default, y, callback)
    local lbl = Instance.new("TextLabel")
    lbl.Size = UDim2.new(1, -16, 0, 14)
    lbl.Position = UDim2.new(0, 8, 0, y)
    lbl.BackgroundTransparency = 1
    lbl.Text = text .. ": " .. default
    lbl.TextColor3 = Color3.fromRGB(180, 180, 180)
    lbl.TextSize = 9
    lbl.Font = Enum.Font.SourceSans
    lbl.TextXAlignment = Enum.TextXAlignment.Left
    lbl.Parent = sc

    local barBg = Instance.new("Frame")
    barBg.Size = UDim2.new(1, -16, 0, 18)
    barBg.Position = UDim2.new(0, 8, 0, y + 15)
    barBg.BackgroundTransparency = 1
    barBg.Parent = sc

    local bar = Instance.new("Frame")
    bar.Size = UDim2.new(1, 0, 0, 4)
    bar.Position = UDim2.new(0, 0, 0, 7)
    bar.BackgroundColor3 = Color3.fromRGB(70, 70, 70)
    bar.BorderSizePixel = 0
    bar.Parent = barBg

    local fill = Instance.new("Frame")
    local ratio = (default - min) / (max - min)
    fill.Size = UDim2.new(ratio, 0, 1, 0)
    fill.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    fill.BorderSizePixel = 0
    fill.Parent = bar

    local dragging = false

    local function update(inputX)
        local relX = math.clamp(inputX - bar.AbsolutePosition.X, 0, bar.AbsoluteSize.X)
        local pos = relX / bar.AbsoluteSize.X
        local val = math.floor(min + (max - min) * pos + 0.5)
        fill.Size = UDim2.new(pos, 0, 1, 0)
        lbl.Text = text .. ": " .. val
        callback(val)
    end

    bar.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 then
            dragging = true
            update(input.Position.X)
        end
    end)

    UserInputService.InputEnded:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 then
            dragging = false
        end
    end)

    UserInputService.InputChanged:Connect(function(input)
        if dragging and input.UserInputType == Enum.UserInputType.MouseMovement then
            update(input.Position.X)
        end
    end)
end

-- ==================== FLY ====================
local flyEnabled = false
local flySpeed = 50
local flyBodyGyro = nil
local flyBodyVelocity = nil
local flyConnection = nil

local function flyCleanup()
    if flyBodyGyro then flyBodyGyro:Destroy(); flyBodyGyro = nil end
    if flyBodyVelocity then flyBodyVelocity:Destroy(); flyBodyVelocity = nil end
    if flyConnection then flyConnection:Disconnect(); flyConnection = nil end
end

local function flyAttach(root)
    flyCleanup()
    if not root then return end
    flyBodyGyro = Instance.new("BodyGyro")
    flyBodyGyro.MaxTorque = Vector3.new(9e9, 9e9, 9e9)
    flyBodyGyro.P = 30000
    flyBodyGyro.CFrame = root.CFrame
    flyBodyGyro.Parent = root

    flyBodyVelocity = Instance.new("BodyVelocity")
    flyBodyVelocity.MaxForce = Vector3.new(9e9, 9e9, 9e9)
    flyBodyVelocity.Velocity = Vector3.zero
    flyBodyVelocity.P = 50000
    flyBodyVelocity.Parent = root
end

local function flyStart()
    local char = LocalPlayer.Character
    if not char then return end
    local root = char:FindFirstChild("HumanoidRootPart")
    if not root then return end
    flyAttach(root)

    flyConnection = RunService.Heartbeat:Connect(function()
        if not flyEnabled then return end
        local char = LocalPlayer.Character
        if not char then return end
        local root = char:FindFirstChild("HumanoidRootPart")
        if not root then return end

        if flyBodyVelocity and flyBodyVelocity.Parent ~= root then
            flyAttach(root)
        end

        local cam = Workspace.CurrentCamera
        if not cam then return end

        local dir = Vector3.zero
        if UserInputService:IsKeyDown(Enum.KeyCode.W) then dir = dir + cam.CFrame.LookVector end
        if UserInputService:IsKeyDown(Enum.KeyCode.S) then dir = dir - cam.CFrame.LookVector end
        if UserInputService:IsKeyDown(Enum.KeyCode.A) then dir = dir - cam.CFrame.RightVector end
        if UserInputService:IsKeyDown(Enum.KeyCode.D) then dir = dir + cam.CFrame.RightVector end
        if UserInputService:IsKeyDown(Enum.KeyCode.Space) then dir = dir + Vector3.yAxis end
        if UserInputService:IsKeyDown(Enum.KeyCode.LeftShift) then dir = dir - Vector3.yAxis end

        if flyBodyVelocity then
            flyBodyVelocity.Velocity = dir.Magnitude > 0 and dir.Unit * flySpeed or Vector3.zero
        end
        if flyBodyGyro then
            flyBodyGyro.CFrame = CFrame.new(root.Position, root.Position + cam.CFrame.LookVector)
        end
    end)
end

local function flyStop()
    flyEnabled = false
    flyCleanup()
end

-- Respawn handler
LocalPlayer.CharacterAdded:Connect(function(char)
    if flyEnabled then
        task.wait(0.3)
        local root = char:FindFirstChild("HumanoidRootPart")
        if root then flyAttach(root) end
    end
end)

-- ==================== NOCLIP ====================
local noclipEnabled = false
local noclipConnection = nil

local function noclipStart()
    if noclipConnection then noclipConnection:Disconnect() end
    noclipConnection = RunService.Stepped:Connect(function()
        if not noclipEnabled then return end
        pcall(function()
            local char = LocalPlayer.Character
            if char then
                for _, p in pairs(char:GetDescendants()) do
                    if p:IsA("BasePart") then p.CanCollide = false end
                end
            end
        end)
    end)
end

local function noclipStop()
    if noclipConnection then noclipConnection:Disconnect(); noclipConnection = nil end
    pcall(function()
        local char = LocalPlayer.Character
        if char then
            for _, p in pairs(char:GetDescendants()) do
                if p:IsA("BasePart") then p.CanCollide = true end
            end
        end
    end)
end

-- ==================== SPEED ====================
local speedEnabled = false
local speedVal = 50
local speedConnection = nil

local function speedStart()
    if speedConnection then speedConnection:Disconnect() end
    speedConnection = RunService.Heartbeat:Connect(function()
        if not speedEnabled then return end
        pcall(function()
            local char = LocalPlayer.Character
            if char then
                local hum = char:FindFirstChild("Humanoid")
                if hum then hum.WalkSpeed = speedVal end
            end
        end)
    end)
    pcall(function()
        local char = LocalPlayer.Character
        if char then
            local hum = char:FindFirstChild("Humanoid")
            if hum then hum.WalkSpeed = speedVal end
        end
    end)
end

local function speedStop()
    if speedConnection then speedConnection:Disconnect(); speedConnection = nil end
    pcall(function()
        local char = LocalPlayer.Character
        if char then
            local hum = char:FindFirstChild("Humanoid")
            if hum then hum.WalkSpeed = 16 end
        end
    end)
end

-- ==================== ESP ====================
local espEnabled = false
local espHighlights = {}

local function espCleanup()
    for _, h in pairs(espHighlights) do
        pcall(function() h:Destroy() end)
    end
    espHighlights = {}
end

local function espAddHighlight(part)
    if not part:IsA("BasePart") then return end
    local h = Instance.new("Highlight")
    h.FillColor = Color3.fromRGB(255, 255, 255)
    h.FillTransparency = 0.85
    h.OutlineColor = Color3.fromRGB(255, 255, 255)
    h.OutlineTransparency = 0
    h.Adornee = part
    h.Parent = part
    table.insert(espHighlights, h)
end

local function espAddPlayer(player)
    local function onChar(char)
        for _, p in pairs(char:GetDescendants()) do
            espAddHighlight(p)
        end
        char.DescendantAdded:Connect(function(p)
            espAddHighlight(p)
        end)
    end
    if player.Character then onChar(player.Character) end
    player.CharacterAdded:Connect(onChar)
end

local function espStart()
    espCleanup()
    for _, p in pairs(Players:GetPlayers()) do
        if p ~= LocalPlayer then espAddPlayer(p) end
    end
    Players.PlayerAdded:Connect(function(p)
        if espEnabled then espAddPlayer(p) end
    end)
end

local function espStop()
    espCleanup()
end

-- ==================== AIMBOT ====================
local aimbotEnabled = false
local aimbotFov = 200
local aimbotSmooth = 5
local aimbotConnection = nil
local aimbotCircle = nil

local function aimbotCleanup()
    if aimbotConnection then aimbotConnection:Disconnect(); aimbotConnection = nil end
    if aimbotCircle then aimbotCircle:Destroy(); aimbotCircle = nil end
end

local function aimbotUpdateCircle()
    if aimbotCircle then
        aimbotCircle.Size = UDim2.new(0, aimbotFov * 2, 0, aimbotFov * 2)
        aimbotCircle.Position = UDim2.new(0.5, -aimbotFov, 0.5, -aimbotFov)
    end
end

local function aimbotGetTarget()
    local cam = Workspace.CurrentCamera
    if not cam then return nil end
    local center = Vector2.new(cam.ViewportSize.X / 2, cam.ViewportSize.Y / 2)
    local best, bestDist = nil, aimbotFov
    for _, p in pairs(Players:GetPlayers()) do
        if p ~= LocalPlayer and p.Character then
            local head = p.Character:FindFirstChild("Head")
            local hum = p.Character:FindFirstChild("Humanoid")
            if head and hum and hum.Health > 0 then
                local sp, onScreen = cam:WorldToViewportPoint(head.Position)
                if onScreen then
                    local d = (Vector2.new(sp.X, sp.Y) - center).Magnitude
                    if d < bestDist then
                        bestDist = d
                        best = head
                    end
                end
            end
        end
    end
    return best
end

local function aimbotStart()
    aimbotCleanup()
    aimbotCircle = Instance.new("Frame")
    aimbotCircle.Size = UDim2.new(0, aimbotFov * 2, 0, aimbotFov * 2)
    aimbotCircle.Position = UDim2.new(0.5, -aimbotFov, 0.5, -aimbotFov)
    aimbotCircle.BackgroundTransparency = 1
    aimbotCircle.ZIndex = 999
    aimbotCircle.Parent = gui
    local stroke = Instance.new("UIStroke")
    stroke.Color = Color3.fromRGB(255, 255, 255)
    stroke.Thickness = 1
    stroke.Transparency = 0.5
    stroke.Parent = aimbotCircle
    local corner = Instance.new("UICorner")
    corner.CornerRadius = UDim.new(1, 0)
    corner.Parent = aimbotCircle

    aimbotConnection = RunService.Heartbeat:Connect(function()
        if not aimbotEnabled then return end
        if not UserInputService:IsMouseButtonPressed(1) then return end
        local head = aimbotGetTarget()
        if head then
            local cam = Workspace.CurrentCamera
            if cam then
                local goal = CFrame.new(cam.CFrame.Position, head.Position)
                cam.CFrame = cam.CFrame:Lerp(goal, aimbotSmooth / 100)
            end
        end
    end)
end

local function aimbotStop()
    aimbotCleanup()
end

-- ==================== MM2 ESP ====================
local mm2espEnabled = false
local mm2espObjects = {}
local mm2espUpdate = nil

local function mm2GetRole(player)
    local char = player.Character
    if not char then return "Innocent", Color3.fromRGB(0, 255, 0) end
    for _, t in pairs(char:GetChildren()) do
        if t:IsA("Tool") then
            local n = t.Name:lower()
            if n:find("knife") then return "Murderer", Color3.fromRGB(255, 0, 0) end
            if n:find("sheriff") then return "Sheriff", Color3.fromRGB(0, 100, 255) end
            if n:find("gun") or n:find("pistol") then return "Hero", Color3.fromRGB(255, 255, 0) end
        end
    end
    return "Innocent", Color3.fromRGB(0, 255, 0)
end

local function mm2espCleanup()
    for _, d in pairs(mm2espObjects) do
        for _, h in pairs(d.Highlights) do
            pcall(function() h:Destroy() end)
        end
    end
    mm2espObjects = {}
    if mm2espUpdate then mm2espUpdate:Disconnect(); mm2espUpdate = nil end
end

local function mm2espAdd(player)
    local data = {Player = player, Highlights = {}}
    local function addH(part, col)
        if not part:IsA("BasePart") then return end
        local h = Instance.new("Highlight")
        h.FillColor = col
        h.FillTransparency = 0.7
        h.OutlineColor = col
        h.OutlineTransparency = 0
        h.Adornee = part
        h.Parent = part
        table.insert(data.Highlights, h)
    end
    local function onChar(char)
        local _, col = mm2GetRole(player)
        for _, p in pairs(char:GetDescendants()) do
            addH(p, col)
        end
        char.DescendantAdded:Connect(function(p)
            local _, currentCol = mm2GetRole(player)
            addH(p, currentCol)
        end)
    end
    if player.Character then onChar(player.Character) end
    player.CharacterAdded:Connect(onChar)
    table.insert(mm2espObjects, data)
end

local function mm2espUpdateColors()
    for _, d in pairs(mm2espObjects) do
        local _, col = mm2GetRole(d.Player)
        for _, h in pairs(d.Highlights) do
            if h and h.Parent then
                h.FillColor = col
                h.OutlineColor = col
            end
        end
    end
end

local function mm2espStart()
    mm2espCleanup()
    for _, p in pairs(Players:GetPlayers()) do
        if p ~= LocalPlayer then mm2espAdd(p) end
    end
    Players.PlayerAdded:Connect(function(p)
        if mm2espEnabled then mm2espAdd(p) end
    end)
    mm2espUpdate = RunService.Heartbeat:Connect(function()
        if not mm2espEnabled then return end
        pcall(mm2espUpdateColors)
    end)
end

local function mm2espStop()
    mm2espCleanup()
end

-- ==================== SHUTDOWN ====================
function shutdown()
    flyEnabled = false
    noclipEnabled = false
    espEnabled = false
    aimbotEnabled = false
    speedEnabled = false
    mm2espEnabled = false
    flyCleanup()
    noclipStop()
    espCleanup()
    aimbotCleanup()
    mm2espCleanup()
    if speedConnection then speedConnection:Disconnect() end
    pcall(function()
        local char = LocalPlayer.Character
        if char then
            local hum = char:FindFirstChild("Humanoid")
            if hum then hum.WalkSpeed = 16 end
            for _, p in pairs(char:GetDescendants()) do
                if p:IsA("BasePart") then p.CanCollide = true end
            end
        end
    end)
end

-- ==================== BUILD UI ====================

-- FLY TAB
local y = 5
addLabel(flyScroller, "FLIGHT", y)
addDivider(flyScroller, y)
y = y + 20
addToggle(flyScroller, "Fly", y, function(s)
    flyEnabled = s
    if s then flyStart() else flyStop() end
    notify(s and "Fly ON" or "Fly OFF")
end)
y = y + 32
addSlider(flyScroller, "Speed", 10, 200, 50, y, function(v) flySpeed = v end)
y = y + 38
addLabel(flyScroller, "NOCLIP", y)
addDivider(flyScroller, y)
y = y + 20
addToggle(flyScroller, "Noclip", y, function(s)
    noclipEnabled = s
    if s then noclipStart() else noclipStop() end
    notify(s and "Noclip ON" or "Noclip OFF")
end)
y = y + 32
addLabel(flyScroller, "SPEED", y)
addDivider(flyScroller, y)
y = y + 20
addToggle(flyScroller, "Speed Boost", y, function(s)
    speedEnabled = s
    if s then speedStart() else speedStop() end
    notify(s and "Speed ON" or "Speed OFF")
end)
y = y + 32
addSlider(flyScroller, "Walk Speed", 16, 200, 50, y, function(v)
    speedVal = v
    if speedEnabled then
        pcall(function()
            local char = LocalPlayer.Character
            if char then
                local hum = char:FindFirstChild("Humanoid")
                if hum then hum.WalkSpeed = v end
            end
        end)
    end
end)
y = y + 40
flyScroller.CanvasSize = UDim2.new(0, 0, 0, y)

-- AIM TAB
y = 5
addLabel(aimScroller, "AIMBOT", y)
addDivider(aimScroller, y)
y = y + 20
addToggle(aimScroller, "Aimbot", y, function(s)
    aimbotEnabled = s
    if s then aimbotStart() else aimbotStop() end
    notify(s and "Aimbot ON" or "Aimbot OFF")
end)
y = y + 32
addSlider(aimScroller, "FOV", 50, 500, 200, y, function(v)
    aimbotFov = v
    aimbotUpdateCircle()
end)
y = y + 38
addSlider(aimScroller, "Smooth", 1, 30, 5, y, function(v) aimbotSmooth = v end)
y = y + 50
aimScroller.CanvasSize = UDim2.new(0, 0, 0, y)

-- ESP TAB
y = 5
addLabel(espScroller, "PLAYER ESP", y)
addDivider(espScroller, y)
y = y + 20
addToggle(espScroller, "ESP", y, function(s)
    espEnabled = s
    if s then espStart() else espStop() end
    notify(s and "ESP ON" or "ESP OFF")
end)
y = y + 50
espScroller.CanvasSize = UDim2.new(0, 0, 0, y)

-- MM2 TAB
y = 5
addLabel(mm2Scroller, "MM2 ESP", y)
addDivider(mm2Scroller, y)
y = y + 20
addToggle(mm2Scroller, "MM2 ESP", y, function(s)
    mm2espEnabled = s
    if s then mm2espStart() else mm2espStop() end
    notify(s and "MM2 ESP ON" or "MM2 ESP OFF")
end)
y = y + 32
addLabel(mm2Scroller, "Colors:", y)
y = y + 16
local colors = {
    {"Murderer - RED", Color3.fromRGB(255, 0, 0)},
    {"Sheriff - BLUE", Color3.fromRGB(0, 100, 255)},
    {"Hero - YELLOW", Color3.fromRGB(255, 255, 0)},
    {"Innocent - GREEN", Color3.fromRGB(0, 255, 0)}
}
for _, c in pairs(colors) do
    local lbl = Instance.new("TextLabel")
    lbl.Size = UDim2.new(1, -16, 0, 14)
    lbl.Position = UDim2.new(0, 8, 0, y)
    lbl.BackgroundTransparency = 1
    lbl.Text = "   " .. c[1]
    lbl.TextColor3 = c[2]
    lbl.TextSize = 9
    lbl.Font = Enum.Font.SourceSansBold
    lbl.TextXAlignment = Enum.TextXAlignment.Left
    lbl.Parent = mm2Scroller
    y = y + 16
end
y = y + 10
mm2Scroller.CanvasSize = UDim2.new(0, 0, 0, y)

notify("SEXSDED loaded!")
