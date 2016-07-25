/*
 * Plugin for SDN Controller for getting the enabled parameter of a metering unit
 *
 * Return 200 with current status if device is found in the list.
 * Return 404 if device is not found.
 */

http().get(function (request) {
  var mac = request.queryString.mac
  var doc = null

  Box.runAsAdmin(function () {
    /*
     * Do a query to the OrientDB and pick the first (and it should be the only)
     * element of the returned array. Also pick only the needed information,
     * namely the mac address for verification and the enabled status.
     */
    doc = Box.Documents.find("Master", {fields: "mac, enabled", where:"mac = '" + mac + "'"})[0]
  })

  if (doc) {
    return {status: 200, content: doc}
  } else {
    // Return 404 for security reasons. Discourages polling.
    return {status: 404}
  }
})
