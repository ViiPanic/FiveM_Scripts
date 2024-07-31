local QBCore = exports['qb-core']:GetCoreObject()

AddEventHandler('onClientResourceStart', function(ressourceName)
    if(GetCurrentResourceName() ~= ressourceName) then 
        return 
    end 
    print("" ..ressourceName.." started sucessfully")
end)

inmenu = false
busy = false
blip1active = false 
object1active = false
globaldifficulty = ''
alldead = false 
inhack = false
step1done = false 
step2done = false 
step3done = false
nachricht = false
local buyerEntity = nil


if Config.ShowBlip then
    Citizen.CreateThread(function()
        for k, v in pairs(Config.Start) do
            local blip = AddBlipForCoord(v.coords)
            SetBlipSprite(blip, 478)
            SetBlipColour(blip, 6)
            SetBlipDisplay(blip, 4)
            SetBlipScale(blip, 0.8)
            SetBlipAsShortRange(blip, true)
            BeginTextCommandSetBlipName("STRING")
            AddTextComponentString(Translation[Config.Locale]['blipname'])
            EndTextCommandSetBlipName(blip)
        end
    end)
end

function LoadAnimDict(dict)
    while (not HasAnimDictLoaded(dict)) do
        RequestAnimDict(dict)
        Wait(5)
    end
end



Citizen.CreateThread(function()
    for k,v in pairs(Config.Buyers) do
        local pedhash = GetHashKey(v.pedname)
        RequestModel(pedhash) 
        while not HasModelLoaded(pedhash) do 
            Citizen.Wait(25)
        end
        local npc = CreatePed(4, v.pedname, v.coords.x, v.coords.y, v.coords.z - 1.0, v.coords.w, false, true)
        FreezeEntityPosition(npc, true)
        SetEntityInvincible(npc, true)
        SetBlockingOfNonTemporaryEvents(npc, true)
        SetEntityInvincible(npc, true)
       
        exports['qb-target']:AddBoxZone("MedicalHeistBuyer", vector3(v.coords.x, v.coords.y, v.coords.z), 2, 1, 
	        { name="MedicalHeistBuyer", heading = v.coords.w, debugPoly=Config.Debug, minZ = v.coords.z - 1, maxZ = v.coords.z + 2, },
		    { options = 
                { 	
                    {                         
                        icon = "fa fa-dollar",
                        label = "Got Medical Shipment?",
                        canInteract = function()
                            return true
                        end, 
                        action = function()
                            LoadAnimDict("mp_ped_interaction")
                            QBCore.Functions.Progressbar("selling", "Evaluating", 5000, false, true, {
                                disableMovement = true,
                                disableCarMovement = true,
                                disableMouse = false,
                                disableCombat = true,
                            }, {
                                animDict = "oddjobs@assassinate@hotel@",
                                anim = "argue_b",
                                flags = 16,
                            }, {}, {}, function() -- Done
                                TriggerServerEvent("phoenix_heist:server:SellGoods", buyerEntity)
                                ClearPedTasks(PlayerPedId())
                            end, function() -- Cancel
                                ClearPedTasks(PlayerPedId())
                            end)
                        end,
                    },
                },
                distance = 2.0 
            }
        )
    end
    -- print("medical heist create buyer target")
    -- local pedSpawn = v["spawn"]
    -- local pedModel = Config.Buyers[1]["model"]
    -- local pedDistance = Config.Buyers[1]["distance"]
    -- RequestModel(pedModel)
    -- while not HasModelLoaded(pedModel) do
    --     Wait(1)
    -- end
    -- buyerEntity = CreatePed(2, pedModel, pedSpawn, false, false)
    -- SetPedFleeAttributes(buyerEntity, 0, 0)
    -- SetPedDiesWhenInjured(buyerEntity, false)
    -- TaskStartScenarioInPlace(buyerEntity, "WORLD_HUMAN_CLIPBOARD", 4, true)
    -- SetPedKeepTask(buyerEntity, true)
    -- SetBlockingOfNonTemporaryEvents(buyerEntity, true)
    -- SetEntityInvincible(buyerEntity, true)
    -- FreezeEntityPosition(buyerEntity, true)  


    -- exports['qb-target']:AddBoxZone("buyerEntity", vector3(pedSpawn.x, pedSpawn.y, pedSpawn.z), 2, 1, {
    --     name = "buyerEntity",
    --     heading =  Config.Buyers[1]["heading"],
    --     debugPoly = Config.Debug,
    --     minZ=pedSpawn.z - 1,
    --     maxZ=pedSpawn.z + 1,
    -- }, {
    --     options = {
    --         {
    --             icon = "fa fa-dollar",
    --             label = "Got Medical Shipment?",
    --             canInteract = function()
    --                 return true
    --             end, 
    --             action = function()
    --                 LoadAnimDict("mp_ped_interaction")
    --                 QBCore.Functions.Progressbar("selling", "Evaluating", 5000, false, true, {
    --                     disableMovement = true,
    --                     disableCarMovement = true,
    --                     disableMouse = false,
    --                     disableCombat = true,
    --                 }, {
    --                     animDict = "oddjobs@assassinate@hotel@",
    --                     anim = "argue_b",
    --                     flags = 16,
    --                 }, {}, {}, function() -- Done
    --                     TriggerServerEvent("phoenix_heist:server:SellGoods", buyerEntity)
    --                     ClearPedTasks(PlayerPedId())
    --                 end, function() -- Cancel
    --                     ClearPedTasks(PlayerPedId())
    --                 end)
    --             end,
    --         },
    --     },
    --     distance = 3.5
    -- })
end)

