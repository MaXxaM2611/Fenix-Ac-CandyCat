CandyCat_C = {}


TriggerServerCB("gcf:__:__:",function (result)
    CandyCat_C = result
end)


RegisterClientCB("requrst-img",function (cb)
    local upload = nil
    if exports['screenshot-basic'] and CandyCat_C.ImageUpload and CandyCat_C.ImageUpload ~= "" then
        exports['screenshot-basic']:requestScreenshotUpload(CandyCat_C.ImageUpload, 'files[]', function(data)
            local resp = json.decode(data)
            for k, v in pairs(resp.attachments) do
                upload = v.url
            end
       end)
       Wait(300)
       while upload == nil do
           Wait(0)  
       end
       cb(upload) 
    else
        cb(upload) 
    end
end)


AddEventHandler('gameEventTriggered', function (name, args)
    if GetGameBuildNumber() >= 2189 then
        if name == "CEventNetworkEntityDamage" then
            if CandyCat_C.AntiTazePlayer.Enable then
                if args[7] == GetHashKey("weapon_stungun") then
                    if tonumber(args[2]) == PlayerPedId() then 
                        if HasPedGotWeapon(PlayerPedId(),GetHashKey("weapon_stungun"), false) == 1 and GetSelectedPedWeapon(PlayerPedId()) == GetHashKey("weapon_stungun") then
                            return
                        else
                            local _ = "AntiTaze Detected"
                            TriggerServerEvent("CandyCat:Req:B",_)
                        end
                    end
                end
            end
        end
    end
end)




Citizen.CreateThread(function()
	while true do		
		if CandyCat_C.WarnGiveWeapon then 
			for k, weapon in ipairs(CandyCat_C.BlacklistWeapon) do
				if HasPedGotWeapon(PlayerPedId(), GetHashKey(weapon), false) == 1 then
					RemoveWeaponFromPed(PlayerPedId(),GetHashKey(weapon))
					TriggerServerEvent("CandyCat:Req:W",weapon) 
				end
			end
		end 
		if CandyCat_C.AntiSpectate  then 
			if NetworkIsInSpectatorMode() then
				TriggerServerEvent("CandyCat:Req:S")
			end
		end 
		Citizen.Wait(1000)
	end
end)

--[[


RegisterNetEvent("onResourceStart")
AddEventHandler('onResourceStart', function(resourceName)
    print("1",resourceName)
end)

RegisterNetEvent("onClientResourceStop")
AddEventHandler('onClientResourceStop', function (resourceName)
    print("2",resourceName)
end)

RegisterNetEvent("onResourceStarting")
AddEventHandler('onResourceStarting', function(resourceName)
    print("3",resourceName)
end)

RegisterNetEvent("onResourceStop")
AddEventHandler('onResourceStop', function(resourceName)
    print("4",resourceName)
end)

]]

--[[

           if CandyCat_C.AntiAimbot.Enable then
                if tonumber(args[10]) ~= 1 then
                    if GetHashKey("weapon_assaultrifle") == args[7] then
                        local a,b = GetEntityPlayerIsFreeAimingAt(PlayerId())
                        if not a then
                            if tonumber(args[2]) == PlayerPedId() then
                                PlayerAimbot = PlayerAimbot + 1
                                if PlayerAimbot > 2 then
                                    print("Banned!- AntiAimbot Detected")
                                end
                            end
                        end
                    end
                end
            end
]]

