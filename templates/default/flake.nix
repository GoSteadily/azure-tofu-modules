{
  inputs = {
    azure-tofu-modules = {
      url = "github:GoSteadily/azure-tofu-modules?ref=add-bash-scripts";
      inputs.nixpkgs.follows = "nixpkgs";
      inputs.flake-utils.follows = "flake-utils";
    };
  };

  outputs = { self, nixpkgs, flake-utils, azure-tofu-modules }:
    flake-utils.lib.eachDefaultSystem(system:
      let
        pkgs = nixpkgs.legacyPackages.${system};
      in
      {
        devShells.default = pkgs.mkShell {
          #
          # N.B. Feel free to change the name.
          #
          name = "azure-iac";

          packages = [
            pkgs.azure-cli
            pkgs.ipcalc
            pkgs.jq
            pkgs.opentofu
            pkgs.postgresql_16

            azure-tofu-modules.packages.${system}.default
          ];

          shellHook = ''
            export PROJECT_ROOT="$PWD"
            export PATH="$PROJECT_ROOT/bin:$PATH"
            export PS1="($name)\n$PS1"

            export ATM_PROJECT_ROOT="$PROJECT_ROOT"

            if [ -f "$PROJECT_ROOT/.envrc" ]; then
              . "$PROJECT_ROOT/.envrc"
            fi

            # Useful for any local changes you want to make
            if [ -f "$PROJECT_ROOT/.bashrc" ]; then
              . "$PROJECT_ROOT/.bashrc"
            fi
          '';
        };
      }
    );
}
