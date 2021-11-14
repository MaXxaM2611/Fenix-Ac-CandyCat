//#region  IMPORT
import { useSession, signIn, signOut } from "next-auth/client"
import React, { useEffect, useState } from "react";
import Router from "next/router"
import Image from 'next/image'
import Sidebar from '../component/sidebar';
//#endregion


//#region ESEMPIO DATI SERVER: 
/*
{
  islogged: true, 
  data: {
      mylicense: "FenixAC-a1cd0f0633def40aa6ce3cfda2d9c7b772ebbf9e",
      myplane: "infinity",  // infinity | 3mount | 1mount 
      myrole: ["edit_setting","ban_player","unban_player","administrator"],  //"edit_setting","ban_player","unban_player","administrator"
      myservername: "My Server Name",
  }
*/
//#endregion



export default function Informazioni() {

  //#region  CONST
  //const [session, loading]      = useSession()
  const [navbar, SetNavbar]     = useState(true)
  const [username, SetUsername] = useState("")
  const [plane, Setplane]       = useState("")
  const [license, SetLicense]   = useState("")
  const [roles, SetRoles]       = useState([])
  //#endregion  

  React.useEffect(() => {
    fetch(`${process.env.NEXTAUTH_URL}/api/info`)
    .then(response => response.json())
    .then(respons => {
      if(respons.islogged){
        if (respons.data.myrole){
          let ListPerms = []
          for (let i = 0; i < respons.data.myrole.length; i++) {
            const element = respons.data.myrole[i];
            if(element == "edit_setting") {
              ListPerms.push({name: "Edit Settings",hasRole: true,description: "Edit all the settings of the Anticheat."})
            }
            if(element == "ban_player") {
              ListPerms.push({name: "Ban Player",hasRole: true,description: "Ban a Player from the players list."})
            }
            if(element == "unban_player") {
              ListPerms.push({name: "Unban Player",hasRole: true,description: "Unban a Player from the bans list."})
            }
            if(element == "administrator") {
              ListPerms.push({name: "Administrator",hasRole: true,description: "Congratulations, you can do EVERYTHING."})
            }
          }
          SetRoles(ListPerms)
        }
        SetUsername(respons.data.myservername)
        Setplane(respons.data.myplane)
        SetLicense(respons.data.mylicense)
      }else{
        Router.push("/")
      }
    });

    if (window.innerWidth < 750) {
      SetNavbar(false)
    }
  }, []);

  let list = [];
  for (let i in roles) {
    if (roles[i].hasRole) {
      list.push(
        <div class="role">
          {/*  <img src="https://img.icons8.com/color/96/000000/checked-2--v1.png" /> */}
          <svg class="checkboxtrue" width="35" height="27" viewBox="0 0 35 27" fill="none" xmlns="http://www.w3.org/2000/svg">
            <path d="M35 2.99999L11 27L0 16L2.82 13.18L11 21.34L32.18 0.179993L35 2.99999Z" fill="#242832" />
          </svg>
          <h3>{roles[i].name}<br /><span class="para">{roles[i].description}</span></h3>
        </div>
      )
    } else {
      list.push(
        <div class="role">
          {/* <img src="https://img.icons8.com/color/96/000000/close-window.png" /> */}
          <svg class="checkboxfalse" width="28" height="28" viewBox="0 0 28 28" fill="none" xmlns="http://www.w3.org/2000/svg">
            <path d="M28 2.82L25.18 0L14 11.18L2.82 0L0 2.82L11.18 14L0 25.18L2.82 28L14 16.82L25.18 28L28 25.18L16.82 14L28 2.82Z" fill="#242832" />
          </svg>
          <h3>{roles[i].name}<br /><span class="para">{roles[i].description}</span></h3>
        </div>
      )
    }
  }

  return (
    <>
      <a className={"button-login"} onClick={() => signOut({ callbackUrl: "http://localhost:3000/" })}>
        ACCEDI
      </a>
      {navbar &&
        <div>
          <Sidebar />
          <div class="normal-container">
            <h1 class="title">Welcome back, {username}</h1>
            <div class="grids-container">

              <div class="firstgridcontainer">
                <div class="firstgrid">
                  <h1>License</h1>
                  <p>Hover to unblur</p>
                  <h3 class="license">{license}</h3>
                </div>
                <div class="firstgrid">
                  <div class="titless">
                    <div class="rightspacer"></div>
                    <h1 className="othenplanes">Other Planes</h1>
                    <h1 className="curr">Current Plane</h1>
                  </div>
                  <p style={{ opacity: '0' }}>Hover to unblur</p>
                  <div style={{ justifyContent: 'space-between' }}>
                    <div class="planes">
                      <div class="first">
                        <div class="infinity">
                          <img class="imageicon" src="https://cdn.discordapp.com/attachments/886609467456749578/888475885395640390/1f36c.png" width="60px" />
                        </div>
                        <h3 class="plan-name" style={{ paddingLeft: '20px' }}>Infinity</h3>
                      </div>
                      <div class="second">
                        <div class="threemonths">
                          <svg style={{ marginLeft: '22px', marginTop: '22px' }} class="imageicon" width="48" height="46" viewBox="0 0 48 46" fill="none" xmlns="http://www.w3.org/2000/svg">
                            <path d="M24 36.9695L38.832 46L34.896 28.98L48 17.5284L30.744 16.0274L24 0L17.256 16.0274L0 17.5284L13.08 28.98L9.168 46L24 36.9695Z" fill="#DFDFDF" />
                          </svg>
                        </div>
                        <h3 class="plan-name">3 Months</h3>
                      </div>
                      <div class="third">
                        <div class="onemonth">
                          <svg style={{ marginLeft: '24px', marginTop: '22px' }} class="imageicon" width="44" height="51" viewBox="0 0 44 51" fill="none" xmlns="http://www.w3.org/2000/svg">
                            <path d="M5.08337 50.0833C1.89337 50.0833 0.612538 44.2817 0.346704 41.9708C0.0605164 39.7273 0.326239 37.4466 1.12004 35.3333C1.46892 34.3277 2.06902 33.4318 2.86136 32.7335C3.6537 32.0353 4.61101 31.5588 5.6392 31.3508C8.4667 30.8592 10.4725 32.58 13.0342 33.17C13.5154 33.3271 14.0284 33.3547 14.5232 33.25C15.018 33.1453 15.4777 32.912 15.8574 32.5728C16.2371 32.2335 16.5239 31.8 16.6899 31.3144C16.8558 30.8288 16.8952 30.3078 16.8042 29.8021C15.7409 25.5738 8.1767 25.5 5.08337 25.5C5.08337 20.9275 10.0134 20.3375 13.5417 20.6817C15.6349 20.8873 17.6959 21.3496 19.68 22.0583C20.8884 22.4763 22.29 23.5333 23.6192 23.435C25.625 23.2629 26.0359 21.1488 25.1659 19.6C23.0634 15.9617 17.0942 15.6667 13.5417 15.6667C13.5417 10.75 17.7225 9.81583 21.7342 10.5533C23.8056 10.9677 25.8243 11.6192 27.7517 12.4954C28.9842 13.0363 30.4584 14.0688 31.8117 13.6017C35.2917 12.52 31.6667 8.73417 30.12 7.82458C29.0345 7.21525 27.8828 6.73674 26.6884 6.39875C25.3834 6.00542 23.7884 6.15292 24.9725 4.60417C26.8242 2.94237 29.1215 1.88091 31.57 1.55583C36.1375 0.474167 42.445 0.277499 43.5567 6.12833C43.9271 9.21735 43.1985 12.3392 41.5025 14.9292C37.0003 22.763 31.4266 29.9062 24.9484 36.1446C21.5171 39.7226 17.7987 43.0035 13.8317 45.9533C11.415 47.7233 8.22504 50.0833 5.08337 50.0833Z" fill="#DFDFDF" />
                          </svg>
                        </div>
                        <h3 class="plan-name" style={{ paddingLeft: '43px' }}>1 Month</h3>
                      </div>
                    </div>
                    <div class="yourplane">
                    </div>
                  </div>
                </div>
              </div>
              <div class="secondgrid">
                <h1>My Roles:</h1>
                <div class="role-container">
                  {list}
                </div>
              </div>
            </div>
          </div>
        </div>
      }

      {!navbar &&
        <div>
          <Sidebar />
          <div class="withnav-container">
            <h1 class="title">Welcome back, {username}</h1>
            <div class="grids-container" style={{ marginLeft: '-28px' }}>
              <div class="firstgridcontainer">
                <div class="firstgrid">
                  <h1>License</h1>
                  <p>Hover to unblur</p>
                  <h3 class="license">{license}</h3>
                </div>
                <div class="firstgrid">
                  <h1>License</h1>
                  <p>Hover to unblur</p>
                  <h3 class="license">{license}</h3>
                </div>
              </div>
              <div class="secondgrid">
                <h1>My Role:</h1>
                <div class="role-container">
                  {list}
                </div>
              </div>
            </div>
          </div>
        </div>
      }

    </>
  )
}