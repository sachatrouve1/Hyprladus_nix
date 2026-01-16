
{ config, pkgs, ... }:

{
  # Home Manager needs a bit of information about you and the paths it should
  # manage.
  home.username = "sacha";
  home.homeDirectory = "/home/sacha";

  # This value determines the Home Manager release that your configuration is
  # compatible with. This helps avoid breakage when a new Home Manager release
  # introduces backwards incompatible changes.
  #
  # You should not change this value, even if you update Home Manager. If you do
  # want to update the value, then make sure to first check the Home Manager
  # release notes.
  home.stateVersion = "25.11"; # Please read the comment before changing.

  # The home.packages option allows you to install Nix packages into your
  # environment.
  home.packages = with pkgs; [
    # # It is sometimes useful to fine-tune packages, for example, by applying
    # # overrides. You can do that directly here, just don't forget the
    # # parentheses. Maybe you want to install Nerd Fonts with a limited number of
    # # fonts?
    # (pkgs.nerdfonts.override { fonts = [ "FantasqueSansMono" ]; })
    htop
    btop
    ncdu
    bat
    git
    wget
    bat
    btop
    fastfetch
    zoxide
    fzf
    jq
    cliphist
    brightnessctl
    pamixer
    cava
    udiskie
    tree
    eza
    pavucontrol
    caffeine-ng
    spotify-player
    docker
    gemini-cli

    kitty
    vim
    neovim
    vscode

    librewolf
    vesktop
    spotify
    feh
    kdePackages.okular
    kdePackages.kruler
    jetbrains-toolbox
    thunar
    libreoffice-still

    waybar
    rofi
    pywal
    grim
    slurp
    wl-clipboard
    swww
    swaynotificationcenter
    wlogout

    nwg-look
    nwg-displays
    papirus-icon-theme
    adwaita-icon-theme
    gtk-engine-murrine
    gruvbox-material-gtk-theme

    jetbrains-mono
    nerd-fonts.symbols-only
    nerd-fonts._0xproto
    dejavu_fonts
    noto-fonts
    noto-fonts-color-emoji

    qt5.qtwayland
    qt6.qtwayland

    hyprpicker
    hyprlock
    hypridle
    hyprsunset
    hyprcursor
    hyprland
    hyprpicker
    hyprlock
    hypridle
    hyprsunset
    hyprcursor
    hyprlang
    hyprgraphics
    aquamarine
    xdg-desktop-portal-hyprland
  ];

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  # Home Manager is pretty good at managing dotfiles. The primary way to manage
  # plain files is through 'home.file'.
  home.file = {
    # # Building this configuration will create a copy of 'dotfiles/screenrc' in
    # # the Nix store. Activating the configuration will then make '~/.screenrc' a
    # # symlink to the Nix store copy.
    # ".screenrc".source = dotfiles/screenrc;

    # # You can also set the file content immediately.
    # ".gradle/gradle.properties".text = ''
    #   org.gradle.console=verbose
    #   org.gradle.daemon.idletimeout=3600000
    # '';
  };

  # Home Manager can also manage your environment variables through
  # 'home.sessionVariables'. These will be explicitly sourced when using a
  # shell provided by Home Manager. If you don't want to manage your shell
  # through Home Manager then you have to manually source 'hm-session-vars.sh'
  # located at either
  #
  #  ~/.nix-profile/etc/profile.d/hm-session-vars.sh
  #
  # or
  #
  #  ~/.local/state/nix/profiles/profile/etc/profile.d/hm-session-vars.sh
  #
  # or
  #
  #  /etc/profiles/per-user/sacha/etc/profile.d/hm-session-vars.sh
  #
  home.sessionVariables = {
    # EDITOR = "emacs";
  };

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
}
