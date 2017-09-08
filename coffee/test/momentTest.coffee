{assert} = require 'chai'
_ = require 'lodash'
moment = require 'moment'
OK = assert.isOk
NG = assert.isNotOk
Equal = assert.equal

describe "moment test", ->
  it "basic", ->
    f = 'YYYYMMDD'
    assert.equal moment('20170907').format(f),'20170907'
    assert.equal moment('2017-09-07').format(f),'20170907'
    # moment('2017/09/07').format() # スラッシュ区切りはエラーになる
    # formatについては[こちら](http://momentjs.com/docs/#/displaying/format/)
    # http://momentjs.com/docs/#/displaying/
  it "isBefore", ->
    OK moment('2010-10-20').isBefore('2010-10-21')
    NG moment('2010-10-20').isBefore('2010-10-20')
    NG moment('2010-10-20').isBefore('2010-10-19')
  it "isSameOrBefore", ->
    OK moment('2010-10-20').isSameOrBefore('2010-10-21')
    OK moment('2010-10-20').isSameOrBefore('2010-10-20')
    NG moment('2010-10-20').isSameOrBefore('2010-10-19')
  it "isBetween", ->
    # moment(X).isBetween(A,B)
    # XがAとBの間であればtrue
    OK moment('2010-10-20').isBetween('2010-10-19', '2010-10-25')

describe "moment original method", ->
  it "lastBisDay", ->
    # 前営業日の取得
    # 前日が土日なら金曜日の日付を取得する
    lastBisDay = (date,format)->
      yesterdayCount = 1
      m = moment(date)
      day = m.format('ddd')
      yesterdayCount = 2 if day is 'Sun'
      yesterdayCount = 3 if day is 'Mon'
      format = format or 'YYYYMMDD'
      return m.subtract(yesterdayCount,'day').format(format)
    Equal lastBisDay('2017-09-01'),'20170831'
    Equal lastBisDay('2017-08-31'),'20170830'
    Equal lastBisDay('2017-08-30'),'20170829'
    Equal lastBisDay('2017-08-29'),'20170828'
    Equal lastBisDay('2017-08-28'),'20170825'
    Equal lastBisDay('2017-08-27'),'20170825'
    Equal lastBisDay('2017-08-26'),'20170825'
    # formatの指定も可能
    Equal lastBisDay('2017-08-26','YYYY-MM-DD'),'2017-08-25'
