{ osConfig, ... }:

{
  _class = "homeManager";

  imports = [
    ../generic
  ];

  home.stateVersion = osConfig.latte.system.stateVersion;
}
