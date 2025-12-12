{ lib, makeWrapper, stdenv

, jq, opentofu, postgresql_16

, withPrefix ? "atm"
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

      isEmpty = s: s == null || (builtins.isString s && s == "");
      prefix = s: if isEmpty withPrefix then s else withPrefix + "-" + s;
    in
    ''
    mkdir -p "$out/bin"

    install -m644 lib.sh "$out/bin/lib.sh"

    install -m755 install-nixos "$out/bin/unwrapped-install-nixos"
    install -m755 login "$out/bin/unwrapped-login"
    install -m755 recreate-vm "$out/bin/unwrapped-recreate-vm"
    install -m755 restore-db "$out/bin/unwrapped-restore-db"
    install -m755 save-keys "$out/bin/unwrapped-save-keys"
    install -m755 with-pg-env "$out/bin/unwrapped-with-pg-env"

    makeWrapper "$out/bin/unwrapped-install-nixos" "$out/bin/${prefix "install-nixos"}" \
      --prefix PATH : ${lib.makeBinPath commonPackages}

    makeWrapper "$out/bin/unwrapped-login" "$out/bin/${prefix "login"}" \
      --prefix PATH : ${lib.makeBinPath commonPackages}

    makeWrapper "$out/bin/unwrapped-recreate-vm" "$out/bin/${prefix "recreate-vm"}" \
      --prefix PATH : ${lib.makeBinPath commonPackages}

    makeWrapper "$out/bin/unwrapped-restore-db" "$out/bin/${prefix "restore-db"}" \
      --prefix PATH : ${lib.makeBinPath (commonPackages ++ [ postgresql_16 ])}

    makeWrapper "$out/bin/unwrapped-save-keys" "$out/bin/${prefix "save-keys"}" \
      --prefix PATH : ${lib.makeBinPath commonPackages}

    makeWrapper "$out/bin/unwrapped-with-pg-env" "$out/bin/${prefix "with-pg-env"}" \
      --prefix PATH : ${lib.makeBinPath commonPackages}
  '';
}
