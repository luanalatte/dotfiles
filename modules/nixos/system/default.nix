{ config, ... }:

{
  imports = [
    # keep-sorted start
    ./fonts.nix
    ./nix.nix
    ./shell_.nix
    # keep-sorted end
  ];

  system.stateVersion = config.latte.system.stateVersion;

  # Work-around for leaked eMudhra certificates
  security.pki.caCertificateBlacklist = [
    "Comodo AAA Services root"
    "emSign ECC Root CA - G3"
  ];
}
