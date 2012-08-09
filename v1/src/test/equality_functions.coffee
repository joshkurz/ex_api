should = require("should")

addressesShouldBeEqual = (address1, address2) ->
  return  if address1 is null and address2 is null
  should.exist address2  if address1 isnt null
  should.exist address1  if address2 isnt null
  should.equal address1.street, address2.street
  should.equal address1.city, address2.city
  should.equal address1.postalCode, address2.postalCode
  should.equal address1.country, address2.country

contactsShouldBeEqual = (contact1, contact2) ->
  return  if contact1 is null and contact2 is null
  should.exist contact2  if contact1 isnt null
  should.exist contact1  if contact2 isnt null
  should.equal contact1.name, contact2.name
  should.equal contact1.email, contact2.email

customersShouldBeEqual = (customer1, customer2) ->
  should.equal customer1.name, customer2.name
  should.equal customer1.vatNumber, customer2.vatNumber
  should.equal customer1.phoneNumber, customer2.phoneNumber
  should.equal customer1.includeContactOnInvoice, customer2.includeContactOnInvoice
  addressesShouldBeEqual customer1.address, customer2.address
  contactsShouldBeEqual customer1.contact, customer2.contact

performedWorkShouldBeEqual = (performedWorkArray1, performedWorkArray2) ->
  i = undefined
  length = undefined
  performedWorkArray1.length.should.equal performedWorkArray2.length
  i = 0
  length = performedWorkArray1.length

  while i < length
    should.equal performedWorkArray1[i].date, performedWorkArray2[i].date
    should.equal performedWorkArray1[i].hours, performedWorkArray2[i].hours
    i++

activitiesShouldBeEqual = (activity1, activity2) ->
  should.equal activity1.customerId, activity2.customerId
  should.equal activity1.description, activity2.description
  should.equal activity1.billed, activity2.billed
  should.equal activity1.hourlyRate.toFixed(), activity2.hourlyRate.toFixed()
  performedWorkShouldBeEqual activity1.performedWork, activity2.performedWork

companiesShouldBeEqual = (company1, company2) ->
  should.equal company1.name, company2.name
  should.equal company1.phoneNumber, company2.phoneNumber
  should.equal company1.email, company2.email
  should.equal company1.vatNumber, company2.vatNumber
  should.equal company1.bankAccount, company2.bankAccount
  should.equal company1.iban, company2.iban
  should.equal company1.bic, company2.bic
  addressesShouldBeEqual company1.address, company2.address

invoicesShouldBeEqual = (invoice1, invoice2) ->
  should.equal invoice1.customerId, invoice2.customerId
  should.equal invoice1.companyId, invoice2.companyId
  should.equal invoice1.invoiceNumber, invoice2.invoiceNumber
  should.equal invoice1.date.valueOf(), invoice2.date.valueOf()
  should.equal invoice1.dueDate.valueOf(), invoice2.dueDate.valueOf()
  should.equal invoice1.paid, invoice2.paid
  should.equal invoice1.activityId, invoice2.activityId
  should.equal invoice1.totalHours.toFixed(), invoice2.totalHours.toFixed()
  should.equal invoice1.hourlyRate.toFixed(), invoice2.hourlyRate.toFixed()
  should.equal invoice1.totalExcludingVat.toFixed(), invoice2.totalExcludingVat.toFixed()
  should.equal invoice1.vat.toFixed(), invoice2.vat.toFixed()
  should.equal invoice1.totalIncludingVat.toFixed(), invoice2.totalIncludingVat.toFixed()

usersShouldBeEqual = (user1, user2) ->
  should.equal user1.name, user2.name
  should.equal user1.email, user2.email
  should.equal user1.salt, user2.salt
  should.equal user1.passwdHash, user2.passwdHash

module.exports =
  addressesShouldBeEqual: addressesShouldBeEqual
  contactsShouldBeEqual: contactsShouldBeEqual
  customersShouldBeEqual: customersShouldBeEqual
  performedWorkShouldBeEqual: performedWorkShouldBeEqual
  activitiesShouldBeEqual: activitiesShouldBeEqual
  companiesShouldBeEqual: companiesShouldBeEqual
  invoicesShouldBeEqual: invoicesShouldBeEqual
  usersShouldBeEqual: usersShouldBeEqual