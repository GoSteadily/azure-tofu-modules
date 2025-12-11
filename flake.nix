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
            export PS1="($name) $PS1"
          '';
        };

        packages.default = pkgs.callPackage ./nix/scripts.nix {};
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
