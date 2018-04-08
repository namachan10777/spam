# ディレクトリ構造
```
~/.spam
|
|
+--installed.json
|
+--hash/
+--fonts/
+--hyph/
+--saty/
+--unicode/
+--dist-origin/
|
+--archive/
   |
   +--<package name>
```
depends.jsonにはその環境にインストールされているパッケージの名前が記載されています。
dist-originにはインストール時の~/.satysfi/distが退避されています
hash/, fonts/, hyph/, saty/とunicde/は~/.satysfi/dist以下のものと同じです。
archive/にはクローンされたGitリポジトリが置かれます。
