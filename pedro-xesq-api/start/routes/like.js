const Route = use('Route')

Route
  .group(() => {
    Route
      .post('', 'TweetLikeController.store')
      .middleware(['auth'])
    Route
      .get('', 'TweetLikeController.index')
      .middleware(['auth'])
  })
  .prefix('likes/')
