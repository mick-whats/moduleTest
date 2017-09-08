# gitメモ
[Git](https://git-scm.com/)

## push

基本的には以下のようにするべき。
```
git push origin master
origin = リモート名
master = ブランチ名
```

引数を省略すると何がどこにpushされるか保証はない

[引数なしのgit pushは危険なので気をつけましょう · DQNEO起業日記](http://dqn.sakusakutto.jp/2012/10/git_push.html)

`-u`オプションを付けて追跡ブランチを設定することもできるが、事故の元とも言える。

[\[git\]ローカルからpushした時に自動的に追跡ブランチにする \- dackdive's blog](http://dackdive.hateblo.jp/entry/2014/09/10/121945)

[Git で「追跡ブランチ」って言うのやめましょう \- Qiita](http://qiita.com/uasi/items/69368c17c79e99aaddbf)
