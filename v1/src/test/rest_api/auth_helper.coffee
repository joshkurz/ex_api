app = require("../../app")
mongoose = require("mongoose")
User = require("../../server/models/user")
request_helper = require("./request_helper")
mongoose.connection.collection("users").drop()
user = new User(
  name: "test_user"
  email: "blah"
)
user.setPassword "test"
user.save (err, result) ->
  throw err  if err

exports.post_login = (done) ->
  request_helper.post "/login",
    username: user.name
    password: "test"
  , ((err, result, done) ->
    throw err  if err
    done()
  ), done


