# quandl メモ
[Financial, Economic and Alternative Data \| Quandl](https://www.quandl.com/)

## 取得時間について

quandlは株価等のファイナンスデータを取得できるサイトでAPIを一部無料で公開している。
東京証券取引所の株価データは無料であり、そのかわりに全銘柄の一斉取得は不可。
2017年現在で3000超の銘柄が有り、例えば本日の株価を全銘柄分取得するには銘柄の数だけリクエストをする必要がある。
そうなると全銘柄を取得するのにどれだけ時間がかかるのか調べてみた。

```coffee
Quandl = require("quandl")
{assert} = require 'chai'
_ = require 'lodash'
async = require 'async'
quandl = new Quandl(
  auth_token: require('../secret/settings').quandl_API_KEY
  api_version: 3)
load = (code,cb)->
  quandl.dataset {
    source: 'TSE'
    table: code
    },
  {
    limit: 1
  }, (err, response) ->
    return cb err if err
    res = JSON.parse(response)
    cb null, _.get(res,'dataset.data',res)
    return

codes = ['9984','6065','8028','2884','5742','7752','3694','6089','9517','5344','7187']

describe "quandl test", ->
  it "basic",(done) ->
    limit = 6
    async.eachOfLimit codes,limit,(code,index,next)->
      load code,(err,res)->
        assert.isNull err
        assert.notProperty res,'quandl_error'
        next()
    ,done

```
上記のコードは11銘柄の1日分のデータを順次取得している。
形式は以下の通り

```
{ dataset:
   { id: 9804503,
     dataset_code: '9984',
     database_code: 'TSE',
     name: 'Softbank Group Corp. — 9984',
     description: '<p>Unadjusted stock prices for Softbank Group Corp. from the Tokyo Stock Exchange.</p>',
     refreshed_at: '2017-09-28T11:11:00.996Z',
     newest_available_date: '2017-09-28',
     oldest_available_date: '2007-01-04',
     column_names: [ 'Date', 'Open', 'High', 'Low', 'Close', 'Volume' ],
     frequency: 'daily',
     type: 'Time Series',
     premium: false,

     limit: 1,
     transform: null,
     column_index: null,
     start_date: '2007-01-04',
     end_date: '2017-09-28',
     data: [ [ '2017-09-28', 2422, 2422, 2299, 2343, 43600 ] ],
     collapse: null,
     order: null,
     database_id: 473 } }
```
 このコードでは同時リクエストを6回にしているが、時々以下の様なメッセージが返る。

```
{ quandl_error:
   { code: 'QELx04',
     message: 'You have exceeded the API speed limit. Please slow down your requests by reducing the number of requests made at the same time.' } }
```
> APIの制限速度を超えました。 同時にリクエスト数を減らしてリクエストを遅くしてください。(google翻訳)

これが出ないようにするには同時リクエスト数(limit)を抑える必要がある。


実際に動かしてみて、同時リクエスト数に対する完了時間を表にしてみた。

limit|time
:|:
1|16569ms
2|8069ms
3|6690ms

トラフィックなどで誤差は出るだろうが、同時リクエストは2,3回が適当なようだ。
だいたい4回を超えると警告が出て取得できない。

上記のコードでは11銘柄で6秒-8秒かかっている。
余裕を持って計算してみると全銘柄の取得は1時間前後という所か。
ただし実際に行っていないので、アクセス過多による制限とかあるかもしれない。



余談だがこの記事を書いてるのは2017年9月29日19時01分。
取得したデータは前日のものになった。
つまり当日データの更新は19時にまだ行われていない。