Citizen.CreateThread(function()
    for k,v in pairs(Config.Start) do
        local pedhash = GetHashKey(v.pedname)
        RequestModel(pedhash) 
        while not HasModelLoaded(pedhash) do 
            Citizen.Wait(25)
        end
        local npc = CreatePed(4, v.pedname, v.coords.x, v.coords.y, v.coords.z, v.coords.w, false, true)
        FreezeEntityPosition(npc, true)
        SetEntityInvincible(npc, true)
        SetBlockingOfNonTemporaryEvents(npc, true)
        SetEntityInvincible(npc, true)
       
        exports['qb-target']:AddBoxZone("MedicalHeistStart", vector3(v.coords.x, v.coords.y, v.coords.z), 2, 1, 
	        { name="MedicalHeistStart", heading = v.coords.w, debugPoly=Config.Debug, minZ = v.coords.z - 1, maxZ = v.coords.z + 2, },
		    { options = 
                { 	
                    {                         
                        --event = "phoenix_heist:startHeist", 
                        icon = "fas fa-suitcase-medical", 
                        label = Translation[Config.Locale]['shipment'],
                        canInteract = function()                                     
                            return true
                        end,
                        action = function()
                            groupID = exports['qb-phone']:GetGroupID()  
                            if groupID > 0 then 
                                local hasItem =  QBCore.Functions.HasItem(Config.RequiredItem)
                                if hasItem or Config.RequiredItem == nil then                                     
                                    TriggerEvent("phoenix_heist:startHeist")
                                else 
                                    Config.MSG(Translation[Config.Locale]['need_item'])
                                end                                
                            else
                                Config.MSG(Translation[Config.Locale]['need_group'])
                            end
                        end
                    },
                },
                distance = 2.0 
            }
        )
    end
end)

local HeistDifficulty = {
    [1]={label = "easy"},
    [2]={label = "normal"}, 
    [3]={label = "hard"}
}

RegisterNetEvent("phoenix_heist:NoItemsToSell")
AddEventHandler("phoenix_heist:NoItemsToSell", function()
    Config.MSG("No item to sell")
end)

RegisterNetEvent("phoenix_heist:startHeist")
AddEventHandler("phoenix_heist:startHeist", function()
    QBCore.Functions.TriggerCallback('phoenix_heist:heistactive', function(isactive)

        --local index =  math.random(1,3)        
        validateheist(isactive)
    end) 
end)

RegisterNetEvent("phoenix_heist:notify")
AddEventHandler("phoenix_heist:notify", function(text)
    Config.MSG(Translation[Config.Locale][text])
end)

RegisterNetEvent("phoenix_heist:setposition")
AddEventHandler("phoenix_heist:setposition", function(position)
    local randomness = math.random(-60.0,60.0)
    local policeblip = AddBlipForCoord(position.x + randomness, position.y + randomness, position.z)
    SetBlipScale(policeblip, 1.2)
    SetBlipSprite(policeblip, 161)
    SetBlipDisplay(policeblip, 4)
    SetBlipColour(policeblip, 1)
    BeginTextCommandSetBlipName("STRING")
    AddTextComponentString(Translation[Config.Locale]['police_blipname'])
    EndTextCommandSetBlipName(policeblip)
    SetBlipAsShortRange(policeblip, true)
    Citizen.Wait(90000) -- How long should the Police see the Blip / After this Time Blip disapear
    RemoveBlip(policeblip)
end)

