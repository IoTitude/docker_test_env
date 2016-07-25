/*
 * Library plugin
 *
 * Provides shared functions for other plugins.
 */

// Url to the java rest api
var JAVA_REST_URL = "http://192.168.142.30:8080/adminkamu/webresources/controller"

// Update the KaMU's data in the database
var update = function (kamu) {
  var id = Box.Documents.find("Master", {fields: "id", where:"mac = '" + kamu.mac + "'"})[0].id
  var mac = kamu.mac
  var hash = kamu.hash
  var installer = kamu.installer
  var installationDate = kamu.installationDate
  var address = kamu.address
  var location = kamu.location
  var sensorHeight = kamu.sensorHeight
  var enabled
  if (typeof kamu.enable === 'string') {
    enabled = (kamu.enabled.toLowerCase() === 'true')
  } else {
    enabled = kamu.enabled
  }
  var status = kamu.status
  var swVersion = kamu.swVersion
  var sensors = kamu.sensors
  var activeProfile = kamu.activeProfile

  // When updating via plugin the document content needs to be the same as
  // on creation. The additional id field indicates that this is an update.
  var updateDoc = {
    "id": id,
    "mac": mac,
    "hash": hash,
    "installer": installer,
    "installationDate": installationDate,
    "address": address,
    "location": location,
    "sensorHeight": sensorHeight,
    "enabled": enabled,
    "status": status,
    "swVersion": swVersion,
    "sensors": sensors,
    "activeProfile": activeProfile
  }

  // Same as for creating new document. Id field makes this an update.
  var doc = Box.Documents.save('Master', updateDoc)

  return doc
}

exports.JAVA_REST_URL = JAVA_REST_URL
exports.update = update
