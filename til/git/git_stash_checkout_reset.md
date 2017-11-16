# git stashしてみたら色々と詰んだ(詰んでない)

2017年11月16日

`git stash`は現在の進行状況を一旦saveしてHEADに戻すコマンド。
つまり保存と`git reset --hard`を同時に行う。(このへんの理解ちょっと怪しい)


現在進行中のブランチがmasterだと気付き、それをdevブランチに移動する為に使ってみた。

```
git stash
git checkout dev
git stash pop
```

ここでコンフリクト。masterとdevをmergeした後でmasterを更新していたためコンフリクトした。

コンフリクトした場合は`stash pop`しても消えずに残るようなので以下のように処理。
```
git reset --hard
git merge master
git stash pop
```

これでコンフリクトせずにできた。コマンドにすると簡単だけど結構悩んだ。

## おまけ

mergeは`--no-ff`を付けると誓ったのにそんなこと忘れてて普通にmergeしてしまった。

```
git config --global --add merge.ff false
git config --global --add pull.ff only
```

とするとオプション無しで`--no-ff`になるけど、コマンド以外の方法(atomのパッケージとか各種gitクライアントとか)でmergeした時にはどうなるんだろう。

今度調べてみよう。
