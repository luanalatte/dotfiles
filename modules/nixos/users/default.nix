{ pkgs, ... }:

{
  # disable the ability to modify users outside of the nixos configuration
  # users.mutableUsers = false;

  users.users.luana = {
    isNormalUser = true;
    description = "Luana";
    extraGroups = [
      "networkmanager"
      "wheel"
    ];
    shell = pkgs.zsh;
  };
}
