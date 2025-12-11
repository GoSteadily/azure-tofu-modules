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

  installPhase =
    let
      commonPackages = [
        jq
        opentofu
      ];
    in
    ''
    mkdir -p "$out/bin"

    install -m644 lib.sh "$out/bin/lib.sh"
    install -m755 save-keys "$out/bin/unwrapped-save-keys"
    install -m755 with-pg-env "$out/bin/unwrapped-with-pg-env"
    install -m755 recreate-vm "$out/bin/unwrapped-recreate-vm"
    install -m755 login "$out/bin/unwrapped-login"

    makeWrapper "$out/bin/unwrapped-save-keys" "$out/bin/save-keys" \
      --prefix PATH : ${lib.makeBinPath commonPackages}

    makeWrapper "$out/bin/unwrapped-with-pg-env" "$out/bin/with-pg-env" \
      --prefix PATH : ${lib.makeBinPath commonPackages}

    makeWrapper "$out/bin/unwrapped-recreate-vm" "$out/bin/recreate-vm" \
      --prefix PATH : ${lib.makeBinPath commonPackages}

    makeWrapper "$out/bin/unwrapped-login" "$out/bin/login" \
      --prefix PATH : ${lib.makeBinPath commonPackages}
  '';
}
