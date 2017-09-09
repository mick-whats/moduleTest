_async = require 'async'

_ = require 'lodash'
{assert} = require 'chai'
{deepEqual,isNull} = assert

asyncFunction = (msec,cb)->
  setTimeout ()->
    cb null, msec / 1000
  ,msec

describe "async test (Collections)", ->
  it "map(coll, iteratee, callback)",(done) ->
    # 処理は並列で行われるが、resultsは順番通りに返る
    arr = []
    _async.map [200,400,100],(msec,next)->
      asyncFunction msec,(err,sec)->
        return next err if err
        arr.push msec
        next(null,sec)
    ,(err,results)->
      isNull err
      deepEqual arr,[ 100,200,400 ]
      deepEqual results,[ 0.2, 0.4, 0.1 ]
      done()
  it "mapLimit(coll, limit, iteratee, callback)",(done) ->
    # 処理はLimit数まで並列で行われる
    # 処理が終わったら随時次の処理を行う
    arr = []
    _async.mapLimit [200,400,50,100],2,(msec,next)->
      asyncFunction msec,(err,sec)->
        return next err if err
        arr.push msec
        next(null,sec)
    ,(err,results)->
      isNull err
      deepEqual arr,[ 200,50,100,400 ]
      # !!!: ↑間隔が狭すぎると順番が変わることがある
      deepEqual results,[ 0.2, 0.4,0.05, 0.1 ]
      done()
  it "mapSeries(coll, iteratee, callback)",(done) ->
    # 処理が終わるのを待ってから次の処理を行う
    arr = []
    _async.mapSeries [200,400,100],(msec,next)->
      asyncFunction msec,(err,sec)->
        return next err if err
        arr.push msec
        next(null,sec)
    ,(err,results)->
      isNull err
      deepEqual arr,[ 200,400,100 ]
      deepEqual results,[ 0.2, 0.4, 0.1 ]
      done()
  it "mapValues(obj, iteratee, callbackopt)",(done) ->
    # 第一引数はArrayではなくObject
    # 処理は並列で行われる
    vals = []
    keys = []
    _async.mapValues {
      f1:200
      f2:400
      f3:100
      },(val,key,next)->
        asyncFunction val,(err,sec)->
          return next err if err
          vals.push val
          keys.push key
          next(null,sec)
          # 返り値はObjectになる(Arrayではない)
          # この場合{key:sec}がmergeされる
    ,(err,result)->
      isNull err
      deepEqual vals,[ 100,200,400 ]
      deepEqual keys,[ 'f3','f1','f2' ]
      deepEqual result,{ f3: 0.1, f1: 0.2, f2: 0.4 }
      done()
  it "mapValuesLimit(obj, limit, iteratee, callback)"
  it "mapValuesSeries(obj, iteratee, callback)"
