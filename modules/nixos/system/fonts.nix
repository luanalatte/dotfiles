{ lib, pkgs, ... }:

{
  fonts.packages = lib.attrValues {
    inherit (pkgs)
      corefonts

      dejavu_fonts
      inter

      noto-fonts
      noto-fonts-cjk-sans
      noto-fonts-cjk-serif

      twemoji-color-font
      noto-fonts-color-emoji
      ;

    inherit (pkgs.nerd-fonts) symbols-only;
  };
}
