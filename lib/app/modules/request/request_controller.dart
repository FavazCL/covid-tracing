import 'dart:io';

import 'package:covid_app/app/modules/request/local_widgets/success_request.dart';
import 'package:date_format/date_format.dart';
import 'package:dio/dio.dart' as dio;
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class RequestController extends GetxController {
  final dio.Dio _dio = Get.find<dio.Dio>();
  ImagePicker picker = ImagePicker();
  File file;
  bool _image = false;
  bool _checked = false;
  String _textImage;
  String _email;

  bool get image => _image;
  bool get checked => _checked;
  String get textImage => _textImage;
  String get email => _email;

  set setImage(bool value) {
    _image = value;
    update(['request']);
  }

  set setChecked(bool value) {
    _checked = value;
    update(['request']);
  }

  set setEmail(String value) {
    _email = value;
    // update(['request']);
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

  Future<void> requestCode() async {
    try {
      dio.FormData formData = dio.FormData.fromMap({
        "dest": "favazcl@gmail.com", // Correo de la persona encargada
        "email": email,
        "rut": "11.111.111-1",
        "date": formatDate(DateTime.now(), [dd, '-', mm, '-', yyyy, ' a las ', HH, ':', nn, ':', ss]),
        "certificate": file
      });

      final res = await _dio.post('/sendMail', data: formData);
      print('response: ${res.statusCode}');
      if (res.statusCode == 200) {
        Get.off(SuccessRequestUI());
      } else {
         Get.snackbar('Error de solicitud de código', '',
           snackPosition: SnackPosition.TOP,
           messageText: Text('Hubo un error con la conexión del servidor, intente nuevamente.'),
           icon: Icon(Icons.warning, color: Colors.redAccent));
      }
    } catch (e) {
      print('Error on requestCode: $e');
    }
  }
}
