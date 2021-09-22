{ stdenv, lib, fetchzip, bash }:

stdenv.mkDerivation rec {
  pname = "nb";
  version = "6.4.0";

  src = fetchzip {
    url = "https://github.com/xwmx/nb/archive/refs/tags/${version}.tar.gz";
    sha256 = "sha256-Rhg4C009siIp0NbJ9SIkaj96XLMX9JxZsTCwLCXkOG8=";
  };

  dontBuild = true;

  installPhase = ''
    mkdir -p $out/bin
    cp nb $out
    cat > $out/bin/nb << EOF
    #!${bash}/bin/bash
    $out/nb "\$@"
    EOF
    chmod 755 $out/bin/nb
  '';

  meta = with lib; {
    description =
      "CLI and local web plain text note‑taking, bookmarking, and archiving with linking, tagging, filtering, search, Git versioning & syncing, Pandoc conversion, + more, in a single portable script.";
    homepage = "https://github.com/xwmx/nb";
    license = licenses.agpl3Only;
    maintainers = with maintainers; [ fionera ];
    platforms = with platforms; linux;
    changelog = "https://github.com/xwmx/nb/releases/tag/${version}";
  };
}
