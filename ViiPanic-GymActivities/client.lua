local QBCore = exports['qb-core']:GetCoreObject()

function DrawText3Ds(x,y,z, text)
    local onScreen,_x,_y=World3dToScreen2d(x,y,z)
    local px,py,pz=table.unpack(GetGameplayCamCoords())
    SetTextScale(0.30, 0.30)
    SetTextFont(4)
    SetTextProportional(1)
    SetTextColour(255, 255, 255, 215)
    SetTextEntry('STRING')
    SetTextCentre(1)
    AddTextComponentString(text)
    DrawText(_x,_y)
    local factor = (string.len(text)) / 370
    DrawRect(_x,_y+0.0125, 0.015+ factor, 0.03, 41, 11, 41, 68)
end

Citizen.CreateThread(function()

	if Config.EnableBlip then
		local blip = AddBlipForCoord( Config.MapBlip.Pos.x,  Config.MapBlip.Pos.y,  Config.MapBlip.Pos.z)
		SetBlipSprite (blip,  Config.MapBlip.Sprite)
		SetBlipDisplay(blip,  Config.MapBlip.Display)
		SetBlipScale  (blip,  Config.MapBlip.Scale)
		SetBlipColour (blip,  Config.MapBlip.Colour)
		SetBlipAsShortRange(blip, true)
		BeginTextCommandSetBlipName("STRING")
		AddTextComponentString(Config.MapBlip.Name)
		EndTextCommandSetBlipName(blip)
	end
	
end)

RegisterNetEvent('Gym:StartYoga', function(data)
    local playerPed = GetPlayerPed(-1)
    TaskStartScenarioInPlace(playerPed, "world_human_yoga", 0, true)
    
    QBCore.Functions.Progressbar("Yoga", "Doing Yoga..", 10000, false, true, {
            disableMovement = false,
            disableCarMovement = false,
            disableMouse = false,
            disableCombat = true,
        }, {}, {}, {}, function() -- Done
            ShowNotification(Config.FinishString)		
            ClearPedTasks(PlayerPedId())
            FreezeEntityPosition(playerPed, false)
            TriggerServerEvent("consumables:server:addHunger", QBCore.Functions.GetPlayerData().metadata["hunger"]-(math.random(0, 10)))
            TriggerServerEvent("consumables:server:addThirst", QBCore.Functions.GetPlayerData().metadata["thirst"]-(math.random(0, 10)))
            TriggerServerEvent('hud:server:RelieveStress', math.random(25, 50))
        end, function() -- Cancel
            ClearPedTasks(PlayerPedId())
            FreezeEntityPosition(playerPed, false)
    end)
end)  

RegisterNetEvent('Gym:StartSquats', function(data)
    local playerPed = GetPlayerPed(-1)
    exports["rpemotes"]:EmoteCommandStart("gym", 0)
    
    --TaskStartScenarioInPlace(playerPed, "WORLD_HUMAN_PUSH_UPS", 0, true)
    QBCore.Functions.Progressbar("Pushup", "Doing Pushups..", 10000, false, true, {
            disableMovement = false,
            disableCarMovement = false,
            disableMouse = false,
            disableCombat = true,
        }, {}, {}, {}, function() -- Done
            ShowNotification(Config.FinishString)		
            ClearPedTasks(PlayerPedId())
            exports["rpemotes"]:EmoteCancel(true)
            FreezeEntityPosition(playerPed, false)
            TriggerServerEvent("consumables:server:addHunger", QBCore.Functions.GetPlayerData().metadata["hunger"]-(math.random(0, 10)))
            TriggerServerEvent("consumables:server:addThirst", QBCore.Functions.GetPlayerData().metadata["thirst"]-(math.random(0, 10)))
            TriggerServerEvent('hud:server:RelieveStress', math.random(25, 50))
        end, function() -- Cancel
            ClearPedTasks(PlayerPedId())
            FreezeEntityPosition(playerPed, false)
    end)
end)  

