const Joi = require('joi')
const { CNPJ } = require('cpf_cnpj')

module.exports = {
  base: Joi.string(),
  name: 'cnpj',
  rules: [
    {
      name: 'valid',
      validate (params, value, state, options) {
        if (CNPJ.isValid(value, true)) {
          return CNPJ.strip(value)
        } else {
          return this.createError('cnpj.valid', { v: value }, state, options)
        }
      }
    }
  ]
}
