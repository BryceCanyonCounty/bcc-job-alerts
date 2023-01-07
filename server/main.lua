local VorpCore = {}
local AlertsGroups = {}

TriggerEvent("getCore",function(core)
    VorpCore = core
end)

local function AlertPlayer(src, alert)
    local OriginUser = VorpCore.getUser(src).getUsedCharacter
    local pos = json.decode(OriginUser.coords)
    TriggerClientEvent("vorp:TipBottom", src, alert.originText, alert.originTime) --Send message to alerter


    Wait(alert.blipDelay)

    for key, jg in pairs(alert.jobgrade) do
        for K, person in pairs(AlertsGroups[alert.job][tostring(jg)]) do
            TriggerClientEvent('bcc:alertplayer', person.src, alert.message, alert.messageTime, alert.job, alert.hash, pos.x, pos.y, pos.z, alert.icon, alert.radius, alert.blipTime) -- send alert to job
        end 
    end
end


local function RegisterAlert(alert)
    if not AlertsGroups[alert.job] then
        AlertsGroups[alert.job] = {}
    end

    for key, jobgrade in pairs(alert.jobgrade) do
        if not AlertsGroups[alert.job][tostring(jobgrade)] then
            AlertsGroups[alert.job][tostring(jobgrade)] = {}
        end
    end

    RegisterCommand(alert.command, function(source, args, rawCommand)
        local src = source
        AlertPlayer(src, alert)
    end)
end

local function setupAlerts()
    for index, alert in ipairs(Config.Alerts) do
        RegisterAlert(alert)
    end
end

local function addUserToAlerts(_source, job, jobgrade)
    local User = VorpCore.getUser(_source).getUsedCharacter

    local j = job or User.job
    local jg = jobgrade or User.jobGrade
   
    if AlertsGroups[j] and AlertsGroups[j][tostring(jg)] then --inherent jobcheck. If the job/grade is registered, then register user
        AlertsGroups[j][tostring(jg)][tostring(_source)] = {
            src = _source,
            job = j,
            grade = jg
        }
    end
end

local function removeUserFromAlert(_source)
    local User = VorpCore.getUser(_source).getUsedCharacter

    if AlertsGroups[User.job] and AlertsGroups[User.job][tostring(User.jobGrade)] then
        AlertsGroups[User.job][tostring(User.jobGrade)][tostring(_source)] = nil
    end
end

AddEventHandler('vorp:setJob', function(_source, job, jobgrade)
    removeUserFromAlert(_source)
    addUserToAlerts(_source, job, jobgrade)
end)

RegisterServerEvent("bcc:alerts:register")
AddEventHandler("bcc:alerts:register", function()
	local _source = source
    addUserToAlerts(_source)
end)


AddEventHandler('playerDropped', function(reason)
    local _source = source
    removeUserFromAlert(_source)
end)

Citizen.CreateThread(function()
    setupAlerts()
end)

-- API
exports('RegisterAlert', RegisterAlert)
exports('SendAlert', AlertPlayer)