RegisterNetEvent('Gym:StartPushups', function(data)
    local playerPed = GetPlayerPed(-1)
    exports["rpemotes"]:EmoteCommandStart("pushup", 0)
    
    --TaskStartScenarioInPlace(playerPed, "WORLD_HUMAN_PUSH_UPS", 0, true)
    QBCore.Functions.Progressbar("Pushup", "Doing Pushups..", 10000, false, true, {
            disableMovement = false,
            disableCarMovement = false,
            disableMouse = false,
            disableCombat = true,
        }, {}, {}, {}, function() -- Done
            ShowNotification(Config.FinishString)		
            ClearPedTasks(PlayerPedId())
            exports["rpemotes"]:EmoteCancel(true)
            FreezeEntityPosition(playerPed, false)
            TriggerServerEvent("consumables:server:addHunger", QBCore.Functions.GetPlayerData().metadata["hunger"]-(math.random(0, 10)))
            TriggerServerEvent("consumables:server:addThirst", QBCore.Functions.GetPlayerData().metadata["thirst"]-(math.random(0, 10)))
            TriggerServerEvent('hud:server:RelieveStress', math.random(25, 50))
        end, function() -- Cancel
            ClearPedTasks(PlayerPedId())
            FreezeEntityPosition(playerPed, false)
    end)
end)  

RegisterNetEvent('Gym:StartSitUps', function(data)    
    local playerPed = GetPlayerPed(-1)
    SetEntityCoords(playerPed, data.exercise.entityCoords.x, data.exercise.entityCoords.y,
    data.exercise.entityCoords.z, 0, 0, 0, true)
    SetEntityHeading(playerPed, data.exercise.heading)
    exports["rpemotes"]:EmoteCommandStart("gym5", 0)
    
    --TaskStartScenarioInPlace(playerPed, "world_human_sit_ups", 0, true)
    QBCore.Functions.Progressbar("Situp", "Doing Situps..", 10000, false, true, {
            disableMovement = false,
            disableCarMovement = false,
            disableMouse = false,
            disableCombat = true,
        }, {}, {}, {}, function() -- Done
            ShowNotification(Config.FinishString)		
            ClearPedTasks(PlayerPedId())
            exports["rpemotes"]:EmoteCancel(true)
            FreezeEntityPosition(playerPed, false)
            TriggerServerEvent("consumables:server:addHunger", QBCore.Functions.GetPlayerData().metadata["hunger"]-(math.random(0, 10)))
            TriggerServerEvent("consumables:server:addThirst", QBCore.Functions.GetPlayerData().metadata["thirst"]-(math.random(0, 10)))
            TriggerServerEvent('hud:server:RelieveStress', math.random(25, 50))
        end, function() -- Cancel
            ClearPedTasks(PlayerPedId())
            FreezeEntityPosition(playerPed, false)
    end)
end)

