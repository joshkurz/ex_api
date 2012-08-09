// Generated by CoffeeScript 1.3.3
(function() {
  var checkValidationErrorFor;

  checkValidationErrorFor = function(err, validatorName, propertyName) {
    var value;
    if (!err) {
      return false;
    }
    if (err.name !== "ValidationError") {
      return false;
    }
    value = err.errors[propertyName];
    if (!value) {
      return false;
    }
    return value.message === "Validator \"" + validatorName + "\" failed for path " + propertyName;
  };

  exports.checkRequiredValidationErrorFor = function(error, propertyName) {
    return checkValidationErrorFor(error, "required", propertyName);
  };

  exports.checkMaxValidationErrorFor = function(error, propertyName) {
    return checkValidationErrorFor(error, "max", propertyName);
  };

  exports.checkMinValidationErrorFor = function(error, propertyName) {
    return checkValidationErrorFor(error, "min", propertyName);
  };

}).call(this);