import 'package:flutter/material.dart';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:billy_app/base_client.dart';
import 'package:billy_app/screens/LoginPage/login_page.dart';
import 'package:billy_app/widgets/button_builder.dart';
import 'package:billy_app/widgets/otp_box.dart';

class VerificationUserPage extends StatefulWidget {
  static const String id = 'verification_user_page';

  const VerificationUserPage({super.key});

  @override
  State<VerificationUserPage> createState() => _VerificationUserPageState();
}

class _VerificationUserPageState extends State<VerificationUserPage> {
  final GlobalKey<FormState> _formVerificationKey = GlobalKey<FormState>();

  final List<TextEditingController> _otpControllers =
      List.generate(6, (index) => TextEditingController());

  void _onOtpEdit(String value, int index, BuildContext context) {
    if (value.length == 1 && index < 6) {
      FocusScope.of(context).nextFocus();
    }
  }

  @override
  void dispose() {
    for (var controller in _otpControllers) {
      controller.dispose();
    }
    super.dispose();
  }

  final Res res = Res();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Form(
          key: _formVerificationKey,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 25.0),
            child: Column(
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
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: const [
                    Text(
                      "OTP Verification",
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
                  "Enter the verification code we just sent on your email address.",
                  style: TextStyle(
                    fontSize: 17,
                    fontWeight: FontWeight.bold,
                    color: Colors.grey.shade400,
                  ),
                ),
                const SizedBox(height: 40),
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
                const SizedBox(height: 40),
                ButtonBuilder(
                    context: context, text: "Send Code", onClick: sendCode),
                const SizedBox(height: 40),
                ButtonBuilder(
                    context: context,
                    text: "Get a new code",
                    onClick: sendAnotherCode),
              ],
            ),
          ),
        ),
      ),
    );
  }

  sendCode() async {
    if (_formVerificationKey.currentState!.validate()) {
      final String confirmationCode =
          _otpControllers.map((value) => value.text).join();
      print(confirmationCode); // ignore: avoid_print
      Map<String, dynamic> body = {
        "email": "a@a.aa",
        "confirmationCode": confirmationCode
      };
      print(body); // ignore: avoid_print
      final response =
          await BaseClient().post('/cognito/confirm-signup', body, context);
      setState(() {
        res.statusCode = response.statusCode;
        res.body = response.body;
        if (response.body["message"].toString() != "null") {
          res.message = response.body["message"];
        }
        if (res.statusCode == 201) {
          Navigator.pushNamed(context, LoginPage.id);
          AwesomeDialog(
            context: context,
            dialogType: DialogType.success,
            animType: AnimType.topSlide,
            showCloseIcon: false,
            title: "success",
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
  }

  sendAnotherCode() async {
    Map<String, dynamic> body = {
      "email": "a@a.aa",
    };
    print(body); // ignore: avoid_print
    final response = await BaseClient()
        .post('/cognito/resend-confirmation-code', body, context);
    setState(() {
      res.statusCode = response.statusCode;
      res.body = response.body;
      if (response.body["message"].toString() != "null") {
        res.message = response.body["message"];
      }
      if (res.statusCode == 204) {
        AwesomeDialog(
          context: context,
          dialogType: DialogType.success,
          animType: AnimType.topSlide,
          showCloseIcon: false,
          title: "success",
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
  
}
