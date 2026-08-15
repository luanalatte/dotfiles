{ lib, config, ... }:

{
  systemd.user.services.opentabletdriver = lib.mkIf config.hardware.opentabletdriver.daemon.enable {
    enable = false; # I prefer to start it on-demand.
  };

  hardware = lib.mkIf config.hardware.opentabletdriver.enable {
    uinput.enable = true;
  };
}
