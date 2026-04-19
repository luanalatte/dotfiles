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

    hardware.printers.epsonL3150.enable = true;

    profiles.graphical.enable = true;
    desktop.gnome.enable = true;
  };

  hardware.opentabletdriver.enable = true;

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

  # Enable touchpad support (enabled default in most desktopManager).
  # services.libinput.enable = true;

  programs.zsh.enable = true;
  programs.starship.enable = true;

  programs.neovim.enable = true;

  programs.direnv = {
    enable = true;
    settings = {
      global = {
        warn_timeout = 0;
      };
    };
  };

  # List packages installed in system profile.
  # You can use https://search.nixos.org/ to find more packages (and options).
  latte.packages = with pkgs; [
    easyeffects
    alacritty
    alsa-utils
    azahar
    htop
    libreoffice-still
    nixd
  ];

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  # };

  programs.droidcam.enable = true;

  programs.git.enable = true;
  programs.git.config = {
    init.defaultBranch = "main";
  };

  programs.steam.enable = true;

  # List services that you want to enable:

  # Enable the OpenSSH daemon.
  # services.openssh.enable = true;

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

  programs.appimage.enable = true;

  services.flatpak = {
    enable = true;
    packages = [
      "com.usebottles.bottles"
    ];
  };

  services.syncthing = {
    enable = true;
    user = "luana";
    dataDir = "/home/luana";
    openDefaultPorts = true;
    # settings.options = {
    #   globalAnnounceEnabled = false;
    # };
  };

  # Copy the NixOS configuration file and link it from the resulting system
  # (/run/current-system/configuration.nix). This is useful in case you
  # accidentally delete configuration.nix.
  # system.copySystemConfiguration = true;
}
