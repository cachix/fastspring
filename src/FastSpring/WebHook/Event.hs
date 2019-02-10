module FastSpring.WebHook.Event
  ( Events(..)
  , Event(..)
  , EventParsingError(..)
  , EventData(..)
  , parse
  ) where

import           Data.Aeson                     ( FromJSON(..), Result(..)
                                                , fieldLabelModifier, genericParseJSON
                                                , defaultOptions, fromJSON, Value
                                                )
import           Data.String.Conv               ( toSL )
import           Data.Text                      ( Text )
import           GHC.Generics                   (Generic)

import FastSpring.UnixTimeMilliSeconds (UnixTimeMilliSeconds)


newtype Events = Events
  { events :: [Event]
  } deriving (Generic, Show, FromJSON)


data Event = Event
  { _id :: Text
  -- ^ Unique ID of the event.
  , _live :: Bool
  -- ^ Whether this event is for live data instead of test data.
  , _processed :: Bool
  -- ^ Whether this event has been marked processed. For a new event this will always be false.
  , _created :: UnixTimeMilliSeconds
  -- ^ Timestamp for when the event was created.
  , _type :: Text
  , _data :: Value
  -- ^ Varies per event, combined from type and data keys in JSON
  }
  deriving (Generic, Show)

instance FromJSON Event where
  parseJSON =
    genericParseJSON
      defaultOptions
      { fieldLabelModifier = drop 1 }

data EventData
  = SubscriptionActivated SubscriptionActivatedData
  | SubscriptionDeactivated SubscriptionDeactivatedData
  deriving (Generic, Show)

data SubscriptionActivatedData = SubscriptionActivatedData
  { foobar :: Text
  } deriving (Generic, Show, FromJSON)

data SubscriptionDeactivatedData = SubscriptionDeactivatedData
  { foobar2 :: Text
  } deriving (Generic, Show, FromJSON)

data EventParsingError
  = UnknownEvent Text
  | FailedToParse Text

-- | TODO: implement parsing
parse :: Event -> Either EventParsingError EventData
parse event =
  case _type event of
      --"subscription.deactivated" -> SubscriptionDeactivated <$> parseData
      --"subscription.activated" -> SubscriptionActivated <$> parseData
      unknown -> Left $ UnknownEvent $ "type " <> toSL unknown <> " no supported yet"
  where
    parseData :: FromJSON a => Either EventParsingError a
    parseData = resultToEither $ fromJSON (_data event)

    resultToEither :: Result a -> Either EventParsingError a
    resultToEither (Error s) = Left $ FailedToParse (toSL s)
    resultToEither (Success val) = Right val
