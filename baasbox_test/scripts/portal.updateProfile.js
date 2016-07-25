/*
 * Plugin for updating the profile of a KaMU
 */

var lib = require('library.shared')

http().put(function (req) {
  // Check that user has the required rights
  if (!Box.isAdmin()) {
    return {status: 401}
  }

  try {
    var body = req.body
    var datetime = body.datetime
    var kamu = body.kamu
    var profile = kamu.activeProfile
    var hash = kamu.hash

    var profileId = Box.Documents.find("Profile", { fields: "profileId", where: "name = '" + profile + "'"})[0].profileId
    Box.log(profileId)
    var data_to_send = "&datetime=" + datetime + "&profileId=" + profileId + "&hash=" + hash + "&"
    Box.log(data_to_send)

    var result_REST = Box.WS.post(
      lib.JAVA_REST_URL + "/changeProfile",
      data_to_send,
      {
        params: {},
        headers: {
          "Content-Type": "application/x-www-form-urlencoded"
        }
      }
    )
    Box.log(result_REST)

    // Update the information in the database
    if (result_REST.status === 200) {
      var result = lib.update(kamu)
    } else {
      return { status: result_REST.status, content: result_REST }
    }


  } catch (error) {
    Box.log(error)
    return {status: 500, content: error}
  }

  return {status: 200, content: result}
})
