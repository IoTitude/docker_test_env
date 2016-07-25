/*
 * Plugin for handling the updating of a metering unit's enabled status
 *
 * At the moment this could be handled by a direct HTTP request to the
 * BaasBox REST API but a plugin provides more possibilities for expansion
 * like making furher HTTP request to other services from BaasBox when toggling.
 */

var lib = require('library.shared')

http().put(function (req) {
  try {
    var body = req.body
    var doc = lib.update(body)
  } catch (error) {
    Box.log(error)
    return {status: 500, content: error}
  }
  return {status: 200, content: doc}
})
