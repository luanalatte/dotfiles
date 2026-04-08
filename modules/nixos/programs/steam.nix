{
  lib,
  config,
  pkgs,
  ...
}:

{
  config = lib.mkIf config.programs.steam.enable {
    programs.gamemode.enable = lib.mkDefault true;
    programs.steam = {
      protontricks.enable = lib.mkDefault true;
      extraCompatPackages = lib.mkDefault [ pkgs.proton-ge-bin ];
      extest.enable = lib.mkDefault true;
      # remotePlay.openFirewall = true;
      # localNetworkGameTransfers.openFirewall = true;
    };
  };
}
