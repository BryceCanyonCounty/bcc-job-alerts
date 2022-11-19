local VorpCore = {}

TriggerEvent("getCore",function(core)
    VorpCore = core
end)

local function AlertPlayer(src, conf)
    local User = VorpCore.getUser(src).getUsedCharacter
    local pos = json.decode(User.coords)

    for _, playerId in ipairs(GetPlayers()) do
        local User = VorpCore.getUser(playerId).getUsedCharacter
    
        if User.job == conf.job then
            TriggerClientEvent('bcc:alertplayer', playerId, conf.message, conf.messageTime, conf.job, conf.hash, pos.x, pos.y, pos.z, conf.icon, conf.radius)
        end
    end

    TriggerClientEvent("vorp:TipBottom", src, conf.originText, conf.originTime)
end
exports('SendAlert', AlertPlayer)

RegisterCommand('alertdoctor', function(source, args, rawCommand)
    local src = source
    AlertPlayer(src, Config.medic)
end)

RegisterCommand('alertpolice', function(source, args, rawCommand)
    local src = source
    AlertPlayer(src, Config.police)
end)
