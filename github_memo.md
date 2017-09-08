# githubメモ

## 既存のリポジトリをgithubに追加

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

`./ssh/config`の内容が上記だとしたら、Hostに書いてある`github-mick`を覚えておく
`https://github.com/`の部分を`git@github-mick:`に変更する

```
# 例
# https://github.com/mick-whats/rrq.git
# ↓
# git@github-mick:mick-whats/rrq.git
```
