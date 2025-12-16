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
            azure-tofu-modules.overlays.default
          ];
        };
      in
      {
        devShells.default = azure-tofu-modules.lib.mkShell {
          inherit pkgs;

          name = "project";
        };
      }
    );
}
