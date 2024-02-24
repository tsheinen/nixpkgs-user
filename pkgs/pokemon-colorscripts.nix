{ lib
, stdenv
, coreutils
, fetchFromGitLab
}:

stdenv.mkDerivation rec {
  pname = "pokemon-colorscripts";
  version = "main";

  src = fetchFromGitLab {
    owner = "phoneybadger";
    repo = "${pname}";
    rev = "0483c85b93362637bdd0632056ff986c07f30868";
    sha256 = "06b86qy2fpzdd81n2mscc2njkrxx0dyzxpgnm1xk6ldn17c853lc";
  };

  buildInputs = [ coreutils ];

  preBuild = ''
    patchShebangs ./install.sh

    # Fix hardcoded prefixed coreutils
    substituteInPlace pokemon-colorscripts.sh --replace greadlink readlink
    substituteInPlace pokemon-colorscripts.sh --replace gshuf shuf

    substituteInPlace install.sh --replace /usr/local $out
  '';

  installPhase = ''
    runHook preInstall

    mkdir -p $out/opt
    mkdir -p $out/bin
    ./install.sh

    runHook postInstall
  '';

  meta = with lib; {
    description = "Pokémon colorscripts for the terminal, compatible for mac";
    longDescription = ''
      Show colored sprites of pokémons in your terminal.
      Contains almost 900 pokemon from gen 1 to gen 8.
      Inspired by DT's colorscripts.
    '';
    homepage = "https://github.com/nuke-dash/pokemon-colorscripts-mac";
    license = licenses.mit;
    maintainers = [ maintainers.wesleyjrz ];
    platforms = platforms.unix;
  };
}
