{
  lib,
  pkgs,
  config,
  ...
}:
let
  cfg = config.services.mysql;
in
{
  options.services.mysql = {
    autoStart = lib.mkEnableOption "Whether to enable starting the service by default." // {
      default = true;
    };
  };

  config = {
    services.mysql.package = lib.mkDefault pkgs.mariadb;
    systemd.services.mysql.wantedBy = lib.mkIf (!cfg.autoStart) (lib.mkForce [ ]);
  };

}
