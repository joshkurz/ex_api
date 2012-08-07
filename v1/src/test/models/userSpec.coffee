User = require("../../server/models/user")
should = require("should")
describe "given a user", ->
  user = null
  beforeEach ->
    user = new User()

  it "should have a default salt value", ->
    should.exist user.salt

  describe "when you create another user", ->
    user2 = null
    beforeEach ->
      user2 = new User()

    it "should not have the same salt value as the previous user", ->
      user.salt.should.not.equal user2.salt

  describe "when you set the password", ->
    beforeEach ->
      user.setPassword "my_password"

    it "should not contain the password value in passwdHash", ->
      user.passwdHash.should.not.equal "my_password"

    describe "when you validate the password with the correct value", ->
      it "should return true", ->
        user.validatePassword("my_password").should.be.true


    describe "when you validate the password with an invalid value", ->
      it "should return false", ->
        user.validatePassword("something_else").should.be.false


