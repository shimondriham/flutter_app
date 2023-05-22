import 'package:flutter/material.dart';

class ConfirmPassTextField extends StatelessWidget {
  const ConfirmPassTextField(
      {super.key,
      required this.passwordController,
      required this.confirmpasswordController});
  final TextEditingController passwordController;
  final TextEditingController confirmpasswordController;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      validator: (value) {
        if (value == null || value.isEmpty) {
          return "Repeat the password";
        } else if (confirmpasswordController.text != passwordController.text) {
          return "The password is not the same";
        }
        return null;
      },
      controller: confirmpasswordController,
      obscureText: true,
      keyboardType: TextInputType.visiblePassword,
      decoration: InputDecoration(
          enabledBorder: const OutlineInputBorder(
              borderSide: BorderSide(color: Colors.white)),
          fillColor: Colors.grey[200],
          filled: true,
          hintText: "Confirm Password",
          hintStyle: TextStyle(color: Colors.grey[500])),
    );
  }
}