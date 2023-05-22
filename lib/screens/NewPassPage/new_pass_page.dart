import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:billy_app/Widgets/our_textfield.dart';
import 'package:billy_app/base_client.dart';
import 'package:billy_app/screens/PassChangedPage/pass_changed_page.dart';
import 'package:billy_app/widgets/button_builder.dart';
import 'package:billy_app/widgets/confirm_pass_textfield.dart';
import 'package:billy_app/widgets/otp_box.dart';
import 'package:flutter/material.dart';

class NewPassPage extends StatefulWidget {
  static const String id = 'new_pass_page';

  const NewPassPage({super.key});

  @override
  State<NewPassPage> createState() => _NewPassPageState();
}

class _NewPassPageState extends State<NewPassPage> {
  final GlobalKey<FormState> _formNewPassKey = GlobalKey<FormState>();
  final emailController = TextEditingController();
  final List<TextEditingController> _otpControllers =
      List.generate(6, (index) => TextEditingController());
  final newPassController = TextEditingController();
  final confirmNewpassController = TextEditingController();

  void _onOtpEdit(String value, int index, BuildContext context) {
    if (value.length == 1 && index < 6) {
      FocusScope.of(context).nextFocus();
    }
  }

  @override
  void dispose() {
    emailController.dispose();
    for (var controller in _otpControllers) {
      controller.dispose();
    }
    newPassController.dispose();
    confirmNewpassController.dispose();
    super.dispose();
  }

  final Res res = Res();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        shadowColor: Colors.white,
      ),
      body: SingleChildScrollView(
        child: Form(
          key: _formNewPassKey,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 25.0),
            child: Column(
              children: [
                const SizedBox(height: 10),
                // title
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: const [
                    Text(
                      "Create new password",
                      style: TextStyle(
                        fontSize: 30,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                // email
                OurTextField(
                  controller: emailController,
                  hintText: "Email",
                  obscureText: false,
                  textInputType: TextInputType.emailAddress,
                  minLength: 6,
                  maxLength: 100,
                ),
                const SizedBox(height: 10),
                Padding(
                  padding: const EdgeInsets.only(left: 10, right: 10),
                  child: Text(
                    "Enter the verification code we just sent to your email address. Valid for up to 24 hours",
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                      color: Colors.grey.shade600,
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: List.generate(
                    6,
                    (index) => OTPBOX(
                      thisController: _otpControllers[index],
                      onChange: (value) => _onOtpEdit(value, index, context),
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                Padding(
                  padding: const EdgeInsets.only(left: 10, right: 10),
                  child: Text(
                    "your new password must be unique frome those previously used",
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                      color: Colors.grey.shade600,
                    ),
                  ),
                ),
                const SizedBox(height: 10),

                // new password
                OurTextField(
                  controller: newPassController,
                  hintText: " new password",
                  obscureText: false,
                  textInputType: TextInputType.visiblePassword,
                  minLength: 6,
                  maxLength: 100,
                ),
                const SizedBox(height: 10),
                // comfirm password
                ConfirmPassTextField(
                    passwordController: newPassController,
                    confirmpasswordController: confirmNewpassController),
                const SizedBox(height: 40),
                // button
                ButtonBuilder(
                    context: context,
                    text: "Set Password",
                    onClick: setPassword)
              ],
            ),
          ),
        ),
      ),
    );
  }

  setPassword() async {
    if (_formNewPassKey.currentState!.validate()) {
      // Map<String, dynamic> body = {
      //   "password": newPassController.text,
      // };

      // Map<String, dynamic> body = {
      //   "email": "shimondriham523@gmail.com",
      //   "confirmationCode": "937945",
      //   "newPassword": "Shimon123@",
      //   "confirmPassword": "Shimon123@"
      // };
      final String otpControllers =
          _otpControllers.map((value) => value.text).join();
      Map<String, dynamic> body = {
        "email": emailController.text,
        "confirmationCode": otpControllers,
        "newPassword": newPassController.text,
        "confirmPassword": confirmNewpassController.text
      };
      print(body); // ignore: avoid_print
      final response = await BaseClient().post('/cognito/confirm-password-reset', body, context);
      setState(() {
        res.statusCode = response.statusCode;
        res.body = response.body;
        if (response.body["message"] != null) {
          res.message = response.body["message"];
        }
        if (res.statusCode == 204) {
          newPassController.text = "";
          Navigator.pushNamed(context, PassChangedPage.id);
          AwesomeDialog(
            context: context,
            dialogType: DialogType.success,
            animType: AnimType.topSlide,
            showCloseIcon: false,
            title: "success",
            desc: "Password reset confirmed successfully",
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
