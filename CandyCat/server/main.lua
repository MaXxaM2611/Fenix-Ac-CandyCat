load(LoadResourceFile(GetCurrentResourceName(), "/config/configS.lua"))()
load(LoadResourceFile(GetCurrentResourceName(), "/config/vehicle_table.lua"))()
load(LoadResourceFile(GetCurrentResourceName(), "/config/ped_table.lua"))()
load(LoadResourceFile(GetCurrentResourceName(), "/config/particle_table.lua"))()
load(LoadResourceFile(GetCurrentResourceName(), "/config/object_table.lua"))()
load(LoadResourceFile(GetCurrentResourceName(), "/config/explosion_table.lua"))()
load(LoadResourceFile(GetCurrentResourceName(), "/config/bypass.lua"))()
local _______________________________________ = false





RegisterServerCB("gcf:__:__:",function (src,cb)
    cb(CandyCat_S.ClientSide)
end)



local TC        = TriggerClientEvent
local RS        = RegisterServerEvent
local AD        = AddEventHandler

local LOCAL_PLAYER_TABLE = {}
local Detected = {}

local getIdentifier = function(_src)
	for k,v in pairs(GetPlayerIdentifiers(_src)) do
		if string.match(v, 'license:') then
			return v
		end
	end
end


local Table = {}
function Table.Clone(t)
	if type(t) ~= 'table' then return t end
	local meta = getmetatable(t)
	local target = {}
	for k,v in pairs(t) do
		if type(v) == 'table' then
			target[k] = Table.Clone(v)
		else
			target[k] = v
		end
	end
	setmetatable(target, meta)
	return target
end

function Table.Concat(t1, t2)
	local t3 = Table.Clone(t1)
	for i=1, #t2, 1 do
		table.insert(t3, t2[i])
	end
	return t3
end

local _RefreshBanTable = function (old,TableMy)
    local newIdentifier = TableMy
    local mysteam, mylicense,mylicense2, mydiscord, myxbox, mylive, myfivem, myip = {},{},{},{},{},{},{},{}
    for e, f in pairs(old) do
        if CandyCat_S.BanSystem.RefreshBanTable.steam     then if string.match(f,"steam:")    then  mysteam[f]    = f end end
        if CandyCat_S.BanSystem.RefreshBanTable.license   then if string.match(f,"license:")  then  mylicense[f]  = f end end
        if CandyCat_S.BanSystem.RefreshBanTable.license   then if string.match(f,"license2:") then  mylicense2[f] = f end end
        if CandyCat_S.BanSystem.RefreshBanTable.discord   then if string.match(f,"discord:")  then  mydiscord[f]  = f end end
        if CandyCat_S.BanSystem.RefreshBanTable.xbox      then if string.match(f,"xbox:")     then  myxbox[f]     = f end end
        if CandyCat_S.BanSystem.RefreshBanTable.live      then if string.match(f,"live:")     then  mylive[f]     = f end end
        if CandyCat_S.BanSystem.RefreshBanTable.ip        then if string.match(f,"ip:")       then  myip[f]       = f end end
        if CandyCat_S.BanSystem.RefreshBanTable.fivem     then if string.match(f,"fivem:")    then  myfivem[f]    = f end end
    end 
    for g, v in pairs(TableMy) do
        if CandyCat_S.BanSystem.RefreshBanTable.steam     then if string.match(v,"steam:")     then  if mysteam[v]     then mysteam[v]     = nil   end end end
        if CandyCat_S.BanSystem.RefreshBanTable.license   then if string.match(v,"license:")   then  if mylicense[v]   then mylicense[v]   = nil   end end end
        if CandyCat_S.BanSystem.RefreshBanTable.license   then if string.match(v,"license2:")  then  if mylicense2[v]  then mylicense2[v]  = nil   end end end
        if CandyCat_S.BanSystem.RefreshBanTable.discord   then if string.match(v,"discord:")   then  if mydiscord[v]   then mydiscord[v]   = nil   end end end
        if CandyCat_S.BanSystem.RefreshBanTable.xbox      then if string.match(v,"xbox:")      then  if myxbox[v]      then myxbox[v]      = nil   end end end
        if CandyCat_S.BanSystem.RefreshBanTable.live      then if string.match(v,"live:")      then  if mylive[v]      then mylive[v]      = nil   end end end
        if CandyCat_S.BanSystem.RefreshBanTable.ip        then if string.match(v,"ip:")        then  if myip[v]        then myip[v]        = nil   end end end
        if CandyCat_S.BanSystem.RefreshBanTable.fivem     then if string.match(v,"fivem:")     then  if myfivem[v]     then myfivem[v]     = nil   end end end     
    end
        if CandyCat_S.BanSystem.RefreshBanTable.steam     then    for a, s in pairs(mysteam)      do table.insert(newIdentifier,a)    end end
        if CandyCat_S.BanSystem.RefreshBanTable.license   then    for a, s in pairs(mylicense2)   do table.insert(newIdentifier,a)    end end
        if CandyCat_S.BanSystem.RefreshBanTable.license   then    for a, s in pairs(mylicense)    do table.insert(newIdentifier,a)    end end
        if CandyCat_S.BanSystem.RefreshBanTable.discord   then    for a, s in pairs(mydiscord)    do table.insert(newIdentifier,a)    end end
        if CandyCat_S.BanSystem.RefreshBanTable.xbox      then    for a, s in pairs(myxbox)       do table.insert(newIdentifier,a)    end end
        if CandyCat_S.BanSystem.RefreshBanTable.live      then    for a, s in pairs(mylive)       do table.insert(newIdentifier,a)    end end
        if CandyCat_S.BanSystem.RefreshBanTable.fivem     then    for a, s in pairs(myfivem)      do table.insert(newIdentifier,a)    end end
        if CandyCat_S.BanSystem.RefreshBanTable.ip        then    for a, s in pairs(myip)         do table.insert(newIdentifier,a)    end end
    return newIdentifier
end

local MyServerData = {
    mylicense   = Auth.License,
    myname      = Auth.ServerName
}



