{-# LANGUAGE DataKinds #-}
{-# LANGUAGE DeriveGeneric #-}
{-# LANGUAGE LambdaCase #-}
{-# LANGUAGE TypeOperators #-}

module App where

import           Network.Wai
import           Network.Wai.Handler.Warp
import           Servant
import           System.IO

-- * api
type EchoApi = "echo" :> ReqBody '[ JSON] Int :> Post '[ JSON] Int

itemApi :: Proxy EchoApi
itemApi = Proxy

-- * app

run :: IO ()
run = do
  let port = 3000
      settings =
        setPort port $
        setBeforeMainLoop (hPutStrLn stderr ("listening on port " ++ show port)) $
        defaultSettings
  runSettings settings =<< mkApp

mkApp :: IO Application
mkApp = return $ serve itemApi server

server :: Server EchoApi
server = return
