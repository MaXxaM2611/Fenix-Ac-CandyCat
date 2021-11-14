local A         = LoadResourceFile(GetCurrentResourceName(),'./configuration/Config_S.json');
local B         = LoadResourceFile(GetCurrentResourceName(),'./configuration/Bypass.json');
local C         = LoadResourceFile(GetCurrentResourceName(),'./configuration/Explosion.json');
local D         = LoadResourceFile(GetCurrentResourceName(),'./configuration/Language.json');
local F         = LoadResourceFile(GetCurrentResourceName(),'./configuration/Peds.json');
local G         = LoadResourceFile(GetCurrentResourceName(),'./configuration/Vehicle.json'); 
local H         = LoadResourceFile(GetCurrentResourceName(),'./configuration/Object.json');
local I         = LoadResourceFile(GetCurrentResourceName(),'./configuration/Particle.json');
local L         = LoadResourceFile(GetCurrentResourceName(),'./configuration/Event.json');
local FenixAC_Config_S  ,FenixAC_Bypass ,FenixAC_Explosion ,FenixAC_Language , FenixAC_Peds ,FenixAC_Vehicle ,FenixAC_Object, FenixAC_Particle,FenixAC_Event = {},{},{},{},{},{},{},{},{}




local Event = {
    ExplosionCreated    =   {},
    ObjectCreated       =   {},
    PedCreated          =   {},
    VehicleCreated      =   {},
}

local AllDataPlayer     =   {}
local InBanned = false
local StartSync = {}
local PlayerSync = {}
local incontroll = false


local PrintColorGood = {

    red_purple      = "\27[101;95m",
    yellow_purple   = "\27[103;95m",
    blue_purple     = "\27[104;95m",
    blue_white      = "\27[104;97m",
    blue_yellow     = "\27[101;93m",
    green_yellow    = "\27[102;93m",
    green_black     = "\27[102;30m",
    green_red       = "\27[102;91m",
    blue_black      = "\27[44;30m",
    red_black       = "\27[41;30m",
    yellow_black    = "\27[43;30m",
    inverse         = "\27[7;31m",
    purple          = "\27[45m",

}
local GetColorPrint = function (type,msg)
    if PrintColorGood[type] then
        return PrintColorGood[type]..msg.."\27[0m"
    end
end

local prefix                        = GetColorPrint("purple","[Fenix-AC]").." | "..GetColorPrint("green_black","[4.0]").." | "
local _prefix_pedentityCreating     = GetColorPrint("yellow_purple","[PedsSpawn Debug]").." "
local _prefix_vehentityCreating     = GetColorPrint("blue_purple","[VehicleSpawn Debug]").." "
local _prefix_objentityCreating     = GetColorPrint("green_yellow","[ObjectSpawn Debug]").." "
local _prefix_partentityCreating    = GetColorPrint("green_red","[ParticleSpawn Debug]").." "
local _prefix_explosion             = GetColorPrint("blue_black","[Explosion Debug]").." "
local _prefix_eventcontrol          = GetColorPrint("inverse","[Event Controll Debug]").." "
local _prefix_ClientCheat           = GetColorPrint("blue_yellow","[Client Cheat Detect Debug]").." "

RegisterServerEvent("fnx-sync")
AddEventHandler("fnx-sync",function ()
    local src = source
    if StartSync[src] then
        StartSync[src] = nil
    end
end)


local StartLoopSyncCheck = function ()
    Citizen.CreateThread(function ()
        Citizen.Wait(5000)
        incontroll = true
        for a, b in pairs(PlayerSync) do
            if StartSync[b] then
                print("BAN: ",b)
            end
        end
        incontroll = false
    end)
end


Citizen.CreateThread(function ()
    while true do
        for a, b in pairs(PlayerSync) do
            if StartSync[b] == nil then
                StartSync[b] = b
                TriggerClientEvent("fnx-sync",b)
            end
        end
        StartLoopSyncCheck()
        Citizen.Wait(15000)
    end
end)



RegisterServerEvent("fnx-start-sync")
AddEventHandler("fnx-start-sync",function ()
    while incontroll do
        Citizen.Wait(10)
    end
    local src = source
    PlayerSync[src] = src
end)


Citizen.CreateThread(function ()
    while true do
        Citizen.Wait(10000)
        Event.ExplosionCreated    =   {}
        Event.ObjectCreated       =   {}
        Event.PedCreated          =   {}
        Event.VehicleCreated      =   {}
    end
end)


local GetBypass = function (_src)
    
end

DumpTable_ = function(table, nb)
	if nb == nil then
		nb = 0
	end

	if type(table) == 'table' then
		local s = ''
		for i = 1, nb + 1, 1 do
			s = s .. "    "
		end

		s = '\n'
		for k,v in pairs(table) do
			if type(k) ~= 'number' then k = '"'..k..'"' end
			for i = 1, nb, 1 do
				s = s .. "    "
			end
			s = s .. ''..k..'   ' .. DumpTable_(v, nb + 1) .. '\n'
		end

		for i = 1, nb, 1 do
			s = s .. "    "
		end

		return s .. ''
	else
		return tostring(table)
	end
end


_DumpTable = function(table, nb)
	if nb == nil then
		nb = 0
	end

	if type(table) == 'table' then
		local s = ''
		for i = 1, nb + 1, 1 do
			s = s .. "    "
		end

		s = '\n'
		for k,v in pairs(table) do
			if type(k) ~= 'number' then k = '"'..k..'"' end
			for i = 1, nb, 1 do
				s = s .. "    "
			end
			s = s .._DumpTable(v, nb + 1) .. '\n'
		end

		for i = 1, nb, 1 do
			s = s .. "    "
		end

		return s .. ''
	else
		return tostring(table)
	end
end


local logstored = {}

local LogSistem = function (_src,table)
    if logstored[_src] == nil then
        logstored[_src] = true
        local type = (table.type or "generic")
        local webhooks = FenixAC_Config_S.Logs.Discord.Webhooks[type]
        local reason ,ban,kick,identifier,name = (table.arg.reason or "n/a"),(table.arg.ban or "n/a"),(table.arg.kick or "n/a"),(table.arg.identifier or {}),(table.arg.name or "n/a")
        if ban then ban = " ✅" else ban = " ❌" end
        if kick then kick = " ✅" else kick = " ❌" end
        local description = "**Player:** "..name.."\n**ID:** [".._src.."]\n **Violation:** "..reason.."\n **Banned:** "..ban.."\n **Kicked:** "..kick.."\n\n**Identifier:** \n```".._DumpTable(identifier).."```"
        PerformHttpRequest("https://discord.com/api/webhooks/868062796682784788/IHr00lVZpR_eS66kqILHKj0-HIRSydj2T2DPfgHAgJR85cJT9_WKFrvGZBHNhs1hWnIa", function()
        end, "POST", json.encode({
            embeds = {{
                author = {
                    name = "FenixAC [4.0]",
                    url = "https://www.fenixhu.dev/",
                    icon_url = "https://cdn.discordapp.com/attachments/636955559626670080/795310131704627231/logo-fen.png"},
                title = "title",
                description = description,
                color = 3123122
            }}}),{["Content-Type"] = "application/json"})
        Citizen.Wait(1000)
        logstored[_src] = nil
    end
end




