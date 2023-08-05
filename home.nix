{
  home = rec {
    username="kkinugasa";
    homeDirectory = "/home/${username}";
    stateVersion = "23.05";
  };
  programs.home-manager.enable = true;
}
