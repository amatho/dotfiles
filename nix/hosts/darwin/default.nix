{
  pkgs,
  inputs,
  config,
  ...
}:
let
  user = "amatho";

  fish =
    if config.home-manager.users.${user}.programs.fish.enable then
      "/etc/profiles/per-user/${user}/bin/fish"
    else
      pkgs.fish;
in
{
  # Necessary for using flakes on this system.
  nix.settings.experimental-features = "nix-command flakes";

  # Enable alternative shell support in nix-darwin.
  programs.fish.enable = true;
  programs.fish.shellInit = builtins.readFile ../../../fish/darwin.fish;

  # Set Git commit hash for darwin-version.
  system.configurationRevision = inputs.self.rev or inputs.self.dirtyRev or null;

  # Used for backwards compatibility, please read the changelog before changing.
  # $ darwin-rebuild changelog
  system.stateVersion = 6;

  # The platform the configuration will be used on.
  nixpkgs.hostPlatform = "aarch64-darwin";

  environment.shells = [ fish ];
  environment.systemPackages = with pkgs; [ pinentry_mac ];

  nix.settings.trusted-users = [
    "root"
    user
  ];
  users.knownUsers = [ user ];
  users.users.${user} = {
    uid = 501;
    home = "/Users/${user}";
    shell = fish;
  };
}
