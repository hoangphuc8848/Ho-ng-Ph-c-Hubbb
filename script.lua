-- [[ HOÀNG PHÚC HUB - ULTIMATE PERFORMANCE EDITION ]]
if not game:IsLoaded() then game.Loaded:Wait() end

-- 1. HỆ THỐNG SIÊU FIX LAG & TĂNG FPS (CHẠY NGAY LẬP TỨC)
pcall(function()
    settings().Rendering.QualityLevel = Enum.QualityLevel.Level01
    game:GetService("Lighting").GlobalShadows = false
    game:GetService("Lighting").FogEnd = 9e9
    for _, v in pairs(game:GetDescendants()) do
        if v:IsA("Part") or v:IsA("MeshPart") or v:IsA("BasePart") then
            v.Material = Enum.Material.SmoothPlastic
            v.CastShadow = false
        elseif v:IsA("Decal") or v:IsA("Texture") then
            v:Destroy()
        elseif v:IsA("ParticleEmitter") or v:IsA("Trail") then
            v.Enabled = false
        end
    end
end)

-- 2. KHỞI CHẠY RAYFIELD MENU (NGUỒN MỚI NHẤT)
local Rayfield = loadstring(game:HttpGet('https://sirius.menu/rayfield'))()

local Window = Rayfield:CreateWindow({
   Name = "HP HUB | BLOX FRUITS V2.6",
   LoadingTitle = "Đang tối ưu FPS...",
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
   Name = "Vũ Khí Farm (M1)",
   Options = {"Melee", "Sword", "Blox Fruit"},
   CurrentOption = {"Melee"},
   Callback = function(v) _G.AttackMethod = v[1] end,
})

SettingTab:CreateDropdown({
   Name = "Tốc Độ Fast Attack",
   Options = {"Chậm", "Bình Thường", "Nhanh", "Siêu Nhanh", "Hoàng Phúc Hub (Tốc Độ Bàn Thờ)"},
   CurrentOption = {"Bình Thường"},
   Callback = function(v)
      local s = v[1]
      if s == "Chậm" then _G.FastAttackSpeed = 0.3
      elseif s == "Bình Thường" then _G.FastAttackSpeed = 0.15
      elseif s == "Nhanh" then _G.FastAttackSpeed = 0.05
      elseif s == "Siêu Nhanh" then _G.FastAttackSpeed = 0.01
      elseif s == "Hoàng Phúc Hub (Tốc Độ Bàn Thờ)" then _G.FastAttackSpeed = 0 end
   end,
})

SettingTab:CreateSlider({
   Name = "Tầm Đánh (Max 30)",
   Min = 1, Max = 30, DefaultValue = 30,
   Callback = function(v) _G.AttackRange = v end,
})

SettingTab:CreateSlider({
   Name = "Khoảng Cách Quái",
   Min = 10, Max = 50, DefaultValue = 25,
   Callback = function(v) _G.MobDistance = v end,
})

-- TAB LOCAL PLAYER & BOOST FPS
local PlayerTab = Window:CreateTab("🚀 Tăng Tốc", 4483362458)

PlayerTab:CreateButton({
   Name = "Siêu Tăng FPS (Xóa Texture)",
   Callback = function()
       pcall(function()
           for _, v in pairs(game:GetDescendants()) do
               if v:IsA("BasePart") then v.Material = Enum.Material.SmoothPlastic end
               if v:IsA("Decal") then v:Destroy() end
           end
       end)
   end,
})

PlayerTab:CreateToggle({
   Name = "Màn Hình Trắng (Treo Máy Cực Mượt)",
   CurrentValue = false,
   Callback = function(v) game:GetService("RunService"):Set3dRenderingEnabled(not v) end,
})

PlayerTab:CreateSlider({
   Name = "Tốc Độ Chạy",
   Min = 20, Max = 500, DefaultValue = 20,
   Callback = function(v) game.Players.LocalPlayer.Character.Humanoid.WalkSpeed = v end,
})

-- CORE LOGIC FARM (ĐÃ TỐI ƯU)
task.spawn(function()
    while task.wait() do
        if _G.AutoFarm then
            pcall(function()
                local player = game.Players.LocalPlayer
                local character = player.Character
                local target = nil
                
                for _, v in pairs(game.Workspace.Enemies:GetChildren()) do
                    if v:FindFirstChild("Humanoid") and v.Humanoid.Health > 0 then
                        target = v
                        break
                    end
                end
                
                if target then
                    for _, tool in pairs(player.Backpack:GetChildren()) do
                        if tool.ToolTip == _G.AttackMethod or (_G.AttackMethod == "Melee" and tool.ToolTip == "Melee") then
                            character.Humanoid:EquipTool(tool)
                        end
                    end
                    character.HumanoidRootPart.CFrame = target.HumanoidRootPart.CFrame * CFrame.new(0, _G.MobDistance, 0) * CFrame.Angles(math.rad(-90), 0, 0)
                    game:GetService("VirtualUser"):CaptureController()
                    game:GetService("VirtualUser"):Button1Down(Vector2.new(850, 450))
                    if _G.FastAttackSpeed > 0 then task.wait(_G.FastAttackSpeed) end
                end
            end)
        end
    end
end)

Rayfield:Notify({
   Title = "HOÀNG PHÚC HUB",
   Content = "Đã Fix Lag và Tăng FPS thành công!",
   Duration = 5,
})
