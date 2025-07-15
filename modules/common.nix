# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{
  config,
  pkgs,
  inputs,
  self,
  ...
}:

{
  imports = [
    ./hyprland.nix
    inputs.home-manager.nixosModules.default
  ];
  nix.settings.experimental-features = [
    "nix-command"
    "flakes"
  ];
  services.flatpak.enable = true;
  # Bootloader.
  boot.loader.grub.device = "nodev";
  boot.loader.efi.canTouchEfiVariables = true;
  boot.loader.grub.enable = true;
  boot.loader.grub.efiSupport = true;
  boot.loader.grub.useOSProber = true;
  boot.loader.grub.default = "saved";
  boot.loader.grub.gfxmodeEfi = "1920x1080";
  boot.loader.grub.theme = pkgs.catppuccin-grub;

  # Use latest kernel.
  boot.kernelPackages = pkgs.linuxPackages_latest;

  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Enable networking
  networking.networkmanager.enable = true;

  # Set your time zone.
  time.timeZone = "America/Denver";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.UTF-8";

  i18n.extraLocaleSettings = {
    LC_ADDRESS = "en_US.UTF-8";
    LC_IDENTIFICATION = "en_US.UTF-8";
    LC_MEASUREMENT = "en_US.UTF-8";
    LC_MONETARY = "en_US.UTF-8";
    LC_NAME = "en_US.UTF-8";
    LC_NUMERIC = "en_US.UTF-8";
    LC_PAPER = "en_US.UTF-8";
    LC_TELEPHONE = "en_US.UTF-8";
    LC_TIME = "en_US.UTF-8";
  };

  # Configure keymap in X11
  services.xserver.xkb = {
    layout = "us";
    variant = "";
  };
  environment.sessionVariables = {
    XDG_CACHE_HOME = "$HOME/.cache";
    XDG_CONFIG_HOME = "$HOME/.config";
    XDG_DATA_HOME = "$HOME/.local/share";
    XDG_STATE_HOME = "$HOME/.local/state";
  };
  # neovim and fish
  programs.neovim.defaultEditor = true;
  programs.fish.enable = true;
  users.defaultUserShell = pkgs.fish;
  users.users.mason = {
    isNormalUser = true;
    description = "Mason Braithwaite";
    extraGroups = [
      "networkmanager"
      "wheel"
    ];
    packages = with pkgs; [ ];
    shell = pkgs.fish;
  };
  # ho manager
  home-manager = {
    extraSpecialArgs = { inherit inputs; };
    users = {
      "mason" = {
        imports = [ inputs.nix4nvchad.homeManagerModule ];
        programs.git = {
          enable = true;
          userName = "Mason Braithwaite";
          userEmail = "mason@braith.net";
        };
        programs.nvchad = {
          enable = true;
          chadrcConfig = ''
            -- This file needs to have same structure as nvconfig.lua 
            -- https://github.com/NvChad/ui/blob/v3.0/lua/nvconfig.lua
            -- Please read that file to know all available options :( 

            ---@type ChadrcConfig
            local M = {}

            M.base46 = {
            	theme = "chadtain",

            	-- hl_override = {
            	-- 	Comment = { italic = true },
            	-- 	["@comment"] = { italic = true },
            	-- },
            }

            M.nvdash = { load_on_startup = true }
            M.ui.statusline = {
              theme = "minimal",
              separator_style = "rounded"
            }
            -- M.ui = {
            --       tabufline = {
            --          lazyload = false
            --      }
            --}

            return M'';
        };
        home.stateVersion = "25.05";
        xdg.configFile = {
          omf = {
            source = ../config/omf;
            recursive = true;
          };
          fish = {
            source = ../config/fish;
            recursive = true;
          };
        };
      };
    };
  };

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;
  nixpkgs.config.catppuccin-grub.flavor = "frappe";
  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
    home-manager
    ripgrep
    firefox
    wget
    tmux
    vscode
    git
    gnumake
    python313
    python313Packages.pip
    cargo
    nodejs
    libgccjit # gcc and all the things
    gcc
    google-chrome
    pipes
    cmatrix
    oh-my-fish
    nixfmt-rfc-style
    go
  ];

# pmo time issues 
  time.hardwareClockInLocalTime = true;

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  # };

  # List services that you want to enable:

  # Enable the OpenSSH daemon.
  # services.openssh.enable = true;

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "25.05"; # Did you read the comment?

}
