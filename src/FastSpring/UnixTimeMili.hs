module FastSpring.UnixTimeMili
  ( UnixTimeMili(..)
  ) where

import Data.Aeson              ( FromJSON(..), withScientific )
import Data.Time.Clock         ( UTCTime )
import Data.Time.Clock.System  ( systemToUTCTime, SystemTime(..) )


-- represents unix time in miliseconds
newtype UnixTimeMili =
  UnixTimeMili { utctime :: UTCTime }
  deriving (Show, Eq)

instance FromJSON UnixTimeMili where
    parseJSON = withScientific "unixtime" $ \i ->
      return $ UnixTimeMili $ systemToUTCTime $ MkSystemTime (fromIntegral (floor (i / 1000))) 0
