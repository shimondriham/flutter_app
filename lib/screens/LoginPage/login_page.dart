import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:billy_app/base_client.dart';
import 'package:billy_app/screens/forget_pass_page.dart';
import 'package:flutter/material.dart';
import 'package:billy_app/components/login_textfield.dart';
import 'package:billy_app/screens/home_page.dart';
import 'package:billy_app/screens/RegisterPage/register_page.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final GlobalKey<FormState> _formLoginKey = GlobalKey<FormState>();

  final emailController = TextEditingController();

  final passwordController = TextEditingController();

  final Res res = Res(0, {});
  @override
  void initState(){
    super.initState();
    
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Biliy"),
      ),
      body: SingleChildScrollView(
        child: SafeArea(
          child: Column(
            children: [
              const SizedBox(height: 40),

              const Icon(
                Icons.lock,
                size: 100,
              ),

              const SizedBox(height: 20),

              const Text(
                "- Somthing like welcome back -",
                style: TextStyle(
                  fontSize: 20,
                ),
              ),

              const SizedBox(height: 20),

              Form(
                  key: _formLoginKey,
                  child: Column(
                    children: [
                      //  email textfild
                      LoginTextField(
                        controller: emailController,
                        hintText: "Email",
                        obscureText: false,
                        textInputType: TextInputType.emailAddress,
                        minLength: 6,
                        maxLength: 100,
                      ),
                      const SizedBox(height: 25),
                      // password textfild
                      LoginTextField(
                        controller: passwordController,
                        hintText: "Password",
                        obscureText: true,
                        textInputType: TextInputType.visiblePassword,
                        minLength: 5,
                        maxLength: 15,
                      ),
                      // Forgot Password
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 25.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            TextButton(
                              onPressed: () {
                                Navigator.of(context).push(MaterialPageRoute(
                                    builder: (BuildContext context) {
                                  return const ForgetPasswordPage();
                                }));
                              },
                              child: const Text("Forgot Password?"),
                            ),
                          ],
                        ),
                      ),
                      // login button
                      MaterialButton(
                        onPressed: () async {
                          if (_formLoginKey.currentState!.validate()) {
                            Map<String, dynamic> body = {
                              "email": emailController.text,
                              "password": passwordController.text,
                            };                        
                            final response = await BaseClient().post('/auth/login',body);
                            setState(() {
                              res.statusCode = response.statusCode;
                              res.body = response.body;
                              if (response.body["message"].toString() != "null") {
                                res.message = response.body["message"];
                              }
                              if (response.body["access_token"].toString() != "null") {
                                res.accessToken = response.body["access_token"];
                              }
                              if (res.statusCode == 201) {                              
                                  emailController.text = "";
                                  passwordController.text = "";
                                Navigator.of(context).push(MaterialPageRoute(
                                    builder: (BuildContext context) {
                                  return const HomePage();
                                }));
                                  AwesomeDialog(
                                  context: context,
                                  dialogType: DialogType.success,
                                  animType: AnimType.topSlide,
                                  showCloseIcon: false,
                                  title: "token",
                                  desc: res.strBody(),
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
                        },
                        padding: const EdgeInsets.symmetric(
                            horizontal: 70, vertical: 25),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15)),
                        color: Colors.black,
                        child: const Text(
                          "login",
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ],
                  )),
              const SizedBox(height: 200),
              // to register
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text("New here"),
                  const SizedBox(width: 4),
                  TextButton(
                    onPressed: () {
                      Navigator.of(context).push(
                          MaterialPageRoute(builder: (BuildContext context) {
                        return const RegisrerPage();
                      }));
                    },
                    child: const Text("Register now"),
                  ),
                ],
              ),
              TextButton(
                  onPressed: () {
                    BaseClient().get('/health-check');
                  },
                  child: const Text("health check")),
            ],
          ),
        ),
      ),
    );
  }
}