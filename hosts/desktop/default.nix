# Edit this configuration file to define what should be installed on
# your system. Help is available in the configuration.nix(5) man page, on
# https://search.nixos.org/options and in the NixOS manual (`nixos-help`).

{
  config,
  lib,
  pkgs,
  ...
}:

{
  imports = [
    ./hardware-configuration.nix
  ];

  latte = {
    hardware.gpu = "nvidia"; # TODO: force version 580, as this host's gpu is deprecated in 590 onwards.
    hardware.audio = {
      hdmi.enable = false;
      disableAutoMute = true;
    };

    profiles.graphical.enable = true;
    desktop.gnome.enable = true;
  };

  services.power-profiles-daemon.enable = false;

  # This machine has issues with suspend due to nvidia.
  systemd.targets.suspend.enable = false;
  systemd.targets.hibernate.enable = false;
  systemd.targets.hybrid-sleep.enable = false;

  swapDevices = [
    {
      device = "/var/lib/swapfile";
      size = 4096;
    }
  ];

  networking.hostName = "nixos"; # Define your hostname.

  # Configure network connections interactively with nmcli or nmtui.
  networking.networkmanager.enable = true;

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # console = {
  #   font = "Lat2-Terminus16";
  #   keyMap = "us";
  #   useXkbConfig = true; # use xkb.options in tty.
  # };

  # Disable the X11 windowing system (I'm using wayland).
  services.xserver.enable = false;

  # Configure keymap in X11
  services.xserver.xkb = {
    layout = "us";
    variant = "altgr-intl";
  };

  # Enable CUPS to print documents.
  services.printing.enable = true;

  # Enable touchpad support (enabled default in most desktopManager).
  # services.libinput.enable = true;

  programs.zsh = {
    enable = true;
    autosuggestions.enable = true;
    histSize = 10000;
    setOptions = [
      "HIST_IGNORE_DUPS"
      "SHARE_HISTORY"
      "HIST_FCNTL_LOCK"
      "AUTOCD"
    ];
  };

  programs.starship.enable = true;

  programs.neovim = {
    enable = true;
    defaultEditor = true;
    vimAlias = true;
    configure = {
      customLuaRC = ''
          vim.opt.tabstop = 4
        	vim.opt.shiftwidth = 4
        	vim.opt.expandtab = true
        	vim.opt.softtabstop = 4
      '';
    };
  };

  environment.shellAliases = {
    grep = "grep --color=auto";
    diff = "diff --color=auto";
    ls = "ls -lh --color=auto";
    ll = "ls -lh";
    la = "ls -lah";
    lla = "ls -lah";
  };

  programs.direnv.enable = true;

  # List packages installed in system profile.
  # You can use https://search.nixos.org/ to find more packages (and options).
  latte.packages = with pkgs; [
    alsa-utils
    htop
    alacritty
    nixd
    azahar
  ];

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  # };

  programs.git.enable = true;
  # programs.git.config = {
  #   init.defaultBranch = "main";
  # };

  programs.gamemode.enable = true;
  programs.steam = {
    enable = true;
    protontricks.enable = true;
    extraCompatPackages = [ pkgs.proton-ge-bin ];
    extest.enable = true;
    # remotePlay.openFirewall = true;
    # localNetworkGameTransfers.openFirewall = true;
  };

  programs.zoom-us.enable = true;

  # List services that you want to enable:

  # Enable the OpenSSH daemon.
  # services.openssh.enable = true;

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

  services.syncthing = {
    enable = true;
    user = "luana";
    dataDir = "/home/luana";
  };

  # Copy the NixOS configuration file and link it from the resulting system
  # (/run/current-system/configuration.nix). This is useful in case you
  # accidentally delete configuration.nix.
  # system.copySystemConfiguration = true;
}
