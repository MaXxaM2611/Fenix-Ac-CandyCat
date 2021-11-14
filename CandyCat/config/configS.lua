


CandyCat_S = {

    LogSystemActive = true,
    LogSystem = "https://discord.com/api/webhooks/908087045539381278/t-nPL2MF3rY94Ycggr15o4FZXNeyC5JLjAvMW8ldv7JEric3k0i0xrXbaWQPEDTcaNfJ",
    
    LogConnectingActive = true,
    LogConnecting = "https://discord.com/api/webhooks/908087045539381278/t-nPL2MF3rY94Ycggr15o4FZXNeyC5JLjAvMW8ldv7JEric3k0i0xrXbaWQPEDTcaNfJ",



    ClientSide = {
        ImageUpload = "https://discord.com/api/webhooks/908087045539381278/t-nPL2MF3rY94Ycggr15o4FZXNeyC5JLjAvMW8ldv7JEric3k0i0xrXbaWQPEDTcaNfJ",
        
        AntiTazePlayer = {
            Enable = true
        },

        WarnGiveWeapon = true,

        BlacklistWeapon = {
            "WEAPON_PISTOL"
        },

        AntiSpectate =true

    },

    BanSystem = {

        BanForToken     = true,

        RefreshBanTable = {

            EnableIdentifier    = true,

            license     = true,
            steam       = true,
            discord     = true,
            ip          = true,
            live        = true,
            xbox        = true,
            fivem       = true,

            EnableToken     = true,

        },

        KickMessage = "You have been banned from this server!"

    },

    Misc = {

        WhitelistCountry = {

            Enable = true,

            KickMessage = "Error. your country is blacklisted, contact the server owner to resolve",

            List = {

                ["IT"] = true,

            }
        },

        AntiVPN = {

            Enable = true,

            KickMessage = "Error, please disable the VPN to join the server",

        },

        BlacklistName = {

            Enable = true,

            KickMessage = "Your name contains words or blacklist characters, change it if you want to join the server",

            TableBlacklistName = {
    
                "%^1", "%^2", "%^3", "%^4", "%^5", "%^6", "%^7", "%^8", "%^9","%^%*", "%^_", "%^=", "%^%~", --[[Do not delete]] 
    
                "admin", "nigga","nigger",
                "fuckyou","candycat",
                "eulen","desudo","mixas"
            },
    

        },


        Requiredidentifiers = {

            Enable = true,

            steam = {
                Enable = false,
                KickMessage = "You must have the steam account connected to fivem to be able to access the server"
            },
            discord = {
                Enable = false,
                KickMessage = "You must have the discord account connected to fivem to be able to access the server"
            },
            live = {
                Enable = false,
                KickMessage = "You must have the live account connected to fivem to be able to access the server"
            },
            xbox = {
                Enable = false,
                KickMessage = "You must have the xbox account connected to fivem to be able to access the server"
            },
            fivem = {
                Enable = false,
                KickMessage = "You must have the fivem account connected to fivem to be able to access the server"

            },

        }

    }

}
