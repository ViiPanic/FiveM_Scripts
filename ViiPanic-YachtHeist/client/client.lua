local QBCore = exports['qb-core']:GetCoreObject()
-- heist variable
local Gards = {}
local Hacks = {}
local HeistStarted = false
local Step = 0
local EngineDisabled = false
local TrolleyObjects = {}
local busy = false

-- function
-- remove the target of the name received in parameter
function YachtRemoveTarget(name)
    exports['qb-target']:RemoveZone(name)
end

-- Send message to the group
function NotifyGroup(groupID, message)    
    TriggerServerEvent('groupNotify:pNotifyGroup', groupID, "Boss man", message)
end

-- Set the job status for the group
function StartJobGroup(groupID)
    TriggerServerEvent("qb-phone:Server:SetJobStatus", groupID, "in_progress", 1)
end 

-- load the animation dictionary received in parameter
function loadAnimDict(dict)
    while not HasAnimDictLoaded(dict) do
        RequestAnimDict(dict)
        Wait(5)
    end
end

-- Load the model received in parameter
function loadModel(model)
    if type(model) == 'number' then
        model = model
    else
        model = GetHashKey(model)
    end
    while not HasModelLoaded(model) do
        RequestModel(model)
        Wait(0)
    end
end

-- Set the dispatch call for cops
local copsAlerted = false
local function YachtAlertCops(coords)
    if not copsAlerted then
        exports['ps-dispatch']:YachtHeist(coords)
        copsAlerted = true
    end
end

-- strat thread
CreateThread(function()
    for k,v in pairs(Config.StartPed) do
        -- Set the starting ped
        local pedhash = GetHashKey(v.pedModel)
        RequestModel(pedhash) 
        while not HasModelLoaded(pedhash) do 
            Citizen.Wait(25)
        end
        local npc = CreatePed(4, v.pedModel, v.coords.x, v.coords.y, v.coords.z, v.coords.w, false, true)
        FreezeEntityPosition(npc, true)
        SetEntityInvincible(npc, true)
        SetBlockingOfNonTemporaryEvents(npc, true)
        SetEntityInvincible(npc, true)
        -- set the target on the starting ped
        exports['qb-target']:AddBoxZone("YachtHeistStart", vector3(v.coords.x, v.coords.y, v.coords.z), 2, 1, 
	        { name="YachtHeistStart", heading = v.coords.w, debugPoly=Config.Debug, minZ = v.coords.z - 1, maxZ = v.coords.z + 2, },
		    { options = 
                { 	
                    {                                                 
                        icon = "fas fa-ship", 
                        label = "Start Yacht Heist?",
                        canInteract = function()                                     
                            return true
                        end,
                        action = function()                            
                            groupID = exports['qb-phone']:GetGroupID()  
                            if groupID > 0 then 
                                local hasItem =  QBCore.Functions.HasItem(Config.RequiredItem)
                                if hasItem or Config.RequiredItem == nil then                                                                      
                                    TriggerEvent("YachtHeist:client:StartHeist")
                                else                                     
                                    QBCore.Functions.Notify("You will need some a decrypter to do the job", "primary")
                                end                                
                            else
                                QBCore.Functions.Notify("Come back when you will be in a group!", "primary")
                            end
                        end
                    },
                },
                distance = 2.0 
            }
        )
    end
end)

-- events
-- Remove all targets of the element position received in parameters
RegisterNetEvent("YachtHeist:client:RemoveTargets")
AddEventHandler("YachtHeist:client:RemoveTargets", function(groupID, loots, engines, console)
    for i = 1, #engines do 
        YachtRemoveTarget("EnginSystem_"..i.."_"..groupID)
    end 

    for i = 1, #loots do 
        YachtRemoveTarget("LootSpot_"..i.."_"..groupID)
    end 

    YachtRemoveTarget("ConsoleYacht_"..groupID)
end)

-- Reset Heist Job variable 
RegisterNetEvent("YachtHeist:client:ResetHeist")
AddEventHandler("YachtHeist:client:ResetHeist", function()
    Gards = {}
    Hacks = {}
    HeistStarted = false
    Step = 0
    EngineDisabled = false
    TrolleyObjects = {}
    busy = false    
end)

