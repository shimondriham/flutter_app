import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter_app/auth_user.dart';
import 'package:flutter_app/base_client.dart';
import 'package:flutter_app/screens/homePage/home_page.dart';
import 'package:flutter_app/widgets/button_builder.dart';
import 'package:flutter_app/widgets/our_textfield.dart';
import 'package:flutter/material.dart';

class AddBusinessPage extends StatefulWidget {
  static const String id = 'add_busines_page';
  const AddBusinessPage({super.key});

  @override
  State<AddBusinessPage> createState() => _AddBusinessPageState();
}

class _AddBusinessPageState extends State<AddBusinessPage> {
  final GlobalKey<FormState> _addBusinessKey = GlobalKey<FormState>();
  final businessController = TextEditingController();
  @override
  void dispose() {
    businessController.dispose();
    super.dispose();
  }

  final Res res = Res();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Form(
          key: _addBusinessKey,
          child: SafeArea(
            minimum: const EdgeInsets.all(25.0),
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
                const SizedBox(height: 30),
                //  title
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const [
                    Text(
                      "Add a business",
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
                  "something about ...",
                  style: TextStyle(
                    fontSize: 17,
                    fontWeight: FontWeight.bold,
                    color: Colors.grey.shade400,
                  ),
                ),
                const SizedBox(height: 40),
                OurTextField(
                  controller: businessController,
                  hintText: "business name",
                  obscureText: false,
                  textInputType: TextInputType.name,
                  minLength: 3,
                  maxLength: 50,
                ),
                const SizedBox(height: 40),
                // get Button(),
                ButtonBuilder(
                    context: context, text: "Add", onClick: addBusiness),
              ],
            ),
          ),
        ),
      ),
    );
  }

  addBusiness() async {
    final thisAuthUser = await authUser(context);
    // print("_authUser$thisAuthUser");
    if (thisAuthUser) {
      print("vlid Token");// ignore: avoid_print
      await addBusinessNow();
    } else {
      print("invlid Token");// ignore: avoid_print
    }
  }

  addBusinessNow() async {
    if (_addBusinessKey.currentState!.validate()) {
      Map<String, dynamic> body = {
        "businessType": businessController.text,
        "businessName": businessController.text,
        "location": businessController.text,
        "bankAccountId": businessController.text,
        "bankId": 0
      };
      print(body); // ignore: avoid_print
      final response = await BaseClient().post('/business', body, context);
      setState(() {
        res.statusCode = response.statusCode;
        res.body = response.body;
        if (response.body["message"].toString() != "null") {
          res.message = response.body["message"];
        }
        if (res.statusCode == 201) {
          businessController.text = "";
          Navigator.pushNamed(context, HomePage.id);
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
}
