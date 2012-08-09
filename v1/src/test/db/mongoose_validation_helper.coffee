checkValidationErrorFor = (err, validatorName, propertyName) ->
  return false  unless err
  return false  if err.name isnt "ValidationError"
  value = err.errors[propertyName]
  return false  unless value
  value.message is "Validator \"" + validatorName + "\" failed for path " + propertyName

exports.checkRequiredValidationErrorFor = (error, propertyName) ->
  checkValidationErrorFor error, "required", propertyName

exports.checkMaxValidationErrorFor = (error, propertyName) ->
  checkValidationErrorFor error, "max", propertyName

exports.checkMinValidationErrorFor = (error, propertyName) ->
  checkValidationErrorFor error, "min", propertyName