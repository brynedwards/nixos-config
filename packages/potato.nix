{ stdenv, lib, fetchFromGitHub, bash }:

stdenv.mkDerivation rec {
  pname = "potato";
  version = "04225e444d2e169900b09c9774dfd02a0af22dce";

  src = fetchFromGitHub {
    owner = "Bladtman242";
    repo = "potato";
    rev = version;
    sha256 = "sha256-8e9R+hZZX8fvTOe4d7MhEVDXREdgTYoe98YHVqLCyGA=";
  };


  dontBuild = true;

  installPhase = ''
    mkdir -p $out/bin $out/share
    cp notification.wav $out/share
    cp potato.sh $out/bin/potato
    sed -i '23s|.*|mpv --really-quiet '"$out"'/share/notification.wav \&|' $out/bin/potato
  '';

  meta = with lib; {
    description =
      "A pomodoro timer for the shell";
    homepage = "https://github.com/Bladtman242/potato";
    license = licenses.mit;
    maintainers = with maintainers; [ fionera ];
    platforms = with platforms; linux;
    changelog = "https://github.com/xwmx/nb/releases/tag/${version}";
  };
}

