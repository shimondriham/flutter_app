import 'package:flutter_app/auth_page.dart';
import 'package:flutter_app/providers/invoice_providet.dart';
import 'package:flutter_app/providers/token_provider.dart';
import 'package:flutter_app/screens/AddBusinesPage/add_business_page.dart';
import 'package:flutter_app/screens/AddInvoicePage/add_invoice_page.dart';
import 'package:flutter_app/screens/ForgotPassPage/forgot_pass_page.dart';
import 'package:flutter_app/screens/LoginPage/login_page.dart';
import 'package:flutter_app/screens/NewPassPage/new_pass_page.dart';
import 'package:flutter_app/screens/PassChangedPage/pass_changed_page.dart';
import 'package:flutter_app/screens/RegisterPage/register_page.dart';
import 'package:flutter_app/screens/VerificationUserPage/verification_user_page.dart';
import 'package:flutter_app/screens/homePage/home_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:provider/provider.dart';

Future<void> main() async {
  await dotenv.load();
  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(create: (_) => Token()),
      ChangeNotifierProvider(create: (_) => Invoice()),
    ],
    child: const MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: "/",
      routes: {
        "/": (context) => const AuthPage(),
        RegisrerPage.id: (context) => const RegisrerPage(),
        VerificationUserPage.id: (context) => const VerificationUserPage(),
        LoginPage.id: (context) => const LoginPage(),
        ForgotPasswordPage.id: (context) => const ForgotPasswordPage(),
        NewPassPage.id: (context) => const NewPassPage(),
        PassChangedPage.id: (context) => const PassChangedPage(),
        HomePage.id: (context) => const HomePage(),
        AddInvoicePage.id: (context) => const AddInvoicePage(),
        AddBusinessPage.id: (context) => const AddBusinessPage(),
      },
      title: 'Billy',
      debugShowCheckedModeBanner: false,
    );
  }
}
