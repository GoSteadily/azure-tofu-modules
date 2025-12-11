{
  description = "The default NixOS installation";

  outputs = { self, nixpkgs, disko }: {
    nixosConfigurations.vm = nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";

      modules = [
        disko.nixosModules.disko
        ./configuration.nix
        ./disk-config.nix
        ./hardware-config.nix
      ];
    };
  };
}
