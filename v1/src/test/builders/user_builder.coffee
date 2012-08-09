User = require("../../server/models/user")

UserBuilder = ->
  @name = "user1"
  @password = "super_secret_password"
  @email = "user1@domain.com"

prototype = UserBuilder::
prototype.withName = (name) ->
  @name = name
  @

prototype.withEmail = (email) ->
  @email = email
  @

prototype.withPassword = (password) ->
  @password = password
  @

prototype.build = ->
  user = new User(
    name: @name
    email: @email
  )
  user.setPassword @password
  user

module.exports = UserBuilder