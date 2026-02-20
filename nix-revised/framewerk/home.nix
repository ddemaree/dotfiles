{ pkgs, inputs, ... }:

let
  catppuccin = {
    base = "1e1e2e";
    mantle = "181825";
    crust = "11111b";
    surface0 = "313244";
    surface1 = "45475a";
    surface2 = "585b70";
    overlay0 = "6c7086";
    overlay1 = "7f849c";
    text = "cdd6f4";
    subtext0 = "a6adc8";
    subtext1 = "bac2de";
    lavender = "b4befe";
    blue = "89b4fa";
    sapphire = "74c7ec";
    sky = "89dceb";
    teal = "94e2d5";
    green = "a6e3a1";
    yellow = "f9e2af";
    peach = "fab387";
    maroon = "eba0ac";
    red = "f38ba8";
    mauve = "cba6f7";
    pink = "f5c2e7";
    flamingo = "f2cdcd";
    rosewater = "f5e0dc";
  };
in
{
  home.username = "david";
  home.homeDirectory = "/home/david";
  home.stateVersion = "25.11";

  programs.home-manager.enable = true;

  home.sessionVariables = {
    EDITOR = "nvim";
  };

  # ---------------------------------------------------------------------------
  # Shell configuration
  # ---------------------------------------------------------------------------
  programs.zsh = {
    enable = true;
    enableCompletion = true;
  };

  programs.fish = {
    enable = true;
    interactiveShellInit = ''
      tv init fish | source
    '';
    shellAliases = {
      ll = "eza -l";
      la = "eza -la";
      update = "sudo nixos-rebuild switch --flake ~/Code/dotfiles/nix-revised#framewerk";
    };
  };

  programs.git.enable = true;

  programs.delta = {
    enable = true;
    options.navigate = true;
  };

  programs.zoxide = {
    enable = true;
    enableFishIntegration = true;
    enableZshIntegration = true;
  };

  programs.fzf.enable = true;
  programs.starship.enable = true;

  programs.television = {
    enable = true;
    enableFishIntegration = false; # using manual init instead
  };

  # ---------------------------------------------------------------------------
  # Hyprland compositor
  # ---------------------------------------------------------------------------
  wayland.windowManager.hyprland = {
    enable = true;
    package = inputs.hyprland.packages.${pkgs.stdenv.hostPlatform.system}.hyprland;
    systemd.enable = true;
    xwayland.enable = true;

    settings = {
      # -- Monitors --
      monitor = [
        "eDP-1, 2560x1600@165, 0x0, 1.5"
        ", preferred, auto, 1"
      ];

      # -- Environment --
      env = [
        "XCURSOR_SIZE,24"
        "XCURSOR_THEME,Bibata-Modern-Classic"
        "QT_QPA_PLATFORM,wayland;xcb"
        "QT_WAYLAND_DISABLE_WINDOWDECORATION,1"
        "XDG_CURRENT_DESKTOP,Hyprland"
        "XDG_SESSION_TYPE,wayland"
        "XDG_SESSION_DESKTOP,Hyprland"
      ];

      # -- Autostart --
      exec-once = [
        "gnome-keyring-daemon --start --components=pkcs11,secrets,ssh"
        "dunst"
        "hyprpaper"
        "waybar"
        "nm-applet --indicator"
        "wl-paste --type text --watch cliphist store"
        "wl-paste --type image --watch cliphist store"
      ];

      # -- Input --
      input = {
        kb_layout = "us";
        follow_mouse = 1;
        sensitivity = 0;
        touchpad = {
          natural_scroll = true;
          tap-to-click = true;
          drag_lock = true;
        };
      };

      # -- General --
      general = {
        gaps_in = 4;
        gaps_out = 8;
        border_size = 2;
        "col.active_border" = "rgba(${catppuccin.lavender}ee) rgba(${catppuccin.mauve}ee) 45deg";
        "col.inactive_border" = "rgba(${catppuccin.surface0}aa)";
        layout = "dwindle";
        allow_tearing = false;
      };

      # -- Decoration --
      decoration = {
        rounding = 8;
        blur = {
          enabled = true;
          size = 5;
          passes = 3;

          ignore_opacity = true;
        };
        shadow = {
          enabled = true;
          range = 8;
          render_power = 2;
          color = "rgba(${catppuccin.crust}99)";
        };
      };

      # -- Animations --
      animations = {
        enabled = true;
        bezier = [
          "snappy, 0.05, 0.9, 0.1, 1.0"
        ];
        animation = [
          "windows, 1, 5, snappy, slide"
          "windowsOut, 1, 5, snappy, slide"
          "fade, 1, 5, snappy"
          "workspaces, 1, 4, snappy, slide"
          "border, 1, 5, snappy"
        ];
      };

      # -- Layout --
      dwindle = {
        pseudotile = true;
        preserve_split = true;
      };

      # -- Misc --
      misc = {
        disable_hyprland_logo = true;
      };

      cursor = {
        no_hardware_cursors = true;
      };

      # -- Window Rules --
      windowrule = [
        "float on, match:class ^(pavucontrol)$"
        "float on, match:class ^(nm-connection-editor)$"
        "float on, match:class ^(1Password)$"
        "float on, match:title ^(Open File)$"
        "float on, match:title ^(Open Folder)$"
        "float on, match:title ^(Save As)$"
        "float on, match:title ^(File Upload)$"
        "float on, match:class ^(xdg-desktop-portal-gtk)$"
        "float on, match:class ^(org.gnome.Nautilus)$, match:title ^(Properties)$"
      ];

      # -- Keybindings --
      "$mod" = "SUPER";

      bind = [
        # Applications
        "$mod, Return, exec, ghostty"
        "$mod, Q, killactive"
        "$mod, Space, exec, rofi -show drun -show-icons"
        "$mod, E, exec, nautilus"
        "$mod, Escape, exec, hyprlock"

        # Window management
        "$mod, F, fullscreen, 1"
        "$mod SHIFT, F, fullscreen, 0"
        "$mod, V, togglefloating"
        "$mod, P, pseudo"
        "$mod, S, togglesplit"

        # Focus (vim keys)
        "$mod, H, movefocus, l"
        "$mod, L, movefocus, r"
        "$mod, K, movefocus, u"
        "$mod, J, movefocus, d"

        # Move windows (vim keys)
        "$mod SHIFT, H, movewindow, l"
        "$mod SHIFT, L, movewindow, r"
        "$mod SHIFT, K, movewindow, u"
        "$mod SHIFT, J, movewindow, d"

        # Workspaces
        "$mod, 1, workspace, 1"
        "$mod, 2, workspace, 2"
        "$mod, 3, workspace, 3"
        "$mod, 4, workspace, 4"
        "$mod, 5, workspace, 5"
        "$mod, 6, workspace, 6"
        "$mod, 7, workspace, 7"
        "$mod, 8, workspace, 8"
        "$mod, 9, workspace, 9"
        "$mod, 0, workspace, 10"

        # Move to workspaces
        "$mod SHIFT, 1, movetoworkspace, 1"
        "$mod SHIFT, 2, movetoworkspace, 2"
        "$mod SHIFT, 3, movetoworkspace, 3"
        "$mod SHIFT, 4, movetoworkspace, 4"
        "$mod SHIFT, 5, movetoworkspace, 5"
        "$mod SHIFT, 6, movetoworkspace, 6"
        "$mod SHIFT, 7, movetoworkspace, 7"
        "$mod SHIFT, 8, movetoworkspace, 8"
        "$mod SHIFT, 9, movetoworkspace, 9"
        "$mod SHIFT, 0, movetoworkspace, 10"

        # Mouse workspace scroll
        "$mod, mouse_down, workspace, e+1"
        "$mod, mouse_up, workspace, e-1"

        # Screenshots
        ", Print, exec, grimblast copy area"
        "$mod SHIFT, S, exec, grimblast copy area"
      ];

      # Mouse bindings
      bindm = [
        "$mod, mouse:272, movewindow"
        "$mod, mouse:273, resizewindow"
      ];

      # Media / brightness (repeat-enabled)
      bindel = [
        ", XF86AudioRaiseVolume, exec, wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%+"
        ", XF86AudioLowerVolume, exec, wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-"
        ", XF86MonBrightnessUp, exec, brightnessctl set 5%+"
        ", XF86MonBrightnessDown, exec, brightnessctl set 5%-"
      ];

      # Media keys (locked -- work even on lock screen)
      bindl = [
        ", XF86AudioMute, exec, wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"
        ", XF86AudioMicMute, exec, wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle"
        ", XF86AudioPlay, exec, playerctl play-pause"
        ", XF86AudioNext, exec, playerctl next"
        ", XF86AudioPrev, exec, playerctl previous"
      ];
    };
  };

  # ---------------------------------------------------------------------------
  # Hyprlock -- screen locker
  # ---------------------------------------------------------------------------
  programs.hyprlock = {
    enable = true;
    settings = {
      general = {
        grace = 5;
        hide_cursor = true;
      };

      background = [
        {
          monitor = "";
          path = "screenshot";
          blur_passes = 4;
          blur_size = 6;
          noise = 0.02;
        }
      ];

      input-field = [
        {
          monitor = "";
          size = "300, 50";
          outline_thickness = 2;
          dots_size = 0.25;
          dots_spacing = 0.3;
          outer_color = "rgb(${catppuccin.lavender})";
          inner_color = "rgb(${catppuccin.surface0})";
          font_color = "rgb(${catppuccin.text})";
          fade_on_empty = true;
          placeholder_text = "<i>Password...</i>";
          halign = "center";
          valign = "center";
          position = "0, -50";
        }
      ];

      label = [
        {
          monitor = "";
          text = "$TIME";
          font_size = 64;
          font_family = "CaskaydiaMono Nerd Font";
          color = "rgb(${catppuccin.text})";
          halign = "center";
          valign = "center";
          position = "0, 100";
        }
      ];
    };
  };

  # ---------------------------------------------------------------------------
  # Hypridle -- idle manager
  # ---------------------------------------------------------------------------
  services.hypridle = {
    enable = true;
    settings = {
      general = {
        lock_cmd = "pidof hyprlock || hyprlock";
        before_sleep_cmd = "loginctl lock-session";
        after_sleep_cmd = "hyprctl dispatch dpms on";
      };

      listener = [
        {
          timeout = 300;
          on-timeout = "brightnessctl -s set 10";
          on-resume = "brightnessctl -r";
        }
        {
          timeout = 600;
          on-timeout = "loginctl lock-session";
        }
        {
          timeout = 900;
          on-timeout = "hyprctl dispatch dpms off";
          on-resume = "hyprctl dispatch dpms on";
        }
      ];
    };
  };

  # ---------------------------------------------------------------------------
  # Waybar -- status bar
  # ---------------------------------------------------------------------------
  programs.waybar = {
    enable = true;
    systemd.enable = false; # started by Hyprland exec-once
    settings = {
      mainBar = {
        layer = "top";
        position = "top";
        height = 36;
        margin-top = 6;
        margin-left = 8;
        margin-right = 8;
        spacing = 8;
        modules-left = [ "hyprland/workspaces" ];
        modules-center = [ "clock" ];
        modules-right = [
          "idle_inhibitor"
          "pulseaudio"
          "backlight"
          "battery"
          "network"
          "tray"
        ];

        "hyprland/workspaces" = {
          format = "{icon}";
          format-icons = {
            active = "";
            default = "";
            urgent = "";
          };
          on-click = "activate";
          sort-by-number = true;
        };

        clock = {
          format = "{:%a %b %d  %I:%M %p}";
          tooltip-format = "<tt>{calendar}</tt>";
        };

        idle_inhibitor = {
          format = "{icon}";
          format-icons = {
            activated = "";
            deactivated = "";
          };
        };

        pulseaudio = {
          format = "{icon} {volume}%";
          format-muted = " muted";
          format-icons = {
            default = [
              ""
              ""
              ""
            ];
          };
          on-click = "pavucontrol";
        };

        backlight = {
          format = "{icon} {percent}%";
          format-icons = [
            ""
            ""
            ""
            ""
            ""
          ];
        };

        battery = {
          states = {
            warning = 30;
            critical = 15;
          };
          format = "{icon} {capacity}%";
          format-charging = " {capacity}%";
          format-plugged = " {capacity}%";
          format-icons = [
            ""
            ""
            ""
            ""
            ""
          ];
        };

        network = {
          format-wifi = " {essid}";
          format-ethernet = " {ifname}";
          format-disconnected = " disconnected";
          tooltip-format = "{ipaddr}/{cidr}";
        };

        tray = {
          spacing = 8;
        };
      };
    };

    style = ''
      * {
        font-family: "CaskaydiaMono Nerd Font", "Font Awesome 6 Free";
        font-size: 13px;
        min-height: 0;
      }

      window#waybar {
        background: rgba(30, 30, 46, 0.85);
        color: #${catppuccin.text};
        border-radius: 12px;
        border: 1px solid #${catppuccin.surface0};
      }

      #workspaces button {
        padding: 0 6px;
        color: #${catppuccin.overlay0};
        border-radius: 8px;
        background: transparent;
        border: none;
      }

      #workspaces button.active {
        color: #${catppuccin.lavender};
        background: #${catppuccin.surface0};
      }

      #workspaces button.urgent {
        color: #${catppuccin.red};
      }

      #clock,
      #battery,
      #pulseaudio,
      #backlight,
      #network,
      #idle_inhibitor,
      #tray {
        padding: 0 10px;
        border-radius: 8px;
      }

      #battery.warning {
        color: #${catppuccin.yellow};
      }

      #battery.critical {
        color: #${catppuccin.red};
      }

      tooltip {
        background: #${catppuccin.mantle};
        color: #${catppuccin.text};
        border: 1px solid #${catppuccin.surface0};
        border-radius: 8px;
      }
    '';
  };

  # ---------------------------------------------------------------------------
  # Dunst -- notifications
  # ---------------------------------------------------------------------------
  services.dunst = {
    enable = true;
    settings = {
      global = {
        width = 350;
        height = 150;
        offset = "10x10";
        origin = "top-right";
        transparency = 10;
        frame_color = "#${catppuccin.lavender}";
        font = "CaskaydiaMono Nerd Font 11";
        corner_radius = 8;
        padding = 12;
        horizontal_padding = 12;
        frame_width = 2;
        icon_theme = "Papirus";
        enable_recursive_icon_lookup = true;
      };
      urgency_low = {
        background = "#${catppuccin.base}";
        foreground = "#${catppuccin.text}";
        frame_color = "#${catppuccin.surface1}";
      };
      urgency_normal = {
        background = "#${catppuccin.base}";
        foreground = "#${catppuccin.text}";
        frame_color = "#${catppuccin.lavender}";
      };
      urgency_critical = {
        background = "#${catppuccin.base}";
        foreground = "#${catppuccin.text}";
        frame_color = "#${catppuccin.red}";
      };
    };
  };

  # ---------------------------------------------------------------------------
  # Rofi -- app launcher
  # ---------------------------------------------------------------------------
  programs.rofi = {
    enable = true;
    package = pkgs.rofi;
    plugins = with pkgs; [
      rofi-emoji
      rofi-calc
    ];
    extraConfig = {
      show-icons = true;
      icon-theme = "Papirus";
      display-drun = " Apps";
      drun-display-format = "{name}";
      disable-history = false;
    };
    theme =
      let
        inherit (builtins) concatStringsSep;
      in
      builtins.toFile "catppuccin-mocha.rasi" ''
        * {
          bg: #${catppuccin.base};
          bg-alt: #${catppuccin.mantle};
          fg: #${catppuccin.text};
          accent: #${catppuccin.lavender};
          border-colour: #${catppuccin.surface0};
          background-color: @bg;
          text-color: @fg;
        }

        window {
          width: 600px;
          border: 2px;
          border-color: @border-colour;
          border-radius: 12px;
          padding: 20px;
        }

        inputbar {
          children: [ prompt, entry ];
          padding: 8px;
          background-color: @bg-alt;
          border-radius: 8px;
        }

        prompt {
          padding: 0 8px 0 0;
          text-color: @accent;
          background-color: transparent;
        }

        entry {
          background-color: transparent;
          placeholder: "Search...";
          placeholder-color: #${catppuccin.overlay0};
        }

        listview {
          lines: 8;
          columns: 1;
          spacing: 4px;
          padding: 8px 0 0 0;
          background-color: transparent;
        }

        element {
          padding: 8px;
          border-radius: 8px;
          background-color: transparent;
        }

        element selected {
          background-color: @bg-alt;
          text-color: @accent;
        }
      '';
  };

  # ---------------------------------------------------------------------------
  # Hyprpaper -- wallpaper
  # ---------------------------------------------------------------------------
  xdg.configFile."hypr/hyprpaper.conf".text = ''
    ipc = off
    splash = false
  '';

  # ---------------------------------------------------------------------------
  # GTK & cursor theming
  # ---------------------------------------------------------------------------
  gtk = {
    enable = true;
    iconTheme = {
      name = "Papirus-Dark";
      package = pkgs.papirus-icon-theme;
    };
    cursorTheme = {
      name = "Bibata-Modern-Classic";
      size = 24;
      package = pkgs.bibata-cursors;
    };
  };

  home.pointerCursor = {
    name = "Bibata-Modern-Classic";
    size = 24;
    package = pkgs.bibata-cursors;
    gtk.enable = true;
    x11.enable = true;
  };

  # ---------------------------------------------------------------------------
  # Packages
  # ---------------------------------------------------------------------------
  home.packages = with pkgs; [
    # Screenshots
    grimblast
    grim
    slurp

    # Clipboard
    wl-clipboard
    cliphist

    # Wallpaper
    hyprpaper

    # System controls
    brightnessctl
    playerctl

    # Utilities
    pavucontrol
    networkmanagerapplet
    nautilus
    wlr-randr

    # Theming
    papirus-icon-theme
    bibata-cursors

    # CLI tools
    gh
    lazygit
    lazydocker
    fastfetch
    btop
    distrobox
    python3
    gcc
    gnumake
    gnupg
    nodejs_22
    pnpm_9
    bun
    mise
    claude-code

    # GUI apps
    code-cursor
    ghostty
    warp-terminal
  ];
}
