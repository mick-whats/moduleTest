###
JavaScriptの基本的仕様についての確認等
###


{assert} = require 'chai'
_ = require 'lodash'
moment = require 'moment'
OK = assert.isOk
NG = assert.isNotOk
Equal = assert.equal
NotEqual = assert.notEqual
DeepEqual = assert.deepEqual
NotDeepEqual = assert.notDeepEqual

describe "JavaScript test", ->
  it "浮動小数点演算", ->
    ###
    小数点以下の計算は誤差がでることの検証
    ###
    nums = [6 , 9 , 8 , 12 , 12 , 20]
    sumArray = (arr)->
      arr.reduce(((sum,n)-> sum + n),0)
    Equal sumArray(nums),67
    nums2 = [0.06 , 0.09 , 0.08 , 0.12 , 0.12 , 0.2]
    NotEqual sumArray(nums2),0.67
    Equal sumArray(nums2),0.6699999999999999

  it "arguments", ->
    templates = [
      {margin: "10px"}
      {margin: "10px 20px"}
    ]
    test = ->
      style = {}
      args = Array::slice.call(arguments, 0)
      attr = args.pop()
      if !_.isPlainObject(attr)
        args.push attr
        attr = null
      nums = []
      strs = []
      for i in [0..args.length]
        item = args[i]
        if _.isNumber(item)
          nums.push(item)
        else if _.isString(item)
          strs.push(item)
      style['color'] = color if color = _.get(strs,'0')
      style['background-color'] = bgColor if bgColor = _.get(strs,'1')
      style = if Object.keys(style).length then {style} else {}
      template = if nums.length then templates[nums[0]] else {}
      return _.merge(template,attr,style)
    DeepEqual test({width: '100px'}),{ width: '100px' }

    DeepEqual test('blue',{width: '100px'}),
    { width: '100px',style: { color: 'blue'} }

    DeepEqual test('blue','red',{width: '100px'}),
    { width: '100px',style: { color: 'blue','background-color': 'red'} }

    DeepEqual test('blue','red','gold',{width: '100px'}),
    { width: '100px',style: { color: 'blue','background-color': 'red'} },
    "第三引数のgoldは無視される"

    DeepEqual test('blue',{width: '100px'},'red'),
    {style: { color: 'blue','background-color': 'red'} },
    "引数の最後ではないObjectは無視される"

    DeepEqual test({width: '100px'},'red','blue'),
    {style: { color: 'red','background-color': 'blue'} },
    "引数の最後ではないObjectは無視される"

    DeepEqual test(0,'red','blue'),
    margin:
      '10px'
    style: { color: 'red', 'background-color': 'blue' },
    "引数にnumberがあればtemplatesを参照する"

    DeepEqual test(1,'red','blue',{margin: '100px'}),
    margin:
      '100px'
    style: { color: 'red', 'background-color': 'blue' },
    "引数の最後にObjectがあり、templateと値が被っていれば上書きされる"

  it "arguments2", ->
    # 関数の引数を別の関数に丸投げする
    X = ->
      return Array::slice.call(arguments, 0)
    B = ->
      return X(arguments)
    C = ->
      return X.apply(@,arguments)

    correct = [ 2, 'a', { hoge: 'fuga' } ]

    NotDeepEqual X(2,'a',{hoge:'fuga'}),B(2,'a',{hoge:'fuga'})
    NotDeepEqual B(2,'a',{hoge:'fuga'}),correct,
    "X(arguments) とそのまま渡すと違う形式になってしまう"

    DeepEqual X(2,'a',{hoge:'fuga'}),C(2,'a',{hoge:'fuga'})
    DeepEqual C(2,'a',{hoge:'fuga'}),correct,
    "X.apply(@,arguments) とすることで、そのままの形で返ってくる"
