{ lib, config, ... }:

let
  cfg = config.hardware.opentabletdriver;
in
{
  options.hardware.opentabletdriver.daemon = {
    autoStart = lib.mkEnableOption "Whether to enable starting the daemon service by default." // {
      default = true;
    };
  };

  config = {
    systemd.user.services.opentabletdriver.wantedBy = lib.mkIf (!cfg.daemon.autoStart) (
      lib.mkForce [ ]
    );

    hardware.uinput = lib.mkIf cfg.enable { enable = true; };
  };
}
