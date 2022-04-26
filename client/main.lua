RegisterNetEvent('bcc:alert')
AddEventHandler('bcc:alert', function(msg, time, job, blip, x, y, z, shape)
    TriggerServerEvent('bcc:jobcheck', msg, time, job, blip, x, y, z, shape)
end)

RegisterNetEvent('bcc:alert2')
AddEventHandler('bcc:alert2', function(msg, time, job, bliphash, x, y, z, shape)
    TriggerEvent("vorp:NotifyLeft", job, msg, 'generic_textures', shape, time)
    local blip = Citizen.InvokeNative(0x45f13b7e0a15c880, -1282792512, x, y, z, 40.0)
    Wait(Config.blipTime)--Time till notify blips dispears, 1 min
	RemoveBlip(blip)
end)
