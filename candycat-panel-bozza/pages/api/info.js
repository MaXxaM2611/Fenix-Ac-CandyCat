import { getSession } from "next-auth/client"





export default async (req, res) => {
  const session = await getSession({ req })
  if(session && session.user.status == "success"){
    res.send({
        islogged: true, 
        
        data: {
            mylicense: "FenixAC-a1cd0f0633def40aa6ce3cfda2d9c7b772ebbf9e",
            myplane: "infinity",  // infinity | 3mount | 1mount 
            myrole: ["edit_setting","ban_player","unban_player","administrator"],  //"edit_setting","ban_player","unban_player","administrator"
            myservername: "My Server Name",
        }
    })
  }else {
    res.send({islogged: false, data: {}})
  }
}