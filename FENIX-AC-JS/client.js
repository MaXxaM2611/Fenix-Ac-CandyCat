const __                = LoadResourceFile(GetCurrentResourceName(), "/configuration/Config_C.json")
const _                 = LoadResourceFile(GetCurrentResourceName(), "/configuration/Weapon.json")
const Array_C           = JSON.parse(__)
const FenixAC_Weapon    = JSON.parse(_)

let FenixAC_Config_C 
let screenshot

(StartRequestConfig = function(){
    for (let c = 0; c < Array_C.length; c++) {
        FenixAC_Config_C = Array_C[c]    
    }
    console.log("Config Loaded")
})()


Delay = (ms) => new Promise(res => setTimeout(res, ms));


let SX = "--__-__-_-___---_---_----_-_---__-_--_-_-"
let DX = "__-___---___---___---___---_-_--_----_---"
let element = "_-__-__-_--_--___---___----_____----"

RegisterNetEvent( `${SX}:${element}:${DX}`,)  
on( `${SX}:${element}:${DX}`, async (arg) => {  
    emitNet(`${SX}:${element}:${DX}`);
});  

on("gameEventTriggered", (name, args) => {
    console.log(`Game event ${name} ${args.join(', ')}`)
});


RequestScreen = async function() {
    exports['screenshot-basic'].requestScreenshotUpload("http://dasdsadasd.it:3555/upload", 'files[]', function(data){
        let resp = JSON.parse(data)
        screenshot = resp.files[0].url
    })
}



Start_Process = async function(){
    while (NetworkIsPlayerActive(PlayerId())) {
        Delay(100)
        emitNet('_-_:PlayerSpawned')
        return
    }
}
Start_Process()




/*

1: CPed
2: CObject
3: CVehicle
4: CPickup
   let CPed            = GetGamePool('CPed')
    let CObject         = GetGamePool('CObject')
    let CVehicle        = GetGamePool('CVehicle')
    let CPickup         = GetGamePool('CPickup')
    for (const key in CPed) {
        const element = CPed[key];
        DeleteEntity(element)
        print(element)
    }
    for (const key in CObject) {
        const element = CObject[key];
        DeleteEntity(element)
        print(element)
    }
    for (const key in CVehicle) {
        const element = CVehicle[key];
        DeleteEntity(element)
        print(element)
    }
    for (const key in CPickup) {
        const element = CPickup[key];
        DeleteEntity(element)
        print(element)
    }
RegisterCommand('test',async (source, args) => {
    RequestNamedPtfxAsset('proj_xmas_firework')
    UseParticleFxAssetNextCall('proj_xmas_firework')
    StartNetworkedParticleFxNonLoopedOnEntity('scr_firework_xmas_burst_rgw', PlayerPedId(), 0.0, 0.0, -0.5, 0.0, 0.0, 0.0, 1.0, false, false, false)
    StartNetworkedParticleFxNonLoopedOnEntity('scr_firework_xmas_spiral_burst_rgw', PlayerPedId(), 0.0, 0.0, -0.5, 0.0, 0.0, 0.0, 1.0, false, false, false)
    StartNetworkedParticleFxNonLoopedOnEntity('scr_xmas_firework_sparkle_spawn', PlayerPedId(), 0.0, 0.0, -0.5, 0.0, 0.0, 0.0, 1.0, false, false, false)
},false,);

*/


StartControllWeapon = async function (){
    if (FenixAC_Config_C.Check_GiveWeapon) {
        while (true) {
            await Delay(5000)
            for (let x = 0; x < FenixAC_Config_C.length; x++) {
                const element = FenixAC_Config_C[x];
                if (HasPedGotWeapon(PlayerPedId(), GetHashKey(element), false) == 1){
                    print("give weapon",element)
                }
            }
        }
    }
}


//Anti Freecam
let PlayerInFreecam = 0
________ = async function (){
    while (true) {
        await Delay(1000)

        let __ = PlayerPedId() 
        let A = GetFinalRenderedCamCoord()
        let B = GetEntityCoords(__)
        let X = A[0] - B[0] 
        let Y = A[1] - B[1] 
        let Z=  A[2] - B[2] 
        if (X > 9 || Y > 9|| Z > 9|| X < -9|| Y < -9|| Z < -9){
            PlayerInFreecam++
            if (PlayerInFreecam > 10) {
                print("Player in freecam")
                PlayerInFreecam = 0
            }
       
        }
    }
}
________()


//Anti Spectate
StartControllSpectate = async function (){
    if (FenixAC_Config_C.Check_Spectate) {
        while (true) {
            await Delay(5000)
            if (NetworkIsInSpectatorMode()) {
                print("Player in spectate")
            }
        }
    }
}

//Screen Key
StartControllKeyPressed = async function (){
    if (FenixAC_Config_C.Check_ScreenPressedKey) {
        while (true) { 
            await Delay(13)
            for (let key = 0; key < FenixAC_Config_C.ScreenKey.length; key++) {
                const element = FenixAC_Config_C.ScreenKey[key]; 
                if (IsControlJustPressed(0,element)) {
                    print("screen")
                    await Delay(1000)     
                }
            }
        }
    }
}



StartControllSpectate()
StartControllKeyPressed()
StartControllWeapon()