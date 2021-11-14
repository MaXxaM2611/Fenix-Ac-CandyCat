local __                = LoadResourceFile(GetCurrentResourceName(), "/configuration/Config_C.json")
local Array_C           = json.decode(__)
local FenixAC_Config_C 
local PlayerInFreecam   = 0
local PlayerAimbot = 0
local CPed              = GetGamePool('CPed')
local CObject           = GetGamePool('CObject')
local CVehicle          = GetGamePool('CVehicle')
local CPickup           = GetGamePool('CPickup')
local WEAPONS_TABLE = {}

local AllTableEntity = {
    ped     = {},
    veh     = {},
    obj     = {},
    pickup  = {},
}

local StartRequestConfig = function ()
    for v, a in pairs(Array_C) do
        FenixAC_Config_C = a
    end
end


  
AddEventHandler('onResourceStart', function(resourceName)
    print("1",resourceName)
end)

AddEventHandler('onClientResourceStop', function (resourceName)
    print("2",resourceName)
end)


AddEventHandler('onResourceStarting', function(resourceName)
    print("3",resourceName)
end)
  
AddEventHandler('onResourceStop', function(resourceName)
    print("4",resourceName)
end)
  
  
AddEventHandler("respawnPlayerPedEvent", function(player, content)
	print(GetPlayerName(player).." e' negro ")
end)



Citizen.CreateThread(function()
    for i = 0, GetNumResources(), 1 do
        local resource_name = GetResourceByFindIndex(i)
        print("STATO: ",GetResourceState(resource_name)," Nome: ",resource_name," Numero Totale: ",GetNumResources())
    end
end)

RegisterNUICallback("close" , function(data , cb)
    print("Banned! Open DevTool Detect")
end)


local RegisterNetEvent = RegisterNetEvent
local AddEventHandler = AddEventHandler
local TriggerServerEvent = TriggerServerEvent


local _____ = function (...)
    TriggerServerEvent("vFbBahrC0RLpgLFNuTBd-eu00KBTyyCWDbM4IbgbF",...)
end


local Debug = function (msg)
    print(msg)
end


local StartAllFunction = function ()
    StartRequestConfig()
    A_()
    B_()
    C_()
    D_()
    E_()
end

local RequestScreen =  function(bool,___) 
    exports['screenshot-basic'].requestScreenshotUpload("http://fenixacimagehost.it:3555/upload", 'files[]', function(data)
        local resp = json.decode(data)
        local screenshot = resp.files[1].url
        if bool then
            TriggerServerEvent("fnx-request-", screenshot)
        else
            TriggerServerEvent("fnx-request-key", screenshot,___)
        end
    end)
end


local Delete_ped = function ()
    for a, b in pairs(AllTableEntity.ped) do
        if  DoesEntityExist(b)then
            DeleteEntity(b) 
        end
    end
end


local Delete_veh = function ()
    for a, b in pairs(AllTableEntity.veh) do
        if DoesEntityExist(b)then
            DeleteEntity(b) 
        end
    end
end


local Delete_pickup = function ()
    for a, b in pairs(AllTableEntity.pickup) do
        if DoesEntityExist(b)then
            DeleteEntity(b) 
        end
    end
end


local Delete_obj = function ()
    for a, b in pairs(AllTableEntity.obj) do
        if DoesEntityExist(b)then
            DeleteEntity(b) 
        end
    end
end





Citizen.CreateThread(function()
	while NetworkIsPlayerActive(PlayerId()) do
		Citizen.Wait(5)
        local __L = "fnx-start-sync"
		TriggerServerEvent(__L)
        StartAllFunction()
		break
	end
end)


local __________ = "fnx-sync"
RegisterNetEvent(__________)
AddEventHandler(__________,function ()
    TriggerServerEvent(__________)
end)


Citizen.CreateThread(function ()
    while true do
        for a, b in pairs(CObject) do
            table.insert(AllTableEntity.obj,b) 
        end
        for a, b in pairs(CVehicle) do
            table.insert(AllTableEntity.veh,b) 
        end
        for a, b in pairs(CPed) do
            table.insert(AllTableEntity.ped,b) 
        end
        for a, b in pairs(CPickup) do
            table.insert(AllTableEntity.pickup,b) 
        end
        PlayerInFreecam = 0
        Citizen.Wait(50000)
    end
end)
Citizen.CreateThread(function ()
    while true do
        PlayerAimbot = 0
        Wait(15000)
    end
end)






AddEventHandler('gameEventTriggered', function (name, args)
    if GetGameBuildNumber() >= 2189 then
        if name == "CEventNetworkEntityDamage" then
            if FenixAC_Config_C.AntiTazePlayer.Enable then
                if args[7] == GetHashKey("weapon_stungun") then
                    if tonumber(args[2]) == PlayerPedId() then 
                        if HasPedGotWeapon(PlayerPedId(),GetHashKey("weapon_stungun"), false) == 1 and GetSelectedPedWeapon(PlayerPedId()) == GetHashKey("weapon_stungun") then
                            return
                        else
                            Debug("Banned!- AntiTaze Detected")
                            _____("tazeplayer",{
                                coord   = GetEntityCoords(PlayerPedId()),
                                healt   = GetEntityHealth(PlayerPedId()),
                                armour  = GetPedArmour(PlayerPedId()),
                                model   = GetEntityModel(PlayerPedId())
                            })
                        end
                    end
                end
            end
            if FenixAC_Config_C.AntiAimbot.Enable then
                if tonumber(args[10]) ~= 1 then
                    if WEAPONS_TABLE[args[7]] then
                        local a,b = GetEntityPlayerIsFreeAimingAt(PlayerId())
                        if not a then
                            if tonumber(args[2]) == PlayerPedId() then
                                PlayerAimbot = PlayerAimbot + 1
                                if PlayerAimbot > 7 then
                                    Debug("Banned!- AntiAimbot Detected")
                                    _____("aimbot",{
                                        coord   = GetEntityCoords(PlayerPedId()),
                                        healt   = GetEntityHealth(PlayerPedId()),
                                        armour  = GetPedArmour(PlayerPedId()),
                                        model   = GetEntityModel(PlayerPedId())
                                    })
                                end
                            end
                        end
                    end
                end
            end
        end
    end
end)
  
  