-- Remove Trolley and Guard entity
RegisterNetEvent("YachtHeist:client:RemoveEntity")
AddEventHandler("YachtHeist:client:RemoveEntity", function(groupID, guards, trolleys)
   for i = 1 , #TrolleyObjects do 
    DeleteObject(TrolleyObjects[i])
    DeleteEntity(TrolleyObjects[i])    
   end
   for i = 1, #guards do 
    DeleteObject(guards[i])
    DeleteEntity(guards[i]) 
   end
end)

-- Send Message to the group
RegisterNetEvent("YachtHeist:client:SendMessageGroup")
AddEventHandler("YachtHeist:client:SendMessageGroup", function(groupID, message)
    NotifyGroup(groupID, message)
end)

-- Send Message to a player
RegisterNetEvent('YachtHeist:client:Notify', function(message, type)	
    QBCore.Functions.Notify(message, type)
end)

-- Set the Guard relationship to players
RegisterNetEvent('YachtHeist:client:SetGuardRelationShip', function(guardPed)	
    SetPedRelationshipGroupHash(guardPed, `HATES_PLAYER`)
end)

-- Start Heist job if not active
RegisterNetEvent("YachtHeist:client:StartHeist")
AddEventHandler("YachtHeist:client:StartHeist", function()
    QBCore.Functions.TriggerCallback('YachtHeist:server:IsHeistActive', function(isactive)               
        if not isactive then
            if not busy then
                groupID = exports['qb-phone']:GetGroupID()
                -- check if the player has the required item
                local hasItem =  QBCore.Functions.HasItem(Config.RequiredItem)
                if hasItem or Config.RequiredItem == nil then
                    busy = true
                    -- set the heist active
                    TriggerServerEvent("YachtHeist:server:cooldown", true)
                    if groupID > 0 then                        
                        StartJobGroup(groupID)
                        TriggerServerEvent("YachtHeist:server:StartHeist", true, groupID)
                    end
                else
                    QBCore.Functions.Notify("You will a decryptor for that!", "primary")
                end
            end
        else 
            QBCore.Functions.Notify("Someone got the job before you, get away!", "primary")
        end
    end) 
end)

-- Set the grab cash animation
RegisterNetEvent('YachtHeist:client:GrabTrolley', function(grabModel)
    local ped = PlayerPedId()
    local pos = GetEntityCoords(ped)
    local grabModel = GetHashKey(grabModel)

    loadModel(grabModel)
    local grabObject = CreateObject(grabModel, pos, true)

    FreezeEntityPosition(grabObject, true)
    SetEntityInvincible(grabObject, true)
    SetEntityNoCollisionEntity(grabObject, ped)
    SetEntityVisible(grabObject, false, false)
    AttachEntityToEntity(grabObject, ped, GetPedBoneIndex(ped, 60309), 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, false, false, false, false, 0, true)
    local Looting = GetGameTimer()

    CreateThread(function()
        while GetGameTimer() - Looting < 37000 do
            Wait(1)
            DisableControlAction(0, 73, true)
            if HasAnimEventFired(ped, GetHashKey('CASH_APPEAR')) then
                if not IsEntityVisible(grabObject) then
                    SetEntityVisible(grabObject, true, false)
                end
            end
            if HasAnimEventFired(ped, GetHashKey('RELEASE_CASH_DESTROY')) then
                if IsEntityVisible(grabObject) then
                    SetEntityVisible(grabObject, false, false)
                end
            end
        end
        DeleteObject(grabObject)
    end)
end)