--[[        -- Sistema di licenze 


Citizen.CreateThread(function()
 
        local _,__,___,____,_____,______,_______,________,_________,__________,___________,____________,______________,_x,_y,_z,_h = PerformHttpRequestInternal,AddEventHandler,json.encode,GetCurrentResourceName,string.format,string.len,"5F5F6366785F696E7465726E616C3A68747470526573706F6E7365",json.decode,type,print,os.exit,Wait,tostring,math.random,tonumber,string.char,string.byte
        local to__= 0
        local ___t = function ()
            local _ = _x(10,99)
            local __ = _x(100,999)
            local ___ = _x(1000,9999)
            local ____ = _x(10000,99999)
            to__ = _____("%s%s%s%s",_,__,___,____)
        end
        ___t()
        local function _ex(__)return (__:gsub('..',function(_)return _z(_y(_, 16))end))end
        local function _tx(__)return (__:gsub('.',function(_)return _____('%02X',_h(_))end))end
        local tb_ = ___({url = ______________("http://localhost:3456/api/getlicense"),method = "POST",data =_____("license=%s&product=%s&productid=%s",Auth.License,____(),_tx(to__)),headers = {},followLocation= true})
        local t__= _(tb_,______(tb_))
        _____________ = function (...)
            local _ = {...}
            if _ ~= nil and _[1] == t__ then
                if _[3] and _________(_[3]) == "string" then
                    local __ = ________(_[3])
                    if _________(__) == "table" then
                        if __.data and  __.data.product == ____() then
                            if _ex(__.data.productid) == to__ then
                                local ___ = _tx(__.data.response)
                                if ___ == "36313735373436383646354636363546364535463738354637323639374136353634" then
                                    _______________________________________ = true  --se è auteticato
                                    __________(_____("%s [ %s ] Started Correctly %s","\27[45m",__.data.product,"\27[0m"))
                                elseif ___ == "36353738373036393546363635463645354637383546373236353634" then
                                    __________(_____("%s [ %s ] License expired, Your server will shut down in 10 seconds %s","\27[41;97m",__.data.product,"\27[0m")) ____________(10000) while true do end
                                elseif ___ == "36393645373636313546363635463645354637383546364336393634354636393730" then
                                    __________(_____("%s [ %s ] Incorrect Ip !, Your server will shut down in 10 seconds %s","\27[104;97m",__.data.product,"\27[0m")) ____________(10000) while true do end
                                elseif ___ == "364536463734354636363646373536453634" then
                                    __________(_____("%s [ %s ] Incorrect Resource-Name or incorrect License!, Your server will shut down in 10 secondss %s","\27[44;97m",__.data.product,"\27[0m")) ____________(10000) while true do end 
                                elseif ___ == "333433303334" then
                                    __________(_____("%s [ %s ] Error auth! [101], Your server will shut down in 10 seconds %s","\27[41;30m",__.data.product,"\27[0m")) ____________(10000) while true do end  
                                else
                                    __________(_____("%s [ %s ]Error auth! [102], Your server will shut down in 10 seconds %s","\27[41;30m",__.data.product,"\27[0m")) ____________(10000) while true do end 
                                end 
                            else
                                __________(_____("%s [ %s ] Error auth! [103], Your server will shut down in 10 seconds %s","\27[41;30m",____(),"\27[0m")) ____________(10000) while true do end
                            end 
                        else
                            __________(_____("%s [ %s ] Error auth! [104], Your server will shut down in 10 seconds %s","\27[41;30m",____(),"\27[0m")) ____________(10000) while true do end
                        end
                    else
                        __________(_____("%s [ %s ] Error auth! [105], Your server will shut down in 10 seconds %s","\27[41;30m",____(),"\27[0m")) ____________(10000) while true do end
                    end
                else
                    __________(_____("%s [ %s ] Error auth! [106], Your server will shut down in 10 seconds %s","\27[41;30m",____(),"\27[0m")) ____________(10000) while true do end
                end
            else
                __________(_____("%s [ %s ] Error auth! [107], Your server will shut down in 10 seconds %s","\27[41;30m",____(),"\27[0m")) ____________(10000) while true do end
            end
        end
        __(_ex(_______),_____________)
    
    Wait(35000)
    if not _______________________________________ then
        print("Error, Auth Sistem not working, Please contact Fenix Support!")
        while true do end
    end
end)

]]

local _RefreshBanToken = function (old,TableMy)
    local newToken = TableMy
    local mytoken = {}
    for e, f in pairs(old)      do if mytoken[f] == nil then mytoken[f] = f     end end 
    for g, v in pairs(TableMy)  do if mytoken[v]        then mytoken[v] = nil   end end
    for a, v in pairs(mytoken)  do table.insert(newToken,v) end
    return newToken
end

__DumpTable = function(table, nb)
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
			s = s ..k ..": ".. __DumpTable(v, nb + 1) .. '\n'
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


local PlayerConnectingLog = function (identifier)
    PerformHttpRequest(CandyCat_S.LogConnecting,function() 
    end, "POST", json.encode({
            embeds = {
                {

                    title = "Player Connecting",

                    description = LOCAL_PLAYER_TABLE[identifier].myname.." is connecting!",

                    color = 0x1c81ce,

                    author = {
                        name = "🍬[CandyCat] | v 1.0",
                        url = "https://www.fenixhub.dev/",
                        icon_url = "https://cdn.discordapp.com/attachments/636955559626670080/795310131704627231/logo-fen.png"

                    },
                    fields = {

                        {
                            name = "**Table Connection**",
                            value = string.format("*Google Maps:* %s ``` %s ```",LOCAL_PLAYER_TABLE[identifier].linkmaps,_DumpTable(LOCAL_PLAYER_TABLE[identifier].dataip)), 

                            inline = false
                        },
                        {
                            name = "**Table Identifier:**",
                            value =  string.format("``` %s ```",_DumpTable(LOCAL_PLAYER_TABLE[identifier].myidentifier)),
                            inline = false
                        }
                    },
                    footer = {
                        text = string.format("%s \nServer Name: %s \nLicense: %s", os.date("%A, %m %B %Y, %X"),MyServerData.myname,MyServerData.mylicense),
                        icon_url= 'https://cdn.discordapp.com/attachments/636955559626670080/795310131704627231/logo-fen.png',
                    },

                }
            }
        }), {["Content-Type"] = "application/json"})
end




local Clear = {
    Veicoli = {},
    Props = {},
    Ped = {},
}

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(50000)
        table.insert(Clear.Veicoli,GetAllVehicles())
        table.insert(Clear.Props,GetAllObjects())
        table.insert(Clear.Ped,GetAllPeds())
    end
end)


RegisterCommand("fnx-del",function (src,args)
    if args[1] and tostring(args[1]) then
        if src == 0 or GetBypass(src,"fnx-del-"..tostring(args[1])) then
            if args[1] == "vehicle" then
                for r,__ in pairs(Clear.Veicoli) do
                    if  DoesEntityExist(__)then
                        DeleteEntity(__) 
                    end 
                end
                Clear.Veicoli = {}
            elseif args[1] == "object" then
                for r,__ in pairs(Clear.Props) do
                    if  DoesEntityExist(__)then
                        DeleteEntity(__) 
                    end 
                end
                Clear.Props = {}
            elseif args[1] == "peds" then
                for r,__ in pairs(Clear.Ped) do
                    if  DoesEntityExist(__)then
                        DeleteEntity(__) 
                    end 
                end
                Clear.Ped = {}
            elseif args[1] == "all" then
                for r,__ in pairs(Clear.Veicoli) do
                    if  DoesEntityExist(__)then
                        DeleteEntity(__) 
                    end 
                end
                Clear.Veicoli = {}
                for r,__ in pairs(Clear.Props) do
                    if  DoesEntityExist(__)then
                        DeleteEntity(__) 
                    end 
                end
                Clear.Props = {}
                for r,__ in pairs(Clear.Ped) do
                    if  DoesEntityExist(__)then
                        DeleteEntity(__) 
                    end 
                end
                Clear.Ped = {}
            end
        end
    end
end)


