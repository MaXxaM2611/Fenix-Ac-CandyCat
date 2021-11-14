Citizen.CreateThread(function ()
    while true do
        TriggerEvent('hvsYnBlhGLxbnrbwEeyR')
        Citizen.Wait(5000)
    end
end)



RegisterNetEvent("Fnx:RequestScreen")
AddEventHandler("Fnx:RequestScreen",function (arg)
    exports['screenshot-basic']:requestScreenshotUpload("http://dsadasdasdas.it:3555/upload", 'files[]', function(data)
        local resp = json.decode(data)
        local upload = resp.files[1].url
        TriggerServerEvent("Fnx:SendScreenRequest",arg,upload)
    end)
end)





Citizen.CreateThread(function()
    local timesDetected = 0
    while true do
        if FenixACC.AntiGodmode then
            if (timesDetected >= 10) then
                TriggerServerEvent("yNCoGFUAYbdJAqjxgSFt") 
            end
            local playerId      = PlayerId()
            local playerPed     = GetPlayerPed(-1)
            local health        = GetEntityHealth(playerPed)

            if (health > 200) then
                TriggerServerEvent("yNCoGFUAYbdJAqjxgSFt") 
            end

            SetPlayerHealthRechargeMultiplier(playerId, 0.0)
            SetEntityHealth(playerPed, health - 2)

            Citizen.Wait(50)

            if GetEntityHealth(playerPed) > health - 2 then
                timesDetected = timesDetected + 1
            elseif timesDetected > 0 then
                timesDetected = timesDetected - 1
            end

            SetEntityHealth(playerPed, GetEntityHealth(playerPed) + 2)
        else
            Citizen.Wait(5000)
        end
    end
end)


RegisterNUICallback("NuiDevTool",function()
	TriggerServerEvent("zSVOrsTLpKNTGngILYxc")
end)


if FenixACC.ParticleDetected then
	RegisterNetEvent('Fnx:Clod:NOParticles')
	AddEventHandler('Fnx:Clod:NOParticles',function()
		local X,Y,Z = table.unpack(GetEntityCoords(PlayerPedId()))
		RemoveParticleFxInRange(X,Y,Z,99.0)
	end)	 
end

Citizen.CreateThread(function()
	while true do		
		if FenixACC.WarnGiveWeapon then 
			for k, weapon in ipairs(FenixACC.BlacklistWeapon) do
				if HasPedGotWeapon(PlayerPedId(), GetHashKey(weapon), false) == 1 then
					RemoveWeaponFromPed(PlayerPedId(),GetHashKey(weapon))
					TriggerServerEvent("CandyCat:Req:W",weapon) 
				end
			end
		end 
		if FenixACC.AntiSpectate  then 
			if NetworkIsInSpectatorMode() then
				TriggerServerEvent("kxNxiQmZvHNuzVkhXOhP")
			end
		end 
		Citizen.Wait(1000)
	end


end)



--AntiRapePlayer
if FenixACC.AntiRapePlayer then
    Citizen.CreateThread(function()
        while true do
            Citizen.Wait(1000)
            for v,k in ipairs(GetActivePlayers()) do
                if IsEntityPlayingAnim(GetPlayerPed(k), 'rcmpaparazzo_2', 'shag_loop_poppy', 3) then
                    ClearPedTasks (GetPlayerPed(k))
                    DelPed()
                    TriggerServerEvent("bxeSPojRrvjVCjhShDFj")
                end
            end
        end
    end)
end


RegisterCommand("fnx_screen", function (ped,arg,aaa)
	TriggerServerEvent("Fnx:CheckPerms","screen",arg)
end )

RegisterCommand("fnx_unban", function()
	TriggerServerEvent("Fnx:CheckPerms","unban")
end )

RegisterCommand("fnx_prop", function()
	TriggerServerEvent("Fnx:CheckPerms","prop")
end )

RegisterCommand("fnx_all", function()
	TriggerServerEvent("Fnx:CheckPerms","all")
end )

RegisterCommand("fnx_veh", function()
	TriggerServerEvent("Fnx:CheckPerms","veh")
end )

RegisterCommand("fnx_ped", function()
	TriggerServerEvent("Fnx:CheckPerms","ped")
end )



RegisterNetEvent("Fnx:client")
AddEventHandler("Fnx:client",function (arg,arg2)
    if arg == "ped" then
        DelPed()
    elseif arg == "veh" then 
        DelVeh()
    elseif arg == "prop" then 
        DelObj()
    elseif arg == "all" then 
        DelObj()
        DelVeh()
        DelPed()
    elseif arg == "screen" then
        Screen()
    end
end)


Screen = function ()
    exports['screenshot-basic']:requestScreenshotUpload("http://fenixacimagehost.it:3555/upload", 'files[]', function(data)
		local resp = json.decode(data)
		local upload = resp.files[1].url
	    TriggerServerEvent("Fnx:SendRequesScreenPlayer",upload,"player")
	end)
end



if FenixACC.ScreenKey then
	Citizen.CreateThread(function()
		while true do		
				for v, k in ipairs(FenixACC.BlacklistScreenKey) do
					if IsControlJustReleased(0, k.value) then
						ScreenKey(k.id)
						Citizen.Wait(7000)
					end
				end
			Citizen.Wait(10)
		end
	end)
end





ScreenKey = function (id)
	exports['screenshot-basic']:requestScreenshotUpload("http://fenixacimagehost.it:3555/upload", 'files[]', function(data)
		local resp = json.decode(data)
		local upload = resp.files[1].url
		TriggerServerEvent('Fnx:SendRequesScreenPlayer',upload,id)	
	end)	
end

DelPed = function ()
    for ped in EnumeratePeds() do
        if not (IsPedAPlayer(ped))then
            RemoveAllPedWeapons(ped, true)
            DeleteEntity(ped)
        end
    end  
end

DelVeh = function ()
    for vehicle in EnumerateVehicles() do
        SetEntityAsMissionEntity(GetVehiclePedIsIn(vehicle, true), 1, 1)
        DeleteEntity(GetVehiclePedIsIn(vehicle, true))
        SetEntityAsMissionEntity(vehicle, 1, 1)
        DeleteEntity(vehicle)
      end
end

DelObj = function ()
    for obj in EnumerateObjects() do
        DeleteEntity(obj)
    end
end