-- Set the loot Trolley animation
RegisterNetEvent("YachtHeist:client:LootTrollyAnimation")
AddEventHandler("YachtHeist:client:LootTrollyAnimation", function(TrolleyCoords, trolleyIndex)
    local ped = PlayerPedId()
    local pos = GetEntityCoords(ped)
    local coords = TrolleyCoords
    LocalPlayer.state:set('inv_busy', true, true)
    local pedRotation = vector3(0.0, 0.0, 0.0)
    local trollyModel = 269934519
    local animDict = 'anim@heists@ornate_bank@grab_cash'
    local grabModel = 'hei_prop_heist_cash_pile'
    local type = Config.MarkedBillName

    loadAnimDict(animDict)
    loadModel('hei_p_m_bag_var22_arm_s')

    local sceneObject = GetClosestObjectOfType(pos.x, pos.y, pos.z, 2.0, trollyModel, false, false, false)
    SetEntityCollision(sceneObject, true, true)
    local bag = CreateObject(GetHashKey('hei_p_m_bag_var22_arm_s'), pos, true, false, false)

    while not NetworkHasControlOfEntity(sceneObject) do
        Wait(1)
        NetworkRequestControlOfEntity(sceneObject)
    end
   
    local scene1 = NetworkCreateSynchronisedScene(GetEntityCoords(sceneObject), GetEntityRotation(sceneObject), 2, true, false, 1065353216, 0, 1.3)
    NetworkAddPedToSynchronisedScene(ped, scene1, animDict, 'intro', 1.5, -4.0, 1, 16, 1148846080, 0)
    NetworkAddEntityToSynchronisedScene(bag, scene1, animDict, 'bag_intro', 4.0, -8.0, 1)

    local scene2 = NetworkCreateSynchronisedScene(GetEntityCoords(sceneObject), GetEntityRotation(sceneObject), 2, true, true, 1065353216, 0, 1.3)
    NetworkAddPedToSynchronisedScene(ped, scene2, animDict, 'grab', 1.5, -4.0, 1, 16, 1148846080, 0)
    NetworkAddEntityToSynchronisedScene(bag, scene2, animDict, 'bag_grab', 4.0, -8.0, 1)
    NetworkAddEntityToSynchronisedScene(sceneObject, scene2, animDict, 'cart_cash_dissapear', 4.0, -8.0, 1)

    local scene3 =  NetworkCreateSynchronisedScene(GetEntityCoords(sceneObject), GetEntityRotation(sceneObject), 2, true, false, 1065353216, 0, 1.3)
    NetworkAddPedToSynchronisedScene(ped, scene3, animDict, 'exit', 1.5, -4.0, 1, 16, 1148846080, 0)
    NetworkAddEntityToSynchronisedScene(bag, scene3, animDict, 'bag_exit', 4.0, -8.0, 1)

    NetworkStartSynchronisedScene(scene1)
    Wait(1750)
    TriggerEvent('YachtHeist:client:GrabTrolley', grabModel)
    NetworkStartSynchronisedScene(scene2)
    Wait(37000)
    NetworkStartSynchronisedScene(scene3)
    Wait(2000)
    local emptyobj = 769923921
    local newTrolly = CreateObject(emptyobj, coords, true, false, false)
    SetEntityRotation(newTrolly, 0, 0, GetEntityHeading(sceneObject), 1, 0)
    DeleteObject(sceneObject)
    DeleteEntity(sceneObject)
    DeleteObject(bag)
    Wait(100)
    -- Get Trolley Reward
    TriggerServerEvent('YachtHeist:Server:TrolleyReward', trolleyIndex)
    LocalPlayer.state:set('inv_busy', false, true) -- Not Busy
    YachtRemoveTarget('Trolley'..trolleyIndex)  
end)

-- Call the trolley loot availability
RegisterNetEvent("YachtHeist:client:LootTrolly")
AddEventHandler("YachtHeist:client:LootTrolly", function(data)
    groupID = exports['qb-phone']:GetGroupID()
    TriggerServerEvent("YachtHeist:Server:LootTrolly", data.trolleyIndex, groupID) 
end)

-- Set the search loot spot animation
RegisterNetEvent("YachtHeist:client:SearchSpotAnimation")
AddEventHandler("YachtHeist:client:SearchSpotAnimation", function(groupID, LootIndex)
    LocalPlayer.state:set('inv_busy', true, true)
    local searchAnim = Config.animation
    local searchAnimDict = Config.animDict
    local time = Config.animetime or 5000
    QBCore.Functions.Progressbar("Searching", "Search spot ", time, false, true, {
        disableMovement = true,
        disableCarMovement = true,
        disableMouse = false,
        disableCombat = true,
    }, {
        animDict = searchAnimDict,
        anim = searchAnim,
        flags = 16,
    }, {}, {}, function()
        -- get reward
        YachtRemoveTarget("LootSpot_"..LootIndex.."_"..groupID)
        TriggerServerEvent("YachtHeist:server:SearchReward", LootIndex)
        ClearPedTasks(PlayerPedId())
        LocalPlayer.state:set('inv_busy', false, true)
    end, function()
        -- cancel 
        ClearPedTasks(PlayerPedId())
        LocalPlayer.state:set('inv_busy', false, true)
    end)
end)