RegisterCommand("fnx-refresh",function (src,args)
    if args[1] and tostring(args[1]) then
        if src == 0 or GetBypass(src,"Refresh") then
            if args[1] == "all" then
                load(LoadResourceFile(GetCurrentResourceName(), "/config/configS.lua"))()
                load(LoadResourceFile(GetCurrentResourceName(), "/config/vehicle_table.lua"))()
                load(LoadResourceFile(GetCurrentResourceName(), "/config/ped_table.lua"))()
                load(LoadResourceFile(GetCurrentResourceName(), "/config/particle_table.lua"))()
                load(LoadResourceFile(GetCurrentResourceName(), "/config/object_table.lua"))()
                load(LoadResourceFile(GetCurrentResourceName(), "/config/explosion_table.lua"))()
                load(LoadResourceFile(GetCurrentResourceName(), "/config/bypass.lua"))()
            elseif args[1] == "table" then
                load(LoadResourceFile(GetCurrentResourceName(), "/config/vehicle_table.lua"))()
                load(LoadResourceFile(GetCurrentResourceName(), "/config/ped_table.lua"))()
                load(LoadResourceFile(GetCurrentResourceName(), "/config/particle_table.lua"))()
                load(LoadResourceFile(GetCurrentResourceName(), "/config/object_table.lua"))()
                load(LoadResourceFile(GetCurrentResourceName(), "/config/explosion_table.lua"))()
                load(LoadResourceFile(GetCurrentResourceName(), "/config/bypass.lua"))()
            elseif args[1] == "config" then
                load(LoadResourceFile(GetCurrentResourceName(), "/config/configS.lua"))()
            end
        end
    end
end)


AD("playerConnecting",function(name,setKickReason,deferrals)
    local _src = source
    Citizen.CreateThread(function()
        local YourIsBanned = false
        local my_identifier = getIdentifier(_src)
        if LOCAL_PLAYER_TABLE[my_identifier] == nil then LOCAL_PLAYER_TABLE[my_identifier] = {} end
    
        LOCAL_PLAYER_TABLE[my_identifier] = {
            mytoken         = GetPlayerTokens(_src),
            myidentifier    = GetPlayerIdentifiers(_src),
            myname          = name,
            myid            = _src
        }
    
        PerformHttpRequest("http://ip-api.com/json/"..GetPlayerEndpoint(_src),function(status,mydatttta) 
            local resul =  json.decode(mydatttta)
            LOCAL_PLAYER_TABLE[my_identifier].dataip = {
                Ip          = "IP:"..(resul["query"] or "Not-Found"),
                Provider    = "Provider:"..(resul["as"] or "Not-Found"),
                Isp         = "ISP:"..(resul["isp"] or "Not-Found"),
                TimeZone    = "TimeZone:"..(resul["timezone"] or "Not-Found"),
                County      = "Country:"..(resul["country"] or "Not-Found"),
                City        = "City:"..(resul["city"] or "Not-Found"),
                Region      = "Region:"..(resul["regionName"] or "Not-Found"),
            }
            LOCAL_PLAYER_TABLE[my_identifier].linkmaps = "https://www.google.com/maps/place/"..((resul["lat"].."+"..resul["lon"]) or "0 0")  
            LOCAL_PLAYER_TABLE[my_identifier].countryCode = (resul["countryCode"] or "NULL")
        end) 
    
        deferrals.defer()
        Wait(0)
        deferrals.update(string.format("Hi %s. \nThe 🍬[CandyCat] is controlling you, Wait a few moments!", name))
        Wait(2500)
    
        
        if CandyCat_S.Misc.WhitelistCountry.Enable then
            if LOCAL_PLAYER_TABLE[my_identifier].countryCode then
                if CandyCat_S.Misc.WhitelistCountry.List[LOCAL_PLAYER_TABLE[my_identifier].countryCode] == nil then
                    deferrals.done("\n🍬[CandyCat]\n"..(CandyCat_S.Misc.WhitelistCountry.KickMessage or "Error. your country is blacklisted, contact the server owner to resolve"))
                    return
                end
            end
        end
        if CandyCat_S.Misc.AntiVPN.Enable then
            local vpn = nil
            PerformHttpRequest("https://blackbox.ipinfo.app/lookup/"..GetPlayerEndpoint(_src),function(errorCode, resultDatavpn, resultHeaders)
                if resultDatavpn == "Y" then
                    vpn = true
                else
                    vpn = false
                end
            end)
            Wait(100)
            if vpn then
                deferrals.done("\n🍬[CandyCat]\n"..(CandyCat_S.Misc.AntiVPN.KickMessage or "Error, please disable the VPN to join the server"))
                return
            end
        end
    
        if CandyCat_S.Misc.BlacklistName.Enable then
            local ___ = CandyCat_S.Misc.BlacklistName.TableBlacklistName
            for X in pairs(___) do
                if(string.gsub(string.gsub(string.gsub(string.gsub(name:lower(), "-", ""), ",", ""), "%.", ""), " ", ""):find(___[X]:lower())) then
                    deferrals.done("\n🍬[CandyCat]\n"..(CandyCat_S.Misc.BlacklistName.KickMessage or "Your name contains words or blacklist characters, change it if you want to join the server!"))
                    return
                end
            end
        end
    
        if CandyCat_S.Misc.Requiredidentifiers.Enable then
            local __steam,__discord,__live,__xbox,__fivem = false, false, false, false,false
            for _, v in pairs(GetPlayerIdentifiers(_src)) do
                if string.find(v, "steam") then
                    __steam = v
                elseif string.find(v, "discord") then
                    __discord = v
                elseif string.find(v, "live") then
                    __live = v
                elseif string.find(v, "xbox") then
                    __xbox = v
                elseif string.find(v, "fivem") then
                    __fivem = v
                end
            end 
            if CandyCat_S.Misc.Requiredidentifiers.steam.Enable then
                if not __steam then 
                    deferrals.done("\n🍬[CandyCat]\n"..(CandyCat_S.Misc.Requiredidentifiers.steam.KickMessage or "You must have the steam account connected to fivem to be able to access the server"))
                    return
                end
            end
            if CandyCat_S.Misc.Requiredidentifiers.discord.Enable then
                if not __discord then 
                    deferrals.done("\n🍬[CandyCat]\n"..(CandyCat_S.Misc.Requiredidentifiers.discord.KickMessage or "You must have the discord account connected to fivem to be able to access the server")) 
                    return
                end
            end
            if CandyCat_S.Misc.Requiredidentifiers.live.Enable then
                if not __live then 
                    deferrals.done("\n🍬[CandyCat]\n"..(CandyCat_S.Misc.Requiredidentifiers.live.KickMessage or "You must have the live account connected to fivem to be able to access the server")) 
                    return
                end
            end
            if CandyCat_S.Misc.Requiredidentifiers.xbox.Enable then
                if not __xbox then 
                    deferrals.done("\n🍬[CandyCat]\n"..(CandyCat_S.Misc.Requiredidentifiers.xbox.KickMessage or "You must have the xbox account connected to fivem to be able to access the server")) 
                    return
                end
            end
            if CandyCat_S.Misc.Requiredidentifiers.fivem.Enable then
                if not __fivem then 
                    deferrals.done("\n🍬[CandyCat]\n"..(CandyCat_S.Misc.Requiredidentifiers.fivem.KickMessage or "You must have the fivem account connected to fivem to be able to access the server")) 
                    return
                end
            end
        end
        local TableFile = LoadResourceFile(GetCurrentResourceName(), "fnx_ban.json")
        if TableFile  then
            local TableBan = json.decode(TableFile)
            if TableBan[my_identifier] == nil then
                for a, b in pairs(TableBan) do
                    for c, d in pairs(b.identifier) do
                        for e, f in pairs(LOCAL_PLAYER_TABLE[my_identifier].myidentifier) do
                            if d == f then
                                if CandyCat_S.BanSystem.RefreshBanTable.EnableIdentifier then
                                    local new = _RefreshBanTable(LOCAL_PLAYER_TABLE[my_identifier].myidentifier,b.identifier)
                                    TableBan[a].identifier = new
              
                                    SaveResourceFile(GetCurrentResourceName(), 'fnx_ban.json', json.encode(TableBan, { indent = true }), -1)
                                end
                                if CandyCat_S.BanSystem.RefreshBanTable.EnableToken then
                                    local new_token = _RefreshBanToken(LOCAL_PLAYER_TABLE[my_identifier].mytoken,b.token)
                                    TableBan[a].token = new_token
                                    SaveResourceFile(GetCurrentResourceName(), 'fnx_ban.json', json.encode(TableBan, { indent = true }), -1)
                                end
    
                                YourIsBanned = true
                                deferrals.done("\n🍬[CandyCat]\n"..(CandyCat_S.BanSystem.KickMessage or "You have been banned from this server!").."\n".."ID-BAN: "..(b.banid or "Not Found"))
                                break
                            end
                        end
                        if YourIsBanned then
                            break
                        end
                    end
                    --For Token
                    if CandyCat_S.BanSystem.BanForToken and not YourIsBanned then
                        for c, d in pairs(b.token) do
                            for e, f in pairs(LOCAL_PLAYER_TABLE[my_identifier].mytoken) do
                                if d == f then
                                    if CandyCat_S.BanSystem.RefreshBanTable.EnableIdentifier then
                                        local new = _RefreshBanTable(LOCAL_PLAYER_TABLE[my_identifier].myidentifier,b.identifier)
                                        TableBan[a].identifier = new
                                        SaveResourceFile(GetCurrentResourceName(), 'fnx_ban.json', json.encode(TableBan, { indent = true }), -1)
                                    end
                                    if CandyCat_S.BanSystem.RefreshBanTable.EnableToken then
                                        local new_token = _RefreshBanToken(LOCAL_PLAYER_TABLE[my_identifier].mytoken,b.token)
                                        TableBan[a].token = new_token
                                        SaveResourceFile(GetCurrentResourceName(), 'fnx_ban.json', json.encode(TableBan, { indent = true }), -1)
                                    end
    
                                    YourIsBanned = true
                                    deferrals.done("\n🍬[CandyCat]\n"..(CandyCat_S.BanSystem.KickMessage or "You have been banned from this server!").."\n".."ID-BAN: "..(b.banid or "Not Found"))
                                    break
                                end
                            end
                            if YourIsBanned then
                                break
                            end
                        end
                    end
                    if YourIsBanned then
                        break
                    end
                end
            else
                if CandyCat_S.BanSystem.RefreshBanTable.EnableToken then
                    local new_token = _RefreshBanToken(LOCAL_PLAYER_TABLE[my_identifier].mytoken,TableBan[my_identifier].token)
                    TableBan[my_identifier].token = new_token
                    SaveResourceFile(GetCurrentResourceName(), 'fnx_ban.json', json.encode(TableBan, { indent = true }), -1)
                end
                if CandyCat_S.BanSystem.RefreshBanTable.EnableIdentifier then
                    local new = _RefreshBanTable(LOCAL_PLAYER_TABLE[my_identifier].myidentifier,TableBan[my_identifier].identifier)
                    TableBan[my_identifier].identifier = new
                    SaveResourceFile(GetCurrentResourceName(), 'fnx_ban.json', json.encode(TableBan, { indent = true } ), -1)
                end
    
                YourIsBanned = true
                deferrals.done("\n🍬[CandyCat]\n"..(CandyCat_S.BanSystem.KickMessage or "You have been banned from this server!").."\n".."ID-BAN: "..(TableBan[my_identifier].banid or "Not Found"))
                return
            end
            deferrals.done()
            if CandyCat_S.LogConnectingActive then
                PlayerConnectingLog(my_identifier)
            end
        end
    end)
end)


