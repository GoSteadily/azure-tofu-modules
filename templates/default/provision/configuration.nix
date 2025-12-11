{
  modulesPath,
  ...
}:
{
  system.stateVersion = "25.05";

  imports = [
    (modulesPath + "/installer/scan/not-detected.nix")
    (modulesPath + "/profiles/qemu-guest.nix")
  ];

  boot.loader.grub = {
    efiSupport = true;
    efiInstallAsRemovable = true;
  };

  services.waagent.enable = true;

  services.openssh.enable = true;
  users.users.root.openssh.authorizedKeys.keys =
    let
      publicKey = "PUBLIC KEY";
    in
    [ publicKey ];
}
