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
  imports = [ /etc/nixos/hardware-configuration.nix ];

  boot.loader.systemd-boot.enable = false;
  boot.loader.grub.enable = true;
  boot.loader.grub.devices = [ "nodev" ];
  boot.loader.grub.efiSupport = true;
  boot.loader.efi.canTouchEfiVariables = true;

  boot.cleanTmpDir = true;

  time.timeZone = "Europe/Paris";

  documentation = {
    enable = true;
    man.enable = true;
    dev.enable = true;
  };

  services = {
    xserver = {
      enable = true;
      layout = "fr";
      xkbOptions = "eurosign:e";
      libinput.enable = true;

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
          ${pkgs.xlibs.xset}/bin/xset r rate 180 25
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

  specialisation = {
    with-gpu.inheritParentConfig = true;
    with-gpu.configuration = {
      system.nixos.tags = [ "with-gpu" ];
      boot.loader.grub.configurationName = "with-gpu";
      services.xserver.videoDrivers = [ "nvidia" ];

      hardware.nvidia.prime.offload.enable = pkgs.lib.mkForce false;
      hardware.nvidia.powerManagement.enable = pkgs.lib.mkForce false;

      hardware.enableRedistributableFirmware = true;
      hardware.nvidia.modesetting.enable = true;
      hardware.nvidia.prime = {
        sync.enable = true;
        intelBusId = "PCI:0:2:0";
        nvidiaBusId = "PCI:1:0:0";
      };
    };

    no-gpu.inheritParentConfig = true;
    no-gpu.configuration = {
      system.nixos.tags = [ "no-gpu" ];
      boot.loader.grub.configurationName = "no-gpu";
    };
  };

  hardware.bluetooth.enable = true;
  sound.enable = true;
  hardware.pulseaudio.enable = true;

  virtualisation.docker = {
    enable = true;
    liveRestore = false;
  };

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
  ];

  services.udev.packages = with pkgs; [ ledger-udev-rules ];

  programs.gnupg.agent = {
    enable = true;
    enableSSHSupport = true;
  };

  programs.light.enable = true;
  networking.networkmanager.enable = true;

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "21.05"; # Did you read the comment?

}