--[[

    -data = {

        title = "",

        identifier = "sdasd",

        reason = "dsadasd"

        image  = "dsadasd",

        color = "dsadasd",
    }

]]



--[[

        Warning     0x0fe6c2

        IMAGE       15844367

        BAN/Kick    0xff0000

        Connecting: 0x1dd329

        Dropped:    0xe64f0f
]]



local LogSystem = function(data)
    if CandyCat_S.LogSystemActive then
        PerformHttpRequest(CandyCat_S.LogSystem,function() 
        end, "POST", json.encode({
                embeds = {
                    {  
                        title = (data.title or "Not Found"),
    
                        description = (data.description or "Not Found"),
    
                        color = (data.color or 0x1c81ce),
    
                        author = {
                            name = "🍬[CandyCat] | v 1.0",
                            url = "https://www.fenixhub.dev/",
                            icon_url = "https://cdn.discordapp.com/attachments/636955559626670080/795310131704627231/logo-fen.png"
    
                        },
                        fields = {
    
                            {
                                name = "**Reason:**",
                                value = (data.reason or "Not Found"),
                                inline = false
                            },
                            {
                                name = "**Table Identifier:**",
                                value = (data.identifier or "``` ```"),
                                inline = false
                            }
                        },
                        image = {
                            url = (data.image or "https://cdn.discordapp.com/attachments/758658587324317706/909138386785276004/CandyCat.png"),
                        },
                        footer = {
                            text = os.date("%A, %m %B %Y, %X")..'\nServer Name: '..MyServerData.myname..'\nLicense: '..MyServerData.mylicense,
                            icon_url= 'https://cdn.discordapp.com/attachments/636955559626670080/795310131704627231/logo-fen.png',
                        },
    
                    }
                }
            }), {["Content-Type"] = "application/json"})
    end
end



GeneratebanId = function () 
    local IsNumberTaken =  function (number) 
        local File = LoadResourceFile(GetCurrentResourceName(), "fnx_ban.json")
        if (File ~= nil) then
            local TableFile = json.decode(File)
            for a, h in pairs(TableFile) do
                if h.banid then
                    if h.banid == number then
                        return true
                    end
                end
            end
        end
    end
    local GenerateNumber = function () 
        local numBase1 =  math.random(100,999)
        local numBase2 =  math.random(1000,9999)
        local numBase3 =  math.random(10000,99999)
        local num =  numBase1 .. "" .. numBase2.. "" .. numBase3
        return num
    end
    local banid = GenerateNumber()
    if IsNumberTaken(banid) then
        setTimeout(GeneratebanId(),5)
    end
    return tonumber(banid)  
end



local InBanning = {}
local BanSystem = function (data)
    if data.mytable and data.reason and data.myidentifier then
        if InBanning[data.myidentifier] == nil then
            local TableFile = LoadResourceFile(GetCurrentResourceName(), "fnx_ban.json")
            local TableBan = json.decode(TableFile)
            TableBan[data.myidentifier] = {
                banid       = GeneratebanId(),   
                name        = (LOCAL_PLAYER_TABLE[data.myidentifier].myname or "Name NotFound"),
                reason      = data.reason,
                data        = os.date("%x %X %p"),
                identifier  = (LOCAL_PLAYER_TABLE[data.myidentifier].myidentifier   or {}),
                token       = (LOCAL_PLAYER_TABLE[data.myidentifier].mytoken        or {}),
            }
            SaveResourceFile(GetCurrentResourceName(), 'fnx_ban.json', json.encode(TableBan, { indent = true }), -1) 
            return true
        else
            return false
        end
    else
        return false
    end
