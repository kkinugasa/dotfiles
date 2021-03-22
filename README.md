# dotfiles

Ubuntu PC の初期設定

## install list

- vscode
- google chrome
- docker
- nvidia docker など gpu 関係
- minikube
- kind
- skaffold
- gcloud
- git-completion, git-prompt
- golang(ghq, hub, peco, peco は apt install)
- pyenv
- poetry
- flutter, android-studio
- [nodejs](https://qiita.com/seibe/items/36cef7df85fe2cefa3ea)

## setting

### Go 関係

```sh
go env -w GO111MODULE=on
go get github.com/x-motemen/ghq
go get github.com/github/hub
sudo apt install peco
git config --global --add ghq.root $(go env GOPATH)/src
```

### GNOME 関係

<https://qiita.com/yas-nyan/items/80f2db8c4bdf4c8e87b8>  
`gnome-screenshot --area`
を windows+shift+s に割当

<https://www.living-in.tokyo/post/2019/1/ubuntu_alt_tab/>  
alt+tab を switch-windows に変更
