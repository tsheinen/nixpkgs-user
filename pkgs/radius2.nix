{ lib
, stdenv
, fetchFromGitHub
, rustPlatform
, openssl
, elfutils
, coreutils
, makeBinaryWrapper
, pkg-config
, xz
, fetchCrate
, boolector
}:

rustPlatform.buildRustPackage rec {
  pname = "radius2";
  version = "1.0.26";

  src = fetchCrate {
    inherit pname version;
    hash = "sha256-00V9avcMyNjt3Cg02VIPtwOzzafU+MVNBAcSE7XtHOc=";
  };
  cargoDeps = rustPlatform.fetchCargoTarball {
    inherit src;
    hash = "sha256-BoHIN/519Top1NUBjpB/oEMqi86Omt3zTQcXFWqrek0=";
  };

  buildInputs = [ openssl xz boolector ];
  nativeBuildInputs = [ pkg-config makeBinaryWrapper ];
  preConfigure = ''
    substituteInPlace /build/${pname}-${version}-vendor.tar.gz/boolector-sys/build-vendor.rs --replace '/usr/bin/env' '${lib.getBin coreutils }/bin/env/'
    # exit 1
  '';

  doCheck = false; # there are no tests to run

  cargoSha256 = "sha256-2nV1o86JaCNPayt/Pa+pcMIVkvpfznc1P/5Wlfr8xmc=";

  meta = {
    description = "Automate starting binary exploit challenges";
    homepage = "https://github.com/io12/pwninit";
    license = lib.licenses.mit;
    maintainers = [ lib.maintainers.scoder12 ];
    platforms = lib.platforms.all;
  };
}
