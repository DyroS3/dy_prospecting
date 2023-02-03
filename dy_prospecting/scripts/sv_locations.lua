ESX = nil

TriggerEvent('esx:getSharedObject', function(obj)
    ESX = obj
end) 

local locations = {
    {x = 1600.185, y = 6622.714, z = 15.85106, data = {
        item = "bones",
		label = "小石子",
    }},
    {x = 1548.082, y = 6633.096, z = 2.377085, data = {
        item = "nuts",
		label = "螺母"
    }},
    {x = 1504.235, y = 6579.784, z = 4.365892, data = {
        item = "bolts",
        label = "螺栓",
    }},
    {x = 1580.016, y = 6547.394, z = 15.96557, data = {
        item = "dragon_scales",
        label = "龙鳞",
    }},
    {x = 1634.586, y = 6596.688, z = 22.55633, data = {
        item = "metalscrap",
		label = "废金属",
    }},
}

local item_pool = {
    {item = "bones", label = "小石子"},
    {item = "nuts", label = "螺母"},
    {item = "bolts", label = "螺栓"},
    {item = "dragon_scales", label = "龙鳞"},
    {item = "metalscrap", label = "废金属"},
}

-- Area to create targets within, matches the client side blips
local base_location = vector3(1580.9, 6592.204, 13.84828)
local area_size = 100.0

-- Choose a random item from the item_pool list
function GetNewRandomItem()
    local item = item_pool[math.random(#item_pool)]
    return {item = item.item, label = item.label}
end

-- Make a random location within the area
function GetNewRandomLocation()
    local offsetX = math.random(-area_size, area_size)
    local offsetY = math.random(-area_size, area_size)
    local pos = vector3(offsetX, offsetY, 0.0)
    if #(pos) > area_size then
        -- It's not within the circle, generate a new one instead
        return GetNewRandomLocation()
    end
    return base_location + pos
end

-- Generate a new target location
function GenerateNewTarget()
    local newPos = GetNewRandomLocation()
    local newData = GetNewRandomItem()
    Prospecting.AddTarget(newPos.x, newPos.y, newPos.z, newData)
end

RegisterServerEvent("dy_prospecting:activateProspecting")
AddEventHandler("dy_prospecting:activateProspecting", function()
    local player = source
    Prospecting.StartProspecting(player)
end)

CreateThread(function()
    -- Default difficulty
    Prospecting.SetDifficulty(1.0)

    -- Add a list of targets
    -- Each target needs an x, y, z and data entry
    Prospecting.AddTargets(locations)

    -- Generate 10 random extra targets
    for n = 0, 10 do
        GenerateNewTarget()
    end

    -- The player collected something
    Prospecting.SetHandler(function(player, data, x, y, z)
		FoundItem(player, data)
        -- Every time a
        GenerateNewTarget()
    end)

    -- The player started prospecting
    Prospecting.OnStart(function(player)
		-- TriggerClientEvent("r3_notifications:client:sendNotification", player, "Started prospecting", "inform", 2500)
        TriggerClientEvent('ox_lib:notify', player, {
            title = '我的收藏',
            description = '开启探勘宝物！',
            type = 'inform',
            icon = 'door-open',
            position = 'bottom',
            style = {
                borderRadius = 5,
            }
        })
    end)

    -- The player stopped prospecting
    -- time in milliseconds
    Prospecting.OnStop(function(player, time)
		-- TriggerClientEvent("r3_notifications:client:sendNotification", player, "Stopped prospecting", "inform", 2500)
        TriggerClientEvent('ox_lib:notify', player, {
            title = '我的收藏',
            description = '已停止探勘',
            type = 'inform',
            icon = 'door-open',
            position = 'bottom',
            style = {
                borderRadius = 5,
            }
        })
    end)
end)


ESX.RegisterUsableItem("detector", function(source)
	TriggerClientEvent("dy_prospecting:useDetector", source)
end)

function FoundItem(player, data)
	local xPlayer = ESX.GetPlayerFromId(player)
	if xPlayer.canCarryItem(data.item, 1) then
		xPlayer.addInventoryItem(data.item, 1)
		-- TriggerClientEvent("r3_notifications:client:sendNotification", player, "You found " .. data.label .. "!", "success", 5000)
        TriggerClientEvent('ox_lib:notify', player, {
            title = '我的收藏',
            description = "哇，您找到了 " .. data.label .. "!",
            type = 'inform',
            icon = 'door-open',
            position = 'bottom',
            style = {
                borderRadius = 5,
            }
        })
	else
		-- TriggerClientEvent("r3_notifications:client:sendNotification", player, "You found " .. data.label .. " but your inventory is full!", "error", 5000)
        TriggerClientEvent('ox_lib:notify', player, {
            title = '我的收藏',
            description = "持有的" .. data.label .. "已到达拥有上限!",
            type = 'inform',
            icon = 'door-open',
            position = 'bottom',
            style = {
                borderRadius = 5,
            }
        })
	end
end