import 'package:billy_app/base_client.dart';
import 'package:billy_app/screens/AddInvoicePage/add_invoice_page.dart';
import 'package:billy_app/screens/LoginPage/login_page.dart';
import 'package:billy_app/screens/RegisterPage/register_page.dart';
import 'package:billy_app/widgets/navigation_button.dart';
import 'package:flutter/material.dart';

class WelcomePage extends StatelessWidget {
  const WelcomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        minimum: const EdgeInsets.all(25.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              "Welcome to my app",
              style: TextStyle(
                fontSize: 35,
                fontWeight: FontWeight.bold,
                color: Colors.purple.shade600,
              ),
            ),
            // billy logo
            const Icon(
              Icons.man,
              size: 300,
            ),
            Column(
              children: [
                // login Button
                NavigationButton(
                    context: context,
                    navigation: LoginPage.id,
                    text: "Login",
                    color: Colors.black,
                    textcolor: Colors.white),
                const SizedBox(height: 10),
                // register Button
                NavigationButton(
                    context: context,
                    navigation: RegisrerPage.id,
                    text: "Register",
                    color: Colors.white,
                    textcolor: Colors.black),
                const SizedBox(height: 10),
                NavigationButton(
                    context: context,
                    navigation: AddInvoicePage.id,
                    text: "to add invoice test",
                    color: Colors.blue,
                    textcolor: Colors.black),
              ],
            ),
            // explore
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                TextButton(
                  onPressed: () {
                    BaseClient().get('/health-check', context);
                  },
                  child: const Text("Explore",
                      style: TextStyle(color: Colors.black)),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
