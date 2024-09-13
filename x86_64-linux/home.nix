{ config, pkgs, ... }:
let
  google-cloud-sdk = pkgs.google-cloud-sdk.withExtraComponents [pkgs.google-cloud-sdk.components.gke-gcloud-auth-plugin];
in
{
  home.stateVersion = "24.05";
  nixpkgs.config.allowUnfree = true;
  nixpkgs.config.permittedInsecurePackages = [
    "electron-27.3.11"
  ];
  home.username = "rimraf";
  home.homeDirectory = "/home/rimraf";
  home.sessionVariables = { EDITOR = "vim"; };
  home.packages = [
    pkgs.slack
    pkgs.thunderbird
    pkgs.spotify
    google-cloud-sdk
    pkgs.bitwarden-cli
    pkgs.starship
    pkgs.vscode
    pkgs.keepassxc
    pkgs.devbox
    pkgs.nixfmt-classic
    pkgs.fishPlugins.z
    pkgs.fishPlugins.fzf-fish
    pkgs.kubectl
    pkgs.opentofu
    pkgs.terragrunt
    pkgs.kubectx
    pkgs.fzf
    pkgs.teller
    pkgs.brave
    pkgs.ffmpeg
    pkgs.tdrop
    pkgs.alacritty
    pkgs.tmux
    pkgs.nmap
    pkgs.beekeeper-studio
    pkgs.ripgrep
    pkgs.fd
    pkgs.dnsutils
    pkgs.xsel
    pkgs.jq
    pkgs.k9s
    pkgs.xfce.xfce4-pulseaudio-plugin
    pkgs.emojipick
    pkgs.python311
    pkgs.xclip
    pkgs.dmenu
    pkgs.kubernetes-helm
    pkgs.stern
    pkgs.kubectl
    pkgs.kubectx
    pkgs.terraform
    pkgs.discord
    pkgs.obsidian
    pkgs.logseq
    pkgs.pipx
    pkgs.libreoffice
    pkgs.hunspell
    pkgs.gnome-calculator
    pkgs.speedtest-cli
    pkgs.ripgrep
    pkgs.cmake
    pkgs.gcc
    pkgs.gdb
    pkgs.unzip
    pkgs.zip
    pkgs.mullvad-vpn
    pkgs.traceroute
    pkgs.font-manager
    pkgs.gnumake
    pkgs.postman
    pkgs.pamixer
    pkgs.playerctl
    pkgs.xorg.xmodmap
    pkgs.xfce.xfce4-panel
    pkgs.usbutils
    pkgs.openlens
    pkgs.openssl
    pkgs.tigervnc
    pkgs.edid-decode
    (pkgs.nerdfonts.override { fonts = [ "FiraCode" ]; })
  ];
  home.file = { ".vimrc".source = ../common/vimrc; };
  home.file = { ".tmux.conf".source = ../common/tmux.conf; };

  # xdg.configFile."monitors/setup-monitors.sh".text = builtins.readFile ./scripts/setup-monitors.sh;
  xdg.configFile."starship.toml".text = builtins.readFile ../common/starship.toml; 
  xdg.configFile."copyq/copyq.conf".text = builtins.readFile ../common/copyq.conf;
  xdg.configFile."i3/config".text = builtins.readFile ../common/i3-config;
  xdg.configFile."i3status-rust/config.toml".text = builtins.readFile ../common/i3status-rust;

  # xdg.configFile."xfce4/xfconf/xfce-perchannel-xml/xfce4-keyboard-shortcuts.xml".text = builtins.readFile ./xfce4/xfce4-keyboard-shortcuts.xml;

  programs = import ./programs.nix;

  services.gpg-agent = { enable = true; enableSshSupport = true; };
  services.copyq.enable = true;
  services.megasync.enable = true;
  
  systemd.user = {
    enable = true;
    services.set-monitors = {
      Unit = {
        Description = "Display Setup Service";
        After = "xorg.target";
      };
      Install = {
        WantedBy =[ "multi-user.target"];
      };
      Service = {
        RestartSec = 10;
        ExecStart = pkgs.writeShellScript "load-monitors" ''
xrandr --output HDMI-2 --mode 1920x1080 --primary
xrandr --output HDMI-1 --mode 1920x1080 --right-of HDMI-2
        '';
        Restart = "always";
      };
    };
  };
  # services.xserver = {
  #   enable = true;
  #   layout = "us";
  #   monitorSection = ''
  #     Section "Monitor"
  #         Identifier "HDMI-2"
  #         Option "PreferredMode" "1920x1080"
  #         Option "Position" "0 0"
  #     EndSection
  #     Section "Monitor"
  #         Identifier "HDMI-3"
  #         Option "PreferredMode" "1920x1080"
  #         Option "Position" "1920 0"
  #     EndSection
  #   '';
  # };
}
