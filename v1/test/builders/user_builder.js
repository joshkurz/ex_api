// Generated by CoffeeScript 1.3.3
(function() {
  var User, UserBuilder, prototype;

  User = require("../../server/models/user");

  UserBuilder = function() {
    this.name = "user1";
    this.password = "super_secret_password";
    return this.email = "user1@domain.com";
  };

  prototype = UserBuilder.prototype;

  prototype.withName = function(name) {
    this.name = name;
    return this;
  };

  prototype.withEmail = function(email) {
    this.email = email;
    return this;
  };

  prototype.withPassword = function(password) {
    this.password = password;
    return this;
  };

  prototype.build = function() {
    var user;
    user = new User({
      name: this.name,
      email: this.email
    });
    user.setPassword(this.password);
    return user;
  };

  module.exports = UserBuilder;

}).call(this);
