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
import Data.Aeson      (ToJSON(..))
import Data.Text (Text)
import Data.ByteString (ByteString)
import GHC.Generics (Generic)
import Crypto.MAC.HMAC (hmac, HMAC)
import Crypto.Hash.Algorithms (SHA256)
import Servant.API


-- } Key supplied to FastSpring for signing webhook payload
newtype SignatureSecret = SignatureSecret ByteString

-- | Base64 encoded HMAC SHA256 signature of request body
newtype Signature = Signature ByteString
  deriving (Show, Generic)

-- | Useful for logging, serialized as a JSON string
instance ToJSON Signature where
  toJSON (Signature bs) = toJSON (toSL bs :: Text)

-- | Compare two Signatures are equal in constant time
instance Eq Signature where
  (Signature l) == (Signature r) = l `constEq ` r

instance FromHttpApiData Signature where
  parseUrlPiece s = Right $ Signature (toSL s)

-- | Create a signature using the secret and a body.
-- | secret: set in fastspring dashboard
-- | body: whole HTTP body in raw form
create :: SignatureSecret -> ByteString -> Signature
create (SignatureSecret secret) body = Signature $
  Encoding.convertToBase Encoding.Base64 digest
  where
    digest :: HMAC SHA256
    digest = hmac secret body
