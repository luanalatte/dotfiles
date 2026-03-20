{ lib, ... }:

{
  boot.loader = {
    efi.canTouchEfiVariables = true;

    systemd-boot = {
      enable = lib.mkDefault true;
      configurationLimit = lib.mkDefault 10;
    };
  };
}
