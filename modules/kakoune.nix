{
  enable = false;
  config = {
    indentWidth = 2;
    hooks = [
      {
        name = "WinSetOption";
        option = "filetype=kakrc";
        commands = "set buffer indentwidth 4";
      }
      {
        name = "ModuleLoaded";
        option = "kitty";
        commands = "set global kitty_window_type os";
      }
    ];
    numberLines = {
      enable = true;
      relative = true;
    };
    showWhitespace.enable = true;
  };
}
