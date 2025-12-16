{
  outputs = { self, nixpkgs, flake-utils }:
    (flake-utils.lib.eachDefaultSystem(system:
      let
        pkgs = nixpkgs.legacyPackages.${system};
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
      })
    ) // {
      #
      # Used to make the default development environment in the default template.
      #
      lib.mkShell =
        { pkgs

        , extraPackages ? []
        , shellHookSuffix ? ""

        , ...
        }@args:
        let
          otherArgs = removeAttrs args [ "pkgs" "extraPackages" "shellHookSuffix" ];
        in
        pkgs.mkShell ({
          packages = [
            pkgs.atm-scripts
            pkgs.atm-scripts.postgresql
            pkgs.azure-cli
            pkgs.ipcalc
            pkgs.jq
            pkgs.opentofu
          ] ++ extraPackages;

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

            ${shellHookSuffix}
          '';
        } // otherArgs);

      overlays.default = _: prev: {
        atm-scripts = prev.callPackage ./nix/scripts.nix {};
      };

      templates = {
        default = {
          description = "A template for getting started on a new Azure-based project.";
          path = ./templates/default;
        };
      };
    };
}
