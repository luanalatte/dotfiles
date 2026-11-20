{
  home-manager.users.luana = {
    programs = {
      # keep-sorted start block=yes
      alacritty.enable = true;
      discord = {
        enable = true;
        settings = {
          "SKIP_MODULE_UPDATE" = true;
        };
      };
      zsh.enable = true;
      # keep-sorted end
    };
  };
}