RegisterNetEvent('Gym:StartOneHandWeight', function(data)     
    local animDict = "amb@world_human_muscle_free_weights@male@barbell@base"
    local animName = "base"

    while not HasAnimDictLoaded(animDict) do
        RequestAnimDict(animDict)
        Wait(100)
    end

    local blendInSpeed = 8.0
    local blendOutSpeed = 8.0
    local duration = 25000
    local flag = 0
    local playbackRate = 0.0
    local lockX = false
    local lockY = false
    local lockZ = false
    local ped = PlayerPedId()


    SetPedKeepTask(ped, true)


    local hash = GetHashKey("prop_barbell_01")
    RequestModel(hash)
    while not HasModelLoaded(hash) do
        Citizen.Wait(100)
        RequestModel(hash)
    end
    local prop = CreateObject(hash, GetEntityCoords(PlayerPedId()), true, true, true)
    AttachEntityToEntity(prop, PlayerPedId(), GetPedBoneIndex(PlayerPedId(), 57005), 0.1, 0.0,
        0.0, 288.0,
        70.0, -36.0, true, true, false, false, 1, true)

    RequestModel(hash)
    while not HasModelLoaded(hash) do
        Citizen.Wait(100)
        RequestModel(hash)
    end
    local prop2 = CreateObject(hash, GetEntityCoords(PlayerPedId()), true, true, true)
    AttachEntityToEntity(prop2, PlayerPedId(), GetPedBoneIndex(PlayerPedId(), 18905), 0.1, 0.0,
        0.0, 267.0, 91.0, -134.0, true, true, false, false, 1, true)

    TaskPlayAnim(ped, animDict, animName, blendInSpeed, blendOutSpeed, duration, flag,
        playbackRate, lockX, lockY, lockZ)
    
    QBCore.Functions.Progressbar("Weight", "lifting weight..", 10000, false, true, {
            disableMovement = false,
            disableCarMovement = false,
            disableMouse = false,
            disableCombat = true,
        }, {}, {}, {}, function() -- Done
            ShowNotification(Config.FinishString)		
            ClearPedTasks(PlayerPedId())
            DeleteObject(prop2)
            DeleteObject(prop)
            FreezeEntityPosition(ped, false)
            TriggerServerEvent("consumables:server:addHunger", QBCore.Functions.GetPlayerData().metadata["hunger"]-(math.random(0, 10)))
            TriggerServerEvent("consumables:server:addThirst", QBCore.Functions.GetPlayerData().metadata["thirst"]-(math.random(0, 10)))
            TriggerServerEvent('hud:server:RelieveStress', math.random(25, 50))
        end, function() -- Cancel
            ClearPedTasks(PlayerPedId())
            DeleteObject(propbench)
            FreezeEntityPosition(ped, false)
    end)
end)

RegisterNetEvent('Gym:StartTwoHandWeight', function(data)     
    local animDict = "amb@world_human_muscle_free_weights@male@barbell@base"
    local animName = "base"

    while not HasAnimDictLoaded(animDict) do
        RequestAnimDict(animDict)
        Wait(100)
    end

    local blendInSpeed = 8.0
    local blendOutSpeed = 8.0
    local duration = -1
    local flag = 49
    local playbackRate = 0.0
    local lockX = false
    local lockY = false
    local lockZ = false
    local ped = PlayerPedId()

    local hash = GetHashKey("prop_curl_bar_01")
    RequestModel(hash)
    while not HasModelLoaded(hash) do
        Citizen.Wait(100)
        RequestModel(hash)
    end
    local prop = CreateObject(hash, GetEntityCoords(PlayerPedId()), true, true, true)
    AttachEntityToEntity(prop, PlayerPedId(), GetPedBoneIndex(PlayerPedId(), 18905), 0.1,
        -0.1, 0.2, 79.0, 90.0, 30.0, true, true, false, false, 1, true)

    TaskPlayAnim(ped, animDict, animName, blendInSpeed, blendOutSpeed, duration, flag,
        playbackRate, lockX, lockY, lockZ)
    
    QBCore.Functions.Progressbar("Weight", "lifting weight..", 10000, false, true, {
            disableMovement = false,
            disableCarMovement = false,
            disableMouse = false,
            disableCombat = true,
        }, {}, {}, {}, function() -- Done
            ShowNotification(Config.FinishString)		
            ClearPedTasks(PlayerPedId())
            DeleteEntity(prop)
            FreezeEntityPosition(ped, false)
            TriggerServerEvent("consumables:server:addHunger", QBCore.Functions.GetPlayerData().metadata["hunger"]-(math.random(0, 10)))
            TriggerServerEvent("consumables:server:addThirst", QBCore.Functions.GetPlayerData().metadata["thirst"]-(math.random(0, 10)))
            TriggerServerEvent('hud:server:RelieveStress', math.random(25, 50))
        end, function() -- Cancel
            ClearPedTasks(PlayerPedId())
            DeleteObject(propbench)
            FreezeEntityPosition(ped, false)
    end)
end)

