'use strict'

/** @type {import('@adonisjs/lucid/src/Schema')} */
const Schema = use('Schema')

class TweetLikeSchema extends Schema {
  up () {
    this.create('tweet_likes', (table) => {
      table.increments()
      table.integer('user_id').unsigned().references('id').inTable('users')
      table.integer('tweet_id').unsigned().references('id').inTable('tweets')
      table.timestamps()
    })
  }

  down () {
    this.drop('tweet_likes')
  }
}

module.exports = TweetLikeSchema
