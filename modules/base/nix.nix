{ lib, ... }:

{
  nix = {
    channel.enable = false;

    # set the nix store to clean every Monday at 3am
    gc = {
      automatic = true;
      dates = "Mon *-*-* 03:00";
    };

    settings = {
      experimental-features = [
        "nix-command"
        "flakes"
      ];

      allowed-users = [ "@wheel" ];
      trusted-users = [ "@wheel" ];

      warn-dirty = false;
      use-xdg-base-directories = true;
    };
  };

  nixpkgs.config = {
    allowUnfree = lib.mkDefault true;

    allowUnsupportedSystem = false;

    allowAliases = false;
  };
}
