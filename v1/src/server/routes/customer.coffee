Customer = require("../models/customer")
module.exports = (app, restrict) ->
  app.get "/customer/create", restrict, (req, res) ->
    res.render "customer/create"

  app.get "/customer/list", restrict, (req, res, next) ->
    customers = Customer.find({}, ["name"], (err, docs) ->
      return next(err)  if err
      res.render "customer/list",
        customers: docs

    )
