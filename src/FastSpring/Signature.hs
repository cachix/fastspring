{- https://docs.fastspring.com/integrating-with-fastspring/webhooks#Webhooks-securityMessageSecret/Security
-}
module FastSpring.Signature
  ( Signature
  , create
  ) where

import Data.ByteArray (constEq)
import qualified Data.ByteArray.Encoding as Encoding
import Data.String.Conv               ( toSL )
import Data.ByteString (ByteString)
import Crypto.MAC.HMAC (hmac, HMAC)
import Crypto.Hash.Algorithms (SHA256)
import Servant.API

import FastSpring.Settings (Settings(..))

newtype Signature = Signature
  { unwrap :: ByteString }
  deriving (Show)

instance Eq Signature where
  l == r = unwrap l `constEq ` unwrap r

instance FromHttpApiData Signature where
  parseUrlPiece s = Right $ Signature (toSL s)

-- | secret: set in fastspring dashboard
-- | body: whole HTTP response body
create :: Settings -> ByteString -> Signature
create Settings { signatureSecret=secret } body = Signature $
  Encoding.convertToBase Encoding.Base64 digest
  where
    digest :: HMAC SHA256
    digest = hmac secret body
