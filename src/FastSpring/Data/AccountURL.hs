module FastSpring.Data.AccountURL
  ( AccountURL(..)
  ) where

import           Data.Aeson (FromJSON, ToJSON)
import           Data.Text (Text)
import           GHC.Generics (Generic)

import FastSpring.Data.Product (Product)

data AccountURL = AccountURL
  { url :: Text
  } deriving (Generic, Show, FromJSON, ToJSON)
