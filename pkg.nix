{ mkDerivation, aeson, base, bytestring, cryptonite, exceptions
, hspec, hspec-discover, http-client, http-client-tls
, markdown-unlit, memory, scientific, servant, servant-client
, servant-client-core, servant-server, stdenv, string-conv, text
, time
}:
mkDerivation {
  pname = "fastspring";
  version = "0.1.0.0";
  src = ./.;
  libraryHaskellDepends = [
    aeson base bytestring cryptonite http-client memory scientific
    servant servant-client servant-client-core string-conv text time
  ];
  testHaskellDepends = [
    aeson base bytestring cryptonite exceptions hspec http-client
    http-client-tls memory scientific servant servant-client
    servant-client-core servant-server string-conv text time
  ];
  testToolDepends = [ hspec-discover markdown-unlit ];
  homepage = "https://github.com/hercules-ci/fastspring#readme";
  description = "Fastspring API + webhooks";
  license = stdenv.lib.licenses.asl20;
}
