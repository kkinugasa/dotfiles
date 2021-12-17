# Ricty Diminished

参考サイト  
<https://zenn.dev/konboi/articles/6dcd22f4e77c175653ed>

<https://rictyfonts.github.io/diminished>から
zipをダウンロードし，解凍したttfファイルを`~/.fonts/`に保存．

このままだとVSCodeでバッククオートが表示されないので，以下のスクリプトを実行

```sh
find ~/.fonts/ -name Ricty*.ttf | xargs -I {} fontforge -lang ff -script fix_backquote {}
```
