'use strict'
const Like = use('App/Models/TweetLike')
const User = use('App/Models/User')
/* const Joi = require('joi')
const Validator = require('../../Services/Validator') */

/**
 * Resourceful controller for interacting with likes
 */
class TweetLikeController {
  /**
   * Show a list of all likes.
   * GET likes
   */
  async index ({ request, response }) {
    const yourLikedTweets = await Like
      .query()
      .orderBy('id', 'asc')
      .with('tweet')
      .fetch()

    return yourLikedTweets
  }

  /**
   * Render a form to be used for creating a new like.
   * GET likes/create
   */
  async create ({ request, response, view }) {
  }

  /**
   * Create/save a new like.
   * POST likes
   */
  async store ({ request, response, auth, params }) {
    let { tweetId } = request.all()

    let tweetUserLiked = await Like
      .query()
      .where('user_id', auth.user.id)
      .where('tweet_id', tweetId)
      .fetch()

    if (tweetUserLiked.toJSON().length >= 1) {
      const likeID = await Like.query().where('tweet_id', tweetId).first()

      await likeID.delete()

      return response.status(401).send({ error: 'Você já deu like nesse tweet.' })
    }

    const likeStatus = await Like.create({
      user_id: auth.user.id,
      tweet_id: tweetId
    })

    return likeStatus
  }

  /**
   * Display a single like.
   * GET likes/:id
   */
  async show ({ params, request, response, view }) {
  }

  /**
   * Render a form to update an existing like.
   * GET likes/:id/edit
   */
  async edit ({ params, request, response, view }) {
  }

  /**
   * Update like details.
   * PUT or PATCH likes/:id
   */
  async update ({ params, request, response }) {
  }

  /**
   * Delete a like with id.
   * DELETE likes/:id
   */
  async destroy ({ params, request, response }) {
  }
}

module.exports = TweetLikeController
