'use strict'

const User = use('App/Models/User')
const Joi = require('joi')
const Validator = require('../../Services/Validator')

class AuthController {
  async register ({ request, response, auth }) {
    new Validator({
      username: Joi.string().min(4).required().label('Nome'),
      email: Joi.string().email().required().label('E-mail'),
      password: Joi.string().min(3).required().label('Senha')
    }).validate(request)

    let { username, email, password } = request.all()

    const userExist = await User.findBy('email', email)

    if (userExist) {
      let err = { name: 'ValidationError', details: [{ message: 'E-mail já cadastrado.' }] }
      throw err
    }

    const user = await User.create({
      username,
      email,
      password
    })

    return user
  }

  async authenticate ({ request, auth }) {
    const { email, password } = request.all()

    const token = await auth
      .withRefreshToken()
      .attempt(email, password)

    const user = await User
      .query()
      .select('id')
      .select('username')
      .where('email', email)
      .where('active', true)
      .first()

    return {
      ...token,
      user
    }
  }

  async update ({ request, auth, response, params }) {
    new Validator({
      name: Joi.string().min(4).label('Nome'),
      email: Joi.string().email().label('E-mail'),
      phone: Joi.string().label('Telefone'),
      password: Joi.string().min(3).label('Senha')
    }).validate(request)

    let authUser = await User.findOrFail(auth.user.id)

    if (Number(request.params.id) !== auth.user.id && !authUser.admin) {
      response.status(401).send({ error: 'Você não tem permissão para atualizar dados desse usuário.' })
    }

    let userData = request.only(['name', 'email', 'phone', 'password'])

    const user = await User.findOrFail(params.id)

    user.merge(userData)

    await user.save()

    return user
  }

  async check ({ request, auth }) {
    const user = await User.findOrFail(auth.user.id)

    return user
  }

  async resetPassword ({ request, response }) {
    new Validator({
      email: Joi.string().email().required().label('E-mail'),
      passwordCode: Joi.string().min(6).max(6).required().label('Código de verificação'),
      password: Joi.string().min(3).required().label('Senha')
    }).validate(request)

    const { email, passwordCode, password } = request.only(['email', 'passwordCode', 'password'])

    const user = await User.findBy('email', email)
    if (!user) return response.status(422).send({ error: 'E-mail não encontrado. Verifique se esse é seu e-mail ou entre em contato com a BG Studio.' })

    if (user.password_code === passwordCode) {
      user.merge({ password })

      await user.save()

      return {}
    } else {
      return response.status(422).send({ error: 'Código incorreto.' })
    }
  }

  /**
   * Delete a store with id.
   * DELETE stores/:id
   */
  async destroy ({ params, request, response }) {
    const user = await User.findOrFail(params.id)

    await user.merge({ active: false, email: null })
    await user.save()

    return user
  }
}

module.exports = AuthController
