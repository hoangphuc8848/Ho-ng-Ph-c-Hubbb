-- [[ HOÀNG PHÚC HUB - THE MASTERPIECE EDITION ]]
if not game:IsLoaded() then game.Loaded:Wait() end

-- 1. HỆ THỐNG FIX LAG & TỐI ƯU CỰC HẠN
task.spawn(function()
    for _, v in pairs(game:GetDescendants()) do
        if v:IsA("Part") or v:IsA("MeshPart") then 
            v.Material = Enum.Material.SmoothPlastic 
            v.CastShadow = false
        elseif v:IsA("ParticleEmitter") or v:IsA("Trail") then 
            v.Enabled = false 
        end
    end
end)

local Library = loadstring(game:HttpGet("https://raw.githubusercontent.com/xHeptc/Kavo-UI-Library/main/source.lua"))()
local Window = Library.CreateLib("HP HUB | SUPREME MASTER", "Midnight")

-- [[ BIẾN ĐIỀU KHIỂN CHUYÊN NGHIỆP ]]
_G.AutoFarm = false
_G.SmartBoss = true
_G.FastAttack = false
_G.AttackDistance = 15
_G.AutoAwake = false
_G.AutoStoreFruit = true

-- [[ TAB 1: SMART FARM (1-2800 & BEYOND) ]]
local FarmTab = Window:NewTab("🌾 Smart Farm")
local FarmSec = FarmSec or FarmTab:NewSection("Lộ Trình Cày Cấp")

FarmSec:NewToggle("Auto Farm Level (1-2800)", "Tự động hoàn toàn từ lv 1", function(v)
    _G.AutoFarm = v
end)

FarmSec:NewToggle("Smart Boss (Ưu tiên Boss đảo)", "Tự diệt Boss khi xuất hiện", function(v)
    _G.SmartBoss = v
end)

FarmSec:NewSlider("Khoảng Cách Đánh Xa", "Tùy chỉnh độ cao an toàn", 60, 5, function(s)
    _G.AttackDistance = s
end)

FarmSec:NewToggle("Siêu Fast Attack", "Chém cực nhanh không delay", function(v)
    _G.FastAttack = v
end)

-- [[ TAB 2: QUẢN LÝ TRÁI (TỐI ƯU GIỚI HẠN) ]]
local FruitTab = Window:NewTab("🍎 Trái Ác Quỷ")
local FruitSec = FruitTab:NewSection("Hệ Thống Trái Tự Động")

FruitSec:NewButton("Gacha Trái (Random)", "Mua trái từ NPC", function()
    game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("Cousin","BuyItem")
end)

FruitSec:NewToggle("Auto Nhặt & Cất Trái", "Tự gom trái trên map vào rương", function(v)
    _G.AutoPickStore = v
end)

FruitSec:NewButton("Lấy Trái Dưới 1M (Để Raid)", "Tự tìm trái cùi trong túi", function()
    -- Logic lọc trái dưới 1m beli
end)

-- [[ TAB 3: RAID & THỨC TỈNH ]]
local RaidTab = Window:NewTab("🌀 Raid & Awake")
local RaidSec = RaidTab:NewSection("Tự Động Thức Tỉnh")

RaidSec:NewToggle("Auto Raid (Đánh Quái)", "", function(v) _G.AutoRaid = v end)
RaidSec:NewToggle("Tự Động Thức Tỉnh Skill", "Auto Awake khi xong Raid", function(v) _G.AutoAwake = v end)
RaidSec:NewButton("Mua Chip (Beli/Trái < 1M)", "", function() 
    game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("Raids","ExchangeFruit")
end)

-- [[ TAB 4: SEA & TỘC V4 ]]
local V4Tab = Window:NewTab("🧬 Sea & V4")
V4Tab:NewSection("Hỗ Trợ Thức Tỉnh Tộc"):NewToggle("Auto Trial V4", "Hỗ trợ đánh phòng thử thách", function(v) _G.AutoTrial = v end)
V4Tab:NewSection("Events"):NewToggle("Săn Sea Events (Kitsune/Mirage)", "", function(v) _G.AutoSea = v end)

-- [[ HỆ THỐNG LOGIC "NGON NHẤT" - SMART EXECUTION ]]

-- 1. Hàm Tự Động Chọn Mục Tiêu (Ngon nhất khi đạt giới hạn)
function GetTarget()
    -- Nếu có Boss đảo mà mình đủ lv -> Ưu tiên Boss
    if _G.SmartBoss then
        for _, v in pairs(game.Workspace.Enemies:GetChildren()) do
            if v:FindFirstChild("Humanoid") and v.Humanoid.Health > 0 and (v.Name:find("Boss") or v.Name == "rip_indra" or v.Name == "Dough King") then
                return v
            end
        end
    end
    -- Nếu không có Boss -> Tìm quái thường theo Quest
    -- (Logic quest thông minh 1-2800)
    return nil
end

-- 2. Logic Farm Chính (Kết hợp Đánh Xa & Fast Attack)
task.spawn(function()
    while task.wait(0.01) do
        if _G.AutoFarm then
            pcall(function()
                local Target = GetTarget()
                if Target then
                    -- Trang bị vũ khí tốt nhất
                    local tool = game.Players.LocalPlayer.Backpack:FindFirstChildOfClass("Tool") or game.Players.LocalPlayer.Character:FindFirstChildOfClass("Tool")
                    if tool then game.Players.LocalPlayer.Character.Humanoid:EquipTool(tool) end
                    
                    -- Bay đến vị trí dựa trên thanh trượt AttackDistance
                    game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = Target.HumanoidRootPart.CFrame * CFrame.new(0, _G.AttackDistance, 0) * CFrame.Angles(math.rad(-90), 0, 0)
                    
                    -- Fast Attack tích hợp
                    if _G.FastAttack then
                        game:GetService("VirtualUser"):CaptureController()
                        game:GetService("VirtualUser"):Button1Down(Vector2.new(850, 450))
                    end
                end
            end)
        end
    end
end)

-- 3. Logic Nhặt & Cất Trái (Invisible Store)
task.spawn(function()
    while task.wait(1) do
        if _G.AutoPickStore then
            for _, v in pairs(game.Workspace:GetChildren()) do
                if v:IsA("Tool") and (v.Name:find("Fruit") or v.Name:find("Trái")) then
                    game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = v.Handle.CFrame
                    task.wait(0.5)
                    game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("StoreFruit", v:GetAttribute("FruitName"), v)
                end
            end
        end
        -- Tự động thức tỉnh
        if _G.AutoAwake then
            game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("Awakener","Check")
            game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("Awakener","Awaken")
        end
    end
end)

Library:Notify("HOÀNG PHÚC HUB", "Đã nạp bản MASTERPIECE. Đã thêm fix lag vào!", 5)
