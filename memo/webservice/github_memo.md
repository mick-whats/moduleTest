# githubメモ

## hubコマンド
hubコマンドを使えば色々と捗る。インストールは
```
brew install hub
```

## カレントディレクトリのリポジトリをブラウザで開く
```
hub browse
# browseと打つのがめんどくさいならエイリアスを設定
hub config --global alias.see browse
hub see
```

## 既存のリポジトリをgithubに追加(hub)
```
hub create
```

## 既存のリポジトリをgithubに追加
(上記のhubコマンド推奨。使わない場合は以下)
1. githubで[new repository]から新規リポジトリを作成
2. git remote add [リポジトリのURL].git
3. ローカルでcommit
4. ローカルでpull origin master
5. ローカルでpush origin master

## リモートURLをhttpsからsshに変更する

```./.ssh/config
Host github-mick
  HostName github.com
  IdentityFile ~/.ssh/github_mick_rsa
  User git
```

1. `./ssh/config`の内容が上記だとしたら、Hostに書いてある`github-mick`を覚えておく
2. `https://github.com/`の部分を`git@github-mick:`に変更する

```
# 例
# https://github.com/mick-whats/rrq.git
# ↓
# git@github-mick:mick-whats/rrq.git
```
