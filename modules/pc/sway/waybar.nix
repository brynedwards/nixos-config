# --------------------------------------------------
# Common waybar module config
# --------------------------------------------------
{
  layer = "bottom";
  height = 30;
  position = "top";
  modules-left = [ "sway/workspaces" "sway/mode" "sway/window" ];
  modules-center = [ "clock" ];
  modules-right =
    [ "cpu" "memory" "temperature" "network" "pulseaudio" "battery" "tray" ];

  modules = {
    battery.format = "{icon} {capacity}%";
    battery.format-icons = [ "" "" "" "" ];

    clock.format = "{:%A %d %B, %H:%M}";
    cpu = {
      format = " {usage}%";
      interval = 1;
    };
    memory.format = " {used:0.1f} GB";
    network = {
      format = " ⬇{bandwidthDownOctets} ⬆{bandwidthUpOctets}";
      interval = 1;
    };
    pulseaudio = {
      format = "{icon} {volume}%";
      format-icons = {
        default = [ "" "" ];
        headphones = "";
      };
      format-muted = " {volume}%";
    };
    temperature = {
      format = "{icon} {temperatureC} °C";
      format-icons = [ "" "" ];
    };
    tray = {
      icon-size = "21";
      spacing = "10";
    };
  };
}