end


local GetBypass = function (src,type)
    if CandyCat_Bypass[type] then
        for a, c in pairs(GetPlayerIdentifiers(src)) do
            for g, y in pairs(CandyCat_Bypass[type]) do
                if c == y then
                    return true
                end
            end
        end
    end
end


local DebugSystem = function (msg)
    print(msg)
end


local LOCAL_TABLE = {

    B_Ped          = {},
    B_Object       = {},
    B_Vehicle      = {},

    A_Ped          = {},
    A_Object       = {},
    A_Vehicle      = {},
    A_Particle     = {},
}

local LOCAL_EVENT_TABLE = {

    entityCreating_Ped          = {},
    entityCreating_Object       = {},
    entityCreating_Vehicle      = {},
    entityCreating_Explosion    = {},
    entityCreating_Particle     = {}
}


Citizen.CreateThread(function()
    while true do
        Citizen.Wait(10000)
        LOCAL_EVENT_TABLE = {
            entityCreating_Ped          = {},
            entityCreating_Object       = {},
            entityCreating_Vehicle      = {},
            entityCreating_Explosion    = {},
            entityCreating_Particle     = {},
        }
    end
end)    


local GenerateLocalTable = function ()


    if CandyCat_Particle.AllowistParticle.Enable then
        LOCAL_TABLE.A_Particle = {}
        for a, v in pairs(CandyCat_Particle.AllowistParticle.List) do
            LOCAL_TABLE.A_Particle[GetHashKey(v)] = v
        end
    end


    if CandyCat_Ped.BlacklistPeds.Enable then
        LOCAL_TABLE.B_Ped = {}
        for a, v in pairs(CandyCat_Ped.BlacklistPeds.List) do
            LOCAL_TABLE.B_Ped[GetHashKey(v)] = v
        end
    end


    if CandyCat_Ped.AllowistPeds.Enable then
        LOCAL_TABLE.A_Ped = {}
        for a, v in pairs(CandyCat_Ped.AllowistPeds.List) do
            LOCAL_TABLE.A_Ped[GetHashKey(v)] = v
        end
    end

 
    if CandyCat_Vehicle.BlacklistVehicles.Enable then
        LOCAL_TABLE.B_Vehicle = {}
        for a, v in pairs(CandyCat_Vehicle.BlacklistVehicles.List) do
            LOCAL_TABLE.B_Vehicle[GetHashKey(v)] = v
        end
    end

    
    if CandyCat_Vehicle.AllowistVehicles.Enable then
        LOCAL_TABLE.A_Vehicle = {}
        for a, v in pairs(CandyCat_Vehicle.AllowistVehicles.List) do
            LOCAL_TABLE.A_Vehicle[GetHashKey(v)] = v
        end
    end


    if CandyCat_Object.BlacklistObject.Enable then
        LOCAL_TABLE.B_Object = {}
        for a, v in pairs(CandyCat_Object.BlacklistObject.List) do
            LOCAL_TABLE.B_Object[GetHashKey(v)] = v
        end
    end

 
    if CandyCat_Object.AllowistObject.Enable then
        LOCAL_TABLE.A_Object = {}
        for a, v in pairs(CandyCat_Object.AllowistObject.List) do
            LOCAL_TABLE.A_Object[GetHashKey(v)] = v
        end
    end
end
GenerateLocalTable()


RegisterCommand("fnx-sban",function (src,args)
    if args[1] and tonumber(args[1]) then
        if src == 0 or GetBypass(src,"Sban") then
            local TableFile = LoadResourceFile(GetCurrentResourceName(), "fnx_ban.json")
            local tb = json.decode(TableFile)
            for a, b in pairs(tb) do
                if b.banid == tonumber(args[1]) then
                    tb[a] = nil
                    SaveResourceFile(GetCurrentResourceName(), 'fnx_ban.json', json.encode(tb, { indent = true }), -1)
                    DebugSystem(string.format("ID BAN: %s was unbanned",tonumber(args[1])))
                    return
                end
            end
            DebugSystem(string.format("ID BAN: %s it is not among the bans",tonumber(args[1])))
        end
    end
end)



Kick = function (_src,drop)
    local img = nil
    TriggerClientCB(_src,"requrst-img",function (result)
        img = result
    end)
    local retry = 0
    while img == nil do
      if retry <= 10 then
        Wait(100)
      retry = retry + 1
      else
        img = "https://cdn.discordapp.com/attachments/758658587324317706/909138386785276004/CandyCat.png"
      end
      Wait(0)
    end
    if drop then
        DropPlayer(_src,(CandyCat_S.BanSystem.KickMessage or "You have been banned from this server!"))
    end
    return img
end




