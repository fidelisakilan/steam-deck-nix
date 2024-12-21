# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
    (
      # Put the most recent revision here:
      let revision = "8d7b2149e618696d5100c2683af1ffa893f02a75"; in
      builtins.fetchTarball {
        url = "https://github.com/Jovian-Experiments/Jovian-NixOS/archive/${revision}.tar.gz";
        # Update the hash as needed:
        sha256 = "sha256:08ka4jamigjg80wsjlfvzccgzcc6mmxszxf2rn10gwiz63wzdgc8";
      } + "/modules"
    )
    ];


  # Bootloader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  networking.hostName = "nixdeck"; # Define your hostname.
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Enable networking
  networking.networkmanager.enable = true;

  # Set your time zone.
  time.timeZone = "America/Chicago";

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


  # services.displayManager.sddm.enable = true;
  services.desktopManager.plasma6.enable = true;
  # services.xserver.desktopManager.gnome.enable = true;

  programs.xwayland.enable = true;

  # Configure keymap in X11
  services.xserver.xkb = {
    layout = "us";
    variant = "";
  };

  # Enable CUPS to print documents.
  services.printing.enable = true;


  # Enable sound with pipewire.
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
  users.users.teal = {
    isNormalUser = true;
    description = "Fidelis Akilan";
    extraGroups = [ "networkmanager" "wheel" ];
    packages = with pkgs; [
      kdePackages.kate
    #  thunderbird
    ];
  };

  programs.nix-ld.enable = true;
  programs.nix-ld.libraries = with pkgs; [
  # Add any missing dynamic libraries for unpackaged
  # programs here, NOT in environment.systemPackages
  ];

  # Install firefox.
  programs.firefox.enable = true;

  programs.neovim = {
    enable = true;
    defaultEditor = true;
  };

  programs.steam.enable = true;
  jovian.steam = {
    enable = true;
    autoStart = true;
    user = "teal";
    desktopSession = "plasma";
  };
  jovian.devices.steamdeck.enable = true;
  jovian.devices.steamdeck.enableGyroDsuService = true;


  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  services.flatpak.enable = true;
  environment.systemPackages = with pkgs; [
  git
  nnn
  neofetch
  wezterm
  spotify
  discord
  librewolf
  protonup-qt
  spicetify-cli
  unityhub
  ];

  fonts.packages = with pkgs; [
    bqn386
    dina-font
    fira-code
    fira-code-symbols
    font-awesome
    iosevka
    liberation_ttf
    noto-fonts
    noto-fonts-cjk-sans
    noto-fonts-emoji
    proggyfonts
    source-code-pro
    uiua386
    (nerdfonts.override { fonts = [ "FiraCode" "SourceCodePro" "CascadiaCode"]; })
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
  services.openssh.enable = true;

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
  system.stateVersion = "unstable"; # Did you read the comment?

}