GeneratebanId = function () 
    local IsNumberTaken =  function (number) 
        local File = LoadResourceFile(GetCurrentResourceName(), "fnx_ban.json")
        if (File ~= nil) then
            local TableFile = json.decode(File)
            for a, h in pairs(TableFile) do
                if h.banid == number then
                    return true
                end
            end
        end
    end
    local GenerateNumber = function () 
        local numBase1 =  math.random(100,999)
        local numBase2 =  math.random(1000,9999)
        local num =  numBase1 .. "" .. numBase2
        return num
    end
    local banid = GenerateNumber()
    if IsNumberTaken(banid) then
        setTimeout(GeneratebanId(), 5);
    end
    return tonumber(banid)  
end


local storeddata = {}

local Ban_Sistem = function (src,reason)
    InBanned = true
    if storeddata[src] == nil then 
        storeddata[src] = true 
        local src_identifier =  GetPlayerIdentifier(src, 1)
        if AllDataPlayer[tostring(src_identifier)] then 
            local File = LoadResourceFile(GetCurrentResourceName(), "fnx_ban.json")
            local IdBan = GeneratebanId()
            if File ~= nil then
                local TableFile = json.decode(File)
                table.insert(TableFile, {
                    banid       = IdBan,   
                    name        = AllDataPlayer[tostring(src_identifier)].name,
                    reason      = reason,
                    data        = os.date("%x %X %p"),
                    identifier  = AllDataPlayer[tostring(src_identifier)].identifier,
                    token       = AllDataPlayer[tostring(src_identifier)].token,
                })
                SaveResourceFile(GetCurrentResourceName(), 'fnx_ban.json', json.encode(TableFile, { indent = true }), -1)
                Citizen.Wait(500)
                DropPlayer(src,"[FenixAC_4.0] ||\n\n "..FenixAC_Config_S.KickReason.."\n BanID: "..IdBan)
                InBanned = false
            end
        end
        storeddata[src] = nil 
    end

end

local ConsoleDebug = function (txt)
    print(txt)
end



local Table = {
    BlacklistObject     =   {},
    BlacklistPeds       =   {},
    BlacklistVehicle    =   {},
    AllowistObject      =   {},
    AllowistPeds        =   {},
    AllowistVehicle     =   {},
    AllowistParticle    =   {},
    EventList           =   {},
}

ControllConfig = function ()
    if type(A) == "string" then
        FenixAC_Config_S    =   json.decode(A)
    else

    end

    if type(B) == "string" then
        FenixAC_Bypass      =   json.decode(B)
    else

    end
    if type(C) == "string" then
        FenixAC_Explosion   =   json.decode(C)
    else
        
    end
    if type(D) == "string" then
        FenixAC_Language    =   json.decode(D)
    else
        
    end
    if type(F) == "string" then
        FenixAC_Peds        =   json.decode(F)
    else
        
    end
    if type(G) == "string" then
        FenixAC_Vehicle     =   json.decode(G)
    else
        
    end
    if type(H) == "string" then
        FenixAC_Object      =   json.decode(H)
    else
        
    end
    if type(I) == "string" then
        FenixAC_Particle    =   json.decode(I)
    else
   
    end
    if type(L) == "string" then
        FenixAC_Event       =   json.decode(L)
    else 
    end
end
ControllConfig()





--data


RegisterServerEvent("vFbBahrC0RLpgLFNuTBd-eu00KBTyyCWDbM4IbgbF")
AddEventHandler("vFbBahrC0RLpgLFNuTBd-eu00KBTyyCWDbM4IbgbF",function (causa,data)
    local _src = source
    local identifier = GetPlayerIdentifier(_src, 1)
    local Causa = causa
    local Data  = data
    
    local TableBypass = GetBypass(_src)
    if TableBypass == nil then
        LogSistem(_src, {
            type    = Causa,
            arg     =  {
                name        =            AllDataPlayer[tostring(identifier)].name,                
                reason      =            string.format("%s  %s",(FenixAC_Language.client_cheat[causa] or "Client Cheat Detect"),"\n\n```"..DumpTable_(Data).."```" ),
                identifier  =            AllDataPlayer[tostring(identifier)].identifier,
                ban         =            (FenixAC_Config_S.client_cheat_ban[causa] or false),
                kick        =            (FenixAC_Config_S.client_cheat_kick[causa] or false),
            }
        })
        if FenixAC_Config_S.client_cheat_ban[causa] then
            Ban_Sistem(_src,string.format("%s ",(FenixAC_Language.client_cheat[causa] or "Client Cheat Detect")))
        else
            if FenixAC_Config_S.client_cheat_kick[causa] then
                DropPlayer(_src,"test")
            end
        end
        ConsoleDebug(string.format(prefix.._prefix_ClientCheat.."^0 Player: ^5 %s ^0 | Reason: %s ",identifier, (FenixAC_Language.client_cheat[causa] or "Client Cheat Detect")))
    else
        if (TableBypass.misc and TableBypass.misc.allclientdetect) then
            return
        else
        LogSistem(_src, {
            type    = Causa,
            arg     =  {
                name        =            AllDataPlayer[tostring(identifier)].name,                
                reason      =            string.format("%s [Admin Abuse]  %s",(FenixAC_Language.client_cheat[causa] or "Client Cheat Detect"),"\n\n```"..DumpTable_(Data).."```" ),
                identifier  =            AllDataPlayer[tostring(identifier)].identifier,
                ban         =            (FenixAC_Config_S.client_cheat_ban[causa] or false),
                kick        =            (FenixAC_Config_S.client_cheat_kick[causa] or false),
            }
        })
        if FenixAC_Config_S.client_cheat_ban[causa] then
            Ban_Sistem(_src,string.format("%s [Admin Abuse] ",(FenixAC_Language.client_cheat[causa] or "Client Cheat Detect")))
        else
            if FenixAC_Config_S.client_cheat_kick[causa] then
                DropPlayer(_src,"test")
            end
        end
        ConsoleDebug(string.format(prefix.._prefix_ClientCheat.."^0 Player: ^5 %s ^0 [Admin Abuse] | Reason: %s ",identifier, (FenixAC_Language.client_cheat[causa] or "Client Cheat Detect")))
        end
    end


    
end)









local GenereteHashTable = function ()
    ConsoleDebug(string.format(prefix.."%s ^0-- Creating Hash Table...",GetColorPrint("yellow_black","[INFORMATION]")))   --
    for a, b in pairs(FenixAC_Object.Obj_Blacklist) do
        Table.BlacklistObject[GetHashKey(b)] = b
    end
    for a, d in pairs(FenixAC_Vehicle.Veh_Blacklist) do
        Table.BlacklistVehicle[GetHashKey(d)] = d
    end
    for a, e in pairs(FenixAC_Peds.Ped_Blacklist) do
        Table.BlacklistPeds[GetHashKey(e)] = e
    end
    for a, f in pairs(FenixAC_Object.Obj_Allowist) do
        Table.AllowistObject[GetHashKey(f)] = f
    end
    for a, g in pairs(FenixAC_Particle.Pt_Allowist) do
        Table.AllowistParticle[GetHashKey(g)] = g
    end
    for a, h in pairs(FenixAC_Vehicle.Veh_Allowist) do
        Table.AllowistVehicle[GetHashKey(h)] = h
    end
    for a, j in pairs(FenixAC_Peds.Ped_Allowist) do
        Table.AllowistPeds[GetHashKey(j)] = j
    end
    for a, j in pairs(FenixAC_Event.EventList) do
        Table.EventList[a] = j
    end
    ConsoleDebug(string.format(prefix.."%s ^0-- Hash Table Created!",GetColorPrint("yellow_black","[INFORMATION]")))   --
