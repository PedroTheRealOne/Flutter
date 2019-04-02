'use strict'

const Tweet = use('App/Models/Tweet')
const Joi = require('joi')
const Validator = require('../../Services/Validator')

/**
 * Resourceful controller for interacting with tweets
 */
class TweetController {
  /**
   * Show a list of all tweets.
   * GET tweets
   */
  async index ({ request, response }) {
    const tweets = await Tweet
      .query()
      .orderBy('id', 'asc')
      .with('user')
      .with('likes')
      .with('likes.user')
      .fetch()

    return tweets
  }

  /**
   * Create/save a new tweet.
   * POST tweets
   */
  async store ({ request, response, auth }) {
    new Validator({
      body: Joi.string().min(1).required().label('Corpo do tweet')
    }).validate(request)

    let { body } = request.all()

    const tweet = await Tweet.create({
      user_id: auth.user.id,
      body
    })

    return tweet
  }

  /**
   * Display a single tweet.
   * GET tweets/:id
   */
  async show ({ params, request, response, view }) {
    const tweets = await Tweet
      .query()
      .orderBy('id', 'asc')
      .where('id', params.id)
      .with('user')
      .fetch()

    return tweets
  }
  /**
   * Update tweet details.
   * PUT or PATCH tweets/:id
   */
  async update ({ request, auth, response, params }) {
    new Validator({
      user_id: Joi.number().label('Codigo Usuario'),
      body: Joi.string().min(1).required().label('Corpo do Tweet')
    }).validate(request)

    const tweet = await Tweet.query().where('id', params.id).with('user').first()

    if (auth.user.id !== tweet.user_id) {
      return response.status(401).send({ error: 'Você não tem permissão para alterar os dados deste tweet.' })
    }

    console.log(request.params.id)

    let tweetData = request.only(['user_id', 'body'])

    const tweetUp = await Tweet.findOrFail(params.id)

    tweetUp.merge(tweetData)

    await tweetUp.save()

    return tweetUp
  }

  /**
   * Delete a tweet with id.
   * DELETE tweets/:id
   */
  async destroy ({ params, request, response }) {
    const tweetId = await Tweet.findOrFail(params.id)

    await tweetId.delete()
  }
}

module.exports = TweetController
