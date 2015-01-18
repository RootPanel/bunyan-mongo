{MongoClient} = require 'mongodb'
BunyanMongo = require './index'
bunyan = require 'bunyan'

bunyanMongo = new BunyanMongo()

logger = bunyan.createLogger
  name: 'sample'
  streams: [
    type: 'raw'
    stream: bunyanMongo
  ]

logger.info 'before connecting to MongoDB'

MongoClient.connect 'mongodb://localhost/bunyan-mongo-test', (err, db) ->
  throw err if err
  bunyanMongo.setDB db
  logger.info 'after connecting to MongoDB'
