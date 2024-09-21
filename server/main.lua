local VorpCore = {}
local AlertsGroups = {}

TriggerEvent("getCore",function(core)
    VorpCore = core
end)

function DumpTable(o)
    if type(o) == 'table' then
        local s = '{ '
        for k,v in pairs(o) do
           if type(k) ~= 'number' then k = '"'..k..'"' end
           s = s .. '['..k..'] = ' .. DumpTable(v) .. ','
        end
        return s .. '} '
     else
        return tostring(o)
     end
  end

function AlertPlayer(src, alert)
    local pos = GetEntityCoords(GetPlayerPed(src))

    Wait(alert.blipDelay)

    -- Iterate over each job in the alert.jobs table
    for _, job in pairs(alert.jobs) do
        -- Iterate over each job grade in the alert.jobgrade table for the current job
        for key, jg in pairs(alert.jobgrade[job]) do
            if AlertsGroups[job] and AlertsGroups[job][tostring(jg)] then
                for K, person in pairs(AlertsGroups[job][tostring(jg)]) do
                    TriggerClientEvent('bcc:alertplayer', person.src, alert.message, alert.messageTime, job, alert.hash,
                        pos.x, pos.y, pos.z, alert.icon, alert.radius, alert.blipTime) -- send alert to job
                end
            end
        end
    end
end

function RegisterAlert(alert)
    for _, job in pairs(alert.jobs) do
        if not AlertsGroups[job] then
            AlertsGroups[job] = {}
        end

        -- Ensure jobgrade for specific job is set correctly
        for _, jobgrade in pairs(alert.jobgrade[job]) do
            if not AlertsGroups[job][tostring(jobgrade)] then
                AlertsGroups[job][tostring(jobgrade)] = {}
            end
        end
    end
        -- Register call command if specified
    if alert.command then
        RegisterCommand(alert.command, function(source, args, rawCommand)
            local src = source
            AlertPlayer(src, alert)
        end) 
    end

    print("Alert Registered!", alert.name)
end

function AddUserToAlerts(_source, job, jobgrade)
    local j = job
    local jg = jobgrade

    if job == nil or jobgrade == nil then
        local User = VorpCore.getUser(_source).getUsedCharacter
        j = User.job
        jg = User.jobGrade
    end

    if AlertsGroups[j] and AlertsGroups[j][tostring(jg)] then --inherent jobcheck. If the job/grade is registered as an alert, then register user
        AlertsGroups[j][tostring(jg)][tostring(_source)] = {
            src = _source,
            job = j,
            grade = jg
        }
    end
end

function RemoveUserFromAlert(_source)
    local User = VorpCore.getUser(_source).getUsedCharacter

    if AlertsGroups[User.job] and AlertsGroups[User.job][tostring(User.jobGrade)] then
        AlertsGroups[User.job][tostring(User.jobGrade)][tostring(_source)] = nil
    end
end

-- Handle when a job is changes in Vorp
AddEventHandler('vorp:setJob', function(_source, job, jobgrade)
    RemoveUserFromAlert(_source)
    AddUserToAlerts(_source, job, jobgrade)
end)

-- Register User to alert. Client triggers this on character select
RegisterServerEvent("bcc:alerts:register")
AddEventHandler("bcc:alerts:register", function()
	local _source = source
    AddUserToAlerts(_source)
end)

-- Remove player from alert list when player leaves server
AddEventHandler('playerDropped', function(reason)
    local _source = source
    RemoveUserFromAlert(_source)
end)


-- Setup config based alerts
Citizen.CreateThread(function()
    for index, alert in ipairs(Config.Alerts) do
        RegisterAlert(alert)
    end
end)

local BccUtils = exports['bcc-utils'].initiate()
BccUtils.Versioner.checkRelease(GetCurrentResourceName(), 'https://github.com/BryceCanyonCounty/bcc-job-alerts')
