{ config, pkgs, ... }:

{
  programs.prismlauncher = {
    enable = config.latte.profiles.gaming.enable;
    package = pkgs.prismlauncher.override {
      textToSpeechSupport = false;
      jdks = with pkgs; [
        jdk25
        jdk21
        jdk17
        jdk8
      ];
    };
  };
}
