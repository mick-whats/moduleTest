

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
    # console.log res
    cb null, _.get(res,'dataset.data',res)
    return

codes = ['9984','6065','8028','2884','5742','7752','3694','6089','9517','5344','7187']

# describe "quandl test", ->
#   it "basic",(done) ->
#     limit = 2
#     async.eachOfLimit codes,limit,(code,index,next)->
#       load code,(err,res)->
#         assert.isNull err
#         console.log res#
#         assert.notProperty res,'quandl_error'
#         next()
#     ,done
