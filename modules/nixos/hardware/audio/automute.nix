{
  lib,
  config,
  pkgs,
  ...
}:

let
  cfg = config.latte.hardware.audio;
in
{
  options.latte.hardware.audio = {
    disableAutoMute = lib.mkEnableOption "Set ALSA Auto-Mute to Disabled";
  };

  config = lib.mkIf cfg.disableAutoMute {
    systemd.user.services.alsa-auto-mute = {
      description = "Disable ALSA Auto-Mute";
      wantedBy = [ "default.target" ];
      after = [ "wireplumber.service" ];

      serviceConfig = {
        Type = "oneshot";
        ExecStart = pkgs.writeShellScript "disable-auto-mute" ''
          while read -r card _; do
            # Only process lines that begin with a card number.
            [[ "$card" =~ ^[0-9]+$ ]] || continue

            if ${pkgs.alsa-utils}/bin/amixer -c "$card" controls | grep -Fq "Auto-Mute Mode"; then
              ${pkgs.alsa-utils}/bin/amixer -c "$card" sset 'Auto-Mute Mode' Disabled
            fi
          done < /proc/asound/cards
        '';
      };
    };
  };
}
