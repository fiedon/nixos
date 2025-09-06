{config, pkgs, ... }:

{
  home.username = "fiedon";
  home.homeDirectory = "/home/fiedon";
  home.stateVersion = "25.05";

  home.packages = with pkgs; [
    uv
    steam-run
  ];

  programs.bash = {
    enable = true ;
    shellAliases = {
      btw = "echo i use nixos btw";
      nrs = "sudo nixos-rebuild switch --flake .#ryzen-nixos";
    };
  };

  # Hyprland configuration
  wayland.windowManager.hyprland = {
    enable = true;
    settings = {
      # Monitor configuration - reversed left and right
      monitor = [
        # HDMI-A-1 (AOC) on the left at position 0x0  
        "HDMI-A-1,1920x1080@60,0x0,1"
        # DP-3 (ASUS) on the right at position 1920x0
        "DP-3,1920x1080@60,1920x0,1"
      ];

      # Programs
      "$terminal" = "ghostty";
      "$fileManager" = "dolphin";
      "$menu" = "wofi --show drun";

      # Main modifier key (Super/Windows key)
      "$mainMod" = "SUPER";

      # Environment variables
      env = [
        "XCURSOR_SIZE,24"
        "HYPRCURSOR_SIZE,24"
      ];
      
      # Startup applications
      exec-once = [
        "waybar"
      ];

      # General settings
      general = {
        gaps_in = 5;
        gaps_out = 20;
        border_size = 2;
        "col.active_border" = "rgba(33ccffee) rgba(00ff99ee) 45deg";
        "col.inactive_border" = "rgba(595959aa)";
        resize_on_border = false;
        allow_tearing = false;
        layout = "dwindle";
      };

      # Decoration
      decoration = {
        rounding = 10;
        active_opacity = 1.0;
        inactive_opacity = 1.0;
        shadow = {
          enabled = true;
          range = 4;
          render_power = 3;
          color = "rgba(1a1a1aee)";
        };
        blur = {
          enabled = true;
          size = 3;
          passes = 1;
          vibrancy = 0.1696;
        };
      };

      # Animations
      animations = {
        enabled = "yes, please :)";
        bezier = [
          "easeOutQuint,0.23,1,0.32,1"
          "easeInOutCubic,0.65,0.05,0.36,1"
          "linear,0,0,1,1"
          "almostLinear,0.5,0.5,0.75,1.0"
          "quick,0.15,0,0.1,1"
        ];
        animation = [
          "global, 1, 10, default"
          "border, 1, 5.39, easeOutQuint"
          "windows, 1, 4.79, easeOutQuint"
          "windowsIn, 1, 4.1, easeOutQuint, popin 87%"
          "windowsOut, 1, 1.49, linear, popin 87%"
          "fadeIn, 1, 1.73, almostLinear"
          "fadeOut, 1, 1.46, almostLinear"
          "fade, 1, 3.03, quick"
          "layers, 1, 3.81, easeOutQuint"
          "layersIn, 1, 4, easeOutQuint, fade"
          "layersOut, 1, 1.5, linear, fade"
          "fadeLayersIn, 1, 1.79, almostLinear"
          "fadeLayersOut, 1, 1.39, almostLinear"
          "workspaces, 1, 1.94, almostLinear, fade"
          "workspacesIn, 1, 1.21, almostLinear, fade"
          "workspacesOut, 1, 1.94, almostLinear, fade"
        ];
      };

      # Dwindle layout
      dwindle = {
        pseudotile = true;
        preserve_split = true;
      };

      # Master layout
      master = {
        new_status = "master";
      };

      # Miscellaneous
      misc = {
        force_default_wallpaper = -1;
        disable_hyprland_logo = false;
      };

      # Input configuration
      input = {
        kb_layout = "us";
        follow_mouse = 1;
        sensitivity = 0;
        touchpad = {
          natural_scroll = false;
        };
      };

      # Gestures
      gestures = {
        workspace_swipe = false;
      };

      # Key bindings
      bind = [
        # Programs
        "$mainMod, Q, exec, $terminal"
        "$mainMod, C, killactive,"
        "$mainMod, M, exit,"
        "$mainMod, E, exec, $fileManager"
        "$mainMod, V, togglefloating,"
        "$mainMod, R, exec, $menu"
        "$mainMod, P, pseudo,"
        "$mainMod, J, togglesplit,"

        # Move focus with arrow keys
        "$mainMod, left, movefocus, l"
        "$mainMod, right, movefocus, r"
        "$mainMod, up, movefocus, u"
        "$mainMod, down, movefocus, d"

        # Switch workspaces
        "$mainMod, 1, workspace, 1"
        "$mainMod, 2, workspace, 2"
        "$mainMod, 3, workspace, 3"
        "$mainMod, 4, workspace, 4"
        "$mainMod, 5, workspace, 5"
        "$mainMod, 6, workspace, 6"
        "$mainMod, 7, workspace, 7"
        "$mainMod, 8, workspace, 8"
        "$mainMod, 9, workspace, 9"
        "$mainMod, 0, workspace, 10"

        # Move windows to workspaces
        "$mainMod SHIFT, 1, movetoworkspace, 1"
        "$mainMod SHIFT, 2, movetoworkspace, 2"
        "$mainMod SHIFT, 3, movetoworkspace, 3"
        "$mainMod SHIFT, 4, movetoworkspace, 4"
        "$mainMod SHIFT, 5, movetoworkspace, 5"
        "$mainMod SHIFT, 6, movetoworkspace, 6"
        "$mainMod SHIFT, 7, movetoworkspace, 7"
        "$mainMod SHIFT, 8, movetoworkspace, 8"
        "$mainMod SHIFT, 9, movetoworkspace, 9"
        "$mainMod SHIFT, 0, movetoworkspace, 10"

        # Special workspace
        "$mainMod, S, togglespecialworkspace, magic"
        "$mainMod SHIFT, S, movetoworkspace, special:magic"

        # Mouse workspace switching
        "$mainMod, mouse_down, workspace, e+1"
        "$mainMod, mouse_up, workspace, e-1"
        
        # Lock screen binding
        "$mainMod, L, exec, hyprlock"
        
        # Toggle waybar
        "$mainMod, B, exec, pkill waybar || waybar"
      ];

      # Mouse bindings
      bindm = [
        "$mainMod, mouse:272, movewindow"
        "$mainMod, mouse:273, resizewindow"
      ];

      # Media key bindings
      bindel = [
        ",XF86AudioRaiseVolume, exec, wpctl set-volume -l 1 @DEFAULT_AUDIO_SINK@ 5%+"
        ",XF86AudioLowerVolume, exec, wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-"
        ",XF86AudioMute, exec, wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"
        ",XF86AudioMicMute, exec, wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle"
        ",XF86MonBrightnessUp, exec, brightnessctl -e4 -n2 set 5%+"
        ",XF86MonBrightnessDown, exec, brightnessctl -e4 -n2 set 5%-"
      ];

      # Media player bindings
      bindl = [
        ", XF86AudioNext, exec, playerctl next"
        ", XF86AudioPause, exec, playerctl play-pause"
        ", XF86AudioPlay, exec, playerctl play-pause"
        ", XF86AudioPrev, exec, playerctl previous"
      ];

      # Window rules
      windowrule = [
        "suppressevent maximize, class:.*"
        "nofocus,class:^$,title:^$,xwayland:1,floating:1,fullscreen:0,pinned:0"
      ];
    };
  };

  # Hypridle configuration - idle daemon
  services.hypridle = {
    enable = true;
    settings = {
      general = {
        after_sleep_cmd = "hyprctl dispatch dpms on";
        ignore_dbus_inhibit = false;
        lock_cmd = "pidof hyprlock || hyprlock";
      };
      
      listener = [
        {
          timeout = 300;  # 5min
          on-timeout = "hyprlock";
        }
        {
          timeout = 330;  # 5.5min
          on-timeout = "hyprctl dispatch dpms off";
          on-resume = "hyprctl dispatch dpms on";
        }
        {
          timeout = 1800; # 30min
          on-timeout = "systemctl suspend";
        }
      ];
    };
  };

  # Waybar configuration
  programs.waybar = {
    enable = true;
    settings = {
      mainBar = {
        layer = "top";
        position = "top";
        height = 40;
        spacing = 4;
        
        modules-left = ["hyprland/workspaces" "hyprland/mode" "custom/media"];
        modules-center = ["hyprland/window"];
        modules-right = ["pulseaudio" "network" "cpu" "memory" "temperature" "battery" "clock" "tray"];
        
        "hyprland/workspaces" = {
          disable-scroll = true;
          all-outputs = true;
          warp-on-scroll = false;
          format = "{icon}";
          format-icons = {
            "1" = "󰲠";
            "2" = "󰲢";
            "3" = "󰲤";
            "4" = "󰲦";
            "5" = "󰲨";
            "6" = "󰲪";
            "7" = "󰲬";
            "8" = "󰲮";
            "9" = "󰲰";
            "10" = "󰿬";
            urgent = "";
            focused = "";
            default = "";
          };
        };
        
        "hyprland/mode" = {
          format = "<span style=\"italic\">  {}</span>";
        };
        
        "hyprland/window" = {
          format = "{}";
          max-length = 50;
          separate-outputs = true;
        };
        
        tray = {
          icon-size = 18;
          spacing = 10;
        };
        
        clock = {
          timezone = "America/Chicago"; # Change to your timezone
          tooltip-format = "<big>{:%Y %B}</big>\n<tt><small>{calendar}</small></tt>";
          format = "{:%H:%M}";
          format-alt = "{:%Y-%m-%d}";
        };
        
        cpu = {
          format = "  {usage}%";
          tooltip = false;
        };
        
        memory = {
          format = "  {}%";
        };
        
        temperature = {
          thermal-zone = 2;
          hwmon-path = "/sys/class/hwmon/hwmon2/temp1_input";
          critical-threshold = 80;
          format-critical = "{temperatureC}°C {icon}";
          format = "{temperatureC}°C {icon}";
          format-icons = ["" "" ""];
        };
        
        battery = {
          states = {
            good = 95;
            warning = 30;
            critical = 15;
          };
          format = "{icon} {capacity}%";
          format-charging = " {capacity}%";
          format-plugged = " {capacity}%";
          format-alt = "{icon} {time}";
          format-icons = ["󰂎" "󰁺" "󰁻" "󰁼" "󰁽" "󰁾" "󰁿" "󰂀" "󰂁" "󰂂" "󰁹"];
        };
        
        network = {
          format-wifi = "  {essid} ({signalStrength}%)";
          format-ethernet = " {ipaddr}/{cidr}";
          tooltip-format = " {ifname} via {gwaddr}";
          format-linked = " {ifname} (No IP)";
          format-disconnected = "⚠ Disconnected";
          format-alt = "{ifname}: {ipaddr}/{cidr}";
        };
        
        pulseaudio = {
          format = "{icon} {volume}%";
          format-bluetooth = "{icon} {volume}% ";
          format-bluetooth-muted = "󰸈 {icon}";
          format-muted = "󰸈";
          format-source = " {volume}%";
          format-source-muted = "";
          format-icons = {
            headphone = "";
            hands-free = "󰏳";
            headset = "󰏳";
            phone = "";
            portable = "";
            car = "";
            default = ["" "" ""];
          };
          on-click = "pavucontrol";
        };
        
        "custom/media" = {
          format = "{icon} {}";
          return-type = "json";
          max-length = 40;
          format-icons = {
            spotify = "";
            default = "🎵";
          };
          escape = true;
          exec = "$HOME/.config/waybar/mediaplayer.py 2> /dev/null";
        };
      };
    };
    
    style = ''
      * {
        border: none;
        border-radius: 0;
        font-family: "JetBrains Mono Nerd Font", "Font Awesome 6 Free";
        font-size: 13px;
        min-height: 0;
      }
      
      window#waybar {
        background: linear-gradient(135deg, rgba(26, 27, 38, 0.95), rgba(40, 42, 54, 0.95));
        color: #f8f8f2;
        border-bottom: 3px solid rgba(189, 147, 249, 0.7);
        transition: all 0.3s ease;
      }
      
      #workspaces {
        background: linear-gradient(135deg, rgba(68, 71, 90, 0.8), rgba(40, 42, 54, 0.8));
        margin: 5px;
        padding: 0px 5px;
        border-radius: 15px;
        border: 1px solid rgba(98, 114, 164, 0.3);
      }
      
      #workspaces button {
        padding: 5px 10px;
        border-radius: 15px;
        margin: 0 3px;
        background: transparent;
        color: rgba(248, 248, 242, 0.6);
        transition: all 0.3s ease;
      }
      
      #workspaces button:hover {
        background: rgba(139, 233, 253, 0.2);
        color: #8be9fd;
        box-shadow: 0 0 10px rgba(139, 233, 253, 0.3);
      }
      
      #workspaces button.active {
        background: linear-gradient(135deg, rgba(189, 147, 249, 0.8), rgba(255, 121, 198, 0.6));
        color: #f8f8f2;
        box-shadow: 0 0 15px rgba(189, 147, 249, 0.5);
      }
      
      #workspaces button.urgent {
        background: rgba(255, 85, 85, 0.8);
        color: #f8f8f2;
        animation: blink 1s linear infinite alternate;
      }
      
      @keyframes blink {
        to { background: rgba(255, 85, 85, 0.4); }
      }
      
      #mode {
        background: rgba(255, 184, 108, 0.8);
        color: #1a1b26;
        padding: 5px 15px;
        margin: 5px;
        border-radius: 15px;
        font-weight: bold;
      }
      
      #window {
        background: rgba(68, 71, 90, 0.6);
        padding: 5px 15px;
        margin: 5px 20px;
        border-radius: 15px;
        color: #f8f8f2;
        border: 1px solid rgba(98, 114, 164, 0.3);
      }
      
      #clock,
      #battery,
      #cpu,
      #memory,
      #temperature,
      #network,
      #pulseaudio,
      #custom-media,
      #tray {
        background: rgba(68, 71, 90, 0.8);
        padding: 5px 15px;
        margin: 5px 3px;
        border-radius: 15px;
        color: #f8f8f2;
        border: 1px solid rgba(98, 114, 164, 0.3);
        transition: all 0.3s ease;
      }
      
      #clock:hover,
      #battery:hover,
      #cpu:hover,
      #memory:hover,
      #temperature:hover,
      #network:hover,
      #pulseaudio:hover {
        background: linear-gradient(135deg, rgba(139, 233, 253, 0.2), rgba(189, 147, 249, 0.2));
        box-shadow: 0 0 10px rgba(139, 233, 253, 0.3);
      }
      
      #battery.charging {
        background: linear-gradient(135deg, rgba(80, 250, 123, 0.8), rgba(139, 233, 253, 0.6));
      }
      
      #battery.warning:not(.charging) {
        background: rgba(255, 184, 108, 0.8);
        color: #1a1b26;
      }
      
      #battery.critical:not(.charging) {
        background: rgba(255, 85, 85, 0.8);
        color: #f8f8f2;
        animation: blink 0.5s linear infinite alternate;
      }
      
      #cpu.warning {
        background: rgba(255, 184, 108, 0.8);
        color: #1a1b26;
      }
      
      #cpu.critical {
        background: rgba(255, 85, 85, 0.8);
        color: #f8f8f2;
      }
      
      #temperature.critical {
        background: rgba(255, 85, 85, 0.8);
        color: #f8f8f2;
        animation: blink 0.5s linear infinite alternate;
      }
      
      #network.disconnected {
        background: rgba(255, 85, 85, 0.8);
        color: #f8f8f2;
      }
      
      #pulseaudio.muted {
        background: rgba(248, 248, 242, 0.2);
        color: rgba(248, 248, 242, 0.5);
      }
      
      #tray {
        margin-right: 10px;
      }
      
      #tray > .passive {
        -gtk-icon-effect: dim;
      }
      
      #tray > .needs-attention {
        -gtk-icon-effect: highlight;
        background: rgba(255, 184, 108, 0.8);
      }
    '';
  };

  # Hyprlock configuration - screen locker
  programs.hyprlock = {
    enable = true;
    settings = {
      general = {
        disable_loading_bar = true;
        grace = 300;
        hide_cursor = true;
        no_fade_in = false;
      };
      
      background = [{
        path = "screenshot";
        blur_passes = 3;
        blur_size = 8;
      }];
      
      input-field = [{
        size = "200, 50";
        position = "0, -80";
        monitor = "";
        dots_center = true;
        fade_on_empty = false;
        font_color = "rgb(202, 211, 245)";
        inner_color = "rgb(91, 96, 120)";
        outer_color = "rgb(24, 25, 38)";
        outline_thickness = 5;
        placeholder_text = "<span foreground=\"##cad3f5\">Password...</span>";
        shadow_passes = 2;
      }];
      
      label = [
        {
          text = "cmd[update:1000] echo \"<b><big> $(date +\"%H:%M:%S\") </big></b>\"";
          color = "rgb(202, 211, 245)";
          font_size = 64;
          font_family = "JetBrains Mono Nerd Font 10";
          position = "0, 16";
          halign = "center";
          valign = "center";
        }
        {
          text = "cmd[update:43200000] echo \"<b><big> \"$(date +\"%A, %B %d, %Y\")\" </big></b>\"";
          color = "rgb(202, 211, 245)";
          font_size = 25;
          font_family = "JetBrains Mono Nerd Font 10";
          position = "0, -16";
          halign = "center";
          valign = "center";
        }
      ];
    };
  };
  programs.atuin = {
    enable = true;
    settings = {
      auto_sync = false;
      #sync_frequency = "5m";
      #sync_address = "https://api.atuin.sh";
      search_mode = "fuzzy";
    };
  };
}
