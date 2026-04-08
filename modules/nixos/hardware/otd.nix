{ lib, config, ... }:

{
  hardware.uinput = lib.mkIf config.hardware.opentabletdriver.enable {
    enable = true;
  };
}
