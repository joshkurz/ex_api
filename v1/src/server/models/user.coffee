mongoose = require("mongoose")
crypto = require("crypto")
uuid = require("node-uuid")
Schema = mongoose.Schema
ObjectId = Schema.ObjectId
userSchema = new Schema(
  name:
    type: String
    required: true
    unique: true

  email:
    type: String
    required: true

  salt:
    type: String
    required: true
    default: uuid.v1

  passwdHash:
    type: String
    required: true
)
hash = (passwd, salt) ->
  crypto.createHmac("sha256", salt).update(passwd).digest "hex"

userSchema.methods.setPassword = (passwordString) ->
  @passwdHash = hash(passwordString, @salt)

userSchema.methods.validatePassword = (passwordString) ->
  @passwdHash is hash(passwordString, @salt)

mongoose.model "User", userSchema
module.exports = mongoose.model("User")