RegisterNetEvent('Gym:StartChinups', function(data) 
    local playerPed = GetPlayerPed(-1)
    FreezeEntityPosition(playerPed, true)
    SetEntityCoords(playerPed, data.exercise.entityCoords.x, data.exercise.entityCoords.y,
    data.exercise.entityCoords.z, 0, 0, 0, true)
    SetEntityHeading(playerPed, data.exercise.heading)
    TaskStartScenarioInPlace(playerPed, "prop_human_muscle_chin_ups", 0, true)
    
    QBCore.Functions.Progressbar("Chinup", "Chinup..", 10000, false, true, {
        disableMovement = false,
        disableCarMovement = false,
		disableMouse = false,
		disableCombat = true,
    }, {}, {}, {}, function() -- Done
		ShowNotification(Config.FinishString)		
        ClearPedTasks(PlayerPedId())
		DeleteObject(propbench)
		FreezeEntityPosition(playerPed, false)
        TriggerServerEvent("consumables:server:addHunger", QBCore.Functions.GetPlayerData().metadata["hunger"]-(math.random(0, 10)))
		TriggerServerEvent("consumables:server:addThirst", QBCore.Functions.GetPlayerData().metadata["thirst"]-(math.random(0, 10)))
		TriggerServerEvent('hud:server:RelieveStress', math.random(25, 50))
	end, function() -- Cancel
		ClearPedTasks(PlayerPedId())
		DeleteObject(propbench)
		FreezeEntityPosition(playerPed, false)
    end)
end)

RegisterNetEvent('Gym:StartBike', function(data) 
    TaskStartScenarioAtPosition(PlayerPedId(), 'PROP_HUMAN_SEAT_CHAIR_MP_PLAYER', data.exercise.entityCoords.x, data.exercise.entityCoords.y, data.exercise.entityCoords.z, data.exercise.heading, 100000, 0, true, true)

    local animDict = "amb@world_human_jog_standing@male@idle_a"
    local animName = "idle_a"

    while not HasAnimDictLoaded(animDict) do
        RequestAnimDict(animDict)
        Wait(100)
    end

    local blendInSpeed = 8.0
    local blendOutSpeed = 8.0
    local duration = -1
    local flag = 49
    local playbackRate = 0.0
    local lockX = false
    local lockY = false
    local lockZ = false
    local ped = PlayerPedId()

    exports["rpemotes"]:EmoteCommandStart("gym2", 0)
    
    --TaskPlayAnim(ped, animDict, animName, blendInSpeed, blendOutSpeed, duration, flag, playbackRate,
                                    --lockX, lockY, lockZ)

    QBCore.Functions.Progressbar("Biking", "Biking..", 10000, false, true, {
        disableMovement = false,
        disableCarMovement = false,
		disableMouse = false,
		disableCombat = true,
    }, {}, {}, {}, function() -- Done
		ShowNotification(Config.FinishString)		
        ClearPedTasks(PlayerPedId())
        exports["rpemotes"]:EmoteCancel(true)
		FreezeEntityPosition(ped, false)
        TriggerServerEvent("consumables:server:addHunger", QBCore.Functions.GetPlayerData().metadata["hunger"]-(math.random(0, 10)))
		TriggerServerEvent("consumables:server:addThirst", QBCore.Functions.GetPlayerData().metadata["thirst"]-(math.random(0, 10)))
		TriggerServerEvent('hud:server:RelieveStress', math.random(25, 50))
	end, function() -- Cancel
		ClearPedTasks(PlayerPedId())
		FreezeEntityPosition(ped, false)
    end)
end)    

