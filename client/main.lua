local QBCore = exports['qb-core']:GetCoreObject()

local currentMarketType = nil
local isNearSellShop = false

function showInfobar(msg)

	CurrentActionMsg  = msg
	SetTextComponentFormat('STRING')
	AddTextComponentString(CurrentActionMsg)
	DisplayHelpTextFromStringLabel(0, 0, 1, -1)

end
local function isAllowedJob(jobs)
    if #jobs == 0 then
        return true
    end
    local PlayerJob = QBCore.Functions.GetPlayerData().job
    for _, job in ipairs(jobs) do
        if job == PlayerJob.name then
            return true
        end
    end
    return false
end

local function sellItem(marketType, itemName, amount)
    TriggerServerEvent('market:sellItem', marketType, itemName, amount)
end

local function spawnPedsOrMarkers()
    for _, market in ipairs(Config.Markets) do
        if market.ped.usePed then
            local pedData = market.ped
            RequestModel(pedData.model)
            while not HasModelLoaded(pedData.model) do
                Wait(1)
            end

            local ped = CreatePed(4, pedData.model, pedData.coords.x, pedData.coords.y, pedData.coords.z, pedData.heading, false, true)
            SetEntityInvincible(ped, true)
            FreezeEntityPosition(ped, true)
            SetBlockingOfNonTemporaryEvents(ped, true)
        elseif market.marker.useMarker then
            local markerData = market.marker
            Citizen.CreateThread(function()
                while true do
                    Wait(0)
                    DrawMarker(
                        markerData.type,
                        markerData.coords.x, markerData.coords.y, markerData.coords.z,
                        0.0, 0.0, 0.0,
                        0.0, 0.0, 0.0,
                        markerData.size.x, markerData.size.y, markerData.size.z,
                        markerData.color.r, markerData.color.g, markerData.color.b, 100,
                        false, true, 2, nil, nil, false
                    )
                end
            end)
        end
    end

    for _, shop in ipairs(Config.SellShops) do
        if shop.ped.usePed then
            local pedData = shop.ped
            RequestModel(pedData.model)
            while not HasModelLoaded(pedData.model) do
                Wait(1)
            end

            local ped = CreatePed(4, pedData.model, pedData.coords.x, pedData.coords.y, pedData.coords.z, pedData.heading, false, true)
            SetEntityInvincible(ped, true)
            FreezeEntityPosition(ped, true)
            SetBlockingOfNonTemporaryEvents(ped, true)
        elseif shop.marker.useMarker then
            local markerData = shop.marker
            Citizen.CreateThread(function()
                while true do
                    Wait(0)
                    DrawMarker(
                        markerData.type,
                        markerData.coords.x, markerData.coords.y, markerData.coords.z,
                        0.0, 0.0, 0.0,
                        0.0, 0.0, 0.0,
                        markerData.size.x, markerData.size.y, markerData.size.z,
                        markerData.color.r, markerData.color.g, markerData.color.b, 100,
                        false, true, 2, nil, nil, false
                    )
                end
            end)
        end
    end
end

CreateThread(function()
    TriggerServerEvent('market:requestPrices')
    spawnPedsOrMarkers()
    while true do
        Wait(0)
        local playerPed = PlayerPedId()
        local playerCoords = GetEntityCoords(playerPed)

        for _, market in ipairs(Config.Markets) do
            local pedCoords = market.ped.coords
            local markerCoords = market.marker.coords
            local distance = #(playerCoords - (market.ped.usePed and pedCoords or markerCoords))
            if distance < 2.0 and isAllowedJob(market.jobs) then
                showInfobar("[~g~E~s~] Preise Checken")
                --showTextUI("[E] Preise Checken")
                if IsControlJustReleased(0, 38) then -- E key
                    currentMarketType = market.type
                    TriggerServerEvent('market:open', market.type)
                end
            else
            isNearSellShop = false
            end
        end

        for _, shop in ipairs(Config.SellShops) do
            local pedCoords = shop.ped.coords
            local markerCoords = shop.marker.coords
            local distance = #(playerCoords - (shop.ped.usePed and pedCoords or markerCoords))
            if distance < 2.0 and isAllowedJob(shop.jobs) then
                showInfobar("[~g~E~s~] Gegenstände Verkaufen")
                if IsControlJustReleased(0, 38) then -- E key
                    local marketType = shop.type
                    local hasItemsToSell = false
                    for _, market in ipairs(Config.Markets) do
                        if market.type == marketType then
                            for _, item in ipairs(market.items) do
                                local amount = exports.ox_inventory:Search("count", item.name)
                                if amount > 0 then
                                    sellItem(marketType, item.name, amount)
                                    hasItemsToSell = true
                                end
                            end
                        end
                    end
                    if not hasItemsToSell then
                        TriggerEvent('QBCore:Notify', 'You have no items to sell', 'error')
                    end
                end
            end
        end
    end
end)

RegisterNetEvent('market:openMarket')
AddEventHandler('market:openMarket', function(items)
    SetNuiFocus(true, true)
    SendNUIMessage({
        action = "openMarket",
        items = items
    })
end)

RegisterNetEvent('market:updatePrices')
AddEventHandler('market:updatePrices', function(markets)
    if currentMarketType then
        for _, market in ipairs(markets) do
            if market.type == currentMarketType then
                SendNUIMessage({
                    action = "updatePrices",
                    items = market.items
                })
                break
            end
        end
    end
end)

RegisterNUICallback('closeMarket', function(data, cb)
    SetNuiFocus(false, false)
    currentMarketType = nil
    cb('ok')
end)
