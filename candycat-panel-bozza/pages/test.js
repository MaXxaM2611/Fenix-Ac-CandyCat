//#region  IMPORT

import { useSession, signIn, signOut } from "next-auth/client"
import React, { useEffect, useState } from "react";
import Router from "next/router"
import Image from 'next/image'

//#endregion

/*

    fetch(`${process.env.NEXTAUTH_URL}/api/test`)
    .then(response => response.json())
    .then(data => {
      if (data.islogged){
        Router.push('/informazioni')
      }
    });

*/


//#region ASSETS
import Logo from '../assets/CandyCat.png'

//#endregion

export default function Component() {
  const [session, loading] = useSession()
  const [username, SetUsername] = useState("")
  const [password, SetPassword] = useState("")

  useEffect(() => {

  },[]);

  function handleName(e) {
    SetUsername(e.target.value);
  }

  function handlePassword(e) {
    SetPassword(e.target.value);
  }


  return (
    <>
      <div className={"login-form animate__animated animate__bounceIn"}>
        <div className={"negro animate__animated animate__fadeIn"}>
          <Image src={Logo} />
        </div>
        <div className={"input-container"}>
          <h6>USERNAME:</h6>
          <input type="text" className="css-input" onChange={(e) => handleName(e)} />
          <h6 style={{ marginTop: '15px' }}>PASSWORD:</h6>
          <input
            type="password"
            className="css-input"
            onChange={(e) => handlePassword(e)}
          />
          <br />
          <a className={"button-login"} onClick={() => signIn("credentials", { username: username, password: password })}>
            ACCEDI
          </a>
        </div>
      </div>
    </>
  )
}



