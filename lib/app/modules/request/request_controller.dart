import 'dart:io';

import 'package:flutter_email_sender/flutter_email_sender.dart';
import 'package:get/get.dart';

class RequestController extends GetxController {
  Email email = Email();

  void sendEmail(File _image) async {
    email = Email(
      body: 'Enviar código a este correo:',
      subject: 'COVID-TRACING - SOLICITUD DE CÓDIGO',
      recipients: ['favazcl@gmail.com'], // Correo del encargado
      cc: ['lyn.cfontalba@gmail.com'], // Copia del correo
      bcc: ['fvalvarez95@gmail.com'], // Copia oculta
      attachmentPaths: [_image.path],
      isHTML: false,
    );

    try {
      await FlutterEmailSender.send(email);
    } catch (e) {
      print('Error on sendEmail: $e');
    }
  }
}
