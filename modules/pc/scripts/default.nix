{ pkgs, ... }:
let
  fuzzelPkg = pkgs.callPackage ../../../packages/fuzzel.nix {};
  myFuzzel = (pkgs.writeScriptBin "fuzzel" ''
    #!${pkgs.stdenv.shell}
    ${fuzzelPkg}/bin/fuzzel -T footclient -I -f 'sans:size='"''${FUZZEL_FONT_SIZE:-24}" -b '000000f0' -t 'fda300ff' -m 'ffffffff' -s '1c458eff' $@ <&0
  '');
in {
  environment.systemPackages = with pkgs; [
    (writeScriptBin "dmenu" ''
      #!${pkgs.stdenv.shell}
      ${myFuzzel}/bin/fuzzel -d $@ <&0
    '')
    myFuzzel
    (callPackage ./gc.nix {})
    (writeScriptBin "term-float" ''
      #!${pkgs.stdenv.shell}
      foot -a foot-floating -f "Mono:size=''${TERM_FLOAT_FONT_SIZE:-14}" -W "''${TERM_FLOAT_GEOMETRY:-80x24}" $@
    '')
  ];
}

