getgenv().autotap = false -- true means its enabled / false means disabled
getgenv().autorebirth = false -- true means its enabled / false means disabled
getgenv().bugEgg = false -- true means its enabled / false means disabled
getgenv().autoHill = false

local remotePath = game:GetService("ReplicatedStorage").Aero.AeroRemoteServices

local ClickMod = require(game:GetService("Players").LameAkame.PlayerScripts.Aero.Controllers.UI.Click)

local gamepassMod = require(game:GetService("ReplicatedStorage").Aero.Shared.Gamepasses)

gamepassMod.HasPassOtherwisePrompt = function() return true end


local library = loadstring(game:HttpGet(('https://raw.githubusercontent.com/bloodball/-back-ups-for-libs/main/wall%20v3')))()
local p = library:CreateWindow("  Clicker Madness Script")
local b = p:CreateFolder("Farming")
local h = p:CreateFolder("Rebirths")
local c = p:CreateFolder("Eggs") 
local d = p:CreateFolder("Teleport")
local f = library:CreateWindow("Localplayer")
local l = library:CreateWindow("Credits")
local i = f:CreateFolder("Local")
local x = l:CreateFolder("Credits")


i:Slider("Walkspeed",{
    min = 16;
    max = 100;
    precise = true
},function(value)
    game.Players.LocalPlayer.Character.Humanoid.WalkSpeed = value
end)

i:Slider("Jumppower",{
    min = 50;
    max = 500;
    precise = true
},function(value)
    game.Players.LocalPlayer.Character.Humanoid.JumpPower = value
end)

x:Label("Made by Akame#1531",{
    TextSize = 18; -- Self Explaining
    TextColor = Color3.fromRGB(255,255,255); -- Self Explaining
    BgColor = Color3.fromRGB(0,0,0); -- Self Explaining
    
}) 
b:DestroyGui()

b:Toggle("Autoclicker",function(bool)
    getgenv().autotap = bool
    print("Auto Tap is: ", bool)
    if bool then
        doTap()
    end
end)

b:Toggle("Auto beastmode",function(bool)
    getgenv().autotap = bool
    if bool then 
        doBeast()
    end
end)

b:Toggle("Auto Attack",function(bool)
    getgenv().autotap = bool
    print("Auto Tap is: ", bool)
    if bool then
        doTap()
    end
end)

b:Toggle("Autohill",function(bool)
    getgenv().autoHill = bool
    if bool then
        autofarmhill()
    end
end)

local selectedRebirth
h:Dropdown("RebirthAmount",{"1","10","100", "1000", "10000", "100000", "1000000", "10000000", "100000000", "1000000000"},true,function(value)
    selectedRebirth = value
end)
h:Toggle("Autorebirth",function(bool)
    getgenv().autorebirth = bool
    print("Auto rebirth is: ", bool)
    if bool then
        autorebirth(selectedRebirth)
    end
end)

h:Button("Unlock Autorebirth",function(bool)
    gamepassMod = bool
    if bool then
        unlockGamepasses()
    end
end)


local selectedEgg
c:Dropdown("Select egg: ",{"basic","lava","desert"},true,function(value)
    selectedEgg = value
end)
c:Toggle("Buy egg",function(bool)
    getgenv().bugEgg = bool
    print("Auto buy egg is: ", bool)
    if bool and selectedEgg then
        buyEgg(selectedEgg)
    end
end)

c:Label("Too lazy to add new eggs",{
    TextSize = 18; -- Self Explaining
    TextColor = Color3.fromRGB(255,255,255); -- Self Explaining
    BgColor = Color3.fromRGB(0,0,0); -- Self Explaining 
})

local selectedWorld
d:Dropdown("Worlds",{"Lava","Desert","Ocean", "Winter", "Toxic", "Candy", "Forest", "Storm", "Blocks", "Space", "Dominus", "Infinity", "Future", "City", "Moon", "Fire"},true,function(value)
    selectedWorld = value
end)
d:Button("Teleport Selected",function()
    if selectedWorld then 
        teleportWorld(selectedWorld)
    end
end)


function unlockGamepasses()
    local gamepassMod = require(game:GetService("ReplicatedStorage").Aero.Shared.Gamepasses)
    gamepassMod.HasPassOtherwisePrompt = function() return true end
end

function doTap()
    spawn(function()
        while getgenv().autotap == true do
            local args = {[1] = 1}
            remotePath.ClickService.Click:FireServer(unpack(args))
            wait()
        end
    end)
end

function doBeast()
    spawn(function()
        while getgenv().autotap == true do
            local args = {[1] = 1}
            ClickMod:Click()
            wait()
        end
    end)
end


function autofarmhill()
    spawn(function()
        while getgenv().autoHill == true do
            wait(1)
            game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(547.0809326171875, 31.61273765563965, -173.9840087890625)
        end
    end)
end
        

function autorebirth(rebirthAmount)
    spawn(function()
        while getgenv().autorebirth == true do
            local args = {[1] = rebirthAmount}
            remotePath.RebirthService.BuyRebirths:FireServer(unpack(args))
            wait()
        end
    end)
end

function buyEgg(eggType)
    spawn(function()
        while wait() do 
                if not getgenv().bugEgg then break end
                remotePath.EggService.Purchase:FireServer(eggType)
        end
    end)
end



function playerPOS()
    local player = game.Players.LocalPlayer
    if player.Character then
         return player.Character.HumanoidRootPart.Position
    end
    return false
end

function teleportTO(placeCFrame)
    local plyr = game.Players.LocalPlayer
    if plyr.Character then
        plyr.Character.HumanoidRootPart.CFrame = placeCFrame
    end
end

function teleportWorld(world)
    if game:GetService("Workspace").Worlds:FindFirstChild(world) then
        teleportTO(game:GetService("Workspace").Worlds[world].Teleport.CFrame)
    end
end
