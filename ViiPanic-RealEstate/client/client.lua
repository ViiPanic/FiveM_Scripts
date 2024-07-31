local QBCore = exports['qb-core']:GetCoreObject()
RegisterNetEvent('QBCore:Client:UpdateObject', function() QBCore = exports['qb-core']:GetCoreObject() end)

PlayerJob = {}
local Targets = {}
local Blips = {}
local onDuty = false
local tempShell = nil
local self = nil

local function jobCheck()
	canDo = true
	if not onDuty then triggerNotify(nil, Loc[Config.Lan].error["not_clockin"], 'error') canDo = false end
	return canDo
end

RegisterNetEvent('QBCore:Client:OnPlayerLoaded', function()
    QBCore.Functions.GetPlayerData(function(PlayerData)
        PlayerJob = PlayerData.job
        if PlayerData.job.onduty then if PlayerData.job.name == "realestate" then TriggerServerEvent("QBCore:ToggleDuty") end end
    end)
end)
RegisterNetEvent('QBCore:Client:OnJobUpdate', function(JobInfo) PlayerJob = JobInfo onDuty = PlayerJob.onduty end)
RegisterNetEvent('QBCore:Client:SetDuty', function(duty) onDuty = duty end)

AddEventHandler('onResourceStart', function(resource) if GetCurrentResourceName() ~= resource then return end
	QBCore.Functions.GetPlayerData(function(PlayerData) PlayerJob = PlayerData.job if PlayerData.job.name == "realestate" then onDuty = PlayerJob.onduty end end)
end)

function makeBlip(data)
	local blip = AddBlipForCoord(data.coords)
	SetBlipAsShortRange(blip, true)
	SetBlipSprite(blip, data.sprite or 1)
	SetBlipColour(blip, data.col or 0)
	SetBlipScale(blip, 0.5)
	SetBlipDisplay(blip, (data.disp or 6))
	BeginTextCommandSetBlipName('STRING')
	AddTextComponentString(tostring(data.name))
	EndTextCommandSetBlipName(blip)
	if Config.Debug then print("^5Debug^7: ^6Blip ^2created for location^7: '^6"..data.name.."^7'") end
    return blip
end

