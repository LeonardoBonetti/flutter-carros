import 'package:flutter/material.dart';

class TextError extends StatelessWidget {
  String message;
  Function onPressed;

  TextError(this.message, {this.onPressed});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: GestureDetector(
        onTap: onPressed,
        child: Text(
          message,
          style: TextStyle(color: Colors.red, fontSize: 20),
        ),
      ),
    );
  }
}
