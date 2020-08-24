import 'package:flutter/material.dart';

class ErrorDialog extends StatelessWidget {
  final String title, content, confirmation;
  final VoidCallback onPressed;
  const ErrorDialog({Key key, @required this.title, @required this.content, @required this.confirmation, this.onPressed}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(this.title),
      content: Text(this.content),
      actions: [
        FlatButton(
          onPressed: this.onPressed, 
          child: Text(this.confirmation)
        )
      ],
    );
  }
}