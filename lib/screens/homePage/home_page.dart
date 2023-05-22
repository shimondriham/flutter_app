import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:billy_app/auth_user.dart';
import 'package:billy_app/base_client.dart';
import 'package:billy_app/providers/token_provider.dart';
import 'package:billy_app/screens/AddBusinesPage/add_business_page.dart';
import 'package:billy_app/screens/AddInvoicePage/add_invoice_page.dart';
import 'package:billy_app/screens/LoginPage/login_page.dart';
import 'package:billy_app/widgets/button_builder.dart';
import 'package:billy_app/widgets/navigation_button.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  static const String id = 'home_page';
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final Res res = Res();
  @override
  Widget build(BuildContext context) {
    final providerToken = Provider.of<Token>(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text("my app"),
      ),
      body: SafeArea(
        minimum: const EdgeInsets.all(25.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              // "Welcome - token: ${providerToken.userTokenDetails("email")}",
              "Welcome - token: ${providerToken.token.length}",
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 20,
              ),
            ),
            const SizedBox(height: 20),
            ButtonBuilder(
              context: context,
              text: "Log Out",
              onClick: logOut,
            ),
            const SizedBox(height: 10),
            NavigationButton(
                context: context,
                navigation: AddInvoicePage.id,
                text: "to add invoice test",
                color: Colors.grey,
                textcolor: Colors.black),
            const SizedBox(height: 10),
            NavigationButton(
                context: context,
                navigation: AddBusinessPage.id,
                text: "to add busines",
                color: Colors.blue,
                textcolor: Colors.black),
            const SizedBox(height: 10),
            ButtonBuilder(
              context: context,
              text: "get all user",
              onClick: getAllUser,
            ),
          ],
        ),
      ),
    );
  }

  logOut() async {
    // authUser(context);
    final response = await BaseClient().post('/auth/logout', {}, context);
    setState(() {
      res.statusCode = response.statusCode;
      res.body = response.body;
      if (response.body["message"].toString() != "null") {
        res.message = response.body["message"];
      }
      if (res.statusCode == 200) {
        Navigator.pushNamed(context, LoginPage.id);
        context.read<Token>().deleteToken();
        AwesomeDialog(
          context: context,
          dialogType: DialogType.success,
          animType: AnimType.topSlide,
          showCloseIcon: false,
          title: "You disconnect",
          desc: res.strMessage(),
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

  getAllUser() async {
    final thisAuthUser = await authUser(context);
    // print("_authUser$thisAuthUser");
    if (thisAuthUser) {
      print("Vlid Token"); // ignore: avoid_print
      await getAllUserNow();
    } else {
      print(" invlid Token"); // ignore: avoid_print
    }
  }

  getAllUserNow() async {
    final response = await BaseClient().get('/user', context);
    setState(() {
      res.statusCode = response.statusCode;
      res.body = response.body;
      if (response.body["message"].toString() != "null") {
        res.message = response.body["message"];
      }
      if (res.statusCode == 200) {
        AwesomeDialog(
          context: context,
          dialogType: DialogType.success,
          animType: AnimType.topSlide,
          showCloseIcon: false,
          title: "all ${res.body["body"].length} user",
          desc: res.body["body"].toString(),
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
