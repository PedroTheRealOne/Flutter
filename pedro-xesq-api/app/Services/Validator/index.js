const Joi = require('joi')
const attrs = require('./attr')
const options = {
  language: require('./language')
}

Joi.extend(attrs)

class Validator {
  constructor(schema) { //eslint-disable-line
    this.schema = schema
  }

  validate (request) {
    const result = Joi.validate(request.body, this.schema, options)
    if (result.error) {
      throw result.error
    }
  }
}

module.exports = Validator
