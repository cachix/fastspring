module FastSpring.UnixTimeMiliSpec where

import Data.Aeson
import Test.Hspec

import FastSpring.UnixTimeMili


expected :: UnixTimeMili
expected = UnixTimeMili $ read "2019-02-07 05:54:03 UTC"

spec :: Spec
spec =
  describe "fromJSON instance" $ do
    it "parses unixtime with miliseconds correctly" $
      (decode "1549518843317" :: Maybe UnixTimeMili)
        `shouldBe` Just expected
