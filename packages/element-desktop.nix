{ stdenv, lib, element-desktop, writeShellScript }:
let
  script = writeShellScript "element-desktop-wrapper" ''
    params=()
    if [ -n "$WAYLAND_DISPLAY" ]; then
      params+=(--enable-features=UseOzonePlatform --ozone-platform=wayland)
    fi
    exec ${element-desktop}/bin/element-desktop "''${params[@]}" $@
  '';
in stdenv.mkDerivation rec {
  pname = "element-desktop-wayland-wrapped";
  version = lib.strings.getVersion element-desktop.name;

  phases = [ "installPhase" ];

  installPhase = ''
    mkdir -p $out/bin
    cd $out && ln -s ${element-desktop}/share
    cd $out/bin && ln -s ${script} element-desktop
  '';
}


