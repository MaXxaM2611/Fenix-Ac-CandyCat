//#region  IMPORT

import { useSession, signIn, signOut } from "next-auth/client"
import React, { useEffect, useState } from "react";
import { SidebarData } from "./SidebarDatas";

import Router from "next/router"
import { Image } from "@chakra-ui/react"


//#endregion


//#region ASSETS
import Logo from '../assets/CandyCat.png'

//#endregion

export default function Component() {
  const [session, loading] = useSession()
  const [displayNav, SetdisplayNav] = useState(true)


  useEffect(() => {
    if (window.innerWidth < 912) {
      SetdisplayNav(false)
    }
    if (session) {
      Router.push('/informazioni')
    }
  }, []);


  function handleMenu() {
    SetdisplayNav(!displayNav);
  };

  function redirect(link) {
    Router.push(link)
  }

  return (
    <>
      {/* {displayNav && (
        <MenuIcon onClick={() => handleMenu()} className="hamburger" />
      )}
      {!displayNav && (
        <MenuIcon onClick={() => handleMenu()} className="hamburger2" />
      )} */}
      {displayNav && (
        <div className="Sidebar">
          <React.Fragment>
            <Image className="sidebarimage" src="https://i.imgur.com/uKy7x0A.png" />
            <ul className="SidebarList">
              {SidebarData.map((val, key) => {
                return (/* 
                  <Link
                    to={{ pathname: val.link, state: "flushDeal" }}
                    style={{ textDecoration: "none" }}
                  > */
                  <li
                    onClick={() => redirect(val.link)}
                    key={key}
                    className="SidebarRow"
                  >
                    <div id="icon">{val.icon}</div>
                    <div id="title">{val.title}</div>
                  </li>
                );
              })}
            </ul>
          </React.Fragment>
        </div>
      )}
      {/* {!displayNav && (
        <div class="normalcontainer">
          <Route exact={true} path="/listaplayer" render={(props) => <Dashboard />} />
        </div>
      )}
      {displayNav && (
        <div class="with-navbar-container">
          <Route exact={true} path="/listaplayer" render={(props) => <Dashboard />} />
        </div>
      )} */}
    </>
  )
}