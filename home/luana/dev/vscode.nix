{ pkgs, ... }:

{
  programs.vscode = {
    enable = true;

    profiles.default.extensions = with pkgs.vscode-extensions; [
      jnoortheen.nix-ide
      mkhl.direnv
      vscodevim.vim
    ];
  };

  latte.packages = with pkgs; [
    nixfmt
  ];
}
