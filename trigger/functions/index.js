const functions = require('firebase-functions');
const admin = require('firebase-admin');
const nodemailer = require('nodemailer');
const cors = require('cors')({ origin: true });
const Busboy = require('busboy');

admin.initializeApp();

var msgData;
var payload;
let transporter = nodemailer.createTransport({
    service: 'gmail',
    auth: {
        user: 'covidtracingapp@gmail.com',
        pass: 'Fl1727fll.'
    }
});

exports.newSubscriberNotification = functions.firestore
    .document('reports/{reportId}')
    .onCreate((snap, context) => {
        msgData = snap.data();
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

exports.sendMail = functions.https.onRequest((req, res) => {
    cors(req, res, () => {
        if (req.method !== 'POST') {
            return res.status(500).json({
                message: 'Not allowed'
            })
        }

        const busboy = new Busboy({ headers: req.headers });
        let attachments = [];
        let fields = {};

        busboy.on('file', function (fieldname, file, filename, encoding, mimetype) {
             file.on('data', function (data) {
                 attachments.push({
                    filename: filename,
                    content: new Buffer.from(data)
                 });
             });

             file.on('end', function () {
                 console.log('File [' + fieldname + '] Finished');
             });
         });

        busboy.on('field', (fieldname, val, fieldnameTruncated, valTruncated) => {
            fields[fieldname] = val;
        });

        busboy.on('finish', () => {
            const mailOptions = {
                from: 'Covid Tracing App <covidtracingapp@gmail.com>',
                to: fields['dest'],
                subject: 'Solicitud de código',
                html: `<div>
                <div style="background: #6c63ff; margin: 0 auto; width: 100%;">
                <div style="padding: 10px;">
                <h1 style="text-align: center; color: #fff;">COVID TRACING APP</h1>
                </div>
                <div style="background: #fff; padding: 10px;">
                <h1 style="text-align: center; color: #463e5d;">Nueva solicitud de c&oacute;digo</h1>
                <p style="text-align: center;">Un usuario de la aplicaci&oacute;n ha solicitado un c&oacute;digo para realizar un reporte de su diagn&oacute;stico, recuerda <strong style="color: #463e5d;">verificar el certificado adjunto</strong> y luego <strong style="color: #463e5d;">env&iacute;a el c&oacute;digo</strong> al correo ingresado por el usuario.</p>
                <div style="border-style: dashed; color: #6c63ff; margin: 40px 0px 0px 0px; padding: 10px 0px;">
                <h3 style="text-align: center; color: #463e5d;">Informaci&oacute;n ingresada por el usuario:</h3>
                <div>
                <div>
                <p style="text-align: center;"><strong style="color: #463e5d;">Correo:</strong> `+ fields['email'] + `<br /><strong style="color: #463e5d;">Rut:</strong> `+ fields['rut'] + `<br /><strong style="color: #463e5d;">Fecha de solicitud:</strong> `+ fields['date'] + `</p>
                </div>
                </div>
                </div>
                <div style="text-align: center;"><img style="margin: 0 auto; width: 50%;" src="http://micro-theme.com/html/covid-19/assets/img/hero-one-img.png" width="50%" /></div>
                </div>
                <div style="background: #08021F; padding: 5px;">
                <h2 style="text-align: center; color: #fff;">Contacto</h2>
                <div>
                <div>
                <p style="text-align: center; color: #fff;"><strong>Web:</strong> covidtracing.cl <br /><strong>Correo de contacto:</strong> covidtracingapp@gmail.com <br /><strong>Tel&eacute;fono:</strong> +569 73443805</p>
                </div>
                </div>
                </div>
                </div>
                </div>
                 `
            };
            
            mailOptions.attachments = attachments;
            transporter.sendMail(mailOptions, (error, info) => {
                if (error) {
                    res.status(404).end();
                } else {
                    res.status(200).end();
                }
            });

            // res.status(statusCode).end();
        });

        busboy.on('error', (error) => {
            console.log('Busy error: ' + error);
        });
        
        return busboy.end(req.rawBody)
    });
});
