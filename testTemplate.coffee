[testするmoduleのrequire]

_ = require 'lodash'
{assert} = require 'chai'
OK = assert.isOk
NG = assert.isNotOk
Equal = assert.equal

describe "[title] test", ->
  it "basic", ->
