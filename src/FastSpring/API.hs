{-# LANGUAGE DataKinds #-}
{-# LANGUAGE TypeOperators #-}
module FastSpring.API
  ( API
  , api
  ) where

import           Data.Text                      ( Text )
import           Data.Proxy                     ( Proxy(..) )
import           Servant.API

import FastSpring.Event     (Event)
import FastSpring.Signature (Signature)


type API
  = ReqBody '[JSON] [Event]
 :> ReqBody '[JSON] Text -- raw body for signature validation
 :> Header' '[Required, Strict] "X-FS-Signature" Signature
 :> Post '[JSON] NoContent

api :: Proxy API
api = Proxy
