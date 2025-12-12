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
        pkgs = nixpkgs.legacyPackages.${system};
      in
      {
        devShells.default = azure-tofu-modules.devShells.${system}.project;
      }
    );
}
