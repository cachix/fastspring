{-# LANGUAGE DataKinds #-}
{-# LANGUAGE TypeOperators #-}
module FastSpring.Client.API
  ( FastSpringAPI(..)
  , fastSpringAPI
  ) where

import           Data.Proxy                     ( Proxy(..) )
import           Data.Text (Text)
import           Servant.API
import           Servant.API.Generic

import           FastSpring.Data.Order (Order)


-- TODO: https://github.com/haskell-servant/servant-auth/issues/140
--type FastSpringAuth = Auth '[BasicAuth] ()
type FastSpringAuth = BasicAuth "FastSpring" ()

data FastSpringAPI route = FastSpringAPI
  { orderGet :: route :-
                FastSpringAuth :>
                "orders" :>
                Capture "order-id" Text :>
                Get '[JSON] Order
  } deriving (Generic)

fastSpringAPI :: Proxy (ToServantApi FastSpringAPI)
fastSpringAPI = genericApi (Proxy :: Proxy FastSpringAPI)