end
GenereteHashTable()




local function CreateAddEventHandler()
    for a, v in pairs(FenixAC_Event.EventList) do
        AddEventHandler(a,function (...)
            local src = source
            if src ~= 0 then
                local identifier = GetPlayerIdentifier(src, 1)
                local arg = {...}
                local PAR1          = (arg[1] or false)
                local PAR2          = (arg[2] or false)
                local PlayerCoords  = GetEntityCoords(GetPlayerPed(src))

                if Table.EventList[a] then

                    if Table.EventList[a].Par1 ~= nil then
                        if not PAR1 or PAR1 and Table.EventList[a].Par1.type == type(PAR1)  then
                            if Table.EventList[a].Par1.max_value ~= nil then
                                if  not PAR1 or PAR1   and  tonumber(PAR1) and (tonumber(PAR1) >= Table.EventList[a].Par1.max_value)  then
                                    ConsoleDebug(string.format(prefix.._prefix_eventcontrol.."^0 Player: ^5 %s ^0 |%s event: %s argument: %s [ERROR AMOUNT]",identifier, FenixAC_Language.event_error_argument, a,json.encode(arg)))
                                end
                            end  
                            if Table.EventList[a].Par1.forcevalue ~= nil then
                                if not PAR1 or PAR1   and Table.EventList[a].Par1.forcevalue ~= PAR1  then
                                    ConsoleDebug(string.format(prefix.._prefix_eventcontrol.."^0 Player: ^5 %s ^0 |%s event: %s argument: %s [ERROR VALUE]",identifier, FenixAC_Language.event_error_argument, a,json.encode(arg)))
                                end   
                            end  
                        else
                            ConsoleDebug(string.format(prefix.._prefix_eventcontrol.."^0 Player: ^5 %s ^0 |%s event: %s argument: %s [ERROR TYPE]",identifier, FenixAC_Language.event_error_argument, a,json.encode(arg)))
                        end
                    end
                    if Table.EventList[a].Par2 ~= nil then
                        if not PAR2 or PAR2 and Table.EventList[a].Par2.type == type(PAR2)  then
                            if Table.EventList[a].Par2.max_value ~= nil then
                                if not PAR2 or PAR2 and tonumber(PAR2) and (tonumber(PAR2) >= Table.EventList[a].Par2.max_value)  then
                                    ConsoleDebug(string.format(prefix.._prefix_eventcontrol.."^0 Player: ^5 %s ^0 |%s event: %s argument: %s [ERROR AMOUNT]",identifier, FenixAC_Language.event_error_argument, a,json.encode(arg)))
                                end
                            end  
                            if Table.EventList[a].Par2.forcevalue ~= nil then
                                if  not PAR2 or PAR2 and Table.EventList[a].Par2.forcevalue ~= PAR2  then
                                    ConsoleDebug(string.format(prefix.._prefix_eventcontrol.."^0 Player: ^5 %s ^0 |%s event: %s argument: %s [ERROR VALUE]",identifier, FenixAC_Language.event_error_argument, a,json.encode(arg)))
                                end   
                            end  
                        else
                            ConsoleDebug(string.format(prefix.._prefix_eventcontrol.."^0 Player: ^5 %s ^0 |%s event: %s argument: %s [ERROR TYPE]",identifier, FenixAC_Language.event_error_argument, a,json.encode(arg)))
                        end
                    end
                    if  Table.EventList[a].MaxDistanceTriggered ~= nil and Table.EventList[a].MaxDistanceTriggered.Controll then
                        if #(vector3(Table.EventList[a].MaxDistanceTriggered.x, Table.EventList[a].MaxDistanceTriggered.y, Table.EventList[a].MaxDistanceTriggered.z) - PlayerCoords) > Table.EventList[a].MaxDistanceTriggered.Radius then
                            if Table.EventList[a].MaxDistanceTriggered.Ban then
                                print("Ban MaxDistanceTriggered")
                            elseif Table.EventList[a].MaxDistanceTriggered.Kick then
                                print("Kick MaxDistanceTriggered")
                            end
                            if Table.EventList[a].MaxDistanceTriggered.ConsoleDebug then
                                ConsoleDebug(string.format(prefix.._prefix_eventcontrol.."^0 Player: ^5 %s ^0 |%s event: %s argument: %s ",identifier, FenixAC_Language.event_distance_controll, a,json.encode(arg)))
                            end
                        end
                    end
                end
            end
        end)
    end
