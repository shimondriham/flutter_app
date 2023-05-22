import 'package:awesome_dialog/awesome_dialog.dart';
// import 'package:flutter_app/base_client.dart';
import 'package:flutter_app/providers/token_provider.dart';
import 'package:flutter_app/screens/LoginPage/login_page.dart';
import 'package:flutter/material.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:provider/provider.dart';

Future<bool> authUser(context) async {
  final token = Provider.of<Token>(context, listen: false).token;
  bool isAccessTokenExpired = JwtDecoder.isExpired(token);
  
  if (isAccessTokenExpired) {
    // final Res res = Res();
  //   final response = await BaseClient().get('/auth/refresh', context);
  //   res.statusCode = response.statusCode;
  //   res.body = response.body;
  //   if (response.body["message"] != null) {
  //     res.message = response.body["message"];
  //   }
  //  if (response.body["AuthenticationResult"] != null) {
  //       res.accessToken = response.body["AuthenticationResult"]["AccessToken"];
  //     }
  //   if (res.statusCode == 200) {
  //     Provider.of<Token>(context, listen: false).newToken(res.accessToken);
  //     print("The token has been updated");// ignore: avoid_print
  //     return true;
  //   } else {
      Navigator.pushNamed(context, LoginPage.id);
      AwesomeDialog(
        context: context,
        dialogType: DialogType.error,
        animType: AnimType.topSlide,
        showCloseIcon: false,
        title: "Unverified connection",
        desc: "go to login",
        btnOkOnPress: () {},
      ).show();
      Provider.of<Token>(context, listen: false).deleteToken();
      return false;
    // }
  }
 
  // /* getExpirationDate() - this method returns the expiration date of the token */
  // DateTime expirationDate = JwtDecoder.getExpirationDate(token);
  // print(expirationDate);

  // /* getTokenTime() - You can use this method to know how old your token is */
  // Duration tokenTime = JwtDecoder.getTokenTime(token);
  // print(tokenTime.inMinutes);

   return true;
}
