import 'package:billy_app/providers/token_provider.dart';
import 'package:billy_app/screens/homePage/home_page.dart';
import 'package:billy_app/screens/welcomePage/welcome_page.dart';
import 'package:flutter/material.dart';

class AuthPage extends StatelessWidget {
  const AuthPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder(
        builder: (BuildContext context, AsyncSnapshot snapshot)  {
          if (Token().isVlidToken()) {
            return const HomePage();
          } else {
            return const WelcomePage();
          }
        },
      ),
    );
  }
}