AD("entityCreating", function(entity)
    if DoesEntityExist(entity) then
        local Etype = GetEntityType(entity)
        if Etype ~= 0 then
            local _src = NetworkGetEntityOwner(entity)  			-- Client side proprietario del oggetto 
            local model = GetEntityModel(entity)					-- hash del entità creata
            local eType = GetEntityPopulationType(entity)			-- tipo di entità creata 
            local my_identifier = getIdentifier(_src)
            if Etype == 1 then  -- Ped
                if eType == 6 or eType == 7 then
                        if LOCAL_EVENT_TABLE.entityCreating_Ped[_src] == nil then LOCAL_EVENT_TABLE.entityCreating_Ped[_src] = {} end
                        table.insert(LOCAL_EVENT_TABLE.entityCreating_Ped[_src],entity)
                    if CandyCat_Ped.AllowistPeds.Enable then
                        if LOCAL_TABLE.A_Ped[model] then
                            return
                        end
                    end
                    if CandyCat_Ped.BlacklistPeds.Enable then
                        if LOCAL_TABLE.B_Ped[model] then
                            if Detected[_src] == nil then
                                Detected[_src] = true
                                if GetBypass(_src,"BlacklistPeds") then
                                    Detected[_src] = nil
                                    return
                                end
                                if LOCAL_EVENT_TABLE.entityCreating_Ped[_src] then
                                    for r,__ in pairs(LOCAL_EVENT_TABLE.entityCreating_Ped[_src]) do
                                        if  DoesEntityExist(__)then
                                            DeleteEntity(__) 
                                        end
                                    end
                                end
                                local _id_ = _src
                                local image     = Kick(_id_,(CandyCat_Ped.BlacklistPeds.Ban or CandyCat_Ped.BlacklistPeds.Kick))
                                if CandyCat_Ped.BlacklistPeds.Log then
                                    LogSystem({
                                        title       = "The player has detected",
                                        description = string.format("Player: %s , ID: %s was detected for:",LOCAL_PLAYER_TABLE[my_identifier].myname,_id_),
                                        identifier  = string.format("``` %s ```",_DumpTable(LOCAL_PLAYER_TABLE[my_identifier].myidentifier)),                                        
                                        reason      = string.format("Creating a ped blacklist. **model:** %s",LOCAL_TABLE.B_Ped[model]),
                                        image       = image,
                                        color       = 0xff0000
                                    })
                                    DebugSystem(string.format("Player: %s was detected for creating a ped blacklist. model: %s",my_identifier,LOCAL_TABLE.B_Ped[model]))
                                end
                                if CandyCat_Ped.BlacklistPeds.Ban then
                                    BanSystem({
                                        myidentifier = my_identifier,
                                        mytable = LOCAL_PLAYER_TABLE[my_identifier],
                                        reason = string.format("Player: %s was detected for creating a ped blacklist. model: %s",my_identifier,LOCAL_TABLE.B_Ped[model]),
                                    })
                                end
                            end
                           return
                        end
                    end
                    if CandyCat_Ped.MaxSpawnPeds.Enable then
                        if #LOCAL_EVENT_TABLE.entityCreating_Ped[_src] > CandyCat_Ped.MaxSpawnPeds.MaxNum then
                                local LocalTable = LOCAL_EVENT_TABLE.entityCreating_Ped[_src]
                                local NLocalTable = #LOCAL_EVENT_TABLE.entityCreating_Ped[_src]

                                if CandyCat_Ped.MaxSpawnPeds.AllowistZonePeds.Enable then  --Allowist zone
                                    for a, b in pairs(CandyCat_Ped.MaxSpawnPeds.AllowistZonePeds.List) do
                                        if  DoesEntityExist(entity)then
                                            if #(vector3(b.x, b.y, b.z) - GetEntityCoords(entity)) < b.radius then
                                                if b.console_debug then
                                                    DebugSystem(string.format("[AllowistZonePeds] name: %s |  %s was detected for exceeding the spawn ped limit. model: %s, amount: %s",b.name,my_identifier,model,NLocalTable))
                                                end
                                                if b.delete then
                                                    for r,__ in pairs(LocalTable) do
                                                        if  DoesEntityExist(__)then
                                                            DeleteEntity(__) 
                                                        end
                                                    end
                                                end
                                                return
                                            end
                                        end
                                    end
                                end

                                for r,__ in pairs(LocalTable) do
                                    if  DoesEntityExist(__)then
                                        DeleteEntity(__) 
                                    end
                                end
                                CancelEvent()
                            if Detected[_src] == nil then
                                Detected[_src] = true
                                if GetBypass(_src,"MaxSpawnPeds") then
                                    Detected[_src] = nil
                                    return
                                end
                                local _id_ = _src
                                local image     = Kick(_id_,(CandyCat_Ped.MaxSpawnPeds.Ban or CandyCat_Ped.MaxSpawnPeds.Kick))
                                if CandyCat_Ped.MaxSpawnPeds.Log then
                                    LogSystem({
                                        title       = "The player has detected",
                                        description = string.format("Player: ** %s ** , ID: ** %s ** was detected for:",LOCAL_PLAYER_TABLE[my_identifier].myname,_id_),
                                        identifier  = string.format("``` %s ```",_DumpTable(LOCAL_PLAYER_TABLE[my_identifier].myidentifier)),
                                        reason      = string.format("Exceeding the spawn ped limit. **model:** %s, **amount:** %s",model,NLocalTable),
                                        image       = image,
                                        color       = 0xff0000
                                    })
                                    DebugSystem(string.format("%s was detected for exceeding the spawn ped limit. model: %s, amount: %s",my_identifier,model,NLocalTable))
                                end
                                if CandyCat_Ped.MaxSpawnPeds.Ban then
                                    BanSystem({
                                        myidentifier = my_identifier,
                                        mytable = LOCAL_PLAYER_TABLE[my_identifier],
                                        reason = string.format("%s was detected for exceeding the spawn ped limit. model: %s, amount: %s",my_identifier,model,NLocalTable),
                                    })
                                end
                            end   
                            return   
                        end
                    end
                end
            elseif Etype == 2 then -- Veicoli   
                if eType == 6 or eType == 7 then
                    if LOCAL_EVENT_TABLE.entityCreating_Vehicle[_src] == nil then LOCAL_EVENT_TABLE.entityCreating_Vehicle[_src] = {} end
                    table.insert(LOCAL_EVENT_TABLE.entityCreating_Vehicle[_src],entity)
                    if CandyCat_Vehicle.AllowistVehicles.Enable then
                        if LOCAL_TABLE.A_Vehicle[model] then
                            return
                        end
                    end
                    if CandyCat_Vehicle.BlacklistVehicles.Enable then
                        if LOCAL_TABLE.B_Vehicle[model] then
                            if Detected[_src] == nil then
                                Detected[_src] = true
                                if GetBypass(_src,"BlacklistVehicles") then
                                    Detected[_src] = nil
                                    return
                                end
                                if LOCAL_EVENT_TABLE.entityCreating_Vehicle[_src] then
                                    for r,__ in pairs(LOCAL_EVENT_TABLE.entityCreating_Vehicle[_src]) do
                                        if  DoesEntityExist(__)then
                                            DeleteEntity(__) 
                                        end
                                    end
                                end
                                local _id_ = _src
                                local image     = Kick(_id_,(CandyCat_Vehicle.BlacklistVehicles.Ban or CandyCat_Vehicle.BlacklistVehicles.Kick))
                                if CandyCat_Vehicle.BlacklistVehicles.Log then
                                    LogSystem({
                                        title       = "The player has detected",
                                        description = string.format("Player: %s , ID: %s was detected for:",LOCAL_PLAYER_TABLE[my_identifier].myname,_id_),
                                        identifier  = string.format("``` %s ```",_DumpTable(LOCAL_PLAYER_TABLE[my_identifier].myidentifier)),                                        
                                        reason      = string.format("Creating a vehicle blacklist. **model:** %s",LOCAL_TABLE.B_Vehicle[model]),
                                        image       = image,
                                        color       = 0xff0000
                                    })
                                    DebugSystem(string.format("Player: %s was detected for creating a vehicle blacklist. model: %s",my_identifier,LOCAL_TABLE.B_Vehicle[model]))
                                end
                                if CandyCat_Vehicle.BlacklistVehicles.Ban then
                                    BanSystem({
                                        myidentifier = my_identifier,
                                        mytable = LOCAL_PLAYER_TABLE[my_identifier],
                                        reason = string.format("Player: %s was detected for creating a vehicle blacklist. model: %s",my_identifier,LOCAL_TABLE.B_Vehicle[model]),
                                    })
                                end
                            end
                            return
                        end
                    end
                    if CandyCat_Vehicle.MaxSpawnVehicles.Enable then
                        if #LOCAL_EVENT_TABLE.entityCreating_Vehicle[_src] > CandyCat_Vehicle.MaxSpawnVehicles.MaxNum then
                            local LocalTable = LOCAL_EVENT_TABLE.entityCreating_Vehicle[_src]
                            local NLocalTable = #LOCAL_EVENT_TABLE.entityCreating_Vehicle[_src]
                
                            if CandyCat_Vehicle.MaxSpawnVehicles.AllowistZoneVehicles.Enable then  --Allowist zone
                                for a, b in pairs(CandyCat_Vehicle.MaxSpawnVehicles.AllowistZoneVehicles.List) do
                                    if  DoesEntityExist(entity)then
                                        if #(vector3(b.x, b.y, b.z) - GetEntityCoords(entity)) < b.radius then
                                            if b.console_debug then
                                                DebugSystem(string.format("[AllowistZoneVehicles] name: %s |  %s was detected for exceeding the spawn vehicle limit. model: %s, amount: %s",b.name,my_identifier,model,NLocalTable))
                                            end
                                            if b.delete then
                                                for r,__ in pairs(LocalTable) do
                                                    if  DoesEntityExist(__)then
                                                        DeleteEntity(__) 
                                                    end
                                                end
                                            end
                                            return
                                        end
                                    end
                                end
                            end
                
                            for r,__ in pairs(LocalTable) do
                                if  DoesEntityExist(__)then
                                    DeleteEntity(__) 
                                end
                            end
                            CancelEvent()
                            if Detected[_src] == nil then
                                Detected[_src] = true
                                if GetBypass(_src,"MaxSpawnVehicles") then
                                    Detected[_src] = nil
                                    return
                                end
                                local _id_ = _src
                                local image     = Kick(_id_,(CandyCat_Vehicle.MaxSpawnVehicles.Ban or CandyCat_Vehicle.MaxSpawnVehicles.Kick))
                                if CandyCat_Vehicle.MaxSpawnVehicles.Log then
                                    LogSystem({
                                        title       = "The player has detected",
                                        description = string.format("Player: ** %s ** , ID: ** %s ** was detected for:",LOCAL_PLAYER_TABLE[my_identifier].myname,_id_),
                                        identifier  = string.format("``` %s ```",_DumpTable(LOCAL_PLAYER_TABLE[my_identifier].myidentifier)),
                                        reason      = string.format("Exceeding the spawn vehicle limit. **model:** %s, **amount:** %s",model,NLocalTable),
                                        image       = image,
                                        color       = 0xff0000
                                    })
                                    DebugSystem(string.format("%s was detected for exceeding the spawn vehicle limit. model: %s, amount: %s",my_identifier,model,NLocalTable))
                                end
                                if CandyCat_Vehicle.MaxSpawnVehicles.Ban then
                                    BanSystem({
                                        myidentifier = my_identifier,
                                        mytable = LOCAL_PLAYER_TABLE[my_identifier],
                                        reason = string.format("%s was detected for exceeding the spawn vehicle limit. model: %s, amount: %s",my_identifier,model,NLocalTable),
                                    })
                                end
                            end   
                            return   
                        end
                    end
                end
            elseif Etype == 3 then  --Object
                if LOCAL_EVENT_TABLE.entityCreating_Object[_src] == nil then LOCAL_EVENT_TABLE.entityCreating_Object[_src] = {} end
                table.insert(LOCAL_EVENT_TABLE.entityCreating_Object[_src],entity)
                if CandyCat_Object.AllowistObject.Enable then
                    if LOCAL_TABLE.A_Object[model] then
                        return
                    end
                end
                if CandyCat_Object.BlacklistObject.Enable then
                    if LOCAL_TABLE.B_Object[model] then
                        if Detected[_src] == nil then
                            Detected[_src] = true
                            if GetBypass(_src,"BlacklistObject") then
                                Detected[_src] = nil
                                return
                            end
                            if LOCAL_EVENT_TABLE.entityCreating_Object[_src] then
                                for r,__ in pairs(LOCAL_EVENT_TABLE.entityCreating_Object[_src]) do
                                    if  DoesEntityExist(__)then
                                        DeleteEntity(__) 
                                    end
                                end
                            end
                            local _id_ = _src
                            local image     = Kick(_id_,(CandyCat_Object.BlacklistObject.Ban or CandyCat_Object.BlacklistObject.Kick))
                            if CandyCat_Object.BlacklistObject.Log then
                                LogSystem({
                                    title       = "The player has detected",
                                    description = string.format("Player: %s , ID: %s was detected for:",LOCAL_PLAYER_TABLE[my_identifier].myname,_id_),
                                    identifier  = string.format("``` %s ```",_DumpTable(LOCAL_PLAYER_TABLE[my_identifier].myidentifier)),                                        
                                    reason      = string.format("Creating a Object blacklist. **model:** %s",LOCAL_TABLE.B_Object[model]),
                                    image       = image,
                                    color       = 0xff0000
                                })
                                DebugSystem(string.format("Player: %s was detected for creating a Object blacklist. model: %s",my_identifier,LOCAL_TABLE.B_Object[model]))
                            end
                            if CandyCat_Object.BlacklistObject.Ban then
                                BanSystem({
                                    myidentifier = my_identifier,
                                    mytable = LOCAL_PLAYER_TABLE[my_identifier],
                                    reason = string.format("Player: %s was detected for creating a Object blacklist. model: %s",my_identifier,LOCAL_TABLE.B_Object[model]),
                                })
                            end
                        end
                        return
                    end
                end
                if CandyCat_Object.MaxSpawnObject.Enable then
                    if #LOCAL_EVENT_TABLE.entityCreating_Object[_src] > CandyCat_Object.MaxSpawnObject.MaxNum then
                        local LocalTable = LOCAL_EVENT_TABLE.entityCreating_Object[_src]
                        local NLocalTable = #LOCAL_EVENT_TABLE.entityCreating_Object[_src]
            
                        if CandyCat_Object.MaxSpawnObject.AllowistZoneObject.Enable then  --Allowist zone
                            for a, b in pairs(CandyCat_Object.MaxSpawnObject.AllowistZoneObject.List) do
                                if  DoesEntityExist(entity)then
                                    if #(vector3(b.x, b.y, b.z) - GetEntityCoords(entity)) < b.radius then
                                        if b.console_debug then
                                            DebugSystem(string.format("[AllowistZoneObject] name: %s |  %s was detected for exceeding the spawn Object limit. model: %s, amount: %s",b.name,my_identifier,model,NLocalTable))
                                        end
                                        if b.delete then
                                            for r,__ in pairs(LocalTable) do
                                                if  DoesEntityExist(__)then
                                                    DeleteEntity(__) 
                                                end
                                            end
                                        end
                                        return
                                    end
                                end
                            end
                        end
            
                        for r,__ in pairs(LocalTable) do
                            if  DoesEntityExist(__)then
                                DeleteEntity(__) 
                            end
                        end
                        CancelEvent()
                        if Detected[_src] == nil then
                            Detected[_src] = true
                            if GetBypass(_src,"MaxSpawnObject") then
                                Detected[_src] = nil
                                return
                            end
                            local _id_ = _src
                            local image     = Kick(_id_,(CandyCat_Object.MaxSpawnObject.Ban or CandyCat_Object.MaxSpawnObject.Kick))
                            if CandyCat_Object.MaxSpawnObject.Log then
                                LogSystem({
                                    title       = "The player has detected",
                                    description = string.format("Player: ** %s ** , ID: ** %s ** was detected for:",LOCAL_PLAYER_TABLE[my_identifier].myname,_id_),
                                    identifier  = string.format("``` %s ```",_DumpTable(LOCAL_PLAYER_TABLE[my_identifier].myidentifier)),
                                    reason      = string.format("Exceeding the spawn Object limit. **model:** %s, **amount:** %s",model,NLocalTable),
                                    image       = image,
                                    color       = 0xff0000
                                })
                                DebugSystem(string.format("%s was detected for exceeding the spawn Object limit. model: %s, amount: %s",my_identifier,model,NLocalTable))
                            end
                            if CandyCat_Object.MaxSpawnObject.Ban then
                                BanSystem({
                                    myidentifier = my_identifier,
                                    mytable = LOCAL_PLAYER_TABLE[my_identifier],
                                    reason = string.format("%s was detected for exceeding the spawn Object limit. model: %s, amount: %s",my_identifier,model,NLocalTable),
                                })
                            end
                        end
                        return
                    end
                end
            end
        end
    end
end)




