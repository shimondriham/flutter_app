import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter_app/base_client.dart';
import 'package:flutter_app/screens/LoginPage/login_page.dart';
import 'package:flutter_app/screens/VerificationUserPage/verification_user_page.dart';
import 'package:flutter_app/widgets/button_builder.dart';
import 'package:flutter_app/widgets/confirm_pass_textfield.dart';
import 'package:flutter_app/widgets/our_textfield.dart';
import 'package:flutter_app/widgets/text_or_connect_with.dart';
import 'package:flutter/material.dart';

class RegisrerPage extends StatefulWidget {
  static const String id = 'regisrer_page';

  const RegisrerPage({super.key});

  @override
  State<RegisrerPage> createState() => _RegisrerPageState();
}

class _RegisrerPageState extends State<RegisrerPage> {
  final GlobalKey<FormState> _formRegisterKey = GlobalKey<FormState>();
  final fullNameController = TextEditingController();
  final phoneController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmpasswordController = TextEditingController();

  @override
  void dispose() {
    fullNameController.dispose();
    phoneController.dispose();
    emailController.dispose();
    passwordController.dispose();
    confirmpasswordController.dispose();
    super.dispose();
  }

  final Res res = Res();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: ConstrainedBox(
          constraints:
              BoxConstraints(maxHeight: MediaQuery.of(context).size.height),
          child: Form(
            key: _formRegisterKey,
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
                  Text(
                    "Hello! Register to get started",
                    style: TextStyle(
                      fontSize: 35,
                      fontWeight: FontWeight.bold,
                      color: Colors.purple.shade600,
                    ),
                  ),
                  const SizedBox(height: 20),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      // Full Name
                      OurTextField(
                        controller: fullNameController,
                        hintText: "Full Name",
                        textInputType: TextInputType.name,
                        obscureText: false,
                        minLength: 0,
                        maxLength: 100,
                      ),
                      const SizedBox(height: 10),
                      // email
                      OurTextField(
                        controller: emailController,
                        hintText: "Email",
                        textInputType: TextInputType.emailAddress,
                        obscureText: false,
                        minLength: 6,
                        maxLength: 100,
                      ),
                      const SizedBox(height: 10),
                      // password
                      OurTextField(
                        controller: passwordController,
                        hintText: "Password",
                        obscureText: true,
                        textInputType: TextInputType.visiblePassword,
                        minLength: 5,
                        maxLength: 15,
                      ),
                      const SizedBox(height: 10),
                      // Confirm password
                      ConfirmPassTextField(
                        passwordController: passwordController,
                        confirmpasswordController: confirmpasswordController,
                      ),
                      const SizedBox(height: 25),
                      //Register buuton
                      ButtonBuilder(
                          context: context,
                          text: "Register",
                          onClick: createUser)
                    ],
                  ),
                  const SizedBox(height: 30),
                  //Sign up with Google or Apple
                  Expanded(
                    child: Column(
                      children: [
                        const TextOrConnectWith(text: "Register"),
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
                  // to login
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text("Already have on account?"),
                      const SizedBox(height: 0.4),
                      TextButton(
                        onPressed: () {
                          Navigator.pushNamed(context, LoginPage.id);
                        },
                        child: const Text("Login Now"),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  createUser() async {
    if (_formRegisterKey.currentState!.validate()) {
      Map<String, dynamic> body = {
        "name": fullNameController.text,
        "email": emailController.text,
        "password": passwordController.text,
        "confirmPassword": confirmpasswordController.text,
      };
      final response =
          await BaseClient().post('/cognito/signup', body, context);
      setState(() {
        res.statusCode = response.statusCode;
        res.body = response.body;
        if (response.body["message"] != null) {
          res.message = response.body["message"];
        }
        if (res.statusCode == 201) {
          Navigator.pushNamed(context, VerificationUserPage.id);
          AwesomeDialog(
            context: context,
            dialogType: DialogType.success,
            animType: AnimType.topSlide,
            showCloseIcon: false,
            title: "user",
            // desc: res.strBody(),
            btnOkOnPress: () {},
          ).show();
          super.dispose();
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
