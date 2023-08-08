{ pkgs, ... }:

{
  home = rec {
    username="kkinugasa";
    homeDirectory = "/home/${username}";
    stateVersion = "23.05";
  };
  home.packages = with pkgs; [
    bat # cat alternative
    bottom # top alternative
    discord
    du-dust # du  alternative
    duf # df alternative
    exa # ls alternative
    fd # find alternative
    gh
    ghq
    go
    google-chrome
    httpie # curl alternative
    lean
    peco
    pinta # Microsoft Paint alternative
    poetry
    pyenv
    ripgrep # grep alternative
    slack
    unzip
    vscode
  ];
  programs.home-manager.enable = true;
}
