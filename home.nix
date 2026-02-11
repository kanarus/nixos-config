{ config, pkgs, ... }:

{
  programs.home-manager.enable = true;

  home.username = "kanarus";
  home.homeDirectory = "/home/kanarus";
  home.stateVersion = "25.11";
  home.packages = with pkgs; [
    wl-clipboard # clipboard sharing with host OS
    cliphist
  ];

  wayland.windowManager.hyprland = {
    enable = true;

    xwayland.enable = true;

    settings = {
      monitor = ",2560x1440@60,0x0,1";

      "$mod" = "SUPER";
      "$terminal" = "alacritty";
      "$browser" = "google-chrome-stable"; # pkg `google-chrome` provides command `google-chrome-stable`!
      "$menu" = "wofi --show drun";

      exec-once = [
        "sleep 5 && spice-vdagent -s /run/spice-vdagentd/spice-vdagent-sock"
        "wl-paste --watch cliphist store"
      ];

      general = {
        gaps_in = 5;
        gaps_out = 10;
        border_size = 2;
        "col.active_border" = "rgba(33ccffee) rgba(00ff99ee) 45deg";
        "col.inactive_border" = "rgba(595959aa)";
        layout = "dwingle";
      };
      
      decoration = {
        rounding = 10;
        blur = {
          enabled = true;
          size = 3;
          passes = 1;
        };
      };
      
      bind = [
        "$mod, A, exec, $terminal"
        "$mod, B, exec, $browser"
        # "$mod, E, exec, dolphin"   # file manager
        "$mod, Space, exec, $menu" # wofi is recommended

        "$mod, C, killactive,"
        "$mod, M, exit,"
        "$mod, V, togglefloating,"
        "$mod, P, pseudo,"
        "$mod, J, togglesplit,"

        "$mod, left, movefocus, l"
        "$mod, right, movefocus, r"
        "$mod, up, movefocus, u"
        "$mod, down, movefocus, d"
      ];

      bindm = [
        "$mod, mouse:272, movewindow"
        "$mod, mouse:273, resizewindow"
      ];
    };
  };
    
  programs.zsh = {
    enable = true;
    enableCompletion = true;
    autocd = true;
    autosuggestion.enable = true;
    syntaxHighlighting = {
      enable = true;
      styles = {
        comment = "fg=#9e9e9e";
      };
    };
    initContent = ''
      setopt INTERACTIVE_COMMENTS

      bindkey ";5C" forward-word
      bindkey ";5D" backward-word

      function maybe_git_branch() {
        git_output=$(git symbolic-ref --short HEAD 2>&1)
        if [[ $git_output =~ '^fatal: ' ]]; then
          echo ""
        else
          echo '(%F{124}'$git_output'%F{153})'
        fi
      }      
      setopt PROMPT_SUBST
      export PS1='%F{153}[%n%F{111}@%m%F{153}:%~]$(maybe_git_branch)%f '

      typeset -Ag abbreviations
      abbreviations=(
        "ns"   "sudo nixos-rebuild switch --flake ~/nixos-config"
        "com"  "git add . && git commit -m"
        "po"   "git push origin"
        "push" "git push"
      )
      function expand_abbreviation() {
        local MATCH
        # empty quotes: workaround to avoid nix's interpretation on the $-brace syntax,
        # which here leads to an syntax error on nix side
        setopt EXTENDED_GLOB
        LBUFFER=''${LBUFFER%%(#m)[_a-zA-Z0-9]#}
        unsetopt EXTENDED_GLOB
        LBUFFER+=''${abbreviations[$MATCH]:-$MATCH}
        zle self-insert
      }
      zle -N expand_abbreviation
      bindkey " " expand_abbreviation
      bindkey -M isearch " " self-insert
    '';
  };

  programs.helix = {
    enable = true;
    settings = {
      theme = "sonokai";
    };
  };

  programs.alacritty = {
    enable = true;
    settings = {
      font = {
        normal = { family = "UDEV Gothic 35NF"; style = "Regular"; };
        size = 16;
      };
      colors = {
        primary = { background = "#1c1c1c"; };
      };
    };
  };

  programs.direnv = {
    enable = true;
    nix-direnv.enable = true;
  };

  programs.google-chrome.enable = true;

  programs.gpg.enable = true;

  services.gpg-agent = {
    enable = true;
    pinentry.package = pkgs.pinentry-gnome3;
    enableSshSupport = true;
  };

  programs.git = {
    enable = true;
    ignores = [
      ".direnv"
    ];
    settings = {
      user = {
        name = "kanarus";
        email = "mail@kanarus.dev";
        signingKey = "5623D3EF85F1D635";
      };
      commit.gpgSign = true;
      init.defaultBranch = "main";
    };
  };

  programs.wofi = {
    enable = true;
  };

  i18n.inputMethod = {
    enable = true;
    type = "fcitx5";
    fcitx5 = {
      addons = [ pkgs.fcitx5-mozc ];
      settings.inputMethod = {
        GroupOrder."0" = "Default";
        "Groups/0" = {
          Name = "Default";
          "Default Layout" = "us";
          DefaultIM = "mozc";
        };
        "Groups/0/Items/0" = {
          Name = "keyboard-us";
          Layout = "";
        };
        "Groups/0/Items/1" = {
          Name = "mozc";
          Layout = "";
        };
      };
    };
  };
}