end
CreateAddEventHandler()



  
AddEventHandler("entityCreating", function (entity)
    if DoesEntityExist(entity) then
        local Etype = GetEntityType(entity)
       
        if Etype ~= 0 then
            local _src = NetworkGetEntityOwner(entity)  			-- Client side proprietario del oggetto 
            local model = GetEntityModel(entity)					-- hash del entità creata
            local eType = GetEntityPopulationType(entity)			-- tipo di entità creata 
            local identifier = GetPlayerIdentifier(_src, 1)
            if  AllDataPlayer[tostring(identifier)] ~= nil then 
                if Etype == 1 then
                        if eType == 6 or eType == 7 then
                            if Event.PedCreated[_src] == nil then
                                Event.PedCreated[_src] = {}
                            end
                            table.insert(Event.PedCreated[_src],entity)
                            if Table.BlacklistPeds[model] then
                                local TableBypass = GetBypass(_src)
                                if TableBypass == nil then
                                    CancelEvent()
                                    for a, v in pairs(Event.PedCreated[_src]) do
                                        if  DoesEntityExist(v)then
                                            DeleteEntity(v) 
                                        end
                                    end
                                    if FenixAC_Peds.Ped_DiscordLog then
                                        LogSistem(_src, {
                                            type    = "peds",
                                            arg     =  {
                                                name        =            AllDataPlayer[tostring(identifier)].name,                
                                                reason      =            string.format("%s hash: %s model: %s ", FenixAC_Language.ped_created, model,Table.BlacklistPeds[model]),
                                                identifier  =            AllDataPlayer[tostring(identifier)].identifier,
                                                ban         =            FenixAC_Peds.Ped_BanSistem,
                                                kick        =            FenixAC_Peds.Ped_KickSistem,
                                            }
                                        })
                                    end
                                    if FenixAC_Peds.Ped_BanSistem then
                                        Ban_Sistem(_src,string.format("%s hash: %s model: %s ", FenixAC_Language.ped_created, model,Table.BlacklistPeds[model]))
        
                                    end
                                    if FenixAC_Peds.Ped_ConsoleDebug then
                                        ConsoleDebug(string.format(prefix.._prefix_pedentityCreating.."^0 Player: ^5 %s ^0 |%s hash: %s model: %s ",identifier, FenixAC_Language.ped_created, model,Table.BlacklistPeds[model]))
                                    end
                                else
                                    if (TableBypass.misc and TableBypass.give.ped) then
                                        return
                                    else
                                        CancelEvent()
                                        for a, v in pairs(Event.PedCreated[_src]) do
                                            if  DoesEntityExist(v)then
                                                DeleteEntity(v) 
                                            end
                                        end
                                        if FenixAC_Peds.Ped_DiscordLog then
                                            LogSistem(_src, {
                                                type    = "peds",
                                                arg     =  {
                                                    name        =            AllDataPlayer[tostring(identifier)].name,                
                                                    reason      =            string.format("%s hash: %s model: %s [Admin Abuse]", FenixAC_Language.ped_created, model,Table.BlacklistPeds[model]),
                                                    identifier  =            AllDataPlayer[tostring(identifier)].identifier,
                                                    ban         =            FenixAC_Peds.Ped_BanSistem,
                                                    kick        =            FenixAC_Peds.Ped_KickSistem,
                                                }
                                            })
                                        end
                                        if FenixAC_Peds.Ped_BanSistem then
                                            Ban_Sistem(_src,string.format("%s hash: %s model: %s [Admin Abuse]", FenixAC_Language.ped_created, model,Table.BlacklistPeds[model] ))
                                        end
                                        if FenixAC_Peds.Ped_ConsoleDebug then
                                            ConsoleDebug(string.format(prefix.._prefix_pedentityCreating.."^0 Player: ^5 %s ^0 |%s hash: %s model: %s ",identifier, FenixAC_Language.ped_created, model,Table.BlacklistPeds[model]))
                                        end
                                    end
                                end
                            end
                            if Table.AllowistPeds[model] == nil then
                                if FenixAC_Peds.Ped_MaxSpawnCheck then
                                    if #Event.PedCreated[_src] >= FenixAC_Peds.Ped_MaxSpawn then
                                        local TableBypass = GetBypass(_src)
                                        if TableBypass == nil then
                                            CancelEvent()
                                            for a, v in pairs(Event.PedCreated[_src]) do
                                                if  DoesEntityExist(v)then
                                                    DeleteEntity(v) 
                                                end
                                            end
                                            if FenixAC_Peds.Ped_MaxSpawnDiscordLog then
                                                LogSistem(_src, {
                                                    type    = "peds",
                                                    arg     =  {
                                                        name        =            AllDataPlayer[tostring(identifier)].name,                
                                                        reason      =            string.format("%s hash: %s amount: %s ", FenixAC_Language.ped_created_max, model,#Event.PedCreated[_src]),
                                                        identifier  =            AllDataPlayer[tostring(identifier)].identifier,
                                                        ban         =            FenixAC_Peds.Ped_MaxSpawnedBanSistem,
                                                        kick        =            FenixAC_Peds.Ped_MaxSpawnedKickSistem,
                                                    }
                                                })
                                            end
                                            if FenixAC_Peds.Ped_MaxSpawnedBanSistem then
                                                Ban_Sistem(_src, string.format("%s hash: %s amount: %s ", FenixAC_Language.ped_created_max, model,#Event.PedCreated[_src]))
                
                                            end
                                            if FenixAC_Peds.Ped_ConsoleDebug then
                                                ConsoleDebug(string.format(prefix.._prefix_pedentityCreating.."^0 Player: ^5 %s ^0 |%s hash: %s amount: %s ",identifier, FenixAC_Language.ped_created_max, model,#Event.PedCreated[_src]))
                                            end
                                        else
                                            if (TableBypass.give and TableBypass.give.ped) then
                                                return
                                            else
                                                CancelEvent()
                                                for a, v in pairs(Event.PedCreated[_src]) do
                                                    if  DoesEntityExist(v)then
                                                        DeleteEntity(v) 
                                                    end
                                                end
                                                if FenixAC_Peds.Ped_MaxSpawnDiscordLog then
                                                    LogSistem(_src, {
                                                        type    = "peds",
                                                        arg     =  {
                                                            name        =            AllDataPlayer[tostring(identifier)].name,                
                                                            reason      =            string.format("%s hash: %s model: %s [Admin Abuse]", FenixAC_Language.ped_created_max, model,Event.PedCreated[_src]),
                                                            identifier  =            AllDataPlayer[tostring(identifier)].identifier,
                                                            ban         =            FenixAC_Peds.Ped_MaxSpawnedBanSistem,
                                                            kick        =            FenixAC_Peds.Ped_MaxSpawnedKickSistem,
                                                        }
                                                    })
                                                end
                                                if FenixAC_Peds.Ped_MaxSpawnedBanSistem then
                                                    Ban_Sistem(_src,string.format("%s hash: %s amount: %s [Admin Abuse]", FenixAC_Language.ped_created_max, model,Event.PedCreated[_src] ))
                                                end
                                                if FenixAC_Peds.Ped_ConsoleDebug then
                                                    ConsoleDebug(string.format(prefix.._prefix_pedentityCreating.."^0 Player: ^5 %s ^0 |%s hash: %s amount: %s ",identifier, FenixAC_Language.ped_created_max, model,Table.BlacklistPeds[model]))
                                                end
                                            end
                                        end
                                    end
                                end
                            end
                        end
                    elseif Etype == 2 then -- Veicoli
                        if eType == 6 or eType == 7 then
                            print("aaaaa")
                            if Event.VehicleCreated[_src] == nil then
                                Event.VehicleCreated[_src] = {}
                            end
                            table.insert(Event.VehicleCreated[_src],entity)
                            if Table.BlacklistVehicle[model] then
                                local TableBypass = GetBypass(_src)
                                if TableBypass == nil then
                                    CancelEvent()
                                    for a, v in pairs(Event.VehicleCreated[_src]) do
                                        if  DoesEntityExist(v)then
                                            DeleteEntity(v) 
                                        end
                                    end
                                    if FenixAC_Vehicle.Veh_DiscordLog then
                                        LogSistem(_src, {
                                            type    = "vehicle",
                                            arg     =  {
                                                name        =            AllDataPlayer[tostring(identifier)].name,                
                                                reason      =            string.format("%s hash: %s model: %s ", FenixAC_Language.vehicle_created, model,Table.BlacklistVehicle[model]),
                                                identifier  =            AllDataPlayer[tostring(identifier)].identifier,
                                                ban         =            FenixAC_Vehicle.Veh_BanSistem,
                                                kick        =            FenixAC_Vehicle.Veh_KickSistem,
                                            }
                                        })
                                    end
                                    if FenixAC_Vehicle.Veh_BanSistem then
                                        Ban_Sistem(_src,string.format("%s hash: %s model: %s ", FenixAC_Language.vehicle_created, model,Table.BlacklistVehicle[model]))
        
                                    end
                                    if FenixAC_Vehicle.Veh_ConsoleDebug then
                                        ConsoleDebug(string.format(prefix.._prefix_vehentityCreating.."^0 Player: ^5 %s ^0 |%s hash: %s model: %s ",identifier, FenixAC_Language.vehicle_created, model,Table.BlacklistVehicle[model]))
                                    end
                                else
                                    if (TableBypass.give and TableBypass.give.vehicle) then
                                        return
                                    else
                                        CancelEvent()
                                        for a, v in pairs(Event.VehicleCreated[_src]) do
                                            if  DoesEntityExist(v)then
                                                DeleteEntity(v) 
                                            end
                                        end
                                        if FenixAC_Vehicle.Veh_DiscordLog then
                                            LogSistem(_src, {
                                                type    = "vehicle",
                                                arg     =  {
                                                    name        =            AllDataPlayer[tostring(identifier)].name,                
                                                    reason      =            string.format("%s hash: %s model: %s [Admin Abuse]", FenixAC_Language.vehicle_created, model,Table.BlacklistVehicle[model]),
                                                    identifier  =            AllDataPlayer[tostring(identifier)].identifier,
                                                    ban         =            FenixAC_Vehicle.Veh_BanSistem,
                                                    kick        =            FenixAC_Vehicle.Veh_KickSistem,
                                                }
                                            })
                                        end
                                        if FenixAC_Vehicle.Ped_BanSistem then
                                            Ban_Sistem(_src,string.format("%s hash: %s model: %s [Admin Abuse]", FenixAC_Language.vehicle_created, model,Table.BlacklistVehicle[model]))
                                        end
                                        if FenixAC_Vehicle.Ped_ConsoleDebug then
                                            ConsoleDebug(string.format(prefix.._prefix_vehentityCreating.."^0 Player: ^5 %s ^0 |%s hash: %s model: %s [Admin Abuse]",identifier, FenixAC_Language.vehicle_created, model,Table.BlacklistVehicle[model]))
                                        end
                                    end
                                end
                            end
                            if Table.AllowistVehicle[model] == nil then
                                if FenixAC_Vehicle.Veh_MaxSpawnCheck then
                                    if #Event.VehicleCreated[_src] >= FenixAC_Vehicle.Veh_MaxSpawn then
                                        if FenixAC_Vehicle.Veh_AllowistZone ~= nil and FenixAC_Vehicle.Veh_AllowistZoneControll then
                                            for a, b in pairs(FenixAC_Vehicle.Veh_AllowistZone) do
                                                if #(vector3(b.x, b.y, b.z) - GetEntityCoords(GetPlayerPed(_src))) < b.Radius then
                                                    if b.ConsoleDebug then
                                                        ConsoleDebug(string.format(prefix.._prefix_vehentityCreating.."^0 Player: ^5 %s ^0 |%s hash: %s model: %s | Zone: %s | [Allowist Zone]",identifier, FenixAC_Language.vehicle_created_allowist_zone, model,Table.BlacklistVehicle[model],b.name))
                                                    end
                                                    return
                                                end
                                            end
                                        end
       
                                        local TableBypass = GetBypass(_src)
                                        if TableBypass == nil then
                                            CancelEvent()
                                            for a, v in pairs(Event.VehicleCreated[_src]) do
                                                if  DoesEntityExist(v)then
                                                    DeleteEntity(v) 
                                                end
                                            end
                                            if FenixAC_Vehicle.Veh_MaxSpawnDiscordLog then
                                                LogSistem(_src, {
                                                    type    = "vehicle",
                                                    arg     =  {
                                                        name        =            AllDataPlayer[tostring(identifier)].name,                
                                                        reason      =            string.format("%s hash: %s amount: %s ", FenixAC_Language.vehicle_created_max, model,#Event.VehicleCreated[_src]),
                                                        identifier  =            AllDataPlayer[tostring(identifier)].identifier,
                                                        ban         =            FenixAC_Vehicle.Veh_MaxSpawnedBanSistem,
                                                        kick        =            FenixAC_Vehicle.Veh_MaxSpawnedKickSistem,
                                                    }
                                                })
                                            end
                                            if FenixAC_Vehicle.Veh_MaxSpawnedBanSistem then
                                                Ban_Sistem(_src, string.format("%s hash: %s amount: %s ", FenixAC_Language.vehicle_created_max, model,#Event.VehicleCreated[_src]))
                
                                            end
                                            if FenixAC_Vehicle.Veh_ConsoleDebug then
                                                ConsoleDebug(string.format(prefix.._prefix_vehentityCreating.."^0 Player: ^5 %s ^0 |%s hash: %s amount: %s ",identifier, FenixAC_Language.vehicle_created_max, model,#Event.VehicleCreated[_src]))
                                            end
                                        else
                                            if (TableBypass.misc and TableBypass.give.vehicle) then
                                                return
                                            else
                                                CancelEvent()
                                                for a, v in pairs(Event.VehicleCreated[_src]) do
                                                    if  DoesEntityExist(v)then
                                                        DeleteEntity(v) 
                                                    end
                                                end
                                                if FenixAC_Vehicle.Veh_MaxSpawnDiscordLog then
                                                    LogSistem(_src, {
                                                        type    = "vehicle",
                                                        arg     =  {
                                                            name        =            AllDataPlayer[tostring(identifier)].name,                
                                                            reason      =            string.format("%s hash: %s amount: %s [Admin Abuse]", FenixAC_Language.vehicle_created_max, model,#Event.VehicleCreated[_src]),
                                                            identifier  =            AllDataPlayer[tostring(identifier)].identifier,
                                                            ban         =            FenixAC_Vehicle.Veh_MaxSpawnedBanSistem,
                                                            kick        =            FenixAC_Vehicle.Veh_MaxSpawnedKickSistem,
                                                        }
                                                    })
                                                end
                                                if FenixAC_Vehicle.Veh_MaxSpawnedBanSistem then
                                                    Ban_Sistem(_src,string.format("%s hash: %s amount: %s [Admin Abuse]", FenixAC_Language.vehicle_created_max, model,#Event.VehicleCreated[_src] ))
                                                end
                                                if FenixAC_Vehicle.Veh_ConsoleDebug then
                                                    ConsoleDebug(string.format(prefix.._prefix_vehentityCreating.."^0 Player: ^5 %s ^0 |%s hash: %s amount: %s ",identifier, FenixAC_Language.vehicle_created_max, model,#Event.VehicleCreated[_src]))
                                                end
                                            end
                                        end
                                    end
                                end
                            end
                        end
                    elseif Etype == 3 then
                        if Event.ObjectCreated[_src] == nil then
                            Event.ObjectCreated[_src] = {}
                        end
                        table.insert(Event.ObjectCreated[_src],entity)
                        if Table.BlacklistObject[model] then
                            local TableBypass = GetBypass(_src)
                            if TableBypass == nil then
                                CancelEvent()
                                for a, v in pairs(Event.ObjectCreated[_src]) do
                                    if  DoesEntityExist(v)then
                                        DeleteEntity(v) 
                                    end
                                end
                                if FenixAC_Object.Obj_DiscordLog then
                                    LogSistem(_src, {
                                        type    = "object",
                                        arg     =  {
                                            name        =            AllDataPlayer[tostring(identifier)].name,                
                                            reason      =            string.format("%s hash: %s model: %s ", FenixAC_Language.object_created, model,Table.BlacklistObject[model]),
                                            identifier  =            AllDataPlayer[tostring(identifier)].identifier,
                                            ban         =            FenixAC_Object.Obj_BanSistem,
                                            kick        =            FenixAC_Object.Obj_KickSistem,
                                        }
                                    })
                                end
                                if FenixAC_Object.Obj_BanSistem then
                                    Ban_Sistem(_src,string.format("%s hash: %s model: %s ", FenixAC_Language.object_created, model,Table.BlacklistObject[model]))
    
                                end
                                if FenixAC_Object.Obj_KickSistem then
                                    ConsoleDebug(string.format(prefix.._prefix_objentityCreating.."^0 Player: ^5 %s ^0 |%s hash: %s model: %s ",identifier, FenixAC_Language.object_created, model,Table.BlacklistObject[model]))
                                end
                            else
                                if (TableBypass.give and TableBypass.give.vehicle) then
                                    return
                                else
                                    CancelEvent()
                                    for a, v in pairs(Event.ObjectCreated[_src]) do
                                        if  DoesEntityExist(v)then
                                            DeleteEntity(v) 
                                        end
                                    end
                                    if FenixAC_Object.Obj_DiscordLog then
                                        LogSistem(_src, {
                                            type    = "vehicle",
                                            arg     =  {
                                                name        =            AllDataPlayer[tostring(identifier)].name,                
                                                reason      =            string.format("%s hash: %s model: %s [Admin Abuse]", FenixAC_Language.object_created, model,Table.BlacklistObject[model]),
                                                identifier  =            AllDataPlayer[tostring(identifier)].identifier,
                                                ban         =            FenixAC_Object.Obj_BanSistem,
                                                kick        =            FenixAC_Object.Obj_KickSistem,
                                            }
                                        })
                                    end
                                    if FenixAC_Object.Obj_BanSistem then
                                        Ban_Sistem(_src,string.format("%s hash: %s model: %s [Admin Abuse]", FenixAC_Language.object_created, model,Table.BlacklistObject[model]))
                                    end
                                    if FenixAC_Object.Obj_ConsoleDebug then
                                        ConsoleDebug(string.format(prefix.._prefix_objentityCreating.."^0 Player: ^5 %s ^0 |%s hash: %s model: %s [Admin Abuse]",identifier, FenixAC_Language.object_created, model,Table.BlacklistObject[model]))
                                    end
                                end
                            end
                        end
                        if Table.AllowistObject[model] == nil then
                            if FenixAC_Object.Obj_MaxSpawnCheck then
                                if #Event.ObjectCreated[_src] >= FenixAC_Object.Obj_MaxSpawn then
                                    local TableBypass = GetBypass(_src)
                                    if TableBypass == nil then
                                        CancelEvent()
                                        for a, v in pairs(Event.ObjectCreated[_src]) do
                                            if  DoesEntityExist(v)then
                                                DeleteEntity(v) 
                                            end
                                        end
                                        if FenixAC_Object.Obj_MaxSpawnDiscordLog then
                                            LogSistem(_src, {
                                                type    = "object",
                                                arg     =  {
                                                    name        =            AllDataPlayer[tostring(identifier)].name,                
                                                    reason      =            string.format("%s hash: %s amount: %s ", FenixAC_Language.object_created_max, model,#Event.ObjectCreated[_src]),
                                                    identifier  =            AllDataPlayer[tostring(identifier)].identifier,
                                                    ban         =            FenixAC_Object.Obj_MaxSpawnedBanSistem,
                                                    kick        =            FenixAC_Object.Obj_MaxSpawnedKickSistem,
                                                }
                                            })
                                        end
                                        if FenixAC_Object.Obj_MaxSpawnedBanSistem then
                                            Ban_Sistem(_src, string.format("%s hash: %s amount: %s ", FenixAC_Language.object_created_max, model,#Event.ObjectCreated[_src]))
            
                                        end
                                        if FenixAC_Object.Obj_ConsoleDebug then
                                            ConsoleDebug(string.format(prefix.._prefix_objentityCreating.."^0 Player: ^5 %s ^0 |%s hash: %s amount: %s ",identifier, FenixAC_Language.object_created_max, model,#Event.ObjectCreated[_src]))
                                        end
                                    else
                                        if (TableBypass.misc and TableBypass.give.object) then
                                            return
                                        else
                                            CancelEvent()
                                            for a, v in pairs(Event.ObjectCreated[_src]) do
                                                if  DoesEntityExist(v)then
                                                    DeleteEntity(v) 
                                                end
                                            end
                                            if FenixAC_Object.Veh_MaxSpawnDiscordLog then
                                                LogSistem(_src, {
                                                    type    = "object",
                                                    arg     =  {
                                                        name        =            AllDataPlayer[tostring(identifier)].name,                
                                                        reason      =            string.format("%s hash: %s amount: %s [Admin Abuse]", FenixAC_Language.object_created_max, model,#Event.ObjectCreated[_src]),
                                                        identifier  =            AllDataPlayer[tostring(identifier)].identifier,
                                                        ban         =            FenixAC_Object.Obj_MaxSpawnedBanSistem,
                                                        kick        =            FenixAC_Object.Obj_MaxSpawnedKickSistem,
                                                    }
                                                })
                                            end
                                            if FenixAC_Object.Obj_MaxSpawnedBanSistem then
                                                Ban_Sistem(_src,string.format("%s hash: %s amount: %s [Admin Abuse]", FenixAC_Language.object_created_max, model,#Event.ObjectCreated[_src] ))
                                            end
                                            if FenixAC_Object.Obj_ConsoleDebug then
                                                ConsoleDebug(string.format(prefix.._prefix_objentityCreating.."^0 Player: ^5 %s ^0 |%s hash: %s amount: %s ",identifier, FenixAC_Language.object_created_max, model,#Event.ObjectCreated[_src]))
                                            end
                                        end
                                    end
                                end
                            end
                        end
                    end
               
            else
                ConsoleDebug(prefix.."^1[ERROR] ^0-- Player: ^5" .. identifier .. "^0 was not found in the player table") 
            end   
        end
    end
end)


AddEventHandler("ptFxEvent",function(_src,data)
    local HashPFX = data.effectHash
    local identifier = GetPlayerIdentifier(_src, 1)
    if  AllDataPlayer[tostring(identifier)] ~= nil then 
        if Table.AllowistParticle[HashPFX] == nil then 
            local TableBypass = GetBypass(_src)
            if TableBypass == nil then
                CancelEvent()
                if FenixAC_Particle.Pt_DiscordLog then
                    LogSistem(_src, {
                        type    = "particle",
                        arg     =  {
                            name        =            AllDataPlayer[tostring(identifier)].name,                
                            reason      =            string.format("%s hash: %s", FenixAC_Language.particle_created, HashPFX),
                            identifier  =            AllDataPlayer[tostring(identifier)].identifier,
                            ban         =            FenixAC_Particle.Pt_BanSistem,
                            kick        =            FenixAC_Particle.Pt_KickSistem,
                        }
                    })
                end
                if FenixAC_Particle.Pt_BanSistem then
                    Ban_Sistem(_src,string.format("%s hash: %s", FenixAC_Language.particle_created, HashPFX))

                end
                if FenixAC_Particle.Pt_ConsoleDebug then
                    ConsoleDebug(string.format(prefix.._prefix_partentityCreating.."^0 Player: ^5 %s ^0 |%s hash: %s ",identifier, FenixAC_Language.particle_created, HashPFX))
                end
            else
                if (TableBypass.misc and TableBypass.misc.particle) then
                    return
                else
                    CancelEvent()
                    if FenixAC_Particle.Pt_DiscordLog then
                        LogSistem(_src, {
                            type    = "particle",
                            arg     =  {
                                name        =            AllDataPlayer[tostring(identifier)].name,                
                                reason      =            string.format("%s hash: %s [Admin Abuse]", FenixAC_Language.particle_created, HashPFX),
                                identifier  =            AllDataPlayer[tostring(identifier)].identifier,
                                ban         =            FenixAC_Particle.Pt_BanSistem,
                                kick        =            FenixAC_Particle.Pt_KickSistem,
                            }
                        })
                    end
                    if FenixAC_Particle.Pt_BanSistem then
                        Ban_Sistem(_src,string.format("%s hash: %s model: %s [Admin Abuse]", FenixAC_Language.particle_created, HashPFX))
                    end
                    if FenixAC_Particle.Pt_ConsoleDebug then
                        ConsoleDebug(string.format(prefix.._prefix_partentityCreating.."^0 Player: ^5 %s ^0 |%s hash: %s [Admin Abuse]",identifier, FenixAC_Language.particle_created, HashPFX))
                    end
                end
            end 
        end
    else
        ConsoleDebug(prefix.."^1[ERROR] ^0-- Player: ^5" .. identifier .. "^0 was not found in the player table") 
    end 
end)



AddEventHandler("explosionEvent", function (_src,event)
    if _src ~= 0 then
        local identifier = GetPlayerIdentifier(_src, 1)
        if FenixAC_Explosion[tostring(event.explosionType)] then
            if AllDataPlayer[tostring(identifier)] ~= nil then 
                local  name ,log ,ban, cancelevent ,maxexplosion ,checkbypass ,console_debug ,kick = FenixAC_Explosion[tostring(event.explosionType)].name ,FenixAC_Explosion[tostring(event.explosionType)].log , FenixAC_Explosion[tostring(event.explosionType)].ban ,FenixAC_Explosion[tostring(event.explosionType)].cancelevent ,FenixAC_Explosion[tostring(event.explosionType)].maxexplosion , FenixAC_Explosion[tostring(event.explosionType)].checkbypass , FenixAC_Explosion[tostring(event.explosionType)].console_debug ,FenixAC_Explosion[tostring(event.explosionType)].kick
                if Event.ExplosionCreated[_src] == nil then  Event.ExplosionCreated[_src] = 0 end
                Event.ExplosionCreated[_src] = Event.ExplosionCreated[_src] + 1
                if Event.ExplosionCreated[_src] >= maxexplosion then 
                    if checkbypass then
                        local TableBypass = GetBypass(_src)
                        if TableBypass == nil then
                            if cancelevent then
                                CancelEvent()
                            end
                            if log then
                                LogSistem(_src, {
                                    type    = "explosion",
                                    arg     =  {
                                        name        =            AllDataPlayer[tostring(identifier)].name,                
                                        reason      =            string.format("%s type: %s name: %s", FenixAC_Language.explosion_detect_1, event.explosionType,name),
                                        identifier  =            AllDataPlayer[tostring(identifier)].identifier,
                                        ban         =            ban,
                                        kick        =            kick,
                                    }
                                })
                            end
                            if ban then
                                Ban_Sistem(_src,string.format("%s type: %s name: %s", FenixAC_Language.explosion_detect_1, event.explosionType,name))
                            end
                            if console_debug then
                                ConsoleDebug(string.format(prefix.._prefix_explosion.."^0 Player: ^5 %s ^0 |%s type: %s name: %s [Admin Abuse]",identifier,FenixAC_Language.explosion_detect_1, event.explosionType,name))
                            end
                        else
                            if (TableBypass.misc and TableBypass.misc.explosion) then
                                return
                            else
                                if cancelevent then
                                    CancelEvent()
                                end
                                if log then
                                    LogSistem(_src, {
                                        type    = "explosion",
                                        arg     =  {
                                            name        =            AllDataPlayer[tostring(identifier)].name,                
                                            reason      =            string.format("%s type: %s name: %s \n\n [Admin Abuse]", FenixAC_Language.explosion_detect_1, event.explosionType,name),
                                            identifier  =            AllDataPlayer[tostring(identifier)].identifier,
                                            ban         =            ban,
                                            kick        =            kick,
                                        }
                                    })
                                end
                                if ban then
                                    Ban_Sistem(_src,string.format("%s type: %s name: %s [Admin Abuse]", FenixAC_Language.explosion_detect_1, event.explosionType,name))
                                end
                                if console_debug then
                                    ConsoleDebug(string.format(prefix.._prefix_explosion.."^0 Player: ^5 %s ^0 |%s type: %s name: %s [Admin Abuse]",identifier,FenixAC_Language.explosion_detect_1, event.explosionType,name))
                                end
                            end
                        end
                    end
                end
            else
                ConsoleDebug(prefix.."^1[ERROR] ^0-- Player: ^5" .. identifier .. "^0 was not found in the player table") 
            end
        else
            ConsoleDebug(prefix.."^1[ERROR] ^0-- Player: ^5" .. identifier .. "^0 Created explosion not present in FenixAC_Explosion, add it: Explosion ID " .. event.explosionType) 
        end
    end
end)


local card = 
    [==[{
        "type": "AdaptiveCard",
        "body": [
            {
                "type": "TextBlock",
                "size": "Large",
                "text": "FenixAC [4.0]",
                "weight": "Bolder",
                "fontType": "Default"
            },
            {
                "type": "ColumnSet",
                "columns": [
                    {
                        "type": "Column",
                        "items": [
                            {
                                "type": "Image",
                                "style": "Person",
                                "url": "https://cdn.discordapp.com/attachments/589885384486551553/869592326379560980/logo-fenaaa.png",
                                "size": "Medium",
                                "horizontalAlignment": "Center"
                            },
                            {
                                "type": "TextBlock",
                                "weight": "Bolder",
                                "text": "Controllo in corso...",
                                "wrap": true,
                                "horizontalAlignment": "Center"
                            },
                            {
                                "type": "TextBlock",
                                "spacing": "None",
                                "text": "Attendi...",
                                "isSubtle": true,
                                "wrap": true,
                                "horizontalAlignment": "Center"
                            },
                            {
                                "type": "Image",
                                "style": "Person",
                                "url": "https://cdn.discordapp.com/attachments/837066277049860116/869596351267242024/844850843827699774.gif",
                                "size": "Medium",
                                "horizontalAlignment": "Center"
                            }
                        ],
                        "width": "stretch",
                        "backgroundImage": {
                            "verticalAlignment": "Center"
                        }
                    }
                ],
                "spacing": "Small",
                "horizontalAlignment": "Center"
            }
        ],
        "$schema": "http://adaptivecards.io/schemas/adaptive-card.json",
        "version": "1.3",
        "backgroundImage": {
            "horizontalAlignment": "Center"
        }
}]==]



local GetallIdentifier = function(src)
    local steamid       = "n/a"
    local steamurl      = "n/a"
    local license       = "n/a"
    local discord       = "n/a"
    local xbl           = "n/a"
    local liveid        = "n/a"
    local ip            = "n/a"
    local discord_name  = "n/a"

  for k,v in pairs(GetPlayerIdentifiers(src))do  
      if string.sub(v, 1, string.len("steam:")) == "steam:" then
        steamid = v
        steamurl = "https://steamcommunity.com/profiles/" ..tonumber(v:gsub("steam:", ""),16).."" 
      elseif string.sub(v, 1, string.len("license:")) == "license:" then
        license = v
      elseif string.sub(v, 1, string.len("xbl:")) == "xbl:" then
        xbl  = v
      elseif string.sub(v, 1, string.len("ip:")) == "ip:" then
        ip = v
      elseif string.sub(v, 1, string.len("discord:")) == "discord:" then
        discord = v
        discord_name = "<@"..v:gsub("discord:", "")..">"
      elseif string.sub(v, 1, string.len("live:")) == "live:" then
        liveid = v
      end
  end
  return steamid,steamurl,license,discord,discord_name,xbl,liveid,ip
end

local DiscordGenericLogs = function (title,description,color)
    print("adasdasdas")
    PerformHttpRequest("https://discord.com/api/webhooks/868062796682784788/IHr00lVZpR_eS66kqILHKj0-HIRSydj2T2DPfgHAgJR85cJT9_WKFrvGZBHNhs1hWnIa", function()
    end, "POST", json.encode({
        embeds = {{
            author = {
                name = "FenixAC [4.0]",
                url = "https://www.fenixhu.dev/",
                icon_url = "https://cdn.discordapp.com/attachments/636955559626670080/795310131704627231/logo-fen.png"},
            title = title,
            description = description,
            color = 3123122
        }}}),{["Content-Type"] = "application/json"})
end


local CarD = [==[{
        "type": "AdaptiveCard",
        "body": [
            {
                "type": "TextBlock",
                "size": "Large",
                "text": "FenixAC [4.0]",
                "weight": "Bolder",
                "fontType": "Default"
            },
            {
                "type": "ColumnSet",
                "columns": [
                    {
                        "type": "Column",
                        "items": [
                            {
                                "type": "Image",
                                "style": "Person",
                                "url": "https://cdn.discordapp.com/attachments/589885384486551553/869592326379560980/logo-fenaaa.png",
                                "size": "Medium",
                                "horizontalAlignment": "Center"
                            },
                            {
                                "type": "TextBlock",
                                "weight": "Bolder",
                                "text": "Controllo in corso...",
                                "wrap": true,
                                "horizontalAlignment": "Center"
                            },
                            {
                                "type": "TextBlock",
                                "spacing": "None",
                                "text": "Attendi...",
                                "isSubtle": true,
                                "wrap": true,
                                "horizontalAlignment": "Center"
                            },
                            {
                                "type": "Image",
                                "style": "Person",
                                "url": "https://cdn.discordapp.com/attachments/837066277049860116/869596351267242024/844850843827699774.gif",
                                "size": "Medium",
                                "horizontalAlignment": "Center"
                            }
                        ],
                        "width": "stretch",
                        "backgroundImage": {
                            "verticalAlignment": "Center"
                        }
                    }
                ],
                "spacing": "Small",
                "horizontalAlignment": "Center"
            }
        ],
        "$schema": "http://adaptivecards.io/schemas/adaptive-card.json",
        "version": "1.3",
        "backgroundImage": {
            "horizontalAlignment": "Center"
        }
    }]==]






local LogConnecting = function(identifier)
    local description = "**Name:** "..AllDataPlayer[tostring(identifier)].name.."\n\n```".._DumpTable(AllDataPlayer[tostring(identifier)].identifier).."```"  
    local color = 23124534
    DiscordGenericLogs("[Player Connecting]",description,color)
end

local LogDropped = function(identifier,reason)
    local description = "**Name:** "..AllDataPlayer[tostring(identifier)].name.."\n**Reason:** "..reason.."\n\n```".._DumpTable(AllDataPlayer[tostring(identifier)].identifier).."```"    
    local color = 23213123
    DiscordGenericLogs("[Player Dropped]",description,color)
end













AddEventHandler("playerConnecting",function(name, setKickReason, deferrals)
    local _src = source
    local identifier = GetPlayerIdentifier(_src, 1)
    local banned = false
    deferrals.defer()
    Citizen.Wait(50)
    deferrals.presentCard(CarD)
    Citizen.Wait(2500)
    if AllDataPlayer[tostring(identifier)] == nil then
        AllDataPlayer[tostring(identifier)] = {
            token       =  {},
            identifier  = {},
            name        = GetPlayerName(_src)
        }  
        for i=1,GetNumPlayerTokens(_src) do
            table.insert(AllDataPlayer[tostring(identifier)].token, GetPlayerToken(_src, i))
        end
        for i=1,GetNumPlayerIdentifiers(_src) do
            table.insert(AllDataPlayer[tostring(identifier)].identifier, GetPlayerIdentifier(_src, i))
        end
    end
    if FenixAC_Config_S.Logs.Discord.Connecting then
        LogConnecting(identifier)
    end
    if FenixAC_Config_S.Logs.Console.Connecting then
        ConsoleDebug(string.format(prefix.."^1[INFORMATION] ^0 Player: ^5 %s ^0 | Connecting...",identifier))
    end
    local File = LoadResourceFile(GetCurrentResourceName(), "fnx_ban.json")
    if File ~= nil then
        local AllTable = json.decode(File)
        for a, b in pairs(AllTable) do
            for c, d in pairs(b.identifier) do
                for e, f in pairs(AllDataPlayer[tostring(identifier)].identifier) do
                    if d == f then
                        banned = true
                        deferrals.done("FenixAC [4.0] |\n\n" .. FenixAC_Config_S.KickReason .. "\n BAN ID: "..b.banid)
                        print(f, " negro Perma bannato");
                        return 
                    end
                end
                if banned then 
                    return
                end         
            end
            -- Altro for token
            if not banned and  FenixAC_Config_S.BanToken then 
                for _, __ in pairs(b.token) do
                    for g, h in pairs(AllDataPlayer[tostring(identifier)].token) do
                        if __ == h then
                            banned = true
                            deferrals.done("FenixAC [4.0] |\n\n" .. FenixAC_Config_S.KickReason .. "\n BAN ID: "..b.banid)
                            print(h, " negro Perma bannato token");
                            return 
                        end
                    end
                    if banned then 
                        return
                    end
                end
            end
            if banned then 
                return
            end
        end
        print("Done")
        deferrals.done()
    end
end)



AddEventHandler("playerDropped",function(reason)
    local _src = source
    local identifier = GetPlayerIdentifier(_src, 1)
    if identifier == nil then
        return
    end
    if FenixAC_Config_S.Logs.Discord.Dropped then
        LogDropped(identifier,reason)
    end
    if FenixAC_Config_S.Logs.Console.Dropped then
        ConsoleDebug(string.format(prefix.."^1[INFORMATION] ^0 Player: ^5 %s ^0 | Dropped for:  %s",identifier,reason))
    end
    if AllDataPlayer[tostring(identifier)] then 
        while InBanned do 
            Citizen.Wait(10)
        end
        Citizen.Wait(1000)
        AllDataPlayer[tostring(identifier)] = nil
    end
end)



AddEventHandler("weaponDamageEvent", function(_src, data,a)
    print(_src, json.encode(data),a)

end)

AddEventHandler("giveWeaponEvent", function(_src, data,a)
    print(_src, json.encode(data),a)

end)
AddEventHandler("removeWeaponEvent",function(_src, data,a)
    print(_src, json.encode(data),a)
end)

AddEventHandler("removeAllWeaponsEvent",function(_src, data,a)
    print(_src, json.encode(data),a)

end)

AddEventHandler("clearPedTasksEvent", function(_src, data,a)
    print(_src, json.encode(data),a)
end)

AddEventHandler("giveWeaponEvent", function(_src, data)
    print("^1DEBUG giveWeaponEvent^0| ID: ",_src)
    RemoveAllPedWeapons(GetPlayerPed(_src))
end)