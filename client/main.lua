local Core = exports.vorp_core:GetCore()

RegisterNetEvent('bcc:alertplayer', function(title, msg, texturedir, icon, time, color, bliphash, x, y, z, radius, bliptime)
    Core.NotifyLeft(title, msg, texturedir, icon, time, color)
    local blip = Citizen.InvokeNative(0x45f13b7e0a15c880, bliphash, x, y, z, radius)
    Wait(bliptime)
	RemoveBlip(blip)
end)

RegisterNetEvent('bcc:notification')
AddEventHandler('bcc:notification', function(title, message)
    Core.NotifyLeft(title, message, "generic_textures", "tick", 5000, (COLOR_WHITE) )
end)

RegisterNetEvent("vorp:SelectedCharacter", function(charid)
	Wait(1000)
    TriggerServerEvent('bcc:alerts:register')
end)
