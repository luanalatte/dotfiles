{ osConfig, inputs, ... }:

{
  _class = "homeManager";

  imports = [
    # keep-sorted start
    ../generic
    ./profiles.nix
    ./programs
    inputs.lazyvim.homeManagerModules.default
    # keep-sorted end
  ];

  home.stateVersion = osConfig.latte.system.stateVersion;
}
