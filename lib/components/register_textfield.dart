import 'package:billy_app/components/login_textfield.dart';
import 'package:flutter/material.dart';


class RegisterTextField extends StatelessWidget {

  final dynamic controller;
  final String hintText;
  final bool obscureText;
  final dynamic textInputType;
  final int minLength;
  final int maxLength;

  const RegisterTextField({
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
    return  Padding(
      padding: const EdgeInsets.symmetric(horizontal: 25.0),
      child: TextFormField(
        validator: (value) {
          return onValidate(value,hintText,minLength,maxLength);
        },
        controller: controller,
        obscureText:obscureText,
        keyboardType:textInputType,
        decoration: InputDecoration(
          enabledBorder:
            const  OutlineInputBorder(borderSide: BorderSide(color: Colors.grey)),
          fillColor: Colors.white,
          filled: true,
          hintText: hintText,
          hintStyle: TextStyle(color: Colors.grey[500])
        ),
       autofocus: false,
      ),
    );
  }
}
