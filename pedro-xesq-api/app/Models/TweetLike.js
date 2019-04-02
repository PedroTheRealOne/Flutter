'use strict'

/** @type {typeof import('@adonisjs/lucid/src/Lucid/Model')} */
const Model = use('Model')

class TweetLike extends Model {
  user () {
    return this.hasMany('App/Models/User', 'user_id', 'id')
  }
  tweet () {
    return this.hasMany('App/Models/Tweet', 'tweet_id', 'id')
  }
}

module.exports = TweetLike
