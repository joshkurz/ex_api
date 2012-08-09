path       = require("path")
config     = require("./config")
express    = require("express")
routes     = require("./server/routes")
http       = require("http")
mongoStore = require("connect-mongodb")
mongoose   = require("mongoose")

app = express()
app.configure ->
  app.set "port", process.env.PORT or 3000
  app.set "views", path.join(__dirname, "views")
  app.set "view engine", "jade"
  app.set "basepath", "/"
  app.use express.favicon()
  app.use express.logger("dev")
  app.use express.bodyParser()
  app.use express.methodOverride()
  app.use app.router
  app.use express["static"](path.join(__dirname, "public"))
  app.use express["static"](path.join(__dirname, "docs"))

app.configure "development", ->
  app.set "port", process.env.PORT or 3000
  app.set "db-uri", process.env.MONGOLAB_URI or process.env.MONGODB_URI or config.default_db_uri
  app.use express.errorHandler(
    dumpExceptions: true
    showStack: true
  )
  app.set "view options",
    layout: false
    pretty: true


app.configure "test", ->
  app.set "port", process.env.PORT or 3001
  app.set "db-uri", process.env.MONGOLAB_URI or process.env.MONGODB_URI or config.default_db_uri
  app.set "view options",
    layout: false
    pretty: true


app.configure "production", ->
  app.set "port", process.env.PORT or 80
  app.set "db-uri", process.env.MONGOLAB_URI or process.env.MONGODB_URI or config.default_db_uri
  app.set "view options",
    layout: false

  app.use express.errorHandler()

mongoose.connect app.get("db-uri")

exports = module.exports = mongoose

# app.get "doc", routes.doc
app.get "/doc", (req, res) ->
  res.render "doc/index",

app.get "/", routes.index

http.createServer(app).listen app.get("port"), ->
  console.log "Express server listening on port " + app.get("port")

