app = require("../../app")
mongoose = require("mongoose")
Customer = require("../../server/models/customer")
CustomerBuilder = require("../builders/customer_builder")

should = require("should")
validationHelper = require("./mongoose_validation_helper")
equalityHelper = require("../equality_functions")

#mongoose.connect "mongodb://localhost/ex_test"
mongoose.connection.collection("customers").drop()

customer = new CustomerBuilder().build()
console.log customer

describe "given a new customer", ->
  customer = null
  error = null
  beforeEach ->
    customer = new CustomerBuilder().build()

  describe "when it is saved with none of its required fields filled in", ->
    beforeEach (done) ->
      customer = new Customer() # the customer reference by default points to a properly filled in instance
      customer.save (err) ->
        error = err
        done()


    it "should fail with validation errors for each required field", ->
      should.exist error
      validationHelper.checkRequiredValidationErrorFor error, "name"
      validationHelper.checkRequiredValidationErrorFor error, "vatNumber"
      validationHelper.checkRequiredValidationErrorFor error, "address.street"
      validationHelper.checkRequiredValidationErrorFor error, "address.postalCode"
      validationHelper.checkRequiredValidationErrorFor error, "address.city"


  describe "when it is saved with all of its required fields filled in", ->
    beforeEach (done) ->
      customer.save (err) ->
        error = err
        done()


    it "should not fail", ->
      should.not.exist error

    it "should contain a default false value for includeContactOnInvoice", (done) ->
      Customer.findById customer.id, (err, result) ->
        result.includeContactOnInvoice.should.be.false
        done()

describe "given an existing customer", ->
  customer = null
  beforeEach (done) ->
    customer = new CustomerBuilder().withIncludeContactOnInvoice().build()
    customer.save (err) ->
      should.not.exist err
      done()


  describe "when it is retrieved from the database", ->
    retrievedCustomer = null
    beforeEach (done) ->
      Customer.findById customer.id, (err, result) ->
        should.not.exist err
        retrievedCustomer = result
        done()


    it "should contain the same values that have been inserted", ->
      equalityHelper.customersShouldBeEqual retrievedCustomer, customer


  describe "when it is modified and updated", ->
    beforeEach (done) ->
      customer.name = "some other customer"
      customer.vatNumber = "0456.876.235"
      customer.address =
        street: "some other street"
        postalCode: "12345"
        city: "some other city"

      customer.phoneNumber = "123456789"
      customer.contact =
        name: "some name"
        email: "some_email@hotmail.com"

      customer.save (err) ->
        should.not.exist err
        done()


    it "contains the updated values in the database", (done) ->
      Customer.findById customer.id, (err, result) ->
        equalityHelper.customersShouldBeEqual result, customer
        done()



  describe "when it is deleted", ->
    beforeEach (done) ->
      customer.remove (err) ->
        should.not.exist err
        done()


    it "can no longer be retrieved", (done) ->
      Customer.findById customer.id, (err, result) ->
        should.not.exist result
        done()

after (done) ->
  mongoose.disconnect()
  do done


