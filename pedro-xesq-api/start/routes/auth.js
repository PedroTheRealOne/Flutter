const Route = use('Route')

Route
  .group(() => {
    Route.post('', 'AuthController.authenticate')
    Route
      .post('register', 'AuthController.register')
    Route
      .put('/:id', 'AuthController.update')
      .middleware(['auth'])
    Route
      .post('password/reset', 'AuthController.resetPassword')
    /**
    * Delete a User with id.
    * DELETE :id
    */
    Route
      .delete(':id', 'AuthController.destroy')
      .middleware(['auth', 'admin'])
  })
  .prefix('auth/')
