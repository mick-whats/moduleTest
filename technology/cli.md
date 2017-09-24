# cliメモ
cliのコマンドに関する簡単なメモ
項目が多い場合は専用ページに書く(git.mdなど)

## browser-sync

[Browsersync \- Time\-saving synchronised browser testing](https://www.browsersync.io/)

### 使い方

プロジェクトのホームディレクトリに移動して
```
browser-sync start --server --files='sample/*.*'
```
これでsampleディレクトリ内のファイルに変更があった時に自動でリロードされる。
起動時にブラウザが開くが、ホームディレクトリ直下に`index.html`が無い場合は`Cannot GET /`とだけ表示される。
URLの欄には`http://localhost:3000/` となっているので`http://localhost:3000/sample/test.html`と作成したhtmlファイルのパスを入力すると表示される。

後は`sample`ディレクトリ内のファイルが更新されるたびに自動でリロードされる。

## curl

-Oオプションでカレントディレクトリにダウンロード

```
cd download_directory_path
curl -O https://coincheck.com/api/order_books
```
