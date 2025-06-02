{
  pkgs,
  inputs,
  config,
  ...
}:
let
  user = "amatho";
  readTOML = path: builtins.fromTOML (builtins.readFile path);
in
{
  # The state version is required and should stay at the version you
  # originally installed.
  home.stateVersion = "24.11";

  home.username = user;
  home.homeDirectory = if pkgs.stdenv.isDarwin then "/Users/${user}" else "/home/${user}";

  programs.fish = {
    enable = true;
    shellInit = "set fish_greeting";
    interactiveShellInit = builtins.readFile ../../fish/interactive.fish;
  };

  programs.bat.enable = true;
  programs.direnv.enable = true;
  programs.direnv.silent = true;
  programs.direnv.nix-direnv.enable = true;
  programs.eza.enable = true;
  programs.fzf.enable = true;
  programs.gh.enable = true;
  programs.gh.settings.git_protocol = "ssh";
  programs.git.enable = true;
  programs.git.delta.enable = true;
  programs.gpg.enable = true;
  programs.ripgrep.enable = true;
  programs.starship.enable = true;
  programs.starship.settings = readTOML ../../starship/starship.toml;
  programs.zellij.enable = true;
  programs.zellij.settings = {
    theme = "ansi";
    default_layout = "compact";
    simplified_ui = true;
    pane_frames = false;
    show_startup_tips = false;
  };
  programs.zoxide.enable = true;

  programs.neovim = {
    enable = true;
    defaultEditor = true;
    package = inputs.neovim-nightly-overlay.packages.${pkgs.system}.default;
  };

  xdg.configFile."ghostty".source = ../../ghostty;
  xdg.configFile."nvim/lua".source = ../../nvim/lua;
  xdg.configFile."nvim/init.lua".source = ../../nvim/init.lua;
  xdg.configFile."nvim/lazy-lock.json".source =
    config.lib.file.mkOutOfStoreSymlink (toString ../../nvim/lazy-lock.json);
  xdg.configFile."wezterm".source = ../../wezterm;

  programs.helix = {
    enable = true;
    languages = readTOML ../../helix/languages.toml;
    settings = readTOML ../../helix/config.toml;
  };

  home.packages = with pkgs; [
    cmctl
    docker
    docker-compose
    fluxcd
    jq
    k9s
    kubectl
    kubernetes-helm
    mise
    nixd
    nixfmt-rfc-style
    nodejs
    podman
    podman-compose
    postgresql
    python3
    rustup
    sops
    stylua
    wget
    yq-go
  ];
}
