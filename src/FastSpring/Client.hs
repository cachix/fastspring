module FastSpring.Client
  ( client
  , mkClient
  , runClientM
  , BasicAuthData(..)
  ) where

import Network.HTTP.Client.TLS         ( newTlsManagerWith, tlsManagerSettings )
import           Servant.API
import           Servant.API.Generic
import           Servant.Client hiding (mkClient, client)
import qualified Servant.Client
import           Servant.Client.Generic

import FastSpring.Client.API (fastSpringAPI, FastSpringAPI(..))


-- TODO: mkClient :: BasicAuthData -> ...
client :: FastSpringAPI (AsClientT ClientM)
client = fromServant $ Servant.Client.client fastSpringAPI

mkClient :: ClientM a -> IO (Either ServantError a)
mkClient cmd = do
  manager <- newTlsManagerWith tlsManagerSettings
  let env = Servant.Client.mkClientEnv manager (BaseUrl Https "api.fastspring.com" 443 "")
  (`runClientM` env) cmd
