{assert} = require 'chai'
_ = require 'lodash'
moment = require 'moment'

describe "query", ->
  it "selectDate(date,date2)", ->
    selectDate=(date,date2)->
      if date2
        date2 = moment(date2).add(1,'days').toDate()
      else
        date2 = moment(date).add(1,'days').toDate()
      query =
        $gte: moment(date).toDate()
        $lt: date2
      return query
    assert.deepEqual selectDate('20170809'),{
      '$gte': moment("2017-08-09").toDate()
      '$lt': moment("2017-08-10").toDate()
  }
    assert.deepEqual selectDate('20170809','20170820'),{
      '$gte': moment("2017-08-09").toDate()
      '$lt': moment("2017-08-21").toDate()
  }