Citizen.CreateThread(function()
	local bossroles = {}
	for k, v in pairs(QBCore.Shared.Jobs["realestate"].grades) do
		if QBCore.Shared.Jobs["realestate"].grades[k].isboss == true then
			if bossroles["realestate"] then
				if bossroles["realestate"] > tonumber(k) then bossroles["realestate"] = tonumber(k) end
			else bossroles["realestate"] = tonumber(k)	end
		end
	end
	for k, v in pairs(Config.Locations) do
		if Config.Locations[k].zoneEnable then
			JobLocation = PolyZone:Create(Config.Locations[k].zones, { name = Config.Locations[k].label, debugPoly = Config.Debug })
			JobLocation:onPlayerInOut(function(isPointInside) if not isPointInside and onDuty and PlayerJob.name == "realestate" then TriggerServerEvent("QBCore:ToggleDuty") end end)

			Blips[#Blips+1] = makeBlip({coords = v.blip, sprite = 374, col = 2, scale = 1, disp = 6, name = v.label})
		end
	end

    Targets["RealEstateClockin"] =
	exports['qb-target']:AddBoxZone("RealEstateClockin", vector3(-715.8, 261.24, 84.04), 1.5, 1, 
	{ name="RealEstateClockin", heading = 5.1, debugPoly=Config.Debug, minZ = 81.18, maxZ = 95.18 },
		{ options = { 	{ 
			type = "server", 
			event = "QBCore:ToggleDuty", 
			icon = "fas fa-user-check", 
			label = "Go On/Off Duty", 
			job = "realestate" },
		{ event = "qb-clothing:client:openOutfitMenu", 
			icon = "fas fa-user-check", 
			label = "Outfits", 
			job = "realestate", },
		{ event = "qb-bossmenu:client:OpenMenu", 
			icon = "fas fa-list", 
			label = "Boss Menu", 
			job = bossroles, },},
			distance = 2.0 
						}
					)


    exports['qb-target']:AddBoxZone("PreviewInterior", vector3(-700.94, 268.2, 83.1), 2, 1, 
        { name="PreviewInterior", heading = 347.1, debugPoly=Config.Debug, minZ = 82.1, maxZ = 93.1, },
        { options = 
            { 	
                {                         
                    icon = "fa fa-house",
                    label = "Preview Interor",
                    event = "real-estate:client:OpenHousePreviewMenu"
                },                
            },
            distance = 2.0 
        }
    )
        
end)

RegisterNetEvent('real-estate:client:OpenHousePreviewMenu', function(data)
    local preview_house_main_menu_option = {
        { title = "80 000$", arrow = true, menu = 'preview_low_menu'},
        { title = "110 000$ to 420 000$", arrow = true, menu = 'preview_mid_menu'},
        { title = "550 000$ to 750 000$", arrow = true, menu = 'preview_highend_menu'},
        { title = "1 100 000$ to 2 200 000$", arrow = true, menu = 'preview_delux_menu'},
    }

    lib.registerContext({
        id = 'OpenHousePreviewMenu',
        title = "House Interior",
        options = preview_house_main_menu_option
    })

    lib.registerContext({
        id = 'preview_low_menu',
        title = "80 000$",
        menu = 'OpenHousePreviewMenu',
        options = {
            { title = 'Trailer', event = 'real-estate:client:VisitInterior', args = { shell = 'shell_trailer', doorOffset = { x = -1.27, y = -2.08, z = -0.48, h = 358.84, width = 2.0  }, Header = "Trailer", lastMenu = 'preview_low_menu'}},
            { title = 'Motel', event = 'real-estate:client:VisitInterior', args = { shell = 'standardmotel_shell', doorOffset = { x = -0.5, y = -2.3, z = 0.0, h = 90.0, width = 1.5 }, Header = "Motel", lastMenu = 'preview_low_menu'}},
        }
    })   
    lib.registerContext({
        id = 'preview_mid_menu',
        title = "110 000$ to 420 000$",
        menu = 'OpenHousePreviewMenu',
        options = {
            --{ title = 'Small Appartment 1', event = 'real-estate:client:VisitInterior', args = { shell = 'playerhouse_tier2', doorOffset = { x = -1.780, y = -0.795, z = 1.1, h = 270.30, width = 2.0  }, Header = "", lastMenu = 'preview_low_menu'}},
           -- { title = 'Small House 1', event = 'real-estate:client:VisitInterior', args = { shell = 'CreateAppartmentTier2', doorOffset = {  x = 4.98, y = 4.35, z = 0.0, h = 179.79, width = 2.0  }, Header = "", lastMenu = 'preview_low_menu'}},
            { title = 'Small House', event = 'real-estate:client:VisitInterior', args = { shell = 'shell_lester', doorOffset = { x = -1.61, y = -6.02, z = -0.37, h = 357.7, width = 2.0  }, Header = "", lastMenu = 'preview_low_menu'}},
            { title = 'Modern Hotel', event = 'real-estate:client:VisitInterior', args = { shell = 'modernhotel_shell', doorOffset = { x = 4.98, y = 4.35, z = 0.0, h = 179.79, width = 2.0  }, Header = "", lastMenu = 'preview_low_menu'}},
            { title = 'Small Apartment', event = 'real-estate:client:VisitInterior', args = { shell = 'shell_v16low', doorOffset = { x = 4.69, y = -6.5, z = -1.0, h = 358.50, width = 1.5  }, Header = "", lastMenu = 'preview_low_menu'}},
            --{ title = 'Small Apartment v2', event = 'real-estate:client:VisitInterior', args = { shell = 'appartment_low', doorOffset = { x = 4.7, y = -6.2, z = 1.2, h = 358.633972168, width = 1.5  }, Header = "", lastMenu = 'preview_low_menu'}},
            { title = 'Medium House 1', event = 'real-estate:client:VisitInterior', args = { shell = 'shell_medium2', doorOffset = { x = 6.069122, y = 0.394775, z = 0.138916, h = 4.643677, width = 1.5  }, Header = "", lastMenu = 'preview_low_menu'}},
            { title = 'Medium House 2', event = 'real-estate:client:VisitInterior', args = { shell = 'shell_medium3', doorOffset = {  x = 5.789444, y = -1.667908, z = 1.004852, h = 89.03, width = 1.5  }, Header = "", lastMenu = 'preview_low_menu'}},
            { title = 'Medium House 3', event = 'real-estate:client:VisitInterior', args = { shell = 'shell_frankaunt', doorOffset = { x = -0.34, y = -5.97, z = -0.57, h = 357.23, width = 2.0  }, Header = "", lastMenu = 'preview_low_menu'}},
            { title = 'Medium House 4', event = 'real-estate:client:VisitInterior', args = { shell = 'shell_trevor', doorOffset = { x = 0.2, y = -3.82, z = -0.41, h = 358.4, width = 2.0  }, Header = "", lastMenu = 'preview_low_menu'}},
            { title = 'Big House', event = 'real-estate:client:VisitInterior', args = { shell = 'shell_v16mid', doorOffset = { x = 1.34, y = -14.36, z = -0.5, h = 354.08, width = 1.5  }, Header = "", lastMenu = 'preview_low_menu'}},
        }
    }) 
    lib.registerContext({
        id = 'preview_highend_menu',
        title = "550 000$ to 750 000$",
        menu = 'OpenHousePreviewMenu',
        options = {
            { title = 'HighEnd House', event = 'real-estate:client:VisitInterior', args = { shell = 'shell_highend', doorOffset = { x = -22.37, y = -0.33, z = 6.96, h = 267.73, width = 2.0  }, Header = "", lastMenu = 'preview_low_menu'}},
            { title = 'HighEnd House 2', event = 'real-estate:client:VisitInterior', args = { shell = 'shell_highendv2', doorOffset = { x = -10.51, y = 0.86, z = 4.06, h = 270.38, width = 2.0  }, Header = "", lastMenu = 'preview_low_menu'}},
            { title = 'Ranch', event = 'real-estate:client:VisitInterior', args = { shell = 'shell_ranch', doorOffset = { x = -1.23, y = -5.54, z = -1.1, h = 272.21, width = 2.0  }, Header = "", lastMenu = 'preview_low_menu'}},
        }
    }) 
    lib.registerContext({
        id = 'preview_delux_menu',
        title = "1 100 000$ to 2 200 000$",
        menu = 'OpenHousePreviewMenu',
        options = {
            { title = 'Two Stories House', event = 'real-estate:client:VisitInterior', args = { shell = 'shell_michael', doorOffset = { x = -9.6, y = 5.63, z = -4.07, h = 268.55, width = 2.0  }, Header = "", lastMenu = 'preview_low_menu'}},
            { title = 'Vinewood House', event = 'real-estate:client:VisitInterior', args = { shell = 'shell_apartment1', doorOffset = { x = -2.23, y = 9.01, z = 3.69, h = 178.81, width = 2.0  }, Header = "", lastMenu = 'preview_low_menu'}},
            { title = 'Vinewood House 2', event = 'real-estate:client:VisitInterior', args = { shell = 'shell_apartment2', doorOffset = { x = -2.25, y = 9.00, z = 3.69, h = 177.86, width = 2.0  }, Header = "", lastMenu = 'preview_low_menu'}},
            { title = 'Vinewood House 3', event = 'real-estate:client:VisitInterior', args = { shell = 'shell_apartment3', doorOffset = { x = 11.75, y = 4.55, z = 3.13, h = 129.16, width = 2.0  }, Header = "", lastMenu = 'preview_low_menu'}},
            { title = 'Vinewood House 4', event = 'real-estate:client:VisitInterior', args = { shell = 'frankelientje', doorOffset = { x = 10.8, y = 7.8, z = 4.27, h = 125.5, width = 2.0  }, Header = "", lastMenu = 'preview_low_menu'}},
        }
    }) 
    lib.showContext('OpenHousePreviewMenu')
end)

RegisterNetEvent('real-estate:client:VisitInterior', function(data)
    CreateTempShell(data)
end)

function DespawnShell()
    if DoesEntityExist(self.entity) then
        DeleteEntity(self.entity)
    end

    if self.exitTarget then
        exports["qb-target"]:RemoveZone(self.exitTarget)
    end
    self = nil
end

function SpawnShell(shellHash, position, rotation)
    lib.requestModel(shellHash)

    local entity = CreateObjectNoOffset(shellHash, position.x, position.y, position.z, false, false, false)
    FreezeEntityPosition(entity, true)

    SetEntityRotation(entity, rotation, 2, true)

    SetModelAsNoLongerNeeded(shellHash)

    return entity
end

function CreateTempShell(data)    
    self = setmetatable({}, Shell)
    --self.shellData = Config.Shells[shellName]
    self.hash = data.shell
    self.position = Config.ShellSpawn
    self.rotation = vector3(0.0, 0.0, 0.0)
    

    DoScreenFadeOut(250)
    Wait(250)

    self.oldCoord = GetEntityCoords(PlayerPedId())

    self.entity = SpawnShell(self.hash, self.position, self.rotation)


    local doorOffset = data.doorOffset
    local offset = GetOffsetFromEntityInWorldCoords(self.entity, doorOffset.x, doorOffset.y, doorOffset.z)

    SetEntityCoordsNoOffset(cache.ped, offset.x, offset.y, offset.z, false, false, true)
    SetEntityHeading(cache.ped, data.doorOffset.h)

    local coords = offset
    local size = vector3(1.0, data.doorOffset.width, 3.0)
    local heading = data.doorOffset.h

    local function leave()
        DoScreenFadeOut(250)
        Wait(250)

        SetEntityCoordsNoOffset(PlayerPedId(), self.oldCoord.x, self.oldCoord.y, self.oldCoord.z, false, false, true)

        if leaveCb then
            leaveCb()
        end
        
        DespawnShell()

        Wait(250)
        DoScreenFadeIn(250)
    end


    self.exitTarget = exports["qb-target"]:AddBoxZone(
        "shellExit",
        vector3(coords.x, coords.y, coords.z),
        size.x,
        size.y,
        {
            name = "shellExit",
            heading = heading,
            debugPoly = Config.DebugMode,
            minZ = coords.z - 2.0,
            maxZ = coords.z + 1.0,
        },
        {
            options = {
                {
                    label = "Leave",
                    action = leave,
                    icon = "fas fa-right-from-bracket",
                },
            },
        }
    )

    Wait(250)
    DoScreenFadeIn(250)

    tempShell = self

    return self.entity
end



