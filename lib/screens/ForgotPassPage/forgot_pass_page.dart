import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter_app/base_client.dart';
import 'package:flutter_app/screens/NewPassPage/new_pass_page.dart';
import 'package:flutter_app/widgets/button_builder.dart';
import 'package:flutter_app/widgets/our_textfield.dart';
import 'package:flutter/material.dart';

class ForgotPasswordPage extends StatefulWidget {
  static const String id = 'forgot_password_page';

  const ForgotPasswordPage({super.key});

  @override
  State<ForgotPasswordPage> createState() => _ForgotPasswordPageState();
}

class _ForgotPasswordPageState extends State<ForgotPasswordPage> {
  final GlobalKey<FormState> _formForgotKey = GlobalKey<FormState>();

  final emailController = TextEditingController();

  @override
  void dispose() {
    emailController.dispose();
    super.dispose();
  }

  final Res res = Res();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Form(
          key: _formForgotKey,
          child: SafeArea(
            minimum: const EdgeInsets.all(25.0),
            child: Column(
              children: [
                const SizedBox(height: 10),
                // Back Button
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    BackButton(
                        color: Colors.black,
                        onPressed: () {
                          Navigator.pop(context);
                        }),
                  ],
                ),
                const SizedBox(height: 30),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: const [
                    Text(
                      "Forgot Password?",
                      style: TextStyle(
                        fontSize: 33,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                Text(
                  "Do not worry! It occurs. Please enter the email address associated with your accountt",
                  style: TextStyle(
                    fontSize: 17,
                    fontWeight: FontWeight.bold,
                    color: Colors.grey.shade400,
                  ),
                ),
                const SizedBox(height: 40),
                OurTextField(
                  controller: emailController,
                  hintText: "Email",
                  obscureText: false,
                  textInputType: TextInputType.emailAddress,
                  minLength: 6,
                  maxLength: 100,
                ),
                const SizedBox(height: 40),
                // get Button(),
                ButtonBuilder(
                    context: context, text: "Send Email", onClick: sendEmail),
              ],
            ),
          ),
        ),
      ),
    );
  }

  sendEmail() async {
    if (_formForgotKey.currentState!.validate()) {
      Map<String, dynamic> body = {
        "email": emailController.text,
      };
      print(body); // ignore: avoid_print
      final response = await BaseClient()
          .post('/cognito/request-password-reset', body, context);
      setState(() {
        res.statusCode = response.statusCode;
        res.body = response.body;
        if (response.body["message"] != null) {
          res.message = response.body["message"];
        }
        if (res.statusCode == 204) {
          emailController.text = "";
          Navigator.pushNamed(context, NewPassPage.id);
          AwesomeDialog(
            context: context,
            dialogType: DialogType.success,
            animType: AnimType.topSlide,
            showCloseIcon: false,
            title: "success",
            // desc: res.strBody(),
            btnOkOnPress: () {},
          ).show();
        } else {
          AwesomeDialog(
            context: context,
            dialogType: DialogType.error,
            animType: AnimType.topSlide,
            showCloseIcon: true,
            title: "error",
            desc: res.strMessage(),
            btnOkOnPress: () {},
          ).show();
        }
      });
    }
  }
}
