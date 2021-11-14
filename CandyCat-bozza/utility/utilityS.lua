
local ServerCB = {}
local ClientCB = {}
local Cb_Id 	= 0

--Server

RegisterServerCB= function(_,__) 
	ServerCB[_] = __
end

TriggerServerCB = function(_, requestId, source, __, ...)
    print(_, requestId, source, __, ...)
    print(ServerCB[_])
    if ServerCB[_] ~= nil then
        ServerCB[_](source,__,...)
    end
end

RegisterServerEvent('CandyCat:Utility_TS')
AddEventHandler('CandyCat:Utility_TS', function(_,__,...)
    local src = source
    TriggerServerCB(_,requestID, src, function(...)
        TriggerClientEvent('CandyCat:Utility_SC',src,__,...)
    end,...)
end)

--Client

TriggerClientCB = function(source, name, PJ, ...)
    ClientCB[Cb_Id] = PJ
    TriggerClientEvent('CandyCat:Utility_TC',source, name,Cb_Id,...)
    if Cb_Id < 99999 then Cb_Id = Cb_Id + 1 else Cb_Id = 0 end
end
RegisterServerEvent('CandyCat:Utility_CC')
AddEventHandler('CandyCat:Utility_CC', function(_,...)
    ClientCB[_](...)
    ClientCB[_] = nil
end)


