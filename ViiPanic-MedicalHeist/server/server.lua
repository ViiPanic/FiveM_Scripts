local QBCore = exports['qb-core']:GetCoreObject()

local heistactive = false
local enemylocation = {}
local globaldifficulty = nil

QBCore.Functions.CreateCallback('phoenix_heist:getEnemyLocation', function(source, cb)
    cb(enemylocation)
end)

QBCore.Functions.CreateCallback('phoenix_heist:getglobaldifficulty', function(source, cb)
    cb(globaldifficulty)
end)

RegisterServerEvent("phoenix_heist:servercooldown")
AddEventHandler("phoenix_heist:servercooldown", function(isstarting)
    if isstarting then 
        heistactive = true 
    else 
        heistactive = false
    end
end)

RegisterServerEvent("phoenix_heist:globalcd")
AddEventHandler("phoenix_heist:globalcd", function()
   if not heistactive and Config.AfterHeistCooldown > 0 then 
        heistactive = true 
        Citizen.Wait((Config.AfterHeistCooldown*1000))
        heistactive = false
   end
end)

RegisterServerEvent("phoenix_heist:setglobaldifficulty")
AddEventHandler("phoenix_heist:setglobaldifficulty", function(globaldifficulty)
    globaldifficulty = globaldifficulty
end)

RegisterServerEvent("phoenix_heist:SetEnemyLocation")
AddEventHandler("phoenix_heist:SetEnemyLocation", function(enemylocation)
    enemylocation = enemylocation
end)

RegisterServerEvent('phoenix_heist:CreateBlipGroup')
AddEventHandler('phoenix_heist:CreateBlipGroup', function(groupID, blipName, blipData)      
    local Locations = vector3(blipData.coords.x, blipData.coords.y, blipData.coords.z)
    local blip = {
        coords = Locations,
        sprite = blipData.sprite,
        color = blipData.color, 
        scale = 0.8,
        route = blipData.route,
        label = blipName, 
        routeColor = blipData.routeColor
    }

    if groupID > 0 and heistactive then
        Wait(100)
        exports['qb-phone']:CreateBlipForGroup(groupID, blipName, blip)
        local groupMembers = exports['qb-phone']:getGroupMembers(groupID)
        
        print(#groupMembers)
        if groupID and #groupMembers > 0 then
            for i = 1, #groupMembers do
                if blipName == "Medical Hacking System" then 
                    TriggerClientEvent("phoenix_heist:HackingSystem", groupMembers[i], groupID, vector3(blipData.coords.x, blipData.coords.y, blipData.coords.z))
                else
                    TriggerClientEvent("phoenix_heist:LootTarget", groupMembers[i], groupID, vector3(blipData.coords.x, blipData.coords.y, blipData.coords.z))
                end
            end
        end
    end

end)

RegisterServerEvent('phoenix_heist:RemoveBlipGroup')
AddEventHandler('phoenix_heist:RemoveBlipGroup', function(groupID, name)     
    if groupID > 0 and heistactive then
        exports['qb-phone']:RemoveBlipForGroup(groupID, name)     
    end
end)

RegisterServerEvent("phoenix_heist:callpolice")
AddEventHandler("phoenix_heist:callpolice", function(position)
    local xPlayers = QBCore.Functions.GetPlayer(-1)
    exports['ps-dispatch']:MedicalRobbery(position)
   
end)

RegisterServerEvent("phoenix_heist:server:SellGoods")
AddEventHandler("phoenix_heist:server:SellGoods", function()
    local src = source
    local player = QBCore.Functions.GetPlayer(src)
    if not player then
        return
    end

    local buyersList = Config.MedicalSupplies
    local falseCount = 0

    for i = 1, #buyersList do
        local buyer = buyersList[i]
        local itemName = buyer.itemName
        local itemWorth = buyer.itemWorth

        local item = player.Functions.GetItemByName(itemName)
        if item then
            player.Functions.RemoveItem(itemName, item.amount)
            TriggerClientEvent('inventory:client:ItemBox', src, QBCore.Shared.Items[itemName], "remove")
            
            local actualWorth = math.random(itemWorth[1], itemWorth[2]) * item.amount

            player.Functions.AddMoney('cash', actualWorth)        
        else
            falseCount = falseCount + 1
        end
    end

    if falseCount == #buyersList then
        TriggerClientEvent("phoenix_heist:NoItemsToSell", src)
    end
end)

RegisterServerEvent("phoenix_heist:removeItem")
AddEventHandler("phoenix_heist:removeItem", function()
    QBCore.Functions.GetPlayer(source).Functions.RemoveItem(Config.RequiredItem, 1, nil)
    TriggerClientEvent('inventory:client:ItemBox', source, QBCore.Shared.Items[Config.RequiredItem], "remove", 1)
end)

RegisterServerEvent("phoenix_heist:givereward")
AddEventHandler("phoenix_heist:givereward", function(globaldifficulty)
    local xPlayers = QBCore.Functions.GetPlayer(source)    
    local rewardItems = {}
    local rewardMoney = {}
    print("phoenix_heist:givereward")
    print(globaldifficulty)
    rewardItems = Config.RewardItem[globaldifficulty]
    rewardMoney = Config.RewardMoney[globaldifficulty]   

    for k, v in pairs(rewardItems) do
        print(v)
        local item = QBCore.Shared.Items[v]
        local amount = math.random(2,10.0)
        TriggerClientEvent('inventory:client:ItemBox', source, item, "add", amoount)
        xPlayers.Functions.AddItem(v, amount)
    end  
    local moneyAmount = math.random(50.0, 500)
    TriggerClientEvent('inventory:client:ItemBox', source, QBCore.Shared.Items[rewardMoney.account], "add", moneyAmount)
    xPlayers.Functions.AddItem(rewardMoney.account, moneyAmount)
end)

function heist_webhook(source, globaldifficulty)
    local xPlayers = QBCore.Functions.GetPlayer(source)
	local information = {
		{
			["color"] = '6684876',
			["author"] = {
				["icon_url"] = 'https://i.imgur.com/oBjCx4T.png',
				["name"] = 'Phoenix Heist',
			},
			["title"] = 'Logs',
			["description"] = '**' ..xPlayer.getName(source)..'** has done the Heist\nDifficulty: **'..globaldifficulty..'**',

			["footer"] = {
				["text"] = os.date('%d/%m/%Y [%X]').." � PHOENIX STUDIOS",
			}
		}
	}
	PerformHttpRequest(Config.Webhook, function(err, text, headers) end, 'POST', json.encode({username = 'Phoenix Studios', embeds = information, avatar_url = 'https://i.imgur.com/oBjCx4T.png' }), {['Content-Type'] = 'application/json'})
end 


QBCore.Functions.CreateCallback('phoenix_heist:heistactive', function(source, cb)
    cb(heistactive)
end)

QBCore.Functions.CreateCallback('phoenix_heist:hasitem', function(source, cb, itemname)
    local Player = QBCore.Functions.GetPlayer(source)

    cb(heistactive)
end)