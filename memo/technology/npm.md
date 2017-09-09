# npmメモ

[npm](https://www.npmjs.com/)

## command

### version [<newversion> | major | minor | patch | premajor | preminor | prepatch | prerelease | from-git]

package.jsonのversionを書き換えてgit tagを追加
$ npm version patch
v0.2.1
$ npm version minor
v0.3.0
$ npm version major
v1.0.0

[node\.js \- What is the convention for versioning npm packages prior to 1\.0\.0? \- Stack Overflow](https://stackoverflow.com/questions/28421489/what-is-the-convention-for-versioning-npm-packages-prior-to-1-0-0)

### outdated

パッケージが更新されているか調べる

```sh
npm outdated                                                                                                                +[master][~/Documents/node/tests/selfmemo]
Package  Current  Wanted  Latest  Location
chai       3.5.0   3.5.0   4.1.2  chai
```

### view [パッケージ名]

パッケージの詳細を表示する(JSON形式)
過去のバージョンアップした日時やmaintainersの連絡先、HP、依存パッケージなどが表示される。

### npm publish [<tarball>|<folder>] [--tag <tag>] [--access <public|restricted>]

自作パッケージをnpmに公開する。

[publish \| npm Documentation](https://docs.npmjs.com/cli/publish)

[3分でできるnpmモジュール \- Qiita](http://qiita.com/fnobi/items/f6b1574fb9f4518ed520)

### npm unpublish [<@scope>/]<pkg>[@<version>]

公開しているパッケージを非公開にする(削除)

### npm star [<pkg>...]

パッケージにスターを付ける

### npm unstar [<pkg>...]

パッケージのスターを外す

### npm stars [<user>]

スターをつけたパッケージを一覧表示する
user名を付けるとそのユーザーの一覧を表示する

## ショートカット

command|alias
:::|:::
install | i
uninstall|remove, rm, r, un, unlink
list|ls,la,ll


## other

### bitbucketのリポジトリからinstallする

```
npm i -S git+ssh://git@bitbucket.org:mick-whats/xax.git
# ./.ssh/configに設定してないとエラーになる
```
