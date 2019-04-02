'use strict'

/** @type {import('@adonisjs/framework/src/Route/Manager'} */
const Route = use('Route')

/* Auth */
require('./auth')
require('./tweet')
require('./like')

Route.get('/', () => {
  return {
    cornsim: 'cornao'
  }
})

Route.get('/corno', () => {
  return { corno: 'so e quem descobre' }
})
