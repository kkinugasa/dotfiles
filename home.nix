{ pkgs, pkgsUnstable, ... }:
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
  # This value determines the Home Manager release that your configuration is
  # compatible with. This helps avoid breakage when a new Home Manager release
  # introduces backwards incompatible changes.
  #
  # You should not change this value, even if you update Home Manager. If you do
  # want to update the value, then make sure to first check the Home Manager
  # release notes.
  home.stateVersion = "25.05"; # Please read the comment before changing.
  home.username = "kkinugasa";
  home.homeDirectory = "/home/kkinugasa";

  home.packages =
    with pkgs;
    [
      bat # cat alternative
      bottom # top alternative btm
      dig
      discord
      du-dust # du alternative dust
      duf # df alternative
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
      hub
      lean4
      nil # nix lsp
      nixfmt-rfc-style
      nmap
      peco
      pinta # Microsoft Paint alternative
      poetry
      pyright
      python311
      ripgrep # grep alternative
      ruff
      rustup
      slack
      # steam
      texlive.combined.scheme-full
      traceroute
      unzip
      uv
      wireshark
    ]
    ++ [ pkgsUnstable.vscode ];
  # ++ [ mypkgs.google-chrome ];

  programs.bash = {
    enable = true;
    enableCompletion = true;
    historyControl = [
      "ignoredups" # 重複コマンドを記録しない
      "ignorespace" # 先頭スペースのコマンドを記録しない
      "erasedups" # 保存時に重複を削除
    ];
    historyFile = "$HOME/.bash_history";
    historyFileSize = 1000000;
    historySize = 1000000;
    historyIgnore = [
      "ls"
      "cd"
    ];
    # initExtra = builtins.readFile ./bashrc;
    bashrcExtra = ''
      # 履歴を他のシェルとリアルタイム共有
      shopt -s histappend
      export PROMPT_COMMAND="history -a; history -c; history -r; $PROMPT_COMMAND"

      source $HOME/.git-completion.bash
      source $HOME/.git-prompt.sh

      # プロンプトに各種情報を表示
      GIT_PS1_SHOWDIRTYSTATE=1
      GIT_PS1_SHOWUPSTREAM="auto"
      GIT_PS1_SHOWUNTRACKEDFILES=1
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
      _peco_history() {
        local selected
        selected="$(
          HISTTIMEFORMAT= history \
            | sed 's/ *[0-9]\+ *//' \
            | tac \
            | awk '!seen[$0]++' \
            | peco --query "''${READLINE_LINE:-}"
        )"
        if [[ -n "$selected" ]]; then
          READLINE_LINE="$selected"
          READLINE_POINT=''${#READLINE_LINE}
        fi
      }
      bind -x '"\C-r": _peco_history'
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
  programs.direnv = {
    enable = true;
    nix-direnv.enable = true;
  };
  programs.home-manager.enable = true;
}
