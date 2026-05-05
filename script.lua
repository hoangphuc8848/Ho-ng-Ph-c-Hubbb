-- [[ HOÀNG PHÚC HUB - ULTIMATE EDITION ]]
-- KHỞI TẠO SIÊU TỐC
if not game:IsLoaded() then game.Loaded:Wait() end

-- TỐI ƯU FPS & GIẢM LAG NGAY LẬP TỨC
task.spawn(function()
    for _, v in pairs(game:GetDescendants()) do
        if v:IsA("Part") or v:IsA("MeshPart") then
            v.Material = Enum.Material.SmoothPlastic
        elseif v:IsA("ParticleEmitter") or v:IsA("Trail") then
            v.Enabled = false
        end
    end
end)

-- LOAD THƯ VIỆN UI
local Library = loadstring(game:HttpGet("https://raw.githubusercontent.com/xHeptc/Kavo-UI-Library/main/source.lua"))()
local Window = Library.CreateLib("HP HUB | BLOX FRUITS PRO", "Midnight")

-- [[ BIẾN ĐIỀU KHIỂN - MẶC ĐỊNH FALSE ]]
_G.AutoFarmLevel = false
_G.AutoFarmBoss = false
_G.FastAttack = false
_G.AutoPvP = false
_G.Aimbot = false
_G.AutoSeaEvent = false
_G.AutoPickFruit = false
_G.AutoRaid = false
_G.AutoAwake = false
_G.AutoTrial = false
_G.TweenSpeed = 150

-- [[ TAB 1: THÔNG TIN ]]
local InfoTab = Window:NewTab("👤 Info")
local InfoSection = InfoTab:NewSection("Tác giả: HOÀNG PHÚC")
InfoSection:NewLabel("Tiktok: @phuc190714")
InfoSection:NewKeybind("Ẩn/Hiện Menu", "Phím tắt mặc định: RightCtrl", Enum.KeyCode.RightControl, function()
    Library:ToggleUI()
end)

-- [[ TAB 2: FARM (LEVEL & BOSS) ]]
local FarmTab = Window:NewTab("🌾 Farm")
local FarmSection = FarmTab:NewSection("Cày Cấp & Boss")
FarmSection:NewToggle("Auto Farm Level", "Tự nhận Quest và đánh quái", function(v) _G.AutoFarmLevel = v end)
FarmSection:NewToggle("Auto Farm Boss", "Tự tìm Boss trong server", function(v) _G.AutoFarmBoss = v end)
FarmSection:NewToggle("Đánh Nhanh (Fast Attack)", "Tăng tốc độ farm", function(v) _G.FastAttack = v end)

-- [[ TAB 3: PVP MODE ]]
local PVPTab = Window:NewTab("⚔️ PvP")
local PVPSection = PVPTab:NewSection("Chiến Đấu")
PVPSection:NewToggle("Auto PvP Smart", "Tấn công người gần nhất", function(v) _G.AutoPvP = v end)
PVPSection:NewToggle("Aimbot Skill", "Tự nhắm kỹ năng", function(v) _G.Aimbot = v end)

-- [[ TAB 4: TRÁI ÁC QUỶ ]]
local FruitTab = Window:NewTab("🍎 Trái Ác Quỷ")
local FruitSection = FruitTab:NewSection("Quản Lý Trái")
FruitSection:NewButton("Random Trái (Gacha)", "Mua trái từ NPC", function()
    game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("Cousin","BuyItem")
end)
FruitSection:NewToggle("Tự Nhặt Trái", "Bay đến trái trên Map", function(v) _G.AutoPickFruit = v end)
FruitSection:NewButton("Cất Trái (Store All)", "Lưu vào rương", function()
    for _, v in pairs(game.Players.LocalPlayer.Backpack:GetChildren()) do
        if v:IsA("Tool") and v:FindFirstChild("Fruit") then
            game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("StoreFruit", v:GetAttribute("FruitName"), v)
        end
    end
end)
FruitSection:NewButton("Thả Trái", "Drop trái đang cầm", function()
    if game.Players.LocalPlayer.Character:FindFirstChildOfClass("Tool") then
        game.Players.LocalPlayer.Character:FindFirstChildOfClass("Tool").Parent = game.Workspace
    end
end)

-- [[ TAB 5: RAID & THỨC TỈNH ]]
local RaidTab = Window:NewTab("🌀 Raid")
local RaidSection = RaidTab:NewSection("Tự Động Raid")
RaidSection:NewToggle("Auto Raid", "Đánh quái trong đảo Raid", function(v) _G.AutoRaid = v end)
RaidSection:NewToggle("Tự Thức Tỉnh (Auto Awake)", "Tự mua chiêu thức tỉnh", function(v) _G.AutoAwake = v end)
RaidSection:NewButton("Mua Chip (100k Beli)", "Mua bằng tiền", function()
    game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("BlackbeardReward","Byte","Item",1)
end)
RaidSection:NewButton("Đổi Chip (Trái < 1M)", "Dùng trái cùi đổi chip", function()
    game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("Raids","ExchangeFruit")
end)

-- [[ TAB 6: SEA EVENTS & V4 ]]
local SeaTab = Window:NewTab("🌊 Events & V4")
local SeaSection = SeaTab:NewSection("Kitsune/Leviathan/Mirage")
SeaSection:NewToggle("Săn Sea Events", "Tìm Boss và Đảo hiếm", function(v) _G.AutoSeaEvent = v end)
SeaSection:NewToggle("Auto Trial V4", "Hỗ trợ thử thách tộc", function(v) _G.AutoTrial = v end)
SeaSection:NewSlider("Tốc Độ Bay (Tween)", "Nên để 150 để né Ban", 300, 50, function(s) _G.TweenSpeed = s end)

-- [[ HỆ THỐNG LOGIC XỬ LÝ - CHẠY NGẦM MƯỢT MÀ ]]

-- Logic Farm & Đánh nhanh
task.spawn(function()
    while task.wait(0.1) do
        if _G.FastAttack or _G.AutoFarmLevel or _G.AutoRaid then
            pcall(function()
                local VU = game:GetService("VirtualUser")
                VU:CaptureController()
                VU:ClickButton1(Vector2.new(850, 450))
            end)
        end
    end
end)

-- Logic Nhặt trái & Săn Event
task.spawn(function()
    while task.wait(1) do
        if _G.AutoPickFruit then
            for _, v in pairs(game.Workspace:GetChildren()) do
                if v:IsA("Tool") and (v.Name:find("Fruit") or v.Name:find("Trái")) then
                    game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = v.Handle.CFrame
                    break
                end
            end
        end
        if _G.AutoAwake then
            game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("Awakener","Check")
            game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("Awakener","Awaken")
        end
    end
end)

Library:Notify("HOÀNG PHÚC HUB", "Đã sẵn sàng! Nhấn Right Ctrl để mở Menu.", 5)
