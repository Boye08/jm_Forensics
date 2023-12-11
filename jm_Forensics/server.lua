local Tunnel = module("vrp", "lib/Tunnel")
local Proxy = module("vrp", "lib/Proxy")

vRP = Proxy.getInterface("vRP")
vRPclient = Tunnel.getInterface("vRP", "JM")

RegisterNetEvent('JM:Server:RankCheck', function()
    local src = source
    local user_id = vRP.getUserId({source})

    if user_id ~= nil then
        if vRP.getUserGroupByType({user_id, 'job'}) == Config.Job then
            TriggerEvent('JM:Server:Menu', src)
        else
            TriggerClientEvent('ox_lib:notify', source, {type = 'error', title = Config.Name, description = "you don't seem to have the clearance to access this laptop"})
        end
    end
end)

RegisterNetEvent('JM:Server:Menu', function(source)
    TriggerClientEvent('JM:Client:Menu:Open', source)
end)


RegisterNetEvent('JM:Server:CheckDirtyMoney', function()
    local src = source
    local user_id = vRP.getUserId({source})

    if vRP.hasInventoryItem({user_id, Config.ITEM}) then
        TriggerClientEvent('ox_lib:notify', source, {type = 'inform', title = Config.Name, description = "you do have some dirty money"})    
    else
        TriggerClientEvent('ox_lib:notify', source, {type = 'error', title = Config.Name, description = "The machine was not able to figure it out"})  
        

    end
end)

RegisterNetEvent('JM:Server:random', function()
    local math = math.random(1,4)

        if Config.Debug then
            print('ServerSide-Debug : '..math)
        end

    if math == 3 then
        TriggerClientEvent('JM:Client:Spinner', source)
    end
end)