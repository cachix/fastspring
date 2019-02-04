module FastSpring.Settings
  ( Settings(..)
  ) where

import Data.ByteString (ByteString)

data Settings = Settings
  { signatureSecret :: ByteString
  }
