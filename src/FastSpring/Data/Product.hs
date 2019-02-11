module FastSpring.Data.Product
  ( Product(..)
  ) where

import           Data.Aeson (FromJSON, ToJSON)
import           Data.Text (Text)
import           GHC.Generics                   (Generic)


data Product = Product
  { product :: Text
  } deriving (Generic, Show, FromJSON, ToJSON)
