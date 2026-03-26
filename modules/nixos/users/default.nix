{
  lib,
  pkgs,
  config,
  ...
}:

let
  inherit (lib.types) enum listOf str;
in
{
  options.latte.system = {
    home-manager.enable = lib.mkEnableOption "Home Manager" // {
      default = true;
    };

    mainUser = lib.mkOption {
      type = enum config.latte.system.users;
      description = "The username of the main user for your system";
      default = builtins.elemAt config.latte.system.users 0;
    };

    users = lib.mkOption {
      type = listOf str;
      default = [ "luana" ];
      description = ''
        A list of users that you wish to declare as your non-system users. The first username
        in the list will be treated as your main user unless {option}`latte.system.mainUser` is set.
      '';
    };
  };

  config = {
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
  };
}