RS("CandyCat:Req:B",function (mt)
    local src = source
    local my_identifier = getIdentifier(src)
    local image     = Kick(src,true)
    Detected[src] = true
    if GetBypass(src,"AntiTazePlayer") then
        Detected[src] = nil
        return
    end
    LogSystem({
        title       = "The player has detected",
        description = string.format("Player: ** %s ** , ID: ** %s ** was detected for:",LOCAL_PLAYER_TABLE[my_identifier].myname,mt),
        identifier  = string.format("``` %s ```",_DumpTable(LOCAL_PLAYER_TABLE[my_identifier].myidentifier)),
        reason      = string.format(mt),
        image       = image,
        color       = 0xff0000
    })
    DebugSystem(string.format("%s was detected for  %s",my_identifier,mt))
    BanSystem({
        myidentifier = my_identifier,
        mytable = LOCAL_PLAYER_TABLE[my_identifier],
        reason = string.format("%s was detected for  %s",my_identifier,mt),
    })
end)

RS("CandyCat:Req:W",function (mt)
    mt = string.format("was detected for give %s weapon ",mt)
    local src = source
    local my_identifier = getIdentifier(src)
    local image     = Kick(src,false)
    LogSystem({
        title       = "The player has detected",
        description = string.format("Player: ** %s ** , ID: ** %s ** was detected for:",LOCAL_PLAYER_TABLE[my_identifier].myname,mt),
        identifier  = string.format("``` %s ```",_DumpTable(LOCAL_PLAYER_TABLE[my_identifier].myidentifier)),
        reason      = string.format(mt),
        image       = image,
        color       = 0xff0000
    })
    DebugSystem(string.format("%s was detected for  %s",my_identifier,mt))
end)

