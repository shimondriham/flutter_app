import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:billy_app/base_client.dart';
import 'package:billy_app/components/register_textfield.dart';
import 'package:billy_app/screens/LoginPage/login_page.dart';
import 'package:flutter/material.dart';

class RegisrerPage extends StatefulWidget {
  const RegisrerPage({super.key});

  @override
  State<RegisrerPage> createState() => _RegisrerPageState();
}

class _RegisrerPageState extends State<RegisrerPage> {
  final GlobalKey<FormState> _formRegisterKey = GlobalKey<FormState>();


  final firstNameController = TextEditingController();

  final lastNameController = TextEditingController();

  final phoneController = TextEditingController();

  final emailController = TextEditingController();

  final passwordController = TextEditingController();

  final confirmpasswordController = TextEditingController();

  final Res res = Res(0,{});

 

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Biliy"),
        ),
        body: SingleChildScrollView(
          child: Center(
            child: Form(
                key: _formRegisterKey,
                child: Column(
                  children: [
                    const SizedBox(height: 10),

                    const Text(
                      "- registeration page -",
                      style: TextStyle(
                        fontSize: 20,
                      ),
                    ),

                    const SizedBox(height: 10),
                    // First Name
                    RegisterTextField(
                      controller: firstNameController,
                      hintText: "First Name",
                      textInputType: TextInputType.name,
                      obscureText: false,
                      minLength: 0,
                      maxLength: 100,
                    ),
                    const SizedBox(height: 10),
                    // Last Name
                    RegisterTextField(
                      controller: lastNameController,
                      hintText: "Last Name",
                      textInputType: TextInputType.name,
                      obscureText: false,
                      minLength: 0,
                      maxLength: 100,
                    ),
                    const SizedBox(height: 10),
                    // phone
                    RegisterTextField(
                      controller: phoneController,
                      hintText: "Phone",
                      textInputType: TextInputType.phone,
                      obscureText: false,
                      minLength: 10,
                      maxLength: 11,
                    ),
                    const SizedBox(height: 10),
                    // email
                    RegisterTextField(
                      controller: emailController,
                      hintText: "Email",
                      textInputType: TextInputType.emailAddress,
                      obscureText: false,
                      minLength: 6,
                      maxLength: 100,
                    ),
                    const SizedBox(height: 10),
                    // password
                    RegisterTextField(
                      controller: passwordController,
                      hintText: "Password",
                      obscureText: true,
                      textInputType: TextInputType.visiblePassword,
                      minLength: 5,
                      maxLength: 15,
                    ),
                    const SizedBox(height: 10),
                    // Confirm password
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 25.0),
                      child: TextFormField(
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return "Repeat the password";
                          } else if (confirmpasswordController.text !=
                              passwordController.text) {
                            return "The password is not the same";
                          }
                          return null;
                        },
                        controller: confirmpasswordController,
                        obscureText: true,
                        keyboardType: TextInputType.visiblePassword,
                        decoration: InputDecoration(
                            enabledBorder: const OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.grey)),
                            fillColor: Colors.white,
                            filled: true,
                            hintText: "Confirm Password",
                            hintStyle: TextStyle(color: Colors.grey[500])),
                      ),
                    ),
                    const SizedBox(height: 25),

                    MaterialButton(
                      onPressed: () async {
                        if (_formRegisterKey.currentState!.validate()) {
                          Map<String, dynamic> body = {
                            "firstName": firstNameController.text,
                            "lastName": lastNameController.text,
                            "phone": phoneController.text,
                            "email": emailController.text,
                            "password": emailController.text,
                            "confirmPassword": passwordController.text,
                            "isAdmin": false
                          };
                           final response = await BaseClient().post('/user',body);
                              setState(() {
                              res.statusCode = response.statusCode;
                              res.body = response.body;
                              if (response.body["message"].toString() != "null") {
                                res.message = response.body["message"];
                              }                                                                                                                                
                              if (res.statusCode == 201) { 
                                firstNameController.text = "";
                                lastNameController.text = "";
                                phoneController.text = "";
                                emailController.text = "";
                                passwordController.text = "";                                 
                                confirmpasswordController.text = "";                                 
                                Navigator.of(context).push(MaterialPageRoute(
                                    builder: (BuildContext context) {
                                  return const LoginPage();
                                }));
                                  AwesomeDialog(
                                  context: context,
                                  dialogType: DialogType.success,
                                  animType: AnimType.topSlide,
                                  showCloseIcon: false,
                                  title: "user",
                                  desc: res.strBody(),
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
                      },
                      padding: const EdgeInsets.symmetric(
                          horizontal: 70, vertical: 25),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15)),
                      color: Colors.black,
                      child: const Text(
                        "SIGN UP",
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ],
                )),
          ),
         ),
        );
  }
}
