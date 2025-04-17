{ pkgs, inputs, ... }:
let
  user = "amatho";
in
{
  # The state version is required and should stay at the version you
  # originally installed.
  home.stateVersion = "24.11";

  home.username = user;
  home.homeDirectory = "/Users/${user}";

  programs.fish = {
    enable = true;
    shellInit = "set fish_greeting";
    interactiveShellInit = builtins.readFile ../../fish/interactive.fish;
  };

  programs.direnv.enable = true;
  programs.direnv.nix-direnv.enable = true;

  programs.starship.enable = true;
  programs.starship.settings = builtins.fromTOML (builtins.readFile ../../starship/starship.toml);

  programs.zoxide.enable = true;

  programs.neovim = {
    enable = true;
    defaultEditor = true;
    package = inputs.neovim-nightly-overlay.packages.${pkgs.system}.default;
  };

  programs.helix.enable = true;
}
