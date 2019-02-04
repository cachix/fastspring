{ mkDerivation, aeson, base, bytestring, cryptonite, hspec
, hspec-discover, http-client, http-client-tls, memory, scientific
, servant, stdenv, string-conv, text, time
}:
mkDerivation {
  pname = "fastspring";
  version = "0.1.0.0";
  src = ./.;
  libraryHaskellDepends = [
    aeson base bytestring cryptonite http-client http-client-tls memory
    scientific servant string-conv text time
  ];
  testHaskellDepends = [
    aeson base bytestring cryptonite hspec http-client http-client-tls
    memory scientific servant string-conv text time
  ];
  testToolDepends = [ hspec-discover ];
  homepage = "https://github.com/hercules-ci/fastspring#readme";
  description = "Fastspring API + webhooks";
  license = stdenv.lib.licenses.asl20;
}
