import 'dart:io';

import 'package:flutter_email_sender/flutter_email_sender.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class RequestController extends GetxController {
  ImagePicker picker = ImagePicker();
  File file;
  Email email = Email();
  bool _image = false;
  bool _checked = false;
  String _textImage;

  bool get image => _image;
  bool get checked => _checked;
  String get textImage => _textImage;

  set setImage(bool value) {
    _image = value;
    update(['request']);
  }

  set setChecked(bool value) {
    _checked = value;
    update(['request']);
  }

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
    update(['request']);
  }

  Future<void> getImage() async {
    try {
      final pickedFile = await picker.getImage(source: ImageSource.gallery);

      file = File(pickedFile.path);

      if (file.path != null || pickedFile != null) {
        final text = file.path.split("/");
        _textImage = text.last;
        _image = true;
      } else {
        _image = false;
      }
    } catch (e) {
      print('Error on getImage $e');
    }
    update(['request']);
  }

  Future<void> takeImage() async {
    final pickedFile = await picker.getImage(source: ImageSource.camera);

    file = File(pickedFile.path);

    try {
      if (file.path != null) {
        final text = file.path.split("/");
        _textImage = text.last;
        _image = true;
      } else {
        _image = false;
      }
    } catch (e) {
      print('Error on takeImage $e');
    }

    update(['request']);
  }
}
