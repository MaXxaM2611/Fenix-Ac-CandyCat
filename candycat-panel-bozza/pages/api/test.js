
import { getSession } from "next-auth/client"

export default async (req, res) => {
  const session = await getSession({ req })
  if(session && session.user.status == "success"){
    res.send({islogged: true, mydata: session})
  }else {
    res.send({islogged: false, mydata: {}})
  }

}