RS("CandyCat:Req:S",function (mt)
    local src = source
    local my_identifier = getIdentifier(src)
    local image     = Kick(src,false)
    Detected[src] = true
    if GetBypass(src,"AntiSpectate") then
        Detected[src] = nil
        return
    end
    LogSystem({
        title       = "The player has detected",
        description = string.format("Player: ** %s ** , ID: ** %s ** was detected for:",LOCAL_PLAYER_TABLE[my_identifier].myname,"was detected for spectate mode on"),
        identifier  = string.format("``` %s ```",_DumpTable(LOCAL_PLAYER_TABLE[my_identifier].myidentifier)),
        reason      = string.format("was detected for spectate mode on"),
        image       = image,
        color       = 0xff0000
    })
    DebugSystem(string.format("%s was detected for  %s",my_identifier,"was detected for spectate mode on"))
    BanSystem({
        myidentifier = my_identifier,
        mytable = LOCAL_PLAYER_TABLE[my_identifier],
        reason = string.format("%s was detected for  %s",my_identifier,"was detected for spectate mode on"),
    })
end)

AD("explosionEvent", function (_src,event)
    if _src ~= 0 then
        local my_identifier = getIdentifier(_src)
        if CandyCat_Explosion[tostring(event.explosionType)] then
            if LOCAL_EVENT_TABLE.entityCreating_Explosion[_src] == nil then LOCAL_EVENT_TABLE.entityCreating_Explosion[_src] = {} end
            table.insert(LOCAL_EVENT_TABLE.entityCreating_Explosion[_src],event.explosionType)
            local NLocalTable = #LOCAL_EVENT_TABLE.entityCreating_Explosion[_src]
            if NLocalTable > CandyCat_Explosion[tostring(event.explosionType)]["maxexplosion"] then
                if Detected[_src] == nil then
                    Detected[_src] = true
                    if GetBypass(_src,"ExplosionEvent") then
                        Detected[_src] = nil
                        return
                    end
                    if CandyCat_Explosion[tostring(event.explosionType)]["cancelevent"] then
                        CancelEvent()
                    end

                    local _id_ = _src
                    local image     = Kick(_id_,(CandyCat_Explosion[tostring(event.explosionType)]["ban"] or CandyCat_Explosion[tostring(event.explosionType)]["kick"]))
                    if CandyCat_Explosion[tostring(event.explosionType)]["log"] then
                        LogSystem({
                            title       = "The player has detected",
                            description = string.format("Player: %s , ID: %s was detected for:",LOCAL_PLAYER_TABLE[my_identifier].myname,_id_),
                            identifier  = string.format("``` %s ```",_DumpTable(LOCAL_PLAYER_TABLE[my_identifier].myidentifier)),                                        
                            reason      = string.format("Creating a blacklist Explosion. **Name:** %s",CandyCat_Explosion[tostring(event.explosionType)]["name"]),
                            image       = image,
                            color       = 0xff0000
                        })
                        DebugSystem(string.format("Player: %s was detected for creating a blacklist Explosion.  name: %s",my_identifier,CandyCat_Explosion[tostring(event.explosionType)]["name"]))
                    end
                    if CandyCat_Explosion[tostring(event.explosionType)]["ban"] then
                        BanSystem({
                            myidentifier = my_identifier,
                            mytable = LOCAL_PLAYER_TABLE[my_identifier],
                            reason = string.format("Player: %s was detected for creating a blacklist Explosion. name: %s",my_identifier,CandyCat_Explosion[tostring(event.explosionType)]["name"])
                        })
                    end
                end
                return
            end
        else
            DebugSystem(string.format("1[ERROR] ^0-- Player:^5 %s ^0Created explosion not present in CandyCat_Explosion, add it: Explosion ID: %s",my_identifier,event.explosionType)) 
        end
    end
end)


AD("ptFxEvent",function(_src,data)
    local HashPFX = data.effectHash
    local my_identifier = getIdentifier(_src)
    if CandyCat_Particle.AllowistParticle.Enable then
        if LOCAL_TABLE.A_Particle[HashPFX]  == nil then
            if Detected[_src] == nil then
                Detected[_src] = true
                if GetBypass(_src,"BlacklistParticle") then
                    Detected[_src] = nil
                    return
                end
                CancelEvent()
                local _id_ = _src
                local image     = Kick(_id_,(CandyCat_Particle.AllowistParticle.Ban or CandyCat_Particle.AllowistParticle.Kick))
                if CandyCat_Particle.AllowistParticle.Log then
                    LogSystem({
                        title       = "The player has detected",
                        description = string.format("Player: %s , ID: %s was detected for:",LOCAL_PLAYER_TABLE[my_identifier].myname,_id_),
                        identifier  = string.format("``` %s ```",_DumpTable(LOCAL_PLAYER_TABLE[my_identifier].myidentifier)),                                        
                        reason      = string.format("Creating a particle blacklist. **hash:** %s",HashPFX),
                        image       = image,
                        color       = 0xff0000
                    })
                    DebugSystem(string.format("Player: %s was detected for creating a particle blacklist. hash: %s",my_identifier,HashPFX))
                end
                if CandyCat_Particle.AllowistParticle.Ban then
                    BanSystem({
                        myidentifier = my_identifier,
                        mytable = LOCAL_PLAYER_TABLE[my_identifier],
                        reason = string.format("Player: %s was detected for creating a particle blacklist. hash: %s",my_identifier,HashPFX),
                    })
                end
            end
        end
    end
end)




























