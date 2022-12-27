{ config, pkgs, lib, ... }:

let unstable = import <nixos-unstable> { config = { allowUnfree = true; }; };
in let
  nvidia-offload = pkgs.writeShellScriptBin "nvidia-offload" ''
    export __NV_PRIME_RENDER_OFFLOAD=1
    export __NV_PRIME_RENDER_OFFLOAD_PROVIDER=NVIDIA-G0
    export __GLX_VENDOR_LIBRARY_NAME=nvidia
    export __VK_LAYER_NV_optimus=NVIDIA_only
    exec -a "$0" "$@"
  '';
in {
  imports = [ 
    /etc/nixos/hardware-configuration.nix 
    (builtins.fetchTarball {
      sha256 = "1qmq5zwd4qdxdxh4zxc7yr7qwajgnsjdw2npw0rfkyahmrqw3j02";
      url = "https://github.com/msteen/nixos-vsliveshare/archive/86624fe317c24df90e9451dd5741220c98d2249d.tar.gz";
    })
  ];

  # boot.kernel.sysctl.perf_event_paranoid = -1;
  boot.kernel.sysctl."kernel.perf_event_paranoid" = 1;
  boot.kernel.sysctl."kernel.perf_event_max_sample_rate" = 200;
  boot.loader.systemd-boot.enable = false;
  boot.loader.grub.enable = true;
  boot.loader.grub.devices = [ "nodev" ];
  boot.loader.grub.efiSupport = true;
  # boot.loader.grub.useOSProber = true;
  boot.loader.efi.canTouchEfiVariables = true;
  boot.loader.grub.extraEntries = ''
    menuentry "Windows" {
      chainloader (hd0,1)+1
    }
  '';

  boot.cleanTmpDir = true;

  services.tlp.enable = true;
  services.tlp.extraConfig = ''
    CPU_SCALING_GOVERNOR_ON_AC=performance
    CPU_SCALING_GOVERNOR_ON_BAT=powersave
    CPU_MAX_PERF_ON_AC=100
    CPU_MAX_PERF_ON_BAT=30
  '';

  time.timeZone = "Europe/Paris";

  documentation = {
    enable = true;
    man.enable = true;
    dev.enable = true;
  };

  services = {
    xserver = {
      enable = true;
      layout = "us";
      xkbOptions = "eurosign:e";
      libinput = {
        enable = true;

        touchpad.middleEmulation = false;
      };

      windowManager.i3 = {
        enable = true;
        package = pkgs.i3-gaps;
      };

      desktopManager = {
        xterm.enable = false;
        xfce = {
          enable = true;
          noDesktop = true;
          enableXfwm = false;
        };
      };

      displayManager = {
        defaultSession = "xfce+i3";
        sessionCommands = ''
          ${pkgs.xorg.xset}/bin/xset r rate 180 25
        '';
      };

      resolutions = [{
        x = 1920;
        y = 1080;
      }];
    };

    autorandr.enable = true;
    blueman.enable = true;
    gnome.gnome-keyring.enable = true;
  };

  # specialisation = {
  #   with-gpu.inheritParentConfig = true;
  #   with-gpu.configuration = {
  # system.nixos.tags = [ "with-gpu" ];
  # boot.loader.grub.configurationName = "with-gpu";
  services.xserver.videoDrivers = [ "nvidia" ];

  hardware.nvidia.prime.offload.enable = pkgs.lib.mkForce false;
  hardware.nvidia.powerManagement.enable = pkgs.lib.mkForce false;
  hardware.opengl.enable = true;
  # hardware.opengl.driSupport32Bit = true;
  hardware.enableRedistributableFirmware = true;
  hardware.nvidia.modesetting.enable = true;
  hardware.nvidia.prime = {
    sync.enable = true;
    intelBusId = "PCI:0:2:0";
    nvidiaBusId = "PCI:1:0:0";
  };
  hardware.steam-hardware.enable = true;
    # };

    # no-gpu.inheritParentConfig = true;
    # no-gpu.configuration = {
    #   system.nixos.tags = [ "no-gpu" ];
    #   boot.loader.grub.configurationName = "no-gpu";
    # };
  # };

  services.ratbagd.enable = true;

  hardware.bluetooth.enable = true;
  sound.enable = true;
  hardware.pulseaudio.enable = true;

  virtualisation.docker = {
    enable = true;
    liveRestore = false;
    enableNvidia = true;
  };

  virtualisation.podman = {
    enable = true;
    # dockerCompat = true;
  };

  virtualisation.virtualbox.host.enable = true;
  users.extraGroups.vboxusers.members = [ "aureleoules" ];

  users.users.aureleoules = {
    isNormalUser = true;
    home = "/home/aureleoules";
    extraGroups = [ "wheel" "docker" "video" ]; # Enable ‘sudo’ for the user.
    shell = pkgs.zsh;

    initialPassword = "password";
  };

  nixpkgs.config.allowUnfree = true;
  environment.systemPackages = with pkgs; [
    nvidia-offload
    arandr
    brightnessctl
    acpi
    acpilight
    # ccache
  ];

  environment.pathsToLink = [ "/include" ];
  environment.extraOutputsToInstall = [ "out" "lib" "bin" "dev" ];
  environment.variables = {
    NIX_CFLAGS_COMPILE_x86_64_unknown_linux_gnu = "-I/run/current-system/sw/include";
    PKG_CONFIG_PATH = "/run/current-system/sw/lib/pkgconfig";
  };


  services.udev.packages = with pkgs; [ ledger-udev-rules ];
  services.logind.extraConfig = ''
    RuntimeDirectorySize=20G
  '';
  services.flatpak.enable = true;
  xdg.portal.enable = true;

  programs.gnupg.agent = {
    enable = true;
    enableSSHSupport = true;
  };

#   services.vsliveshare = {
#     enable = true;
#     enableWritableWorkaround = true;
#     enableDiagnosticsWorkaround = true;
#     extensionsDir = "/home/matthijs/.vscode/extensions";
#   };

  programs.light.enable = true;
  programs.steam.enable = true;
  programs.ccache.enable = true;
  networking.networkmanager.enable = true;
  networking.nameservers = ["1.1.1.1" "1.0.0.1"];
  networking.firewall.enable = false;
  systemd.services.NetworkManager-wait-online.enable = false;

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "21.05"; # Did you read the comment?

}
