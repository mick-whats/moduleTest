# lodash(js)

https://lodash.com/docs/4.17.4



## orderBy

### 二次元配列のsortをする方法

公式DocumentではObjectが並んだ配列が例に上がっているが、ObjectでなくArrayの場合はどうするのか。
Objectではkeyを指定する。Arrayは添字がkeyになるのでそれを使う。それだけ。

```
arr = [
  [5,1]
  [3,1]
  [4,1]
  [2,1]
  [1,1]
]
console.log _.orderBy(arr,[0],['asc']) # asc or desc
# [ [ 1, 1 ], [ 2, 1 ], [ 3, 1 ], [ 4, 1 ], [ 5, 1 ] ]
```
