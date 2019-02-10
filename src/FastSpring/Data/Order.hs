module FastSpring.Data.Order
  ( Order(..)
  ) where

import           Data.Aeson (FromJSON)
import           Data.Text (Text)
import           GHC.Generics                   (Generic)

import FastSpring.Data.Product (Product)

data Order = Order
  { account :: Text
  , live :: Bool
  , result :: Text
  , items :: [Product]
  } deriving (Generic, Show, FromJSON)