RegisterNetEvent('Gym:StartBench', function(data) 
	local animDict = "amb@prop_human_seat_muscle_bench_press@idle_a"
	local animName = "idle_a"

	while not HasAnimDictLoaded(animDict) do
		RequestAnimDict(animDict)
		Wait(100)
	end

	local blendInSpeed = 8.0
	local blendOutSpeed = 8.0
	local flag = 49
	local playbackRate = 0.0
	local lockX = false
	local lockY = false
	local lockZ = false
	local ped = PlayerPedId()

	SetEntityCoords(ped, data.exercise.entityCoords.x, data.exercise.entityCoords.y,
	data.exercise.entityCoords.z, 0, 0, 0, true)
	SetEntityHeading(ped, data.exercise.heading)

	FreezeEntityPosition(ped, true)
	local hash = GetHashKey("prop_barbell_100kg")
	RequestModel(hash)
	while not HasModelLoaded(hash) do
		Citizen.Wait(100)
		RequestModel(hash)
	end
	local propbench = CreateObject(hash, GetEntityCoords(PlayerPedId()), true, true, true)
	AttachEntityToEntity(propbench, PlayerPedId(), GetPedBoneIndex(PlayerPedId(), 57005), 0.17,
		0.33, 0.0, -43.0, -43.0, -103.0, true, true, false, false, 1, true)

    TaskPlayAnim(ped, animDict, animName, blendInSpeed, blendOutSpeed, 50000, 0, playbackRate,
        lockX, lockY, lockZ)

	QBCore.Functions.Progressbar("benching", "Benching..", 5000, false, true, {
        disableMovement = false,
        disableCarMovement = false,
		disableMouse = false,
		disableCombat = true,
    }, {}, {}, {}, function() -- Done
		ShowNotification(Config.FinishString)		
        ClearPedTasks(PlayerPedId())
		DeleteObject(propbench)
		FreezeEntityPosition(ped, false)
        TriggerServerEvent("consumables:server:addHunger", QBCore.Functions.GetPlayerData().metadata["hunger"]-(math.random(0, 10)))
		TriggerServerEvent("consumables:server:addThirst", QBCore.Functions.GetPlayerData().metadata["thirst"]-(math.random(0, 10)))
		TriggerServerEvent('hud:server:RelieveStress', math.random(25, 50))
	end, function() -- Cancel
		ClearPedTasks(PlayerPedId())
		DeleteObject(propbench)
		FreezeEntityPosition(ped, false)
    end)
end)

