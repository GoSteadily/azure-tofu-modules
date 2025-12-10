{ lib, makeWrapper, stdenv

, jq, opentofu
}:

stdenv.mkDerivation {
  name = "atm-scripts";
  src = ../bin;

  nativeBuildInputs = [
    makeWrapper
  ];

  dontBuild = true;

  installPhase = ''
    mkdir -p "$out/bin"

    install -m644 lib.sh "$out/bin/lib.sh"
    install -m755 save-keys "$out/bin/unwrapped-save-keys"

    makeWrapper "$out/bin/unwrapped-save-keys" "$out/bin/save-keys" \
      --prefix PATH : ${lib.makeBinPath [ jq opentofu ]}
  '';
}
