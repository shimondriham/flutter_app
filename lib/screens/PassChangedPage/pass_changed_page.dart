import 'package:flutter_app/screens/LoginPage/login_page.dart';
import 'package:flutter_app/widgets/navigation_button.dart';
import 'package:flutter/material.dart';

class PassChangedPage extends StatefulWidget {
  static const String id = 'pass_changed_page';

  const PassChangedPage({super.key});

  @override
  State<PassChangedPage> createState() => _PassChangedPageState();
}

class _PassChangedPageState extends State<PassChangedPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        shadowColor: Colors.white,
      ),
      body:  SafeArea(
          minimum: const EdgeInsets.all(25.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // logo
              const Icon(
                Icons.add_task,
                size: 100,
              ),
              const SizedBox(height: 40),
              // title
              const Text(
                "Password changed",
                style: TextStyle(
                  fontSize: 33,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
              const SizedBox(height: 20),
              // text
              SizedBox(
                width: MediaQuery.of(context).size.width,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 40.0),
                  child: Text(
                    "Your password has been changed successfully",
                    style: TextStyle(
                      fontSize: 17,
                      fontWeight: FontWeight.bold,
                      color: Colors.grey.shade400,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 40),
              // button
              NavigationButton(
                  context: context,
                  navigation: LoginPage.id,
                  text: "Back to Login",
                  color: Colors.black,
                  textcolor: Colors.white),
            ],
          ),
        ),
    );
  }
}
