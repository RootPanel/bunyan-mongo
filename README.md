# bunyan-mongo
Stream log from bunyan to MongoDB capped collection.

Usages:

    BunyanMongo = require 'bunyan-mongo'
    bunyanMongo = new BunyanMongo()

    logger = bunyan.createLogger
      name: 'sample'
      streams: [
        type: 'raw'
        stream: bunyanMongo
      ]

    logger.info 'before connecting to MongoDB'

    MongoClient.connect 'mongodb://localhost/test', (err, db) ->
      bunyanMongo.setDB db
      logger.info 'after connecting to MongoDB'
