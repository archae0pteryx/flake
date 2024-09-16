{ lib, config, pkgs, ... }:

{
  home.stateVersion = "24.05";
  nixpkgs.config.allowUnfree = true;
  nixpkgs.config.permittedInsecurePackages = [
    "electron-27.3.11"
  ];
  home.username = "rimraf";
  home.homeDirectory = "/home/rimraf";
  home.sessionVariables = { EDITOR = "vim"; };
  home.packages = import ./packages.nix { inherit pkgs; };
  home.file = { ".vimrc".source = ../common/vimrc; };
  home.file = { ".tmux.conf".source = ../common/tmux.conf; };

  xdg.configFile."monitors/setup-monitors.sh".text = builtins.readFile ./scripts/setup-monitors.sh;
  xdg.configFile."starship.toml".text = builtins.readFile ../common/starship.toml; 
  xdg.configFile."copyq/copyq.conf".text = builtins.readFile ../common/copyq.conf;
  xdg.configFile."i3/config".text = builtins.readFile ./config/i3-config;
  xdg.configFile."i3status-rust/config.toml".text = builtins.readFile ./config/i3status-rust;

  # xdg.configFile."xfce4/xfconf/xfce-perchannel-xml/xfce4-keyboard-shortcuts.xml".text = builtins.readFile ./xfce4/xfce4-keyboard-shortcuts.xml;

  programs = import ./programs.nix { inherit lib;};

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
}
