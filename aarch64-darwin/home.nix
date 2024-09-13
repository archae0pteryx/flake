{ pkgs, ... }:
let
  google-cloud-sdk = pkgs.google-cloud-sdk.withExtraComponents [pkgs.google-cloud-sdk.components.gke-gcloud-auth-plugin];
in
{
  home.stateVersion = "24.11";
  programs.home-manager.enable = true;
  programs.vscode.enable = true;
  programs.vscode.extensions = [ pkgs.vscode-extensions.bbenoist.nix ];
  programs.fish = import ../common/fish.nix;
  # programs.git = import ../common/git.nix;
  programs.starship.enable = true;
  home.file = { ".vimrc".source = ../common/vimrc; };
  home.file = { ".tmux.conf".source = ../common/tmux.conf; };
  xdg.configFile."starship.toml".text = builtins.readFile ../common/starship.toml;
  home.sessionVariables = { EDITOR = "vim"; };
  home.packages = [
    pkgs.slack
    pkgs.spotify
    google-cloud-sdk
    pkgs.bitwarden-cli
    pkgs.vscode
    pkgs.keepassxc
    pkgs.devbox
    # pkgs.nixfmt-classic
    # pkgs.fishPlugins.z
    # pkgs.fishPlugins.fzf-fish
    # pkgs.kubectl
    # pkgs.opentofu
    # pkgs.terragrunt
    # pkgs.kubectx
    # pkgs.fzf
    # pkgs.teller
    # pkgs.brave
    # pkgs.ffmpeg
    # pkgs.tdrop
    # pkgs.alacritty
    # pkgs.tmux
    # pkgs.nmap
    # pkgs.beekeeper-studio
    # pkgs.ripgrep
    # pkgs.fd
    # pkgs.dnsutils
    # pkgs.xsel
    # pkgs.jq
    # pkgs.k9s
    # pkgs.xfce.xfce4-pulseaudio-plugin
    # pkgs.emojipick
    # pkgs.python311
    # pkgs.xclip
    # pkgs.dmenu
    # pkgs.kubernetes-helm
    # pkgs.stern
    # pkgs.kubectl
    # pkgs.kubectx
    # pkgs.terraform
    # pkgs.discord
    # pkgs.obsidian
    # pkgs.logseq
    # pkgs.pipx
    # pkgs.libreoffice
    # pkgs.hunspell
    # pkgs.gnome-calculator
    # pkgs.speedtest-cli
    # pkgs.ripgrep
    # pkgs.cmake
    # pkgs.gcc
    # pkgs.gdb
    # pkgs.unzip
    # pkgs.zip
    # pkgs.mullvad-vpn
    # pkgs.traceroute
    # pkgs.font-manager
    # pkgs.gnumake
    # pkgs.postman
    # pkgs.pamixer
    # pkgs.playerctl
    # pkgs.xorg.xmodmap
    # pkgs.xfce.xfce4-panel
    # pkgs.usbutils
    # pkgs.openlens
    # pkgs.openssl
    (pkgs.nerdfonts.override { fonts = [ "FiraCode" ]; })
  ];
 }