-- Call the loot spot availability
RegisterNetEvent("YachtHeist:client:SearchSpot")
AddEventHandler("YachtHeist:client:SearchSpot", function(data)
    groupID = exports['qb-phone']:GetGroupID()
    TriggerServerEvent("YachtHeist:server:SearchSpot", data.lootIndex, groupID)
end)

-- remove console target
RegisterNetEvent("YachtHeist:client:RemoveTargetConsole")
AddEventHandler("YachtHeist:client:RemoveTargetConsole", function(groupID)
    YachtRemoveTarget("ConsoleYacht_"..groupID)
end)

-- Lauch Consol Hack mini game
RegisterNetEvent("YachtHeist:client:HackConsoleMinigame")
AddEventHandler("YachtHeist:client:HackConsoleMinigame", function(difficulty)
    groupID = exports['qb-phone']:GetGroupID()
    local playerped = PlayerPedId()
    local unarmed = GetHashKey('WEAPON_UNARMED')
    SetCurrentPedWeapon(playerped, unarmed)
    FreezeEntityPosition(playerped, true)
    exports["rpemotes"]:EmoteCommandStart('type', 0)

    exports['ps-ui']:VarHack(function(success)
        if success then
            YachtRemoveTarget("ConsoleYacht_"..groupID)
            FreezeEntityPosition(playerped, false)
            exports["rpemotes"]:EmoteCancel()
            TriggerServerEvent('YachtHeist:server:ConsoleHacked', groupID)
        else 
            TriggerServerEvent('YachtHeist:server:ConsoleFailed', groupID)
        end
    end, difficulty.consolHackBlock, difficulty.time)
end)

-- Call the hack console availability
RegisterNetEvent("YachtHeist:client:HackConsole")
AddEventHandler("YachtHeist:client:HackConsole", function(data)
    groupID = exports['qb-phone']:GetGroupID()
    TriggerServerEvent('YachtHeist:server:HackConsole', groupID)    
end)

-- Launche the Engine Hack Minigame
RegisterNetEvent("YachtHeist:client:HackEngineMinigame")
AddEventHandler("YachtHeist:client:HackEngineMinigame", function(groupID, data, index)
    local playerped = PlayerPedId()
    local unarmed = GetHashKey('WEAPON_UNARMED')
    SetCurrentPedWeapon(playerped, unarmed)
    FreezeEntityPosition(playerped,true)
    exports["rpemotes"]:EmoteCommandStart('tablet2', 0)   

    exports['untangle']:hacking(function(success)
        FreezeEntityPosition(PlayerPedId(), false)
        ClearPedTasks(PlayerPedId())
        exports["rpemotes"]:EmoteCancel(true)

        if success then
            YachtRemoveTarget("EnginSystem_"..index.."_"..groupID)
            TriggerServerEvent("InteractSound_SV:PlayOnSource", "Power_Down" or "DLC_HEIST_HACKING_SNAKE_SOUNDS", 0.25)
            TriggerServerEvent("YachtHeist:server:DisableEngine", index, groupID)
        else
            TriggerServerEvent("YachtHeist:server:Hackfaild", groupID, index)
    end
    end, data.hackDot, data.time)
end)

-- Call the Engine hack availability
RegisterNetEvent("YachtHeist:client:HackEngine")
AddEventHandler("YachtHeist:client:HackEngine", function(data)
    groupID = exports['qb-phone']:GetGroupID()
    TriggerServerEvent('YachtHeist:server:HackEngine', data.engineIndex, groupID)     
end)

