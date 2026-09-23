{ config, ... }:

{
  imports = [
    # keep-sorted start
    ./fonts.nix
    ./nix.nix
    ./revision.nix
    ./shell_.nix
    # keep-sorted end
  ];

  system.stateVersion = config.latte.system.stateVersion;
}
