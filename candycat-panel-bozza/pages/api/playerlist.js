import { getSession } from "next-auth/client"





export default async (req, res) => {
  const session = await getSession({ req })
  if(session && session.user.status == "success"){
    res.send({islogged: true, data:[

        {name: "Salvo lo scucciato",    identifier:["diocane:123456","diocane:123456","diocane:123456"]},
        {name: "Ture lo scucciato",     identifier:["diocane:123456","diocane:123456","diocane:123456"]}

    ]})
  }else {
    res.send({islogged: false, data: {}})
  }
}