{
  programs.git = {
    enable = true;
    settings = {
      init.defaultBranch = "main";
      # commit.gpgsign = true;
      # gpg.format = "ssh";
      alias = {
        s = "status";
        b = "branch";
        lo = "log --oneline";
        cane = "commit --amend --no-edit";
        undo = "reset --soft HEAD~1";
      };
    };
  };
}
