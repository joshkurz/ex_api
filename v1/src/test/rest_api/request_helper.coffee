getUrlFor = (route) ->
  "http://localhost:3000" + route
sendRequest = (method, route, body, callback, done) ->
  request[method]
    url: getUrlFor(route)
    json: body
  , (err, res, b) ->
    callback err, res, done

request = require("request")
module.exports =
  post: (route, body, callback, done) ->
    sendRequest "post", route, body, callback, done

  get: (route, callback, done) ->
    sendRequest "get", route, null, callback, done