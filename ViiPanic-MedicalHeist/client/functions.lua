
local QBCore = exports['qb-core']:GetCoreObject()
local enemys = {}
local enemylocation = {}

function startheist()
    --globaldifficulty = difficulty
    groupID = exports['qb-phone']:GetGroupID()
    print(groupID)
    local hasItem =  QBCore.Functions.HasItem(Config.RequiredItem)
        if hasItem or Config.RequiredItem == nil then 
            busy = true
            TriggerServerEvent("phoenix_heist:servercooldown", true)
            for k, v in pairs(Config.Start) do
                --local gordon = math.random(#Config.EnemyLocations)
                --enemylocation = Config.EnemyLocations[gordon]
                --Wait(100)
                --TriggerServerEvent('phoenix_heist:setEnemyLocation', enemylocation)
                randomcoords = Config.HackingCoords[math.random(#Config.HackingCoords)]
                local randomness = math.random(-60.0,60.0)
                
                if groupID > 0 then
                    TriggerServerEvent('groupNotify:pNotifyGroup', groupID, "Get the Deed Done", Translation[Config.Locale]['started_message'])
                    TriggerServerEvent("qb-phone:Server:SetJobStatus", groupID, "in_progress", 1)
                    TriggerServerEvent('groups:server:StartGroupHax')
                    print('phoenix_heist:CreateBlipGroup')
                    Wait(100)
                    TriggerServerEvent('phoenix_heist:CreateBlipGroup',groupID, "Medical Hacking System", {coords = vector3(randomcoords.x, randomcoords.y, randomcoords.z), sprite = 1, color = 1, scale = 1.0, route = false, label = "Medical Hacking System"})

                end   
                hackerobjectactive = true
                step1done = true
            end
        else 
            Config.MSG(Translation[Config.Locale]['need_item'])
        end
end

local attemp = 0
local HeistDifficulty = {
    [1]={label = "easy"},
    [2]={label = "normal"}, 
    [3]={label = "hard"}
}
function starthacking() 
    local playerped = PlayerPedId()
    groupID = exports['qb-phone']:GetGroupID()
    local dict = Config.HackingAnim.dict
    local anim = Config.HackingAnim.anim
    local heading = GetEntityHeading(playerped)
    RequestAnimDict(dict)
    while not HasAnimDictLoaded(dict) do 
        Citizen.Wait(25)
    end 
    startanim(playerped, dict, anim)
    
    local unarmed = GetHashKey('WEAPON_UNARMED')
    SetCurrentPedWeapon(playerped, unarmed)
    FreezeEntityPosition(playerped, Config.HackingAnim.freeze)
    
    if Config.UseMinigame.enable then
        local result = exports['pure-minigames']:numberCounter(Config.UseMinigame.gameData)
        print(result)
        attemp = attemp + 1
        if result then
            FreezeEntityPosition(PlayerPedId(), false)
            ClearPedTasks(PlayerPedId())
            heist2()            
            if groupID > 0 then
                Wait(100)
                TriggerServerEvent('phoenix_heist:RemoveBlipGroup',groupID, "Medical Hacking System")            
            end 
            step2done = true 
            PlaySound(-1, "Event_Start_Text", "GTAO_FM_Events_Soundset", 0, 0, 1) 
            Wait(100)
            TriggerServerEvent("phoenix_heist:removeItem")
            return true
        else            
            FreezeEntityPosition(PlayerPedId(), false)
            ClearPedTasksImmediately(PlayerPedId())
            Config.MSG(Translation[Config.Locale]['hack_failed'])
            
            if attemp >= Config.UseMinigame.lifes then 
                endheist()               
                Wait(100)
                TriggerServerEvent("phoenix_heist:servercooldown", false)
                Wait(100)
                TriggerServerEvent("phoenix_heist:globalcd")
                Config.MSG(Translation[Config.Locale]['heist_failed'])
                Wait(100)
                TriggerServerEvent("phoenix_heist:removeItem") 
            else 
                return false
            end
        end        
    else 
        Config.Progressbar(Translation[Config.Locale]['hack_in_progress'], 5000)
        PlaySound(-1, "Event_Start_Text", "GTAO_FM_Events_Soundset", 0, 0, 1)
        step2done = true
        FreezeEntityPosition(playerped, false)
        ClearPedTasks(playerped)
        Wait(100)
        TriggerServerEvent('phoenix_heist:RemoveBlipGroup',groupID, "Medical Hacking System")        
        heist2()
        return true
    end
end

function getEnemyLocation() -- can also be an event
    QBCore.Functions.TriggerCallback('phoenix_heist:getEnemyLocation', function(result)
        enemylocation = result
    end)
end

function heist2()
    local gordon = math.random(#Config.EnemyLocations)
    enemylocation = Config.EnemyLocations[gordon]
    local peds = Config.EnemyLocations[gordon].peds
    local propcoords = Config.EnemyLocations[gordon].propcoords
    globaldifficulty = HeistDifficulty[math.random(1,3)].label
    print(globaldifficulty)
    groupID = exports['qb-phone']:GetGroupID()
    TriggerServerEvent('groupNotify:pNotifyGroup', groupID, "Get the Shipment", Translation[Config.Locale]['hack_success'])
    if groupID > 0 then
        Wait(100)
        TriggerServerEvent('phoenix_heist:CreateBlipGroup',groupID, "Medical Drop Off", {coords = vector3(enemylocation.propcoords.x, enemylocation.propcoords.y, enemylocation.propcoords.z), label = "Medical Drop Off", sprite = 440, color = 1, display = 4, scale = 0.8, route = true, routeColor = 1})
        SetDropOffScenario()
    end 
    blip1active = true

    local pedAmount = math.random(Config.Difficulty[globaldifficulty].minped, Config.Difficulty[globaldifficulty].maxped)
    weaponhash = GetHashKey(Config.Difficulty[globaldifficulty].weaponname)
    objecthash = GetHashKey(Config.Difficulty[globaldifficulty].propname)
    local peds = Config.EnemyLocations[gordon].peds
    for i=1, pedAmount do         
        local ped = peds[i]
        local enemyhash = GetHashKey(ped.pedname)
        RequestModel(enemyhash) 
        while not HasModelLoaded(enemyhash) do 
            Citizen.Wait(25)
        end 
        enemy = CreatePed(4, enemyhash, ped.pedcoords.x , ped.pedcoords.y, ped.pedcoords.z - 1.0, ped.pedcoords.w, true, true)

        GiveWeaponToPed(enemy, weaponhash, 500, false, true)
        
        SetCurrentPedWeapon(enemy, weaponhash, true)

        SetPedRelationshipGroupHash(enemy, 0xE3D976F3)

        SetPedCombatAbility(enemy, 60)

        TaskCombatPed(enemy, PlayerPedId(), 0, 16)
        table.insert(enemys, enemy)
    end
   
    RequestModel(objecthash)
    while not HasModelLoaded(objecthash) do 
        Citizen.Wait(25)
    end
    object1 = CreateObject(objecthash, propcoords.x, propcoords.y, propcoords.z - 1.0, true, true, false)
    FreezeEntityPosition(object1, true)
    PlaceObjectOnGroundProperly(object1)
    SetEntityInvincible(object1, true)
    step3done = true
    object1active = true
end

function checkalldead() 
    local alldead = true
    for i = 1, #enemys do 
        if not IsEntityDead(enemys[i]) then alldead = false end
    end 

    return alldead
end 

function SetDropOffScenario()
    getEnemyLocation()
    Citizen.CreateThread(function()
        groupID = exports['qb-phone']:GetGroupID()
        while object1active do
            Citizen.Wait(1)
            local playerped = PlayerPedId()
            local playercoords = GetEntityCoords(playerped)
            local src = source
            if blip1active then 
                local distance = Vdist(playercoords, enemylocation.propcoords.x, enemylocation.propcoords.y, enemylocation.propcoords.z)
                if distance < 50 then 
                    RemoveBlip(blip1)
                    blip1active = false 
                    TriggerServerEvent('groupNotify:pNotifyGroup', groupID, "Get the Deed Done", Translation[Config.Locale]['eleminate_all'])
                    
                    local random = math.random(1,100)
                    if random < Config.WarnPolice then                         
                        exports['ps-dispatch']:MedicalRobbery(enemylocation.propcoords)
                    end
                end
            end             
        end
    end)
end

function phoenixcleararea()
    getEnemyLocation()
    local radiusToFloat = 50 + 0.0
    ClearAreaLeaveVehicleHealth(enemylocation.propcoords.x, enemylocation.propcoords.y, enemylocation.propcoords.z, radiusToFloat, false, false, false, false, false)
end

function validateheist(isactive)
    if not isactive then
        if not busy then 
            startheist()
        end
    else 
        Config.MSG(Translation[Config.Locale]['server_cdactive'])
    end
end

function endheist()
    groupID = exports['qb-phone']:GetGroupID()
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
    if groupID > 0 then
        Wait(100)
        TriggerServerEvent('phoenix_heist:RemoveBlipGroup',groupID, "Medical Hacking System")
        Wait(100)
        TriggerServerEvent('phoenix_heist:RemoveBlipGroup',groupID, "Medical Drop Off")
    end 
    Citizen.Wait(100)
    TriggerServerEvent("phoenix_heist:servercooldown", false)
    Citizen.Wait(100)
    TriggerServerEvent("phoenix_heist:globalcd")
    Citizen.Wait(100)
    DeleteAllPeds()
    phoenixcleararea()
end

function showPictureNotification(icon, msg, title, subtitle)
    Config.MSG(msg)
end

function startanim(entity, dictionary, animation)
    RequestAnimDict(dictionary)
    while not HasAnimDictLoaded(dictionary) do
        Citizen.Wait(0)
    end
    TaskPlayAnim(entity, dictionary, animation, 1.0, -1, -1, 3, 0, false, false, false)
end

function DeleteAllPeds()    
    for i = 1, #enemys do 
        DeleteEntity(enemys[i])
    end 
    enemys = {}
end

AddEventHandler('onResourceStop', function(ressourceName)
    if(GetCurrentResourceName() == ressourceName) then  
        endheist()
        RemoveBlip(blip1)
        DeleteEntity(object1) 
        DeleteEntity(hackerobject) 
        DeleteAllPeds()
    end
end)
