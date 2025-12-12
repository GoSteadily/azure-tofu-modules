{
  outputs = { self, nixpkgs, flake-utils }:
    (flake-utils.lib.eachDefaultSystem(system:
      let
        pkgs = nixpkgs.legacyPackages.${system};
        scripts = pkgs.callPackage ./nix/scripts.nix {};
      in
      {
        devShells.default = pkgs.mkShell {
          name = "azure-tofu-modules";

          packages = [
            pkgs.opentofu
          ];

          shellHook = ''
            export PS1="($name)\n$PS1"

            alias t=tofu
            alias f='tofu fmt -recursive'
          '';
        };

        #
        # The project development environment
        #
        # It is used as the default development environment by the default template.
        #
        # You can use overrideAttrs to tweak it to your liking.
        #
        # For e.g.
        #
        # devShells.${system}.project.overrideAttrs { name = "..."; }
        #
        # or
        #
        # devShells.${system}.project.overrideAttrs(old: {
        #   nativeBuildInputs = old.nativeBuildInputs ++ [ ... ];
        #   shellHook = old.shellHook + ''
        #   '';
        # })
        #
        # Learn how to use overrideAttrs here: https://nixos.org/manual/nixpkgs/stable/#sec-pkg-overrideAttrs.
        #
        # N.B.: packages end up as nativeBuildInputs. See https://github.com/NixOS/nixpkgs/blob/master/pkgs/build-support/mkshell/default.nix#L49.
        #
        devShells.project = pkgs.mkShell {
          packages = [
            pkgs.azure-cli
            pkgs.ipcalc
            pkgs.jq
            pkgs.opentofu
            pkgs.postgresql_16
            scripts
          ];

          shellHook = ''
            export PROJECT_ROOT="$PWD"
            export PATH="$PROJECT_ROOT/bin:$PATH"
            export PS1="($name)\n$PS1"

            export ATM_PROJECT_ROOT="$PROJECT_ROOT"

            #
            # Put secrets in here
            #
            if [ -f "$PROJECT_ROOT/.envrc" ]; then
              . "$PROJECT_ROOT/.envrc"
            fi

            #
            # Anything else can go in here
            #
            if [ -f "$PROJECT_ROOT/.bashrc" ]; then
              . "$PROJECT_ROOT/.bashrc"
            fi
          '';
        };

        packages.default = scripts;
      })
    ) // {
      templates = {
        default = {
          description = "A template for getting started on a new Azure-based project.";
          path = ./templates/default;
        };
      };
    };
}
