{
  lib,
  pkgs,
  config,
  osConfig,
  ...
}:

let
  uint32 = lib.hm.gvariant.mkUint32;
in
{
  config = lib.mkIf osConfig.latte.desktop.gnome.enable {
    programs.gnome-shell.enable = true;

    dconf.settings = {
      "org/gnome/shell" = {
        enabled-extensions = with pkgs.gnomeExtensions; [
          appindicator.extensionUuid
          vitals.extensionUuid
        ];
      };

      "org/gnome/shell/extensions/vitals" = {
        show-temperature = true;
        show-processor = true;
        show-memory = true;
        show-storage = true;
        show-gpu = true;
        show-fan = false;
        show-network = false;
        show-system = false;
        show-voltage = false;
        hot-sensors = [
          "__temperature_avg__"
          "_processor_usage_"
          "_memory_usage_"
          "_gpu#1_utilization_"
          "_storage_free_"
        ];
      };

      "org/gnome/shell/favorite-apps" = {
        favorite-apps = [
          "org.gnome.Nautilus.desktop"
          "zen.desktop"
          "obsidian.desktop"
          "code.desktop"
        ];
      };

      "org/gnome/desktop/sound" = {
        event-sounds = false;
      };

      "org/gnome/desktop/interface" = {
        enable-hot-corners = false;
        cursor-theme = config.home.pointerCursor.name;
      };

      "org/gnome/desktop/peripherals/keyboard" = {
        delay = uint32 200;
        repeat = uint32 20;
      };

      "org/gnome/desktop/peripherals/mouse" = {
        speed = 0.5;
        accel-profile = "flat";
      };

      "org/gnome/desktop/wm/keybindings" = {
        close = [ "<Super>w" ];
        switch-to-workspace-left = [ "<Super>comma" ];
        switch-to-workspace-right = [ "<Super>period" ];
        move-to-workspace-left = [ "<Shift><Super>comma" ];
        move-to-workspace-right = [ "<Shift><Super>period" ];
      };

      "org/gnome/settings-daemon/plugins/media-keys" = {
        custom-keybindings = [
          "/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom0/"
        ];
      };

      "org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom0" = {
        name = "Launch Terminal";
        command = "alacritty";
        binding = "<Super>Return";
      };
    };
  };
}
