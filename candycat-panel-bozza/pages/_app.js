import { Provider } from "next-auth/client";
import React, { useEffect } from "react";
import { ChakraProvider } from "@chakra-ui/react"

import '../styles/App.css'
import '../styles/Dashboard.css'
import '../styles/globals.css'
import '../styles/Login.css'
import '../styles/Sidebar.css'
import '../styles/Grids.css'

import 'material-icons/iconfont/material-icons.css';



export default function App({ Component, pageProps }) {

  return (
      <Provider session={pageProps.session}>
        <Component {...pageProps} />
      </Provider>
  );

}