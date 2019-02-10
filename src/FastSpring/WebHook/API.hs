{-# LANGUAGE DataKinds #-}
{-# LANGUAGE TypeOperators #-}
module FastSpring.WebHook.API
  ( API
  , api
  ) where

import           Data.ByteString                ( ByteString )
import           Data.Proxy                     ( Proxy(..) )
import           Servant.API

import FastSpring.WebHook.Signature (Signature)
import FastSpring.RawMimetype (RawJSON)


type API
    = ReqBody '[RawJSON] ByteString -- raw body for signature validation
   :> Header' '[Required, Strict] "X-FS-Signature" Signature
   :> Post '[JSON] NoContent

api :: Proxy API
api = Proxy
