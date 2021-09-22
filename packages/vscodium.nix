{ stdenv, lib, vscodium, writeShellScript }:
let
  script = writeShellScript "codium-wrapper" ''
    params=()
    if [ -n "$WAYLAND_DISPLAY" ]; then
      params+=(--enable-features=UseOzonePlatform --ozone-platform=wayland)
    fi
    exec ${vscodium}/bin/codium "''${params[@]}" $@
  '';
in stdenv.mkDerivation rec {
  # This is used in home-manager vscode.nix to determine the correct path for
  # config and extensions
  pname = "vscodium";
  version = lib.strings.getVersion vscodium.name;

  phases = [ "installPhase" ];

  installPhase = ''
    mkdir -p $out/bin
    cd $out && ln -s ${vscodium}/share
    cd $out/bin && ln -s ${script} codium
  '';
}



