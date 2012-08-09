app = require("../../app")
mongoose = require("mongoose")
User = require("../../server/models/user")
UserBuilder = require("../builders/user_builder")
should = require("should")
validationHelper = require("./mongoose_validation_helper")
equalityHelper = require("../equality_functions")

mongoose.connection.collection("users").drop()

describe "given a new user", ->
  user = null
  error = null
  beforeEach ->
    user = new UserBuilder().build()

  describe "when it is saved with none of its required fields filled in", ->
    beforeEach (done) ->
      user = new User() # the user reference by default points to a properly filled in instance
      user.salt = null # to avoid the default value
      user.save (err) ->
        error = err
        done()


    it "should fail with validation errors for each required field", ->
      should.exist error
      validationHelper.checkRequiredValidationErrorFor error, "name"
      validationHelper.checkRequiredValidationErrorFor error, "email"
      validationHelper.checkRequiredValidationErrorFor error, "salt"
      validationHelper.checkRequiredValidationErrorFor error, "passwdHash"


  describe "when it is saved with all of its required fields filled in", ->
    beforeEach (done) ->
      user.save (err) ->
        error = err
        done()


    afterEach (done) ->
      
      # there's a unique index on user.name, if we don't remove it after each spec, the next insert fails
      user.remove (err) ->
        done()


    it "should not fail", ->
      should.not.exist error

describe "given an existing user", ->
  user = null
  beforeEach (done) ->
    user = new UserBuilder().build()
    user.save (err) ->
      should.not.exist err
      done()


  afterEach (done) ->
    done()  if user.removed
    user.remove (err) ->
      done()


  describe "when it is retrieved from the database", ->
    retrievedUser = null
    beforeEach (done) ->
      User.findById user.id, (err, result) ->
        should.not.exist err
        retrievedUser = result
        done()


    it "should contain the same values that have been inserted", ->
      equalityHelper.usersShouldBeEqual retrievedUser, user


  describe "when it is modified and updated", ->
    beforeEach (done) ->
      user.name = "some user name"
      user.email = "some email"
      user.salt = "some salt value"
      user.passwdHash = "some passwd hash"
      user.save (err) ->
        should.not.exist err
        done()


    it "contains the updated values in the database", (done) ->
      User.findById user.id, (err, result) ->
        equalityHelper.usersShouldBeEqual result, user
        done()



  describe "when it is deleted", ->
    beforeEach (done) ->
      user.remove (err) ->
        user.removed = true # HACK: to avoid double removal in afterEach of parent suite
        should.not.exist err
        done()


    it "can no longer be retrieved", (done) ->
      User.findById user.id, (err, result) ->
        should.not.exist result
        done()

after (done) ->
  mongoose.disconnect()
  do done
