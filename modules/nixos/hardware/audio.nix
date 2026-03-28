{
  lib,
  pkgs,
  config,
  ...
}:

let
  cfg = config.latte.audio;
in
{
  options.latte.audio = {
    disableAutoMute = lib.mkEnableOption "Set ALSA Auto-Mute to Disabled";
  };

  config = {
    systemd.user.services.alsa-auto-mute = lib.mkIf cfg.disableAutoMute {
      description = "Disable ALSA Auto-Mute";
      wantedBy = [ "default.target" ];
      after = [ "wireplumber.service" ];

      serviceConfig = {
        Type = "oneshot";
        ExecStart = "${pkgs.alsa-utils}/bin/amixer -c 0 sset 'Auto-Mute Mode' Disabled";
      };
    };

    security.rtkit.enable = true;

    services.pulseaudio.enable = false;
    services.pipewire = {
      enable = true;
      alsa = {
        enable = true;
        support32Bit = true;
      };

      pulse.enable = true;
      #jack.enable = true;
    };
  };
}
