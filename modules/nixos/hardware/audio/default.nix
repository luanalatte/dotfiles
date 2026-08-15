{ lib, config, ... }:

{
  imports = [
    ./automute.nix
  ];

  config = lib.mkIf config.latte.profiles.graphical.enable {
    security.rtkit.enable = true;

    services = {
      pulseaudio.enable = lib.mkForce false;

      pipewire = {
        enable = true;
        alsa = {
          enable = true;
          support32Bit = true;
        };

        pulse.enable = true;
        jack.enable = false;
      };
    };
  };
}
