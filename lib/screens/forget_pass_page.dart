import 'package:flutter/material.dart';

class ForgetPasswordPage extends StatefulWidget {
  const ForgetPasswordPage({super.key});

  @override
  State<ForgetPasswordPage> createState() => _ForgetPasswordPageState();
}

class _ForgetPasswordPageState extends State<ForgetPasswordPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Biliy"),
      ),
      body: const Center(
        child: Text(
          "forget password page",
          style: TextStyle(
            fontSize: 40,
          ),
        ),
      ),
    );
  }
}
