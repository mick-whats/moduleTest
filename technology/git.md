# gitメモ
[Git](https://git-scm.com/)

## 直前のコミットを取り消し

```
git reset --soft HEAD^
```

## ディレクトリ構造を変更する

`./memo`以下を`./`に移動する方法。`git mv`を使う
`git mv ./memo ./ `としたら一括で移動できると思ったができない。

```
git mv ./memo ./
# fatal: can not move directory into itself, source=memo, destination=memo
```

一つづつ指定する必要があるようだ。

```
git mv ./memo/life ./        
git mv ./memo/technology ./  
git mv ./memo/os ./          
git mv ./memo/tools ./       
git mv ./memo/webservice/ ./ 
git rm memo  
# fatal: pathspec 'memo' did not match any files
```

gitの設定だけ変わるのかと思ったが実際のファイルもちゃんと移動している。
memoディレクトリは空になったのでrm(削除)しようと思ったが`fatal: pathspec 'memo' did not match any files`と出る。
空のディレクトリは削除できないようだ。

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

追跡ブランチの確認は
```
git branch -vv
> * master xxxxxx [origin/master] initial
```
