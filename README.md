# dotfiles

Ubuntu PCの初期設定

## install list

- vscode
- google chrome
- docker
- nvidia dockerなどgpu関係
- minikube
- kind
- skaffold
- gcloud
- git-completion, git-prompt
- golang(ghq, hub, peco, pecoはapt install)
- pyenv
- poetry
- flutter, android-studio

## setting

### Go関係

```sh
go env -w GO111MODULE=on
go get github.com/x-motemen/ghq
go get github.com/github/hub
sudo apt install peco
git config --global --add ghq.root $(go env GOPATH)/src
```

### GNOME関係

<https://qiita.com/yas-nyan/items/80f2db8c4bdf4c8e87b8>  
`gnome-screenshot --area`
をwindows+shift+sに割当

<https://www.living-in.tokyo/post/2019/1/ubuntu_alt_tab/>  
alt+tabをswitch-windowsに変更
