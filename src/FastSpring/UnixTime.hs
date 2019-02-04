module FastSpring.UnixTime
  ( UnixTime(..)
  ) where

import Data.Aeson (FromJSON(..), withScientific)
import Data.Time.Clock (UTCTime)
import           Data.Time.Clock.System         (systemToUTCTime, SystemTime(..))
import Data.Scientific (coefficient)

-- represents unix time with JSON parsing
newtype UnixTime =
  UnixTime { utctime :: UTCTime }
  deriving (Show)

instance FromJSON UnixTime where
    parseJSON = withScientific "unixtime" $ \i ->
      return $ UnixTime $ systemToUTCTime $ MkSystemTime (fromIntegral ( coefficient i)) 0