RegisterNetEvent("phoenix_heist:cancel")
AddEventHandler("phoenix_heist:cancel", function()
    endheist()
    TriggerServerEvent("phoenix_heist:servercooldown", false)
    Config.MSG(Translation[Config.Locale]['heist_canceled'])
    Citizen.Wait(1000)
    DeleteAllPeds()
    TriggerServerEvent("phoenix_heist:globalcd")
end)

local lifes = Config.UseMinigame.lifes
RegisterNetEvent('phoenix_heist:HackingSystem')
AddEventHandler('phoenix_heist:HackingSystem', function(triggeringGroupID, coords)    
    groupID = exports['qb-phone']:GetGroupID()
    print(triggeringGroupID)
    print(json.encode(coords))
    print("phoenix_heist:HackingSystem start")
    exports['qb-target']:AddBoxZone("HackingSystem_"..triggeringGroupID, vector3(coords.x, coords.y, coords.z), 2, 1, {
        name="HackingSystem_"..triggeringGroupID,
        heading=coords.w,
        debugpoly = false,
    }, {
        options = {
            {
                icon = "fas fa-key",
                label = "Start Hacking",
                canInteract = function()
                    -- Only allow interaction if Gen1Target is false and the groupID matches
                    print("can interact")
                    print(lifes)
                    return (lifes > 0) and (groupID == triggeringGroupID)
                end,
                action = function()                    
                    local hasItem =  QBCore.Functions.HasItem(Config.RequiredItem)
                    if hasItem or Config.RequiredItem == nil then 
                        
                        local result = starthacking()
                        print(result)
                        if result then 
                            lifes = 0
                        else 
                            lifes = lifes - 1
                        end
                        print("action")
                        print(lifes)
                    else 
                        Config.MSG(Translation[Config.Locale]['need_item'])
                    end
                end,
            },
        },
        distance = 2.5
    })
end)

RegisterNetEvent('phoenix_heist:LootTarget')
AddEventHandler('phoenix_heist:LootTarget', function(triggeringGroupID, coords)
    groupID = exports['qb-phone']:GetGroupID()
    print(triggeringGroupID)
    print(json.encode(coords))
    print("phoenix_heist:LootTarget start")
    exports['qb-target']:AddBoxZone("Loot_"..triggeringGroupID, vector3(coords.x, coords.y, coords.z), 2, 1, {
        name="Loot_"..triggeringGroupID,
        heading=coords.w,
        debugpoly = false,
    }, {
        options = {
            {
                icon = "fas fa-key",
                label = "Get the Shipment",
                canInteract = function()
                    -- Only allow interaction if Gen1Target is false and the groupID matches
		     
                    return checkalldead() and object1active and step3done and groupID == triggeringGroupID
                end,
                action = function()
                    FreezeEntityPosition(PlayerPedId(), true)
                    alldead = false 
                    object1active = false
                    QBCore.Functions.Progressbar("medical_heist", Translation[Config.Locale]['loot_in_progress'], 5000, false, true, {
                        disableMovement = true,
                        disableCarMovement = true,
                        disableMouse = false,
                        disableCombat = true,
                    }, {
                        animDict = "rcmextreme3",
                        anim = "idle",
                        flags = 79,
                    }, {}, {}, function() -- Done
                        ClearPedTasks(PlayerPedId())
                        FreezeEntityPosition(PlayerPedId(), false)
                        PlaySound(-1, "LOCAL_PLYR_CASH_COUNTER_INCREASE", "DLC_HEISTS_GENERAL_FRONTEND_SOUNDS", 0, 0, 1)
                        DeleteEntity(object1) 
                        Config.MSG(Translation[Config.Locale]['received_reward'])
                        Citizen.Wait(100)
                        TriggerServerEvent("phoenix_heist:givereward", globaldifficulty)
                        Citizen.Wait(3000)
                        TriggerServerEvent('groupNotify:pNotifyGroup', groupID, "Leave the area", Translation[Config.Locale]['heist_successfull'])
                        Citizen.Wait(10000)
                        endheist()                        
                    end, function() -- Cancel
                                    
                    end)
                end,
            },
        },
        distance = 2.5
    })
end)