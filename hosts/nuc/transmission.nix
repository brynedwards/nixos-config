{ pkgs, ... }: {
  networking.firewall.extraCommands = ''
    iptables -A OUTPUT ! -o lo -m owner --uid-owner transmission -j DROP
  '';

  services.nginx.virtualHosts.default.locations."/transmission".proxyPass =
    "http://localhost:9091";

  services.transmission = {
    enable = true;
    openFirewall = true;
    downloadDirPermissions = "775";
    settings = {
      download-dir = "/mnt/media/Downloads";
      incomplete-dir = "/mnt/media/.incomplete";
      rpc-host-whitelist = "nuc.local";
    };
  };
}
