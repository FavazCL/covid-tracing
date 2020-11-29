import 'dart:async';

import 'package:covid_app/app/theme/color_theme.dart';
import 'package:covid_app/app/utils/responsive.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

import '../report_controller.dart';

// ignore: must_be_immutable
class PinTextField extends StatelessWidget {
  PinTextField({Key key}) : super(key: key);

  // ignore: close_sinks
  StreamController<ErrorAnimationType> errorController;
  final TextEditingController textEditingController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final Responsive responsive = Responsive.of(context);
    
    return GetBuilder<ReportController>(
      id: 'report',
      builder: (_) => 
         Container(
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
          onCompleted: (value) {
            print('complete');
            _.setDisplay = true;
          },
          onChanged: (value) {
            print(value);
            if (value.length < 5) {
              _.setDisplay = false;
            }
          },
          beforeTextPaste: (text) {
            return true;
          },
        ),
      ),
    );
  }
}