{- https://docs.fastspring.com/integrating-with-fastspring/webhooks#Webhooks-securityMessageSecret/Security
-}
module FastSpring.WebHook.Signature
  ( Signature
  , SignatureSecret(..)
  , create
  ) where

import Data.ByteArray (constEq)
import qualified Data.ByteArray.Encoding as Encoding
import Data.String.Conv               ( toSL )
import Data.ByteString (ByteString)
import Crypto.MAC.HMAC (hmac, HMAC)
import Crypto.Hash.Algorithms (SHA256)
import Servant.API


newtype SignatureSecret = SignatureSecret
  { unwrapSecret :: ByteString}

newtype Signature = Signature
  { unwrap :: ByteString }
  deriving (Show)

instance Eq Signature where
  l == r = unwrap l `constEq ` unwrap r

instance FromHttpApiData Signature where
  parseUrlPiece s = Right $ Signature (toSL s)

-- | secret: set in fastspring dashboard
-- | body: whole HTTP response body
create :: SignatureSecret -> ByteString -> Signature
create SignatureSecret { unwrapSecret=secret } body = Signature $
  Encoding.convertToBase Encoding.Base64 digest
  where
    digest :: HMAC SHA256
    digest = hmac secret body
