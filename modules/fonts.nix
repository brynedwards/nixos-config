{ pkgs, ... }: {
  imports = [ ./desktop/fonts.nix ];
  # Console fonts
  console = {
    font = "ter-i32n";
    keyMap = "uk";
    packages = with pkgs; [ terminus_font ];
  };
}
