import 'package:flutter/material.dart';

class LoginTextField extends StatelessWidget {
 
  final dynamic controller;
  final String hintText;
  final bool obscureText;
  final TextInputType textInputType;
  final int minLength;
  final int maxLength;

  const LoginTextField({
    super.key,
    required this.controller,
    required this.hintText,
    required this.textInputType,
    required this.obscureText,
    required this.minLength,
    required this.maxLength,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 25.0),
      child: TextFormField(
        validator: (value) {
          return onValidate(value, hintText, minLength, maxLength);
        },
        controller: controller,
        obscureText: obscureText,
        keyboardType: textInputType,
        decoration: InputDecoration(
            enabledBorder: const OutlineInputBorder(
                borderSide: BorderSide(color: Colors.grey)),
            fillColor: Colors.white,
            filled: true,
            hintText: hintText,
            hintStyle: TextStyle(color: Colors.grey[500])),
        autofocus: false,
      ),
    );
  }
}

String? onValidate(value, hintText, minLength, maxLength) {
  if (value == null || value.isEmpty) {
    return " Enter  $hintText";
  }
  if (hintText == "Email") {
    if (!RegExp(
            r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
        .hasMatch(value)) {
      return "Email invalid";
    }
  }
  if (hintText == "Phone") {
    if (double.tryParse(value) == null) {
      return "Pone invalid";
    }
  }
  if (value.length < minLength) {
    return "Do not type less than $minLength chars";
  } else if (value.length > maxLength) {
    return "Do not type more than $maxLength chars";
  }
  return null;
}
