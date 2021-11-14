
local ServerCB = {}
local ClientCB = {}
local Cb_Id 	= 0


--Server

TriggerServerCB = function(_,__,...)
    ServerCB[Cb_Id] = __
    TriggerServerEvent('CandyCat:Utility_TS', _,Cb_Id, ...)
    if Cb_Id < 99999 then Cb_Id = Cb_Id + 1 else Cb_Id = 0 end
end

RegisterNetEvent('CandyCat:Utility_SC')
AddEventHandler('CandyCat:Utility_SC',function(_, ...)
    ServerCB[_](...)
    ServerCB[_] = nil
end)

--Client

RegisterNetEvent('CandyCat:Utility_TC')
AddEventHandler('CandyCat:Utility_TC', function(_, __, ...)
    local src = source
    TriggerClientCB(_,requestID,src,function(...)
        TriggerServerEvent('CandyCat:Utility_CC',__,...)
    end,...)
end)

RegisterClientCB =function(_, __) 
	ClientCB[_] = __ 
end

TriggerClientCB = function(_,requestId,source,__,...)
    if ClientCB[_] ~= nil then
        ClientCB[_](__,...)
    end
end

