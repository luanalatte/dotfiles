{
  lib,
  pkgs,
  config,
  ...
}:

let
  cfg = config.latte.hardware.audio;
in
{
  options.latte.hardware.audio = {
    hdmi.enable = lib.mkEnableOption "HDMI audio drivers" // {
      default = true;
    };

    disableAutoMute = lib.mkEnableOption "Set ALSA Auto-Mute to Disabled";
  };

  config = {
    systemd.user.services.alsa-auto-mute = lib.mkIf cfg.disableAutoMute {
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

    services.udev.extraRules = lib.mkIf (cfg.hdmi.enable == false) ''
      ACTION=="add", SUBSYSTEM=="pci", ATTR{vendor}=="0x10de", ATTR{class}=="0x040300", ATTR{remove}="1"
    ''; # NVIDIA HDMI audio device
  };
}
