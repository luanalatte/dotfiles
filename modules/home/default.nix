{ osConfig, ... }:

{
  _class = "homeManager";

  imports = [
    ../generic
    ./programs
  ];

  home.stateVersion = osConfig.latte.system.stateVersion;
}
