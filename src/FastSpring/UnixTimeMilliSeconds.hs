module FastSpring.UnixTimeMilliSeconds
  ( UnixTimeMilliSeconds(..)
  ) where

import Data.Aeson              ( FromJSON(..), withScientific )
import Data.Time.Clock         ( UTCTime )
import Data.Time.Clock.System  ( systemToUTCTime, SystemTime(..) )


-- | Represents unix time in miliseconds.
-- | Used by FastSpring HTTP API in JSON responses.
newtype UnixTimeMilliSeconds =
  UnixTimeMilliSeconds { utctime :: UTCTime }
  deriving (Show, Eq)

instance FromJSON UnixTimeMilliSeconds where
    parseJSON = withScientific "unixtime" $ \i ->
      return $ UnixTimeMilliSeconds $ systemToUTCTime
        $ MkSystemTime (fromIntegral (floor (i / 1000) :: Integer)) 0
