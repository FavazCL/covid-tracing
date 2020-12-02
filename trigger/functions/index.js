const functions = require('firebase-functions');
const admin = require('firebase-admin');

admin.initializeApp();

var msgData;
var payload;

exports.newSubscriberNotification = functions.firestore
    .document('report/{reportId}')
    .onCreate((snap, context) => {
        msgData = snap.data();
        payload = {
            "notification": {
                "title": "Nuevo caso reportado.",
                "body": "Verifica si estuviste en contacto con esta persona.",
                "sound": "default"
            },
            "data": {
                "reportDate": msgData.reportDate,
                "seed": msgData.seed
            }
        }

        return admin.messaging().sendToTopic("reports", payload).then((response) => {
            console.log('Notifications Success: ' + response);
        }).catch((error) => {
            console.log('Notifications Error: ' + error);
        });
    });