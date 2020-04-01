module FastSpring.Data.AccountURL
  ( AccountURL(..)
  ) where

import           Data.Aeson (FromJSON(..), (.:), withObject)
import           Data.Text (Text)
import           Data.Traversable (for)
import           GHC.Generics (Generic)

import FastSpring.Data.Product (Product)

data AccountURL = AccountURL
  { urls :: [Text]
  } deriving (Generic, Show)

        
instance FromJSON AccountURL where
  parseJSON = withObject "AccountURL" $ \v -> do
    accounts <- v .: "accounts" 
    u <- for accounts $ \account -> do
      -- TODO: error handling
      account .: "url" 
    return $ AccountURL { urls = u }
