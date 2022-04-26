local VorpCore = {}

TriggerEvent("getCore",function(core)
    VorpCore = core
end)
VORP = exports.vorp_core:vorpAPI()
Config.medic = {
    ["message"] = "Injury Reported!",
    ["messageTime"] = 60000,
    ["job"] = "medic",
    ["icon"] = "shield"
}

RegisterCommand('alertdoctor', function(src, args, rawCommand)
    local User = VorpCore.getUser(src).getUsedCharacter
    local pos = json.decode(User.coords)

    TriggerClientEvent('bcc:alert', src, Config.medic.message, Config.medic.messageTime, Config.medic.job, -1282792512, pos.x, pos.y, pos.z, Config.medic.icon)
    TriggerClientEvent("vorp:TipBottom", src, Config.medic.originText, Config.medic.originTime)
end)

RegisterCommand('alertpolice', function(src, args, rawCommand)
    local User = VorpCore.getUser(src).getUsedCharacter
    local pos = json.decode(User.coords)

    TriggerClientEvent('bcc:alert', src, Config.police.message, Config.police.messageTime, Config.police.job, -1282792512, pos.x, pos.y, pos.z, Config.police.icon)
    TriggerClientEvent("vorp:TipBottom", src, Config.police.originText, Config.police.originTime)
end)

-- Ensure the users with the proper rolls are notified
RegisterServerEvent('bcc:jobcheck')
AddEventHandler('bcc:jobcheck', function(msg, time, job1, blip, x, y, z, shape)
    for _, playerId in ipairs(GetPlayers()) do
        local name = GetPlayerName(playerId)
        print(name, playerId)
        local User = VorpCore.getUser(playerId).getUsedCharacter
    
        if User.job == job1 then
            -- print('Player' .. name .. 'has been alerted!')
            TriggerClientEvent('bcc:alert2', playerId, msg, time, job1, blip, x, y, z, shape)
        end

    end
end)