Citizen.CreateThread(function()

	for exerciseIndex, exerciseData in pairs(Config.Bench) do
		exports['qb-target']:AddBoxZone("bench"..exerciseIndex, vector3(exerciseData.coords.x, exerciseData.coords.y, exerciseData.coords.z), 2, 1, 
        {name="bench"..exerciseIndex, heading=0, debugPoly=false, minZ = exerciseData.coords.z - 1, maxZ = exerciseData.coords.z + 1}, 
		{
			options = { 
				{  
					event = "Gym:StartBench", 
					icon = "fas fa-dumbbell", 
					label = "Start Bench Exercise", 
					exercise = exerciseData,
				},				
			},
			distance = 2
		})
	end

    for exerciseIndex, exerciseData in pairs(Config.Bike) do
        exports['qb-target']:AddBoxZone("bike"..exerciseIndex, vector3(exerciseData.coords.x, exerciseData.coords.y, exerciseData.coords.z), 2, 1, 
        {name="bike"..exerciseIndex, heading=0, debugPoly=false, minZ = exerciseData.coords.z - 1, maxZ = exerciseData.coords.z + 1},
		{
			options = { 
				{  
					event = "Gym:StartBike", 
					icon = "fas fa-dumbbell", 
					label = "Start Bike Exercise", 
					exercise = exerciseData,
				},			
			},
			distance = 2
		})
    end

    for exerciseIndex, exerciseData in pairs(Config.Chinups) do
        exports['qb-target']:AddBoxZone("chinups"..exerciseIndex, vector3(exerciseData.coords.x, exerciseData.coords.y, exerciseData.coords.z), 2, 2,
        {name="chinups"..exerciseIndex, heading=0, debugPoly=false, minZ = exerciseData.coords.z - 1, maxZ = exerciseData.coords.z + 1}, 
		{
			options = { 
				{  
					event = "Gym:StartChinups", 
					icon = "fas fa-dumbbell", 
					label = "Start Chinup Exercise", 
					exercise = exerciseData,
				},				
			},
			distance = 2
		})
    end

    for i, coord in ipairs(Config.TwoHandWeight) do
        exports['qb-target']:AddBoxZone("TwoHandWeight"..i, vec3(coord.x, coord.y, coord.z), 2, 1,
        {name="TwoHandWeight"..i, heading=0, debugPoly=false, minZ = coord.z - 1, maxZ = coord.z + 1}, 
		{
			options = { 
				{  
					event = "Gym:StartTwoHandWeight", 
					icon = "fas fa-dumbbell", 
					label = "Start Weight Exercise", 
					exercise = coord,
				},			
			},
			distance = 2
		})
    end

    for i, coord in ipairs(Config.OneHandWeight) do
        exports['qb-target']:AddBoxZone("OneHandWeight"..i, vec3(coord.x, coord.y, coord.z),  2, 1,
        {name="OneHandWeight"..i, heading=0, debugPoly=false, minZ = coord.z - 1, maxZ = coord.z + 1}, 
		{
			options = { 
				{  
					event = "Gym:StartOneHandWeight", 
					icon = "fas fa-dumbbell", 
					label = "Start Weight Exercise", 
					exercise = coord,
				},				
			},
			distance = 2
		})
    end

    for exerciseIndex, exerciseData in pairs(Config.Situps) do
        exports['qb-target']:AddBoxZone("SitUps"..exerciseIndex, vector3(exerciseData.coords.x, exerciseData.coords.y, exerciseData.coords.z), 2, 1,
        {name="SitUps"..exerciseIndex,debugPoly=false, minZ = exerciseData.coords.z - 1, maxZ = exerciseData.coords.z + 1},  
		{
			options = { 
				{  
					event = "Gym:StartSitUps", 
					icon = "fas fa-dumbbell", 
					label = "Start SitUps Exercise", 
					exercise = exerciseData,
				},				
			},
			distance = 2
		})
    end

    for i, coord in ipairs(Config.Pushups) do
        exports['qb-target']:AddCircleZone("Pushups"..i, vec3(coord.x, coord.y, coord.z), 10.0,  
        {name="Pushups"..i, debugPoly=false, }, 
		{
			options = { 
				{  
                    type = "client",
					event = "Gym:StartPushups", 
					icon = "fas fa-dumbbell", 
					label = "Start Pushups Exercise", 
				},				
			},
			distance = 2
		})
    end

    for i, coord in ipairs(Config.Squats) do
        exports['qb-target']:AddCircleZone("Squats"..i, vec3(coord.x, coord.y, coord.z), 3.0,  
        {name="Squats"..i, debugPoly=false, }, 
		{
			options = { 
				{  
                    type = "client",
					event = "Gym:StartSquats", 
					icon = "fas fa-dumbbell", 
					label = "Start Squats Exercise", 
				},				
			},
			distance = 2
		})
    end

    for i, coord in ipairs(Config.Yoga) do
        exports['qb-target']:AddCircleZone("Yoga"..i,vec3(coord.x, coord.y, coord.z), 10.0,
        {name="Yoga"..i, debugPoly=false, }, 
		{
			options = { 
				{  
                    type = "client",
					event = "Gym:StartYoga", 
					icon = "fas fa-dumbbell", 
					label = "Start Yoga Exercise", 
				},				
			},
			distance = 2
		})
    end
end)


function ShowNotification(text)
	SetNotificationTextEntry('STRING')
    AddTextComponentString(text)
	DrawNotification(false, true)
end
