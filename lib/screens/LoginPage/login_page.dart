import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter_app/base_client.dart';
import 'package:flutter_app/providers/token_provider.dart';
import 'package:flutter_app/screens/ForgotPassPage/forgot_pass_page.dart';
import 'package:flutter_app/screens/RegisterPage/register_page.dart';
import 'package:flutter_app/screens/homePage/home_page.dart';
import 'package:flutter_app/widgets/button_builder.dart';
import 'package:flutter_app/widgets/text_or_connect_with.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/widgets/our_textfield.dart';
import 'package:provider/provider.dart';

class LoginPage extends StatefulWidget {
  static const String id = 'login_page';

  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final GlobalKey<FormState> _formLoginKey = GlobalKey<FormState>();

  final emailController = TextEditingController();

  final passwordController = TextEditingController();

  final Res res = Res();

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: ConstrainedBox(
          constraints:
              BoxConstraints(maxHeight: MediaQuery.of(context).size.height),
          child: SafeArea(
            minimum: const EdgeInsets.all(25.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const SizedBox(height: 20),
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
                const SizedBox(height: 10),
                // title
                const Text(
                  "Welcome back!  Glad to see you Again!",
                  style: TextStyle(
                    fontSize: 33,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
                const SizedBox(height: 40),
                Form(
                    key: _formLoginKey,
                    child: Column(
                      children: [
                        //  email textfild
                        OurTextField(
                          controller: emailController,
                          hintText: "Email",
                          obscureText: false,
                          textInputType: TextInputType.emailAddress,
                          minLength: 6,
                          maxLength: 100,
                        ),
                        const SizedBox(height: 10),
                        // password textfild
                        OurTextField(
                          controller: passwordController,
                          hintText: "Password",
                          obscureText: false,
                          // obscureText: true,
                          textInputType: TextInputType.visiblePassword,
                          minLength: 5,
                          maxLength: 15,
                        ),
                        // Forgot Password
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            TextButton(
                              onPressed: () {
                                Navigator.pushNamed(
                                    context, ForgotPasswordPage.id);
                              },
                              child: const Text(
                                "Forgot Password?",
                                style: TextStyle(color: Colors.black),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 20),
                        // login button
                        ButtonBuilder(
                          context: context,
                          text: "Login",
                          onClick: loginUser,
                        ),
                      ],
                    )),
                const SizedBox(height: 30),
                Expanded(
                  child: Column(
                    children: [
                      const TextOrConnectWith(text: "Login"),
                      const SizedBox(height: 30),
                      // Soon when there will be support from the server
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 40, vertical: 10),
                            decoration: BoxDecoration(
                              border: Border.all(color: Colors.grey.shade300),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Image.asset(
                              'lib/images/google.png',
                              height: 40,
                            ),
                          ),
                          const SizedBox(width: 25),
                          Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 40, vertical: 10),
                            decoration: BoxDecoration(
                              border: Border.all(color: Colors.grey.shade300),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Image.asset(
                              'lib/images/apple.png',
                              height: 40,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                // to Register,
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text("Don't have on account?"),
                    const SizedBox(width: 4),
                    TextButton(
                      onPressed: () {
                        Navigator.pushNamed(context, RegisrerPage.id);
                      },
                      child: const Text("Register Now"),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
      backgroundColor: Colors.white,
    );
  }

  loginUser() async {
    if (_formLoginKey.currentState!.validate()) {
    Map<String, dynamic> body = {
      "email": emailController.text,
      "password": passwordController.text,
    };
    // Map<String, dynamic> body = {
    //   "email": "shimondriham523@gmail.com",
    //   "password": "Shimon123@",
    // };
    final response = await BaseClient().post('/cognito/signin', body, context);
    setState(() {
      res.statusCode = response.statusCode;
      res.body = response.body;
      if (response.body["message"] != null) {
        res.message = response.body["message"];
      }
      if (response.body["AuthenticationResult"] != null) {
        res.accessToken = response.body["AuthenticationResult"]["AccessToken"];
      }
      if (res.statusCode == 201) {
        Navigator.pushNamed(context, HomePage.id);
        context.read<Token>().newToken(res.accessToken);
        AwesomeDialog(
          context: context,
          dialogType: DialogType.success,
          animType: AnimType.topSlide,
          showCloseIcon: false,
          title: "Welcome ",
          // desc: Provider.of<Token>(context, listen: false).userTokenDetails("email"),
          desc: Provider.of<Token>(context, listen: false).token.length.toString(),
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
