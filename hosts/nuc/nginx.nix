{ pkgs, ... }:
let secrets = import ../../secrets;
in {
  networking.firewall.allowedTCPPorts = [ 80 443 ];
  security.acme.acceptTerms = true;
  security.acme.certs = secrets.certs;
  services.gitweb.extraConfig = ''
    $export_ok = "export_ok"
  '';
  services.nginx = {
    enable = true;
    gitweb = {
      enable = true;
      virtualHost = "default";
    };
    package = pkgs.nginxMainline;
    recommendedProxySettings = true;
    virtualHosts.default = secrets.virtualHost // {
      forceSSL = true;
      enableACME = true;
    };
  };
}
