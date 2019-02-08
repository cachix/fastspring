{-# LANGUAGE MultiParamTypeClasses #-}
module FastSpring.RawMimetype
  ( RawJSON
  ) where

import Servant.API
import Data.Proxy
import Data.ByteString (ByteString)


-- TODO: Raw parametrized by content type, upstream
data RawJSON

instance MimeUnrender RawJSON ByteString where
    mimeUnrender _ = mimeUnrender (Proxy :: Proxy OctetStream)

instance Accept RawJSON where
    contentTypes _ = contentTypes (Proxy :: Proxy JSON)
