const fs = require('fs')

const attrs = fs.readdirSync(__dirname)
  .filter(fileName => fileName !== 'index.js')
  .map(fileName => require(`./${fileName}`))

module.exports = attrs
