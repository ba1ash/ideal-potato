{ pkgs, inputs, host, ... }:
{
  imports = [ inputs.nix-doom-emacs.hmModule ];
  xsession.windowManager.i3 = {
    enable = true;
    config = rec {
      modifier = "Mod1";
      terminal = "alacritty";
      fonts = {
        names = [ "FontAwesomeSFree" ];
        style = "Bold Semi-Condensed";
        size = 15.0;
      };
      keybindings = pkgs.lib.mkOptionDefault {
        "${modifier}+h" = "focus left";
        "${modifier}+j" = "focus down";
        "${modifier}+k" = "focus up";
        "${modifier}+l" = "focus right";

        "${modifier}+Shift+h" = "move left";
        "${modifier}+Shift+j" = "move down";
        "${modifier}+Shift+k" = "move up";
        "${modifier}+Shift+l" = "move right";
      };
      bars = [
        {
          fonts = {
            names = [ "FontAwesomeSFree" ];
            style = "Bold Semi-Condensed";
            size = 15.0;
          };
          statusCommand = "${pkgs.i3status-rust}/bin/i3status-rs ~/.config/i3status-rust/config-bottom.toml";
        }
      ];

    };
  };
  home.packages = [
    pkgs.nix-prefetch-git
    pkgs.grc
  ];
  programs.home-manager.enable = true;
  programs = {
    doom-emacs = {
      enable = true;
      doomPrivateDir = ./doom.d;
    };
    z-lua = {
      enable = true;
      enableBashIntegration = true;
      # enableFishIntegration = true;
    };
    direnv = {
      enable = true;
      enableBashIntegration = true;
      # enableFishIntegration = true;
      nix-direnv = {
        enable = true;
      };
    };
    alacritty = {
      enable = true;
      # https://github.com/alacritty/alacritty/blob/master/alacritty.yml
      settings = {
        shell = {
          program = "/run/current-system/sw/bin/bash";
          args = [
            "--login"
          ];
        };
        key_bindings = [
          {
            key = "Return";
            mods = "Control|Shift";
            action = "SpawnNewInstance";
          }
        ];
      };
    };
    fzf = {
      enable = true;
      enableBashIntegration = true;
      # enableFishIntegration = true;
    };
    qutebrowser = {
      enable = true;
      settings = {
        fonts.default_size = "20pt";
        qt.highdpi = true;
      };
      keyBindings = {
        command = {
          "<Ctrl-j>" = "completion-item-focus next";
          "<Ctrl-k>" = "completion-item-focus --history prev";
        };
      };
    };
    git = {
      enable = true;
      userName = "Pavel Balashov";
      userEmail = "ba1ashpash@gmail.com";
    };
    bash = {
      enable = true;
      bashrcExtra = ''
        nixify() {
          if [ ! -e ./.envrc ]; then
            echo "use nix" > .envrc
            direnv allow
          fi
          if [[ ! -e shell.nix ]] && [[ ! -e default.nix ]]; then
            cat > default.nix <<'EOF'
        with import <nixpkgs> {};
        mkShell {
          nativeBuildInputs = [
            bashInteractive
          ];
        }
        EOF
            vim default.nix
          fi
        }

        flakifiy() {
          if [ ! -e flake.nix ]; then
            nix flake new -t github:nix-community/nix-direnv .
          elif [ ! -e .envrc ]; then
            echo "use flake" > .envrc
            direnv allow
          fi
          vim flake.nix
        }
      '';
    };
    i3status-rust = {
      enable = true;
      bars = {
        bottom = {
          blocks = import (./. + (builtins.toPath "/blocks_${host}.nix"));
          settings = {
            icons = "material";
            theme = {
              name = "plain";
            };
          };
        };
      };
    };
  };
  home.username = "ba1ash";
  home.homeDirectory = "/home/ba1ash";
  home.stateVersion = "21.05";
}
