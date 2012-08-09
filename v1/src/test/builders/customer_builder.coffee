Customer = require("../../server/models/customer")


CustomerBuilder = ->
  @name = "some customer"
  @vatNumber = "0456.876.234"
  @address =
    street: "some street"
    postalCode: "1234"
    city: "some city"

prototype = CustomerBuilder::
prototype.withName = (name) ->
  @name = name
  @

prototype.withVatNumber = (vatNumber) ->
  @vatNumber = name
  @

prototype.withAddress = (address) ->
  @address = address
  @

prototype.withPhoneNumber = (phoneNumber) ->
  @phoneNumber = phoneNumber
  @

prototype.withContact = (contact) ->
  @contact = contact
  @

prototype.withIncludeContactOnInvoice = ->
  @includeContactOnInvoice = true
  @

# prototype.build = ->
#   customer = new Customer(
#     name: @name
#     vatNumber: @vatNumber
#     address: @address
#   )
#   customer.phoneNumber = @phoneNumber  if @phoneNumber isnt `undefined`
#   customer.contact = @contact  if @contact isnt `undefined`
#   customer.includeContactOnInvoice = @includeContactOnInvoice  if @includeContactOnInvoice isnt `undefined`
#   customer

prototype.build = ->
  customer = new Customer(
    name: @name
    vatNumber: @vatNumber
    address: @address
  )
  customer
  
console.log "CustomerBuilder()"
console.log new CustomerBuilder()
console.log 'after'
module.exports = CustomerBuilder