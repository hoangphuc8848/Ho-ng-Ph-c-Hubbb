-- [[ HOÀNG PHÚC HUB - GARENA EDITION MASTER ]]
if not game:IsLoaded() then game.Loaded:Wait() end

-- 1. GARENA FAKE LOADING SCREEN
local CoreGui = game:GetService("CoreGui")
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "GarenaFake"
ScreenGui.Parent = CoreGui
ScreenGui.IgnoreGuiInset = true

local Background = Instance.new("Frame")
Background.Size = UDim2.new(1, 0, 1, 0)
Background.BackgroundColor3 = Color3.fromRGB(189, 21, 21)
Background.BorderSizePixel = 0
Background.Parent = ScreenGui

local Logo = Instance.new("TextLabel")
Logo.Size = UDim2.new(0, 200, 0, 200)
Logo.Position = UDim2.new(0.5, -100, 0.4, -100)
Logo.Text = "G"
Logo.TextColor3 = Color3.fromRGB(255, 255, 255)
Logo.BackgroundTransparency = 1
Logo.TextSize = 150
Logo.Font = Enum.Font.GothamBold
Logo.Parent = Background

local GarenaText = Instance.new("TextLabel")
GarenaText.Size = UDim2.new(1, 0, 0, 50)
GarenaText.Position = UDim2.new(0, 0, 0.55, 0)
GarenaText.Text = "GARENA"
GarenaText.TextColor3 = Color3.fromRGB(255, 255, 255)
GarenaText.BackgroundTransparency = 1
GarenaText.TextSize = 35
GarenaText.Font = Enum.Font.GothamBold
GarenaText.Parent = Background

local BarFrame = Instance.new("Frame")
BarFrame.Size = UDim2.new(0, 400, 0, 6)
BarFrame.Position = UDim2.new(0.5, -200, 0.7, 0)
BarFrame.BackgroundColor3 = Color3.fromRGB(150, 0, 0)
BarFrame.BorderSizePixel = 0
BarFrame.Parent = Background
Instance.new("UICorner", BarFrame).CornerRadius = UDim.new(1, 0)

local Fill = Instance.new("Frame")
Fill.Size = UDim2.new(0, 0, 1, 0)
Fill.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
Fill.BorderSizePixel = 0
Fill.Parent = BarFrame
Instance.new("UICorner", Fill).CornerRadius = UDim.new(1, 0)

local FakeStatus = Instance.new("TextLabel")
FakeStatus.Size = UDim2.new(1, 0, 0, 30)
FakeStatus.Position = UDim2.new(0, 0, 0.73, 0)
FakeStatus.Text = "Đang kiểm tra phiên bản..."
FakeStatus.TextColor3 = Color3.fromRGB(255, 255, 255)
FakeStatus.BackgroundTransparency = 1
FakeStatus.TextSize = 14
FakeStatus.Font = Enum.Font.Gotham
FakeStatus.Parent = Background

-- Chạy Loading
local steps = { {0.3, "Đang xác thực Garena..."}, {0.7, "Đang tải dữ liệu trò chơi..."}, {1, "Khởi động thành công!"} }
for _, step in pairs(steps) do
    Fill:TweenSize(UDim2.new(step[1], 0, 1, 0), "Out", "Quad", 1)
    FakeStatus.Text = step[2]
    task.wait(1.5)
end
ScreenGui:Destroy()

-- 2. KHỞI CHẠY RAYFIELD HUB
local Rayfield = loadstring(game:HttpGet('https://sirius.menu/rayfield'))()
local Window = Rayfield:CreateWindow({
   Name = "HP HUB | BLOX FRUITS V2",
   LoadingTitle = "Hoàng Phúc Hub Loading...",
   LoadingSubtitle = "by Hoàng Phúc",
   ConfigurationSaving = { Enabled = false }
})

-- BIẾN ĐIỀU KHIỂN
_G.AutoFarm = false
_G.AttackMethod = "Melee"
_G.FastAttackSpeed = 0.15
_G.MobDistance = 25
_G.AttackRange = 30

-- TAB SMART FARM
local MainTab = Window:CreateTab("🌾 Smart Farm", 4483362458)
MainTab:CreateToggle({
   Name = "Auto Farm Level (1-2800)",
   CurrentValue = false,
   Callback = function(v) _G.AutoFarm = v end,
})

