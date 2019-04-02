const Route = use('Route')

Route
  .group(() => {
    Route
      .post('', 'TweetController.store')
      .middleware(['auth'])
    Route
      .get('', 'TweetController.index')
      .middleware(['auth'])
    Route
      .delete('/:id', 'TweetController.destroy')
      .middleware(['auth'])
    Route
      .put('/:id', 'TweetController.update')
      .middleware(['auth'])
    Route
      .get('/:id', 'TweetController.show')
      .middleware(['auth'])
  })
  .prefix('tweets/')
