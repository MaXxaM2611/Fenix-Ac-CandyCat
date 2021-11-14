import NextAuth from 'next-auth'
import Providers from 'next-auth/providers'
import TableLogin from '../../../config/login.json'


export default async function auth(req, res) {
  return await NextAuth(req, res, {
    providers: [
      Providers.Credentials({
        name: 'Credentials',
        authorize: async (credentials) => {
         // console.log(credentials)
          if(credentials.username && credentials.password ){
            for (let i = 0; i < TableLogin.length; i++) {
              const login = TableLogin[i];
              if  (login.username === credentials.username && login.password === credentials.password ){
                return {status: 'success', user: {user:login.username ,password:login.password ,token:credentials.csrfToken ,perms: login.permessi}}
              }
            }
            return null
    
          } else{
            return null
          }
        }
      })
    ],
    callbacks: {
      async signIn({ user,status}) {
      },
      jwt: async (token, user, account, profile, isNewUser) => {
          //console.log(JSON.stringify(account) + JSON.stringify(profile) + JSON.stringify(isNewUser))
          user && (token.user = user);
          return Promise.resolve(token)
      },
      session: async (session, user, sessionToken) => {
          session.user = user.user;
         // console.log(session)
          return Promise.resolve(session)
      },
      redirect: async () =>{
        return  "/informazioni"
      }
    },
  });
}