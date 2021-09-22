{ stdenv, lib, ungoogled-chromium, writeShellScript }:
let
  script = writeShellScript "ungoogled-chromium-wrapper" ''
    params=()
    if [ -n "$WAYLAND_DISPLAY" ]; then
      params+=(--enable-features=UseOzonePlatform --ozone-platform=wayland)
    fi
    exec ${ungoogled-chromium}/bin/chromium "''${params[@]}" $@
  '';
in stdenv.mkDerivation rec {
  pname = "chromium-wayland-wrapped";
  version = lib.strings.getVersion ungoogled-chromium.name;

  phases = [ "installPhase" ];

  installPhase = ''
    mkdir -p $out/bin
    cd $out && ln -s ${ungoogled-chromium}/share
    cd $out/bin && ln -s ${script} chromium
    cd $out/bin && ln -s ${script} chromium-browser
  '';
}


