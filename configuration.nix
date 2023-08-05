# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ inputs, config, pkgs, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
    ]
    # ++ (with inputs.nixos-hardware.nixosModules; [
    #   common-cpu-amd
    #   common-gpu-nvidia
    #   common-pc-ssd
    # ])
    ++ [
      inputs.xremap.nixosModules.default
    ];

  # Bootloader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  # Setup keyfile
  boot.initrd.secrets = {
    "/crypto_keyfile.bin" = null;
  };

  networking.hostName = "archimedes"; # Define your hostname.
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Enable networking
  networking.networkmanager.enable = true;

  # Set your time zone.
  time.timeZone = "Asia/Tokyo";

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

  i18n.inputMethod = {
    enabled = "fcitx5";
    fcitx5.addons = [pkgs.fcitx5-mozc];
  };

  fonts = {
    packages = with pkgs; [
      noto-fonts-cjk-serif
      noto-fonts-cjk-sans
      noto-fonts-emoji
      nerdfonts
    ];
    fontDir.enable = true;
    fontconfig = {
      defaultFonts = {
        serif = ["Noto Serif CJK JP" "Noto Color Emoji"];
        sansSerif = ["Noto Sans CJK JP" "Noto Color Emoji"];
        monospace = ["JetBrainsMono Nerd Font" "Noto Color Emoji"];
        emoji = ["Noto Color Emoji"];
      };
    };
  };

  # Enable the X11 windowing system.
  services.xserver.enable = true;

  # Enable the GNOME Desktop Environment.
  services.xserver.displayManager.gdm.enable = true;
  services.xserver.desktopManager.gnome.enable = true;

  # Configure keymap in X11
  services.xserver = {
    layout = "jp";
    xkbVariant = "";
  };

  # Configure console keymap
  console.keyMap = "jp106";

  # Enable CUPS to print documents.
  services.printing.enable = true;

  # Enable sound with pipewire.
  sound.enable = true;
  hardware.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    # If you want to use JACK applications, uncomment this
    #jack.enable = true;

    # use the example session manager (no others are packaged yet so this is enabled by default,
    # no need to redefine it in your config for now)
    #media-session.enable = true;
  };

  # Enable touchpad support (enabled default in most desktopManager).
  # services.xserver.libinput.enable = true;

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.kkinugasa = {
    isNormalUser = true;
    description = "kkinugasa";
    extraGroups = [ "networkmanager" "wheel" ];
    packages = with pkgs; [
      firefox
    #  thunderbird
    ];
  };

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
    vim # Do not forget to add an editor to edit configuration.nix! The Nano editor is also installed by default.
    wev
    wget
  ];

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  # };
  programs.git.enable = true;

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
  system.stateVersion = "23.05"; # Did you read the comment?

  nix = {
    package = pkgs.nixFlakes;
    settings = {
      auto-optimise-store = true;
      experimental-features = ["nix-command" "flakes"];
    };
    gc = {
      automatic = true;
      dates = "weekly";
      options = "--delete-older-than 7d";
    };
    # nixPath = ["nixos-config=/home/kkinugasa/dotfiles/configuration.nix"];
  };
  services.xremap = {
    userName = "kkinugasa";
    serviceMode = "system";
    config = {
      modmap = [
        {
          name = "My config";
          remap = {
            CapsLock = "Ctrl_L";
            Muhenkan = "Alt_L";
            Henkan = "Shift_R";
            KatakanaHiragana = "Shift_R";
          };
        }
      ];
      # keymap = [
      #   {
      #     name = "Emacs-like";
      #     application = { only = "Google-chrome"; };
      #     remap = {
      #       # Cursor
      #       C-b = { with_mark = "left"; };
      #       C-f = { with_mark = "right"; };
      #       C-p = { with_mark = "up"; };
      #       C-n = { with_mark = "down"; };
      #       # Forward/Backward word
      #       M-b = { with_mark = "C-left"; };
      #       M-f = { with_mark = "C-right"; };
      #       # Beginning/End of line
      #       C-a = { with_mark = "home"; };
      #       C-e = { with_mark = "end"; };
      #       # # Page up/down
      #       # M-v = "pageup";
      #       # C-v = "pagedown";
      #       # Newline
      #       C-m = "enter";
      #       # Tab
      #       C-i = "tab";
      #       # Copy
      #       # C-w = ["C-x" { set_mark = false; }];
      #       M-w = ["C-c" { set_mark = false; }];
      #       C-y = ["C-v" { set_mark = false; }];
      #       # Delete
      #       C-d = ["delete" { set_mark = false; }];
      #       M-d = ["C-delete" { set_mark = false; }];
      #       C-h = ["Backspace" { set_mark = false; }];
      #       M-h = ["C-Backspace" { set_mark = false; }];
      #       # # Search
      #       # C-s = "F3";
      #       # C-r = "Shift-F3";
      #       # Kill line
      #       # C-k = ["Shift-end" "C-x" { set_mark = false; }];
      #       # # C-x YYY
      #       # # C-x = {
      #       #   remap = {
      #       #     # C-x h (select all)
      #       #     h = "C-home, C-a";
      #       #   };
      #       # }
      #     };
      #   }
      # ];
    };
  };

  # https://nixos.wiki/wiki/Nvidia
  # Make sure opengl is enabled
  hardware.opengl = {
    enable = true;
    driSupport = true;
    driSupport32Bit = true;
  };

  # Tell Xorg to use the nvidia driver (also valid for Wayland)
  services.xserver.videoDrivers = ["nvidia"];

  hardware.nvidia = {

    # Modesetting is needed for most Wayland compositors
    modesetting.enable = true;

    # Use the open source version of the kernel module
    # Only available on driver 515.43.04+
    open = false;

    # Enable the nvidia settings menu
    nvidiaSettings = true;

    # Optionally, you may need to select the appropriate driver version for your specific GPU.
    package = config.boot.kernelPackages.nvidiaPackages.stable;
  };
}
