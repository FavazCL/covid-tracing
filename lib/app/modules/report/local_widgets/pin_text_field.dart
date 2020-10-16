import 'dart:async';

import 'package:covid_app/app/theme/color_theme.dart';
import 'package:covid_app/app/utils/responsive.dart';
import 'package:flutter/material.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

class PinTextField extends StatelessWidget {
  PinTextField({Key key}) : super(key: key);

  StreamController<ErrorAnimationType> errorController;
  final TextEditingController textEditingController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final Responsive responsive = Responsive.of(context);
    
    return Container(
      padding: EdgeInsets.symmetric(horizontal: responsive.dp(6)),
      child: PinCodeTextField(
        length: 5,
        obsecureText: false,
        animationType: AnimationType.fade,
        autoFocus: false,
        dialogConfig: DialogConfig(
            dialogTitle: 'Pegar código',
            dialogContent: '¿Quieres pegar este código ',
            affirmativeText: 'Pegar',
            negativeText: 'Cancelar'),
        pinTheme: PinTheme(
          fieldHeight: 50,
          fieldWidth: 40,
          activeFillColor: Colors.white,
          inactiveFillColor: Colors.transparent,
          selectedFillColor: Colors.transparent,
          activeColor: ColorsPalette.primary,
          selectedColor: ColorsPalette.primary,
        ),
        animationDuration: Duration(milliseconds: 300),
        backgroundColor: Colors.white,
        enableActiveFill: true,
        errorAnimationController: errorController,
        controller: textEditingController,
        onCompleted: (value) {},
        onChanged: (value) {},
        beforeTextPaste: (text) {
          return true;
        },
      ),
    );
  }
}