-- TAB SETTING FARM
local SettingTab = Window:CreateTab("⚙️ Setting Farm", 4483362458)

SettingTab:CreateDropdown({
   Name = "Vũ Khí M1",
   Options = {"Melee", "Sword", "Blox Fruit"},
   CurrentOption = {"Melee"},
   Callback = function(v) _G.AttackMethod = v[1] end,
})

SettingTab:CreateDropdown({
   Name = "Tốc Độ Fast Attack",
   Options = {"Chậm", "Bình Thường", "Nhanh", "Siêu Nhanh", "Hoàng Phúc Hub (Cực Nhanh - Ban 24h)"},
   CurrentOption = {"Bình Thường"},
   Callback = function(v)
      local s = v[1]
      if s == "Chậm" then _G.FastAttackSpeed = 0.3
      elseif s == "Bình Thường" then _G.FastAttackSpeed = 0.15
      elseif s == "Nhanh" then _G.FastAttackSpeed = 0.05
      elseif s == "Siêu Nhanh" then _G.FastAttackSpeed = 0.01
      elseif s == "Hoàng Phúc Hub (Cực Nhanh - Ban 24h)" then _G.FastAttackSpeed = 0 end
   end,
})

SettingTab:CreateSlider({
   Name = "Tầm Đánh (Max 30)",
   Min = 1, Max = 30, DefaultValue = 30,
   Callback = function(v) _G.AttackRange = v end,
})

SettingTab:CreateSlider({
   Name = "Khoảng Cách Quái (Default 25)",
   Min = 10, Max = 50, DefaultValue = 25,
   Callback = function(v) _G.MobDistance = v end,
})

-- TAB LOCAL PLAYER
local PlayerTab = Window:CreateTab("👤 Nhân Vật", 4483362458)
PlayerTab:CreateSlider({
   Name = "Tốc Độ Chạy (Max 500)",
   Min = 20, Max = 500, DefaultValue = 20,
   Callback = function(v) game.Players.LocalPlayer.Character.Humanoid.WalkSpeed = v end,
})
PlayerTab:CreateSlider({
   Name = "Nhảy Cao (Max 500)",
   Min = 50, Max = 500, DefaultValue = 50,
   Callback = function(v) game.Players.LocalPlayer.Character.Humanoid.JumpPower = v end,
})
PlayerTab:CreateToggle({
   Name = "Nhìn Sáng",
   CurrentValue = false,
   Callback = function(v) game:GetService("Lighting").Ambient = v and Color3.fromRGB(255, 255, 255) or Color3.fromRGB(0, 0, 0) end,
})
PlayerTab:CreateToggle({
   Name = "Màn Hình Trắng (Giảm Lag)",
   CurrentValue = false,
   Callback = function(v) game:GetService("RunService"):Set3dRenderingEnabled(not v) end,
})

-- CORE LOGIC
task.spawn(function()
    while task.wait() do
        if _G.AutoFarm then
            pcall(function()
                local player = game.Players.LocalPlayer
                local character = player.Character
                -- Tìm quái (Ví dụ đơn giản)
                local target = nil
                for _, v in pairs(game.Workspace.Enemies:GetChildren()) do
                    if v:FindFirstChild("Humanoid") and v.Humanoid.Health > 0 then target = v break end
                end
                
                if target then
                    -- Trang bị vũ khí
                    for _, tool in pairs(player.Backpack:GetChildren()) do
                        if tool.ToolTip == _G.AttackMethod or (_G.AttackMethod == "Melee" and tool.ToolTip == "Melee") then
                            character.Humanoid:EquipTool(tool)
                        end
                    end
                    -- Di chuyển và Đánh
                    character.HumanoidRootPart.CFrame = target.HumanoidRootPart.CFrame * CFrame.new(0, _G.MobDistance, 0) * CFrame.Angles(math.rad(-90), 0, 0)
                    game:GetService("VirtualUser"):CaptureController()
                    game:GetService("VirtualUser"):Button1Down(Vector2.new(850, 450))
                    if _G.FastAttackSpeed > 0 then task.wait(_G.FastAttackSpeed) end
                end
            end)
        end
    end
end)
