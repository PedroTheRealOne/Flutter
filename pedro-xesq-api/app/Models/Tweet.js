'use strict'

/** @type {typeof import('@adonisjs/lucid/src/Lucid/Model')} */
const Model = use('Model')

class Tweet extends Model {
  user () {
    return this.hasMany('App/Models/User', 'user_id', 'id')
  }
  likes () {
    return this.hasMany('App/Models/TweetLike', 'id', 'tweet_id')
  }
}

module.exports = Tweet
