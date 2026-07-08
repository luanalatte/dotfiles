{ osConfig, inputs, ... }:

{
  _class = "homeManager";

  imports = [
    ../generic
    ./programs
    inputs.lazyvim.homeManagerModules.default
  ];

  home.stateVersion = osConfig.latte.system.stateVersion;
}
