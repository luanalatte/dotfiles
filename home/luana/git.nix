{ config, ... }:

{
  programs.git = {
    inherit (config.latte.profiles.workstation) enable;

    signing = {
      format = "ssh";
      signByDefault = false;
    };

    settings = {
      alias = {
        s = "status";
        b = "branch";
        lo = "log --oneline";
        cane = "commit --amend --no-edit";
        undo = "reset --soft HEAD~1";
      };

      init.defaultBranch = "main";
    };
  };
}
