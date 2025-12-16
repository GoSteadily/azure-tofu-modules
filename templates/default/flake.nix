{
  inputs = {
    azure-tofu-modules = {
      url = "github:GoSteadily/azure-tofu-modules";
      inputs.nixpkgs.follows = "nixpkgs";
      inputs.flake-utils.follows = "flake-utils";
    };
  };

  outputs = { self, nixpkgs, flake-utils, azure-tofu-modules }:
    flake-utils.lib.eachDefaultSystem(system:
      let
        pkgs = import nixpkgs {
          inherit system;
          overlays = [
            #
            # This overlay adds the `atm-scripts` derivation
            #
            azure-tofu-modules.overlays.default

            #
            # Uncomment to override `atm-scripts` to suit your needs
            #
            # (final: prev: {
            #   atm-scripts = prev.atm-scripts.override {
            #     postgresqlPackage = final.postgresql_17;
            #     withPrefix = "new-prefix";
            #   };
            # })
          ];
        };
      in
      {
        devShells.default = azure-tofu-modules.lib.mkShell {
          inherit pkgs;

          #
          # In addition to the options that pkgs.mkShell takes you can set the following custom options:
          #
          # extraPackages :: [Derivation]
          # extraPackages is used for adding extra derivations to the development shell
          #
          # shellHookSuffix :: String
          # shellHookSuffix is used for appending extra Bash commands to the default shellHook
          #

          #
          # Feel free to change the name of the development shell
          #
          name = "project";
        };
      }
    );
}
