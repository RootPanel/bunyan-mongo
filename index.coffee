_ = require 'underscore'

module.exports = class BunyanMongo
  queue: []

  collection: null

  options:
    collection_name: 'logs'
    capped: true
    size: 32 * 1024 * 1024

  constructor: (options = {}) ->
    _.extend @options, options

  setDB: (db) ->
    options = _.pick @options, 'capped', 'size'

    db.createCollection @options.collection_name, options, (err, collection) =>
      throw err if err
      @collection = collection
      @dequeueRecords()

  dequeueRecords: ->
    while @queue.length
      @write @queue.shift()

  write: (data) ->
    if @collection
      @collection.insert data, (err) ->
        console.error err if err
    else
      @queue.push data
