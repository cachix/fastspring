{-# LANGUAGE CPP #-}
module FastSpring.Client
  ( client
  , runClient
  , BasicAuthData(..)
  ) where

import           Network.HTTP.Client ( Manager )
import           Servant.API
import           Servant.API.Generic
import           Servant.Client hiding (mkClient, client)
import qualified Servant.Client
import           Servant.Client.Generic

import FastSpring.Client.API (fastSpringAPI, FastSpringAPI(..))

#if !MIN_VERSION_servant_client(0,16,0)
#define ClientError ServantError
#endif


-- TODO: mkClient :: BasicAuthData -> ...
client :: FastSpringAPI (AsClientT ClientM)
client = fromServant $ Servant.Client.client fastSpringAPI

runClient :: Manager -> ClientM a -> IO (Either ClientError a)
runClient httpmanager cmd = do
  (`runClientM` env) cmd
  where
    env :: ClientEnv
    env = Servant.Client.mkClientEnv httpmanager (BaseUrl Https "api.fastspring.com" 443 "")
