# ディレクトリ構造
```
~/.spam
|
+--current.txt
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
|     |
|     +--<ver>.tar.gz
|
+--index/
```
current.txtには現在の環境の名前だけが書かれています。
depends.jsonにはその環境にインストールされているパッケージの名前とバージョンが記載されています。
hash/, fonts/, hyph/, saty/とunicde/は~/.satysfi/dist以下のものと同じです。
archive/にはダウンロードされたtar.gzファイルがキャッシュとして保存されます。
index/はspam-repositoryをローカルにクローンしたものです。
# spamファイル
<package name>.spamとspamは同じものとして扱われます。
tar.gzアーカイブにはspamは含まれていなくても問題ありません。
