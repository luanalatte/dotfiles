{
  lib,
  config,
  inputs',
  pkgs,
  ...
}:

let
  cfg = config.services.lerd;
in
{
  options.services.lerd =
    let
      inherit (lib) mkEnableOption mkOption;
      inherit (lib.types) enum;
    in
    {
      enable = mkEnableOption "Laravel Lerd";
      user = mkOption {
        type = enum config.latte.system.users;
      };

      useHostPHP = mkEnableOption "Host PHP";
    };

  config = lib.mkIf cfg.enable (
    let
      waitForDefaultRoute = pkgs.writeShellScript "wait-for-default-route" ''
        set -eu
        ip=${pkgs.iproute2}/bin/ip
        grep=${pkgs.gnugrep}/bin/grep
        sleep=${pkgs.coreutils}/bin/sleep

        until "$ip" -o route show default | "$grep" -q . \
           || "$ip" -o -6 route show default | "$grep" -q .; do
          "$sleep" 0.5
        done
      '';
    in
    {
      environment.systemPackages = [
        inputs'.lerd.packages.default
        pkgs.nssTools
      ]
      # OPTIONAL host PHP + Composer (for editor tooling and `lerd new`'s
      # initial scaffold). lerd serves your app's PHP from containers regardless
      # of this — pin the per-project version with `lerd isolate <ver>`.
      ++ lib.optionals cfg.useHostPHP (
        with pkgs;
        [
          php84
          php84Packages.composer
        ]
      );

      # 1. Rootless Podman — lerd runs everything in containers.
      virtualisation.podman.enable = true;

      # 2. Move Podman's default subnet pool off 10.x.
      #    REQUIRED ONLY IF a route on your machine claims 10.0.0.0/8 (common with
      #    corporate VPNs — check `ip route`). Podman's default pool lives in 10.x,
      #    and an overlapping route makes network creation fail with
      #    "could not find free subnet from subnet pools".
      #    Harmless to keep even without a VPN.
      virtualisation.containers.containersConf.settings.network.default_subnet_pools = [
        {
          base = "172.20.0.0/16";
          size = 24;
        }
      ];

      # 3. Let rootless nginx bind 80/443. Without this, lerd asks for sudo to set
      #    the sysctl at runtime on every install; declaring it makes it permanent.
      boot.kernel.sysctl."net.ipv4.ip_unprivileged_port_start" = 80;

      # 4. Keep lerd's user containers alive outside an active graphical session
      #    (otherwise systemd-logind tears them down on lock/logout).
      users.users.${cfg.user}.linger = true;

      # 5. DNS for *.test — owned by NixOS, NOT by lerd (see notes below).
      #    Routes ONLY *.test to lerd's DNS container on 127.0.0.1:5300; everything
      #    else stays on your normal resolver, so a stopped lerd-dns can only ever
      #    break .test, never the whole internet.
      services.resolved.enable = true;
      services.resolved.settings.Resolve = {
        DNS = "127.0.0.1:5300";
        Domains = [ "~test" ];
      };

      # 6. Trust lerd's mkcert root CA system-wide (curl, PHP, Node, …).
      #    The file doesn't exist yet on a fresh install — add this line AFTER the
      #    "First-time lerd setup" step below generates and copies it in.
      security.pki.certificateFiles = [ ./certs/lerd-rootCA.pem ];

      # 7. Point lerd's host-binary services at the Nix profile.
      #    lerd-ui and lerd-watcher exec `~/.local/bin/lerd`, where lerd would
      #    self-install on other distros. On NixOS the binary comes from the Nix
      #    profile, so without this symlink both fail with status=203/EXEC.
      #    /run/current-system/sw/bin/lerd tracks the current generation, so this
      #    survives nixos-rebuild and lerd updates.
      systemd.user.tmpfiles.rules = [
        "L %h/.local/bin/lerd - - - - /run/current-system/sw/bin/lerd"
      ];

      # 8. (Moved to top).

      # 9. Wait for a real default route before rootless containers start.
      #    Every rootless quadlet is ordered after
      #    podman-user-wait-network-online.service, whose stock command only
      #    polls network-online.target. On NixOS that target is reached by
      #    NetworkManager-wait-online (`nm-online -s`), which returns when
      #    NetworkManager has finished starting. On Wi-Fi that is often before
      #    a default route exists. Pasta then builds the rootless netns with no
      #    gateway and keeps it until the last container using it stops, so
      #    containers fail DNS (`getaddrinfo ... Try again`) until
      #    `lerd stop && lerd start`. A host that already has a route passes
      #    immediately. The unit's own 90s timeout still applies, so an offline
      #    boot is not held forever.
      #    https://github.com/containers/podman/issues/27976
      systemd.user.services.podman-user-wait-network-online = {
        overrideStrategy = "asDropin";
        serviceConfig.ExecStart = lib.mkForce [
          ""
          waitForDefaultRoute
        ];
      };

      # 10. lerd 1.37 writes this into every PHP-FPM quadlet:
      #       ExecStartPre=/bin/mkdir -p -m 0700 %t/lerd/env
      #     NixOS's /bin contains only sh, so systemd reports
      #     "Unable to locate executable '/bin/mkdir'" (203/EXEC) and lerd
      #     reports "PHP x.y FPM quadlet: start lerd-phpXX-fpm failed". FPM
      #     never starts. /bin is a real directory; activation re-applies the
      #     symlink on every switch, after the script that creates /bin/sh.
      #     Drop this once lerd stops hardcoding /bin/mkdir
      #     (internal/podman/provided_env.go).
      system.activationScripts.lerd-bin-mkdir = {
        deps = [ "binsh" ];
        text = ''
          ln -sfn ${pkgs.coreutils}/bin/mkdir /bin/mkdir
        '';
      };
    }
  );
}
