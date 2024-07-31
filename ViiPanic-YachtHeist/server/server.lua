local QBCore = exports['qb-core']:GetCoreObject()
-- Variable initiation
local EngineHacked = 0
local lootedSpot = 0
local trolleylooted = 0
local isConsoleHacked = false
local yachtheistactive = false
local guardLocation = {}
local GuardList = {}
local lootLocation = {}
local difficulty = {}
local scenario = {}
local life = 3
local consoleLife = 3

-----------------------------------------------
--             CreateBlipForGroup            --
--     Make the Yacht Heist visible for      --
--            all group members              --
--  Params groupID - the players group id    --
--  Params name    - the Blip name           -- 
--  Params blip    - the Blip data           --
-----------------------------------------------
function CreateBlipForGroup(groupID, name, blip)
    exports['qb-phone']:CreateBlipForGroup(groupID, name, blip)
end

--function 
-----------------------------------------------
--             GuardSelector                 --
--     Select an item in the options         --
--        received in parameters             --
-- Params Options-the option to be selected  --
-----------------------------------------------
function GuardSelector(Options)
    local List = Options
    local Number = 0
    math.random()
    local Selection = math.random(1, #List)
    for i = 1, #List do
        Number = Number + 1
        if Number == Selection then
            return List[i]
        end
    end
end

-----------------------------------------------
--              SpawnGuards                  --
--     Spawn Guard Ped on the selected       --
--           scenario position               --
-----------------------------------------------
function SpawnGuards()
    local src = source
    for i = 1, #guardLocation do
        local type = GuardSelector(Config.YachtGuardPed)
        local weapon = GuardSelector(Config.YachtGuardWeapon)
        GuardList[i] = CreatePed(4, type, guardLocation[i].coords.x, guardLocation[i].coords.y, guardLocation[i].coords.z, guardLocation[i].coords.w, true, true)
        SetPedArmour(GuardList[i], Config.YachtGuardArmour)
        GiveWeaponToPed(GuardList[i], weapon, 200)
        SetCurrentPedWeapon(GuardList[i], weapon, true)
        Wait(1000)        
        TriggerClientEvent("YachtHeist:client:SetGuardRelationShip", GuardList[i])
        TaskCombatPed(GuardList[i], src, 0, 16)
    end
end

-----------------------------------------------
--             InitiateHeistEnd              --
--        Reset the Yacht Heist Job          --
--  Params groupID  - the players group ID   --
--  Params waitTime - The wait time before   --
--                    reseting the job       --
-----------------------------------------------
function InitiateHeistEnd(groupID, waitTime)
    local src = source
    CreateThread(function()
        Wait(waitTime)
        -- Remove all Targets
        TriggerClientEvent("YachtHeist:client:RemoveTargets", src, groupID, lootLocation, scenario.Engines, scenario.Console)            
        -- Remove all props and ped
        TriggerClientEvent("YachtHeist:client:RemoveEntity", src, groupID, GuardList, scenario.Trolley)
        -- Reset variables
        TriggerClientEvent("YachtHeist:client:ResetHeist", src)

        EngineHacked = 0
        lootedSpot = 0
        trolleylooted = 0
        isConsoleHacked = false
        yachtheistactive = false
        guardLocation = {}
        GuardList = {}
        lootLocation = {}
        difficulty = {}
        scenario = {}
        life = 3
        consoleLife = 3
        exports['qb-phone']:resetJobStatus(groupID)
    end)
end 

-- Call Back to Get the Status of the Job
QBCore.Functions.CreateCallback('YachtHeist:server:IsHeistActive', function(source, cb)
    cb(yachtheistactive)
end)

-- status change
-- Set the Trolleys of the received index in the selected scenario active
RegisterServerEvent("YachtHeist:server:SetTrolleyActive")
AddEventHandler("YachtHeist:server:SetTrolleyActive", function(isActive, index)
    scenario.Trolley[index].active = isActive
end)

-- Set the Status of the Job
RegisterServerEvent("YachtHeist:server:cooldown")
AddEventHandler("YachtHeist:server:cooldown", function(isstarting)
    if isstarting then 
        yachtheistactive = true 
    else 
        yachtheistactive = false
    end
end)

-- Set the Looted status of the loot spot at the index received to true in the selected scenario
RegisterServerEvent("YachtHeist:server:LootSpot")
AddEventHandler("YachtHeist:server:LootSpot", function(index)
    lootLocation[index].looted = true
end)

-- reward
-- Select the reward to be received from the Trolley
RegisterServerEvent("YachtHeist:Server:TrolleyReward")
AddEventHandler("YachtHeist:Server:TrolleyReward", function(index)
	local src = source
	local Player = nil  
    -- randomly select a number between 1 to 100 to determine the chance of the player to get the Bonus loot  
    local chance = math.random(1, 100)    
    
    local string = " inked bags!"
    -- Select a random ammount of inked bags to be received as reward set by the difficulty selected 
    local Ammount = math.random(difficulty.MarkedBillMin, difficulty.MarkedBillMax)
    
    if Ammount > 0 then        
        Player = QBCore.Functions.GetPlayer(src)
        -- Give marked bills to player
        Player.Functions.AddItem(Config.MarkedBillName, Ammount)
        TriggerClientEvent('inventory:client:ItemBox', src, QBCore.Shared.Items[Config.MarkedBillName], 'add')
        TriggerEvent('qb-log:server:CreateLog', 'YachtHeist', 'Yacht Heist', 'green', 'Marked Bills Received:\nMarked Bills worth $'..Ammount..'\n**Person**:\n'..GetPlayerName(src))        
        -- Set the flags of the Trolley 
        scenario.Trolley[index].looted = true  
        scenario.Trolley[index].inUse = false    
        TriggerClientEvent('YachtHeist:client:Notify', src, "You got ".. Ammount .. string, 'success')       
    end  
    
    -- if the chance of the player is lower or equal of the bonus trolley chance set the bonus reward 
    if chance <= Config.BonusTrolley.chance then 
        -- select item in random in the list
        local item = Config.BonusTrolley.item[math.random(1, #Config.BonusTrolley.item)]
        -- give item to the player
        Player.Functions.AddItem(item, 1)
        TriggerClientEvent('inventory:client:ItemBox', src, QBCore.Shared.Items[item], 'add')
    end
   
end)

-- Get the loot spot reward 
RegisterServerEvent("YachtHeist:server:SearchReward")
AddEventHandler("YachtHeist:server:SearchReward", function(index)
    local src = source
    local player = QBCore.Functions.GetPlayer(src)
    -- Set the Looted flag to true
    lootLocation[index].looted = true
    if not player then return end
    for rarity, v in pairs(Config.RewardItem) do
        -- get the item randomly depending on the loot chance define in the selected difficulty
        if math.random(difficulty.lootMinChance, difficulty.lootMaxChance) <= Config.RewardItem[rarity]["chance"] then
            local rng = math.random(1, #Config.RewardItem[rarity])
            local item = Config.RewardItem[rarity][rng]["item"]
            local amount = math.random(Config.RewardItem[rarity][rng]["amount"][1], Config.RewardItem[rarity][rng]["amount"][2])
            local itemInfo = QBCore.Shared.Items[item]
            player.Functions.AddItem(item, amount, false)
            TriggerClientEvent("inventory:client:ItemBox", src, itemInfo, "add")
        end 
    end
end)

-- heist events
-- Validate if the Trolley is available to be looted and start the animation
RegisterServerEvent("YachtHeist:Server:LootTrolly")
AddEventHandler("YachtHeist:Server:LootTrolly", function(trolleyIndex, groupID)
    local src = source
    if scenario.Trolley[trolleyIndex].active and not scenario.Trolley[trolleyIndex].looted and not scenario.Trolley[trolleyIndex].inUse then
        scenario.Trolley[trolleyIndex].inUse = true
        TriggerClientEvent("YachtHeist:client:LootTrollyAnimation", src, scenario.Trolley[trolleyIndex].coords, trolleyIndex)
    else 
        -- send not available message
        if scenario.Trolley[trolleyIndex].looted then 
            TriggerClientEvent('YachtHeist:client:Notify', src, "This Trolley is empty", 'error')  
        else 
            TriggerClientEvent('YachtHeist:client:Notify', src, "This Trolley is being emptied", 'error')  
        end
    end
end)

-- remove a life if the console hack is failed
RegisterServerEvent("YachtHeist:server:ConsoleFailed")
AddEventHandler("YachtHeist:server:ConsoleFailed", function(groupID)
   local src = source
   consoleLife = consoleLife - 1
   -- if no life left, remove the console target
   if consoleLife <= 0 then 
    TriggerClientEvent('YachtHeist:client:RemoveTargetConsole', src, groupID)    
   end
end)

-- Release the Trolley on the success of the consol hack
RegisterServerEvent("YachtHeist:server:ConsoleHacked")
AddEventHandler("YachtHeist:server:ConsoleHacked", function(groupID)
    local src = source
    isConsoleHacked = true
    -- set the Trolleys active flag to true
    for i = 1, #scenario.Trolley do 
        scenario.Trolley[i].active = true
    end
    local groupMembers = exports['qb-phone']:getGroupMembers(groupID)
    TriggerClientEvent("YachtHeist:client:SendMessageGroup", src, groupID, "The Console Has Been Hacked! The Trolley Have Been Release!")
    -- Release Trolleys and set target for the group
    for i = 1, #groupMembers do 
        TriggerClientEvent("YachtHeist:client:ReleaseTrolley", groupMembers[i], groupID, scenario.Trolley)
    end
end)

-- Validate if the Console is available to hack and lauch the mini game
RegisterServerEvent("YachtHeist:server:HackConsole")
AddEventHandler("YachtHeist:server:HackConsole", function(groupID)
    local src = source
    if not isConsoleHacked and consoleLife > 0 then
        TriggerClientEvent("YachtHeist:client:HackConsoleMinigame", src, difficulty)
    else 
        -- send not available message
        TriggerClientEvent('YachtHeist:client:Notify', src, "This Console can't be hacked right now", 'error')
    end    
end)

-- Validate that the search spot is available and launch the animation
RegisterServerEvent("YachtHeist:server:SearchSpot")
AddEventHandler("YachtHeist:server:SearchSpot", function(LootIndex, groupID)
    local src = source
    if not lootLocation[LootIndex].looted and not lootLocation[LootIndex].active then   
        
        TriggerClientEvent("YachtHeist:client:SearchSpotAnimation", src, groupID, LootIndex)
    else
        -- send not available message
        if lootLocation[LootIndex].looted then 
            TriggerClientEvent('YachtHeist:client:Notify', src, "This Spot is already searched", 'error')  
        else 
            TriggerClientEvent('YachtHeist:client:Notify', src, "This Spot is being searched", 'error')  
        end
    end
end)

-- Remove a life if the Engine Hack fail
RegisterServerEvent("YachtHeist:server:Hackfaild")
AddEventHandler("YachtHeist:server:Hackfaild", function(groupID, engineIndex)
   life = life - 1
   scenario.Engines[engineIndex].occupied = false
   -- If no life left, remove the required item and launch the heist end
   if life <= 0 then 
    QBCore.Functions.GetPlayer(source).Functions.RemoveItem(Config.RequiredItem, 1, nil)
    TriggerClientEvent('inventory:client:ItemBox', source, QBCore.Shared.Items[Config.RequiredItem], "remove", 1)
    InitiateHeistEnd(groupID, 0)
   end
end)

-- Disable the engine on the hack success 
RegisterServerEvent("YachtHeist:server:DisableEngine")
AddEventHandler("YachtHeist:server:DisableEngine", function(index, groupID)
    local src = source
    EngineHacked = EngineHacked + 1
    -- set the engine active flag to false
    scenario.Engines[index].active = false 
    -- if all engine hacked pass to the next step  
    if EngineHacked >= 4 then     
        -- remove the reqired item 
        QBCore.Functions.GetPlayer(source).Functions.RemoveItem(Config.RequiredItem, 1, nil)
        TriggerClientEvent('inventory:client:ItemBox', source, QBCore.Shared.Items[Config.RequiredItem], "remove", 1)   
        local groupMembers = exports['qb-phone']:getGroupMembers(groupID)
        -- send success message to group
        TriggerClientEvent("YachtHeist:client:SendMessageGroup", src, groupID, "Get rid of the guards and search the boat! Don't forget to hack the console!")
        for i = 1, #groupMembers do 
            -- set loot spot and console target for group
            TriggerClientEvent("YachtHeist:client:LootConsoleTargets", groupMembers[i], groupID, scenario.Console, lootLocation)
        end  
        -- spawn the guards 
        SpawnGuards()     
        -- initiate heist end after an hour 
        InitiateHeistEnd(groupID, 3600000)
    else 
        -- send success message to group
        TriggerClientEvent("YachtHeist:client:SendMessageGroup", src, groupID, EngineHacked.."/4 Engines Disabled")
    end
end)

-- validate if the engine is available to hack and lauch the mini game
RegisterServerEvent("YachtHeist:server:HackEngine")
AddEventHandler("YachtHeist:server:HackEngine", function(engineIndex, groupID)
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    
    if scenario.Engines[engineIndex].active and not scenario.Engines[engineIndex].occupied and life > 0 then
        if Player.Functions.GetItemByName(Config.RequiredItem) then
            -- set the occupied flag to true
            scenario.Engines[engineIndex].occupied = true
            -- start mini game
            TriggerClientEvent("YachtHeist:client:HackEngineMinigame", src, groupID, difficulty, engineIndex)
        else 
            -- send not available message-- send not available message
            TriggerClientEvent('YachtHeist:client:Notify', src, "You don't have the right tool for this", 'error')
        end
    else
        -- send not available message-- send not available message
        TriggerClientEvent('YachtHeist:client:Notify', src, "This Engine is already being hacked", 'error')  
    end
end)

-- Start Heist Job
RegisterServerEvent("YachtHeist:server:StartHeist")
AddEventHandler("YachtHeist:server:StartHeist", function(isStarted, groupID)  
    local src = source  
    local scenarioIndex = math.random(1, #Config.YachtScenario)
    -- Select the scenario in the available scenario
    scenario = Config.YachtScenario[scenarioIndex]
    -- select a random difficulty
    difficulty = Config.Difficultly[math.random(1, #Config.Difficultly)]
    -- the loot spot and guard ammount
    local lootspot = difficulty.nbLootSpot
    local nbguard = math.random(difficulty.minGuard, difficulty.maxGuard)

    -- Get random loot spot position in the list
    for i = 1, lootspot do 
        table.insert(lootLocation, scenario.SearchableSpots[math.random(1, #scenario.SearchableSpots)])
    end
    -- Get random guard position in the list
    for i = 1, nbguard do 
        table.insert(guardLocation, scenario.GardianCoords[math.random(1, #scenario.GardianCoords)])
    end
    -- set blip data
    local blip = {
        coords = scenario.YachtCoords, 
        sprite = 774,
        color = 47,
        scale = 1.0, 
        route = false, 
        label = "Active Yacht"
    }
    -- create blip for the group
    CreateBlipForGroup(groupID, 'YachtHeist', blip)
    local groupMembers = exports['qb-phone']:getGroupMembers(groupID)
    -- send message to the group
    TriggerClientEvent("YachtHeist:client:SendMessageGroup", src, groupID, "Go to the marked Area and disable the engines")
    for i = 1, #groupMembers do 
        -- set the engine target for the group
        TriggerClientEvent("YachtHeist:client:EngineTargets", groupMembers[i], groupID, scenario.Engines)
    end
end)
