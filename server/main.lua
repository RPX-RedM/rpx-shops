RPX = exports['rpx-core']:GetObject()

RegisterNetEvent("RPXShops:SERVER:PurchaseItem", function(shop, item, amount)
    local src = source
    local player = RPX.GetPlayer(src)
    local itemData = GetShopItem(shop, item)
    if itemData then
        local price = itemData.price * amount
        if player.money.cash >= price then
            exports['rpx-inventory']:AddItem(src, item, amount)
            player.func.RemoveMoney('cash', price)
            TriggerClientEvent("RPXShops:CLIENT:PurchaseItem", src)
        else
            RPX.pNotifyLeft(src, {text = "You don't have enough money to purchase this item.", type = "error", timeout = 3000, layout = "centerLeft"})
        end
    end
end)

GetShopItem = function(shop, item)
    local itemData = Config.Shops[shop].items
    for k,v in pairs(itemData) do
        if v.item == item then
            return v
        end
    end
    return nil
end