--targets
-- Set Trolleys Targets
RegisterNetEvent("YachtHeist:client:ReleaseTrolley")
AddEventHandler("YachtHeist:client:ReleaseTrolley", function(groupID, Trolleys)
    for k, Data in pairs(Trolleys) do 
        if #TrolleyObjects < #Trolleys then 
            loadModel(Data.model)
            local TrolleyObj = CreateObject(Data.model, Data.coords.x, Data.coords.y, Data.coords.z, 1, 0, 0)
            SetEntityHeading(TrolleyObj, Data.coords.w)
            table.insert(TrolleyObjects, TrolleyObj)
        end
            
        exports['qb-target']:AddBoxZone("Trolley"..k.."_"..groupID, vector3(Data.coords.x, Data.coords.y, Data.coords.z), 3.0, 2.0, {
            name="Trolley"..k.."_"..groupID,
            heading=Data.coords.w,
            debugpoly = false,
            minZ= Data.coords.z - 1,
  		    maxZ= Data.coords.z + 1,
        }, {
            options = {
                {
                    icon = "fas fa-laptop-code",
                    label = "Loot Goods",
                    event = "YachtHeist:client:LootTrolly", 
                    trolleyIndex = k, 
                    name = "Trolley"..k.."_"..groupID, 
                    coords = vector3(Data.coords.x, Data.coords.y, Data.coords.z),                   
                },
            },
            distance = 2.5
        })
    end
end)

-- Set Engines Targets
RegisterNetEvent("YachtHeist:client:EngineTargets")
AddEventHandler("YachtHeist:client:EngineTargets", function(groupID, engine)
    triggeringGroupID = exports['qb-phone']:GetGroupID()
    for i = 1, #engine do
        local hack = engine[i]
        local engineIndex = i
        exports['qb-target']:AddBoxZone("EnginSystem_"..i.."_"..triggeringGroupID, vector3(hack.coords.x, hack.coords.y, hack.coords.z), 3.0, 2.0, {
            name="EnginSystem_"..i.."_"..triggeringGroupID,
            heading=0,
            debugpoly = false,
            minZ= hack.coords.z - 1,
  		    maxZ= hack.coords.z + 1,
        }, {
            options = {
                {
                    icon = "fas fa-laptop-code",
                    label = "Disable Engine",
                    event = "YachtHeist:client:HackEngine", 
                    engineIndex = engineIndex, 
                    item = Config.RequiredItem, 
                    name = "EnginSystem_"..i.."_"..triggeringGroupID,                    
                },
            },
            distance = 2.5
        })
    end
end)

-- Set Loot Spot and Console Targets
RegisterNetEvent("YachtHeist:client:LootConsoleTargets")
AddEventHandler("YachtHeist:client:LootConsoleTargets", function(groupID, console, loot)
    YachtAlertCops(vector3(console.x, console.y, console.z))
    triggeringGroupID = exports['qb-phone']:GetGroupID()
    for i = 1, #loot do
        local searchable = loot[i]
        exports['qb-target']:AddBoxZone("LootSpot_"..i.."_"..triggeringGroupID, vector3(searchable.coords.x, searchable.coords.y, searchable.coords.z), 2, 1, {
            name="LootSpot"..i.."_"..triggeringGroupID,
            heading=0,
            debugpoly = false,
            minZ= searchable.coords.z - 1,
  		    maxZ= searchable.coords.z + 1,
        }, {
            options = {
                {
                    icon = "fas fa-magnifying-glass",
                    label = "Search",
                    event = "YachtHeist:client:SearchSpot", 
                    lootIndex = i, 
                    name = "Lootspot"..i.."_"..triggeringGroupID,                     
                },
            },
            distance = 2.5
        })
    end

    exports['qb-target']:AddBoxZone("ConsoleYacht_"..triggeringGroupID, vector3(console.x, console.y, console.z), 2, 1, {
        name="ConsoleYacht_"..triggeringGroupID,
        heading=0,
        debugpoly = false,
        minZ= console.z - 1,
        maxZ= console.z + 1,
    }, {
        options = {
            {
                icon = "fas fa-laptop-code",
                label = "Hack Console",
                event = "YachtHeist:client:HackConsole", 
                lootIndex = i, 
                name = "ConsoleYacht_"..triggeringGroupID,                 
            },
        },
        distance = 2.5
    })
end)

