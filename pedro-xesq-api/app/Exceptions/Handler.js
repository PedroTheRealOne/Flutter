'use strict'
const BaseExceptionHandler = use('BaseExceptionHandler')

/**
 * This class handles all exceptions thrown during
 * the HTTP request lifecycle.
 *
 * @class ExceptionHandler
 */
class ExceptionHandler extends BaseExceptionHandler {
  /**
   * Handle exception thrown during the HTTP lifecycle
   *
   * @method handle
   *
   * @param  {Object} err
   * @param  {Object} options.request
   * @param  {Object} options.response
   *
   * @return {void}
   */
  async handle (err, { request, response }) {
    console.log(err)
    if (err.name === 'ValidationError') {
      return response.status(422).send({ error: err.details[0].message.replace(/"/g, '') })
    }

    if (err.name === 'PasswordMisMatchException' || err.name === 'UserNotFoundException') {
      return response.status(err.status).send({ error: 'Usuário ou Senha incorretos.' })
    }

    if (process.env.NODE_ENV === 'production') {
      return response.status(err.status).send('Oops, algo deu errado...')
    } else {
      return response.status(err.status).send(err.message)
    }
  }

  /**
   * Report exception for logging or debugging.
   *
   * @method report
   *
   * @param  {Object} error
   * @param  {Object} options.request
   *
   * @return {void}
   */
  async report (err, { request }) {
    console.log(err)
  }
}

module.exports = ExceptionHandler
