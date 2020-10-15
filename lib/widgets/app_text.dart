import 'package:flutter/material.dart';

class AppText extends StatelessWidget {
  String labelText;
  String hintText;
  bool obscureText;
  TextEditingController controller;
  FormFieldValidator<String> validator;
  TextInputType inputType;
  TextInputAction textInputAction;
  FocusNode focus;
  FocusNode nextFocus;

  AppText(
    this.labelText,
    this.hintText, {
    this.obscureText = false,
    this.controller,
    this.validator,
    this.inputType,
    this.textInputAction,
    this.focus,
    this.nextFocus,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      obscureText: obscureText,
      validator: validator,
      keyboardType: inputType,
      textInputAction: textInputAction,
      focusNode: focus,
      onFieldSubmitted: (String text) {
        if (nextFocus != null) {
          FocusScope.of(context).requestFocus(nextFocus);
        }
      },
      style: TextStyle(
        fontSize: 25,
        color: Colors.blue,
      ),
      decoration: InputDecoration(
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(5)),
          labelText: labelText,
          labelStyle: TextStyle(
            fontSize: 25,
            color: Colors.grey,
          ),
          hintText: hintText,
          hintStyle: TextStyle(
            fontSize: 16,
          )),
    );
  }
}
