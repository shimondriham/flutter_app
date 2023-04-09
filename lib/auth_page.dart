import 'package:billy_app/screens/LoginPage/login_page.dart';
import 'package:billy_app/screens/home_page.dart';
import 'package:flutter/material.dart';

class AuthPage extends StatelessWidget {

  const AuthPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder(
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (1<2) {
            return const LoginPage();
          } else {
            return const HomePage();
          }
        },
      ),
    );
  }
}
