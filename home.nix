{ pkgs, ... }:
# let
#   mypkgs = import
#     (builtins.fetchGit {
#       # Descriptive name to make the store path easier to identify
#       name = "my-old-revision";
#       url = "https://github.com/NixOS/nixpkgs/";
#       ref = "refs/heads/nixpkgs-unstable";
#       rev = "9957cd48326fe8dbd52fdc50dd2502307f188b0d";
#     })
#     {
#       system = "x86_64-linux";
#       config.allowUnfree = true;
#     };
# in
{
  home = rec {
    username = "kkinugasa";
    homeDirectory = "/home/${username}";
    stateVersion = "24.11";
  };
  home.packages = with pkgs; [
    bat # cat alternative
    bottom # top alternative btm
    dig
    discord
    du-dust # du alternative dust
    duf # df alternative
    elan # lean version manager
    eza # ls alternative
    fd # find alternative
    gcc
    gh
    ghq
    gnumake
    go
    google-chrome
    haskellPackages.cabal-install
    haskellPackages.ghc
    haskellPackages.haskell-language-server
    httpie # curl alternative
    nil # nix lsp
    nixfmt-rfc-style
    peco
    pinta # Microsoft Paint alternative
    poetry
    pyenv
    python311
    ripgrep # grep alternative
    rustup
    # rye
    slack
    steam
    texlive.combined.scheme-full
    traceroute
    unzip
    uv
    vscode
  ];
  # ++ [ mypkgs.google-chrome ];

  programs.bash = {
    enable = true;
    enableCompletion = true;
    historyControl = [
      "ignoredups"
      "ignorespace"
      "erasedups"
    ];
    historyIgnore = [
      "ls"
      "cd"
    ];
    # initExtra = builtins.readFile ./bashrc;
    initExtra = ''
      # https://qiita.com/varmil/items/9b0aeafa85975474e9b6
      source $HOME/.git-completion.bash
      source $HOME/.git-prompt.sh

      # プロンプトに各種情報を表示
      GIT_PS1_SHOWDIRTYSTATE=1
      GIT_PS1_SHOWUPSTREAM=1
      GIT_PS1_SHOWUNTRACKEDFILES=
      GIT_PS1_SHOWSTASHSTATE=1
      ############### ターミナルのコマンド受付状態の表示変更
      # \u ユーザ名
      # \h ホスト名
      # \W カレントディレクトリ
      # \w カレントディレクトリのパス
      # \n 改行
      # \d 日付
      # \[ 表示させない文字列の開始
      # \] 表示させない文字列の終了
      # \$ $
      PS1="\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[01;31m\]$(__git_ps1)\[\033[00m\]\n\$ "
      peco-cd() {
          local GIT_SRC=$(ghq list | peco)
          if [ -n "$GIT_SRC" ]; then
              cd $(ghq root)/"$GIT_SRC"
          fi
      }

      #https://qiita.com/omega999/items/8717c1b9d8bc10596d67#peco-history%E3%81%AE%E5%AE%9F%E8%A3%85
      peco-history() {
          local NUM=$(history | wc -l)
          local FIRST=$((-1*(NUM-1)))

          if [ $FIRST -eq 0 ] ; then
              history -d $((HISTCMD-1))
              echo "No history" >&2
              return
          fi

          local CMD=$(fc -l $FIRST | sort -k 2 -k 1nr | uniq -f 1 | sort -nr | sed -E 's/^[0-9]+[[:blank:]]+//' | peco | head -n 1)

          if [ -n "$CMD" ] ; then
              history -s $CMD

              if type osascript > /dev/null 2>&1 ; then
                  (osascript -e 'tell application "System Events" to keystroke (ASCII character 30)' &)
              fi
          else
              history -d $((HISTCMD-1))
          fi
      }
      bind -x '"\C-r":peco-history'
    '';

    shellAliases = {
      cat = "bat";
      gcd = "peco-cd";
      ghub = "hub browse $(ghq list | peco | cut -d / -f 2,3)";
      grep = "rg";
      ls = "eza";
      tree = "eza --tree";
    };
  };

  programs.home-manager.enable = true;
}
