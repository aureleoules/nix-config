# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, ... }:

let
  nvidia-offload = pkgs.writeShellScriptBin "nvidia-offload" ''
    export __NV_PRIME_RENDER_OFFLOAD=1
    export __NV_PRIME_RENDER_OFFLOAD_PROVIDER=NVIDIA-G0
    export __GLX_VENDOR_LIBRARY_NAME=nvidia
    export __VK_LAYER_NV_optimus=NVIDIA_only
    exec -a "$0" "$@"
  '';
in
{
  imports =
    [ # Include the results of the hardware scan.
      /etc/nixos/hardware-configuration.nix
    ];

  # Use the systemd-boot EFI boot loader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  # networking.hostName = "nixos"; # Define your hostname.
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

  # Set your time zone.
  # time.timeZone = "Europe/Amsterdam";

  # The global useDHCP flag is deprecated, therefore explicitly set to false here.
  # Per-interface useDHCP will be mandatory in the future, so this generated config
  # replicates the default behaviour.
  networking.useDHCP = false;
  networking.interfaces.enp8s0.useDHCP = true;

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Select internationalisation properties.
  # i18n.defaultLocale = "en_US.UTF-8";
  # console = {
  #   font = "Lat2-Terminus16";
  #   keyMap = "us";
  # };

  # Enable the X11 windowing system.
  services = {
    xserver = {
  	enable = true;
  	layout = "fr";
  	xkbOptions = "eurosign:e";
  	libinput.enable = true;

	desktopManager = {
          #default = "xfce";
          xterm.enable = false;
	  xfce = {
	    enable = true;
	    noDesktop = true;
	    enableXfwm = false;
	  };
        };
  	windowManager.i3.enable = true;
  	windowManager.i3.package = pkgs.i3-gaps;

        displayManager.defaultSession = "xfce+i3";

  	resolutions = [{ x = 1920; y = 1080; }];
  	videoDrivers = [ "nvidia" ];
    };

    autorandr.enable = true;
  };
  hardware.nvidia.modesetting.enable = true;
  hardware.nvidia.prime = {
    #offload.enable = false;
    sync.enable = true;
    # Bus ID of the Intel GPU. You can find it using lspci, either under 3D or VGA
    intelBusId = "PCI:0:2:0";
    # Bus ID of the NVIDIA GPU. You can find it using lspci, either under 3D or VGA
    nvidiaBusId = "PCI:1:0:0";
  };

  hardware.nvidia.prime.offload.enable = pkgs.lib.mkForce false;
  hardware.nvidia.powerManagement.enable = pkgs.lib.mkForce false;
  #specialisation = {
  #  external-display.configuration = {
  #    boot.loader.grub.configurationName = "external-display";
  #    system.nixos.tags = [ "external-display" ];
  #    hardware.nvidia.prime.offload.enable = pkgs.lib.mkForce false;
  #    hardware.nvidia.powerManagement.enable = pkgs.lib.mkForce false;
  #  };
  #}; 

  # Configure keymap in X11

  # Enable CUPS to print documents.
  # services.printing.enable = true;

  # Enable sound.
  sound.enable = true;
  hardware.pulseaudio.enable = true;

  # Enable touchpad support (enabled default in most desktopManager).
  virtualisation.docker.enable = true;

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.aureleoules = {
    isNormalUser = true;
    home = "/home/aureleoules";
    extraGroups = [ "wheel" "docker" ]; # Enable ‘sudo’ for the user.
    shell = pkgs.zsh;
  };

  # List packages installed in system profile. To search, run:
  # $ nix search wge
  nixpkgs.config.allowUnfree = true;
  environment.systemPackages = with pkgs; [
    # tools
    vim 
    git
    wget
    docker
    htop
    kitty
    file
    curl
    neofetch

    # ui
    rofi
    i3
    i3-gaps
    ranger
    mpd
    compton
    polybar
    pywal
    calc
    networkmanager_dmenu

    # applications
    firefox
    vlc

    # programming
    python3
    gcc
    gnumake     
    #
    # other
    nvidia-offload
    arandr
  ];


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
  system.stateVersion = "21.05"; # Did you read the comment?

}
