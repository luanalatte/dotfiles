# Edit this configuration file to define what should be installed on
# your system. Help is available in the configuration.nix(5) man page, on
# https://search.nixos.org/options and in the NixOS manual (`nixos-help`).

{
  config,
  pkgs,
  ...
}:

{
  imports = [
    ./hardware-configuration.nix
    ./users.nix
  ];

  latte = {
    hardware = {
      gpu = "nvidia";
      audio.disableAutoMute = true;
      printers.epsonL3150.enable = true;
      nvidia.hdmiAudio = false;
    };

    profiles = {
      graphical.enable = true;
      workstation.enable = true;
      gaming.enable = true;
    };

    desktop.gnome.enable = true;
  };

  hardware.nvidia.package = config.boot.kernelPackages.nvidiaPackages.legacy_580;

  hardware.opentabletdriver.enable = true;

  # This machine has issues with power management due to nvidia.
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
  latte.packages = {
    inherit (pkgs)
      # keep-sorted start
      easyeffects
      libreoffice-still
      # keep-sorted end
      ;
  };

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  # };

  programs.droidcam.enable = true;

  programs.steam.enable = true;

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

  programs.appimage.enable = true;

  services.flatpak = {
    enable = true;
    packages = [
      # keep-sorted start
      "com.bitwarden.desktop"
      "com.brave.Browser"
      "com.logseq.Logseq"
      "com.usebottles.bottles"
      "org.azahar_emu.Azahar"
      "org.telegram.desktop"
      # keep-sorted end
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

  virtualisation.podman.enable = true;

  # Copy the NixOS configuration file and link it from the resulting system
  # (/run/current-system/configuration.nix). This is useful in case you
  # accidentally delete configuration.nix.
  # system.copySystemConfiguration = true;
}
