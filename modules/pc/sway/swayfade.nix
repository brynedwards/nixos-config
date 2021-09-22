{ pkgs }:
with pkgs;
python3Packages.buildPythonApplication rec {
  pname = "swayfade";
  version = "e1d5bf1";

  src = fetchFromGitHub {
    owner = "brynedwards";
    repo = "${pname}";
    rev = "${version}";
    sha256 = "sha256-CPtW9RnVOU+WWC37A0jSTS0w8yqArsF95W7fnJH7w2s=";
  };

  format = "other";

  propagatedBuildInputs = with python3Packages; [ i3ipc toml ];

  installPhase = ''
    install -Dm 0755 $src/${pname}.py $out/bin/${pname}
    sed -i '1s/^/#!\/usr\/bin\/python\n/' $out/bin/${pname}
  '';

  meta = {
    description = "Fades windows when focused/unfocused";
    homepage = "https://github.com/brynedwards/swayfade";
  };
}
