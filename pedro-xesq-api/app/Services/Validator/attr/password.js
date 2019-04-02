const Joi = require('joi')

module.exports = {
  base: Joi.string().min(6).max(20),
  name: 'password',
  rules: [
    {
      name: 'valid',
      validate (params, value, state, options) {
        if (/(?=.*[a-z])(?=.*\d)/i.test(value)) {
          return value
        } else {
          return this.createError('password.valid', { v: value }, state, options)
        }
      }
    }
  ]
}
