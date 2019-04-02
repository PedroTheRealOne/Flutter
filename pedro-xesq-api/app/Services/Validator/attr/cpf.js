const Joi = require('joi')
const { CPF } = require('cpf_cnpj')

module.exports = {
  base: Joi.string(),
  name: 'cpf',
  rules: [
    {
      name: 'valid',
      validate (params, value, state, options) {
        if (CPF.isValid(value, true)) {
          return CPF.strip(value)
        } else {
          return this.createError('cpf.valid', { v: value }, state, options)
        }
      }
    }
  ]
}
