{ lib, config, ... }:

{
  config = lib.mkIf config.programs.zsh.enable {
    programs.zsh = {
      autosuggestions.enable = lib.mkDefault true;
      syntaxHighlighting.enable = lib.mkDefault true;
      histSize = lib.mkDefault 10000;
      setOptions = lib.mkDefault [
        "HIST_IGNORE_DUPS"
        "SHARE_HISTORY"
        "HIST_FCNTL_LOCK"
        "AUTOCD"
      ];
    };
  };
}
