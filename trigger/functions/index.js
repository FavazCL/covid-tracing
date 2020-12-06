const functions = require('firebase-functions');
const admin = require('firebase-admin');

admin.initializeApp();

var msgData;
var payload;

exports.newSubscriberNotification = functions.firestore
    .document('reports/{reportId}')
    .onCreate((snap, context) => {
        msgData = snap.data();
        console.log('MsgData: ' + msgData['reportDate']);
        console.log('MsgData: ' + msgData['ephId']);

        payload = {
            "notification": {
                "title": "Nuevo caso reportado.",
                "body": "Verifica si estuviste en contacto con esta persona.",
                "sound": "default",
                "click_action": "FLUTTER_NOTIFICATION_CLICK"
            },
            "data": {
                "reportDate": msgData['reportDate'].toString(),
                "ephId": JSON.stringify(msgData['ephId'])
            }
        }

        return admin.messaging().sendToTopic("reports", payload).then((response) => {
            console.log('Notifications Success: ' + response);
        }).catch((error) => {
            console.log('Notifications Error: ' + error);
        });
    });