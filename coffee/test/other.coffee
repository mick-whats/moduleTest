{assert} = require 'chai'
_ = require 'lodash'

# その他のnpmモジュール


describe "sizeof", ->
  it "オブジェクトのサイズを計ってくれる", ->
    sizeof = require('sizeof').sizeof
    obj1 =
      name: 'Daniel'
      age: 18
    assert.equal sizeof(obj1),'34'
    assert.equal sizeof(obj1,true),'34B'
