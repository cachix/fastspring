# FastSpring API/Webhooks for Haskell

[![Hackage](https://img.shields.io/hackage/v/fastspring.svg)](https://hackage.haskell.org/package/fastspring)

## Getting started with Webhooks

Implements [FastSpring Webhooks](https://docs.fastspring.com/integrating-with-fastspring/webhooks)
using Servant Server.

```haskell
import Data.Aeson (eitherDecode)
import Data.ByteString (ByteString)
import Data.ByteString.Lazy (fromStrict)
import Control.Monad (unless, forM_)
import Control.Monad.Catch (throwM)
import Control.Monad.IO.Class (liftIO)
import Servant

import FastSpring


secret :: SignatureSecret
secret = SignatureSecret "foobar"

webhook :: ByteString -> Signature -> Handler NoContent
webhook body signature = do
  -- verify that fastspring signature matches
  unless (FastSpring.create secret body == signature) $ throwM err400

  liftIO $ case eitherDecode (fromStrict body) of
    Left err ->
      print err
    Right (Events { events=events}) ->
      forM_ events $ \event ->
        case FastSpring.parse event of
          Right (SubscriptionActivated payload) -> print payload
          Left (FailedToParse err) -> print err
          Left (UnknownEvent unknownevent) -> print unknownevent
  return NoContent
```

And hook up your servant server to `webhook` endpoint.

## Getting started with the API

Implements [FastSpring API](http://docs.fastspring.com/integrating-with-fastspring/fastspring-api)
using Servant Client.

```haskell
main :: IO ()
main = do
  orderOrErr <- mkClient $ orderGet client (BasicAuthData "user" "password") "order-id"
  case orderOrErr of
    Right order -> print order
    Left err -> print err
```
