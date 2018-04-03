# ディレクトリ構造
```
~/.spam
|
+--current.txt
+--db.dat
|
+--env/
|  |
|  +--<env name>/
|     |
|     +--depends.json
|     |
|     +--hash/
|     +--fonts/
|     +--hyph/
|     +--saty/
|     +--unicode/
|
+--archive/
|  |
|  +--<package name>
|
+--index/
```
current.txtには現在の環境の名前だけが書かれています。
db.datには依存関係のキャッシュが入っています。
depends.jsonにはその環境にインストールされているパッケージの名前とバージョンが記載されています。
hash/, fonts/, hyph/, saty/とunicde/は~/.satysfi/dist以下のものと同じです。
archive/にはクローンされたGitリポジトリが置かれます。
index/はspam-repositoryをローカルにクローンしたものです。
