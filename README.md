# dotfiles

Ubuntu PC の初期設定

## install list

- vscode
- [HackGen](https://github.com/yuru7/HackGen)
- google chrome
- docker
- hadolint, dockle, trivy
- nvidia docker など gpu 関係
- kubectl
- kustomize
- [kind](https://kind.sigs.k8s.io/docs/user/quick-start/#installation)
- [krew](https://krew.sigs.k8s.io/docs/user-guide/setup/install/)
- skaffold
- gcloud
- git-completion, git-prompt
- golang
- pyenv
- poetry
- [flutter](https://flutter.dev/docs/get-started/install/linux), android-studio
- [nodejs](https://volta.sh/)
- [texlive](https://texwiki.texjp.org/?Linux)
- [haskell](https://www.haskell.org/platform/linux.html#linux-ubuntu)
- [lean](https://leanprover.github.io/lean4/doc/quickstart.html)
- [sdkman](https://sdkman.io/)

## setting

### Go 関係

```sh
go env -w GO111MODULE=on
go get github.com/x-motemen/ghq
sudo apt install hub peco
git config --global --add ghq.root $(go env GOPATH)/src
```

### Flutter 関係

Android studio インストール後，`flutter doctor --android-licenses`で java の exception が発生した場合  
<https://zenn.dev/captain_blue/articles/flutter-android-licenses-classnotfound>

### GNOME 関係

<https://qiita.com/yas-nyan/items/80f2db8c4bdf4c8e87b8>  
`gnome-screenshot --area`
を windows+shift+s に割当

<https://www.living-in.tokyo/post/2019/1/ubuntu_alt_tab/>  
alt+tab を switch-windows に変更  
ubuntu 20.04 で `alt + tab`がデフォルトで switch-windows になったから、特に何もしなくていい

disable emoji shortcut  
command `ibus-setup` and launch `IBus Preferences`.  
Select Emoji tab and delete shortcut `<Control><Shift>e`
