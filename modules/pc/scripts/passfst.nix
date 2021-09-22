{ pkgs, ... }:
pkgs.writeScriptBin "passfst" ''
  #!${pkgs.stdenv.shell}
  pass $@ | head -n1 | tr -d '\n'
''
