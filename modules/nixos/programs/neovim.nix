{ lib, config, ... }:

{
  config = lib.mkIf config.programs.neovim.enable {
    programs.neovim = {
      defaultEditor = lib.mkDefault true;
      vimAlias = lib.mkDefault true;
    };
  };
}
