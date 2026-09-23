{
  config,
  inputs,
  ...
}:

{
  _class = "homeManager";

  imports = [
    # keep-sorted start
    ../generic
    ./desktop
    ./programs
    inputs.lazyvim.homeManagerModules.default
    # keep-sorted end
  ];

  programs.home-manager.enable = true;

  home.stateVersion = config.latte.system.stateVersion;
}
