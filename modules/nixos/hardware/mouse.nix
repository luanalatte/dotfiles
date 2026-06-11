{ lib, config, ... }:

{
  services.libinput = {
    enable = true;
    mouse = {
      accelProfile = "flat";
      accelSpeed = "0";
      middleEmulation = false;
    };
  };

  hardware.uinput = lib.mkIf config.hardware.opentabletdriver.enable {
    enable = true;
  };
}
