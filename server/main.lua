local QBCore = exports['qb-core']:GetCoreObject()
local function ensurePricesInDatabase()
    for _, market in ipairs(Config.Markets) do
        for _, item in ipairs(market.items) do
            local query = 'INSERT INTO market_prices (item_name, price, price_change) VALUES (?, ?, ?) ON DUPLICATE KEY UPDATE item_name=item_name'
            local params = {item.name, item.price, 0}
            MySQL.Async.execute(query, params)
        end
    end
end

local function loadPricesFromDatabase()
    MySQL.Async.fetchAll('SELECT * FROM market_prices', {}, function(results)
        if results then
            for _, row in ipairs(results) do
                for _, market in ipairs(Config.Markets) do
                    for _, item in ipairs(market.items) do
                        if item.name == row.item_name then
                            item.price = row.price
                            item.priceChange = row.price_change
                        end
                    end
                end
            end

            -- Ensure all items have prices (set to default if not found in database)
            for _, market in ipairs(Config.Markets) do
                for _, item in ipairs(market.items) do
                    if not item.price then
                        item.price = item.defaultPrice or 0
                        item.priceChange = 0
                    end
                end
            end
        end

        -- Send updated prices to all clients
        TriggerClientEvent('market:updatePrices', -1, Config.Markets)

        -- Schedule the next price update
        Citizen.SetTimeout(Config.PriceChangeInterval, updatePrices)
    end)
end

function updatePrices()
    for _, market in ipairs(Config.Markets) do
        for _, item in ipairs(market.items) do
            local minPrice = item.minPrice
            local maxPrice = item.maxPrice
            local priceChange = math.random(-100, 200) -- random price change within a range
            local newPrice = item.price + priceChange

            -- Ensure the price is within the min and max range
            if newPrice < minPrice then
                newPrice = minPrice
            elseif newPrice > maxPrice then
                newPrice = maxPrice
            end

            item.priceChange = newPrice - item.price
            item.price = newPrice

            -- Update the database with the new prices
            local query = 'UPDATE market_prices SET price = ?, price_change = ? WHERE item_name = ?'
            local params = {item.price, item.priceChange, item.name}
            MySQL.Async.execute(query, params)
        end
    end
    TriggerClientEvent('market:updatePrices', -1, Config.Markets)
    Citizen.SetTimeout(Config.PriceChangeInterval, updatePrices)
end

AddEventHandler('onResourceStart', function(resourceName)
    if GetCurrentResourceName() ~= resourceName then return end
    ensurePricesInDatabase()
    loadPricesFromDatabase()
end)

RegisterServerEvent('market:sellItem')
AddEventHandler('market:sellItem', function(marketType, itemName, amount)
    local src = source
    local xPlayer = QBCore.Functions.GetPlayer(src)

    MySQL.Async.fetchAll('SELECT price FROM market_prices WHERE item_name = ?', {itemName}, function(result)
        if result[1] then
            local price = result[1].price
            local totalPrice = price * amount

            local inventoryAmount = exports.ox_inventory:Search(src, 'count', itemName)
            if inventoryAmount >= amount then
                xPlayer.Functions.RemoveItem(itemName, amount)
                xPlayer.Functions.AddItem('money', totalPrice)
                TriggerClientEvent('QBCore:Notify', src, 'You sold ' .. amount .. ' ' .. itemName .. ' for $' .. totalPrice, 'success')
            else
                TriggerClientEvent('QBCore:Notify', src, 'You do not have enough ' .. itemName, 'error')
            end
        else
            TriggerClientEvent('QBCore:Notify', src, 'Failed to find price for ' .. itemName, 'error')
        end
    end)
end)

RegisterNetEvent('market:requestPrices')
AddEventHandler('market:requestPrices', function()
    local src = source
    TriggerClientEvent('market:updatePrices', src, Config.Markets)
end)

RegisterServerEvent('market:open')
AddEventHandler('market:open', function(marketType)
    local src = source
    local marketItems = {}

    for _, market in ipairs(Config.Markets) do
        if market.type == marketType then
            marketItems = market.items
            break
        end
    end

    if marketItems then
        TriggerClientEvent('market:openMarket', src, marketItems)
    end
end)