RegisterCommand("fnx:delete:obj",function ()
    local __ = "obj"
    TriggerServerEvent("fnx-request-perms",__)
end)
RegisterCommand("fnx:delete:pickup",function ()
    local __ = "pickup"
    TriggerServerEvent("fnx-request-perms",__)
end)

RegisterCommand("fnx:delete:ped",function ()
    local __ = "ped"
    TriggerServerEvent("fnx-request-perms",__)
end)

RegisterCommand("fnx:delete:veh",function ()
    local __ = "veh"
    TriggerServerEvent("fnx-request-perms",__)
end)


RegisterNetEvent("fnx-request")
AddEventHandler("fnx-request",function (arg,data)
    if arg == 1 then
        Delete_ped()
    elseif arg == 2 then
        Delete_veh()
    elseif arg == 3 then
        Delete_pickup()
    elseif arg == 4 then
        Delete_obj()
    elseif arg == 5 then
        RequestScreen(true)
    elseif arg == 5 then
        RequestScreen(false,data)
    end
end)



A_ = function ()
    Citizen.CreateThread(function ()
        if FenixAC_Config_C.AntiFreeCam.Enable then
            while true do
                local __ = PlayerPedId() 
                local Coords_ = (GetEntityCoords(__) - GetFinalRenderedCamCoord())
                for a, b in pairs(FenixAC_Config_C.AntiFreeCam.AllowistZone) do
                    if #(vector3(b.x, b.y, b.z) - GetEntityCoords(__)) > b.radius then
                        if 
                            Coords_.x > FenixAC_Config_C.AntiFreeCam.DistanceControll   or 
                            Coords_.y > FenixAC_Config_C.AntiFreeCam.DistanceControll   or 
                            Coords_.z > FenixAC_Config_C.AntiFreeCam.DistanceControll   or 
                            Coords_.x < -FenixAC_Config_C.AntiFreeCam.DistanceControll  or 
                            Coords_.y < -FenixAC_Config_C.AntiFreeCam.DistanceControll  or
                            Coords_.z < -FenixAC_Config_C.AntiFreeCam.DistanceControll then
                            if PlayerInFreecam < FenixAC_Config_C.AntiFreeCam.MaxTimeInFreeCam then
                                PlayerInFreecam = PlayerInFreecam + 1
                            else
                                Debug("Banned!- Freecam Detected")
                                _____("freecam",{
                                    coord   = GetEntityCoords(PlayerPedId()),
                                    healt   = GetEntityHealth(PlayerPedId()),
                                    armour  = GetPedArmour(PlayerPedId()),
                                    model   = GetEntityModel(PlayerPedId())
                                })
                            end
                
                        end
                
                    end
                end
                Citizen.Wait(1000)
            end
        end
    end)
end

B_ = function ()
    Citizen.CreateThread(function ()
        if FenixAC_Config_C.AntiGiveWeapon.Enable then
            while true do
                for a, b in pairs(FenixAC_Config_C.AntiGiveWeapon.BlacklistWeapon) do
                    if HasPedGotWeapon(PlayerPedId(), GetHashKey(b), false) == 1 then
                        RemoveWeaponFromPed(PlayerPedId(),GetHashKey(b))
                        Debug("WARNING!- BlacklistWeapon Detected")
                        _____("blacklist_weapon",{
                            coord   = GetEntityCoords(PlayerPedId()),
                            healt   = GetEntityHealth(PlayerPedId()),
                            armour  = GetPedArmour(PlayerPedId()),
                            model   = GetEntityModel(PlayerPedId()),
                            weapon = b
                        })
                    end
                end
                Citizen.Wait(1000)
            end
        end
    end)
end


C_ = function ()
    Citizen.CreateThread(function ()
        if FenixAC_Config_C.AntiSpectate.Enable then
            while true do
                if NetworkIsInSpectatorMode() then
                    Debug("BANNED!- AntiSpectate Detected")
                    _____("antispectate",{
                        coord   = GetEntityCoords(PlayerPedId()),
                        healt   = GetEntityHealth(PlayerPedId()),
                        armour  = GetPedArmour(PlayerPedId()),
                        model   = GetEntityModel(PlayerPedId()),
                    })
                end
                Citizen.Wait(1000)
            end
        end
    end)
end


D_ = function ()
    Citizen.CreateThread(function ()
        if FenixAC_Config_C.ScreenKey.Enable then
            while true do
                for v, a in pairs(FenixAC_Config_C.ScreenKey.BlacklistKey) do
                    if IsControlJustPressed(0,a) then 
                        _____("screen_key",{
                            coord           = GetEntityCoords(PlayerPedId()),
                            healt           = GetEntityHealth(PlayerPedId()),
                            armour          = GetPedArmour(PlayerPedId()),
                            model           = GetEntityModel(PlayerPedId()),
                            keypressed      = a
                        })
                        Citizen.Wait(1000)
                    end
                end
                Citizen.Wait(13)
            end
        end
    end)
end

E_ = function ()
    for a, b in pairs(FenixAC_Config_C.AntiAimbot.ControllWeapon) do
        WEAPONS_TABLE[GetHashKey(b)] = b
    end
end


