{ osConfig, ... }:

{
  _class = "homeManager";

  home.stateVersion = osConfig.latte.system.stateVersion;
}
