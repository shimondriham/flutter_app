import 'package:flutter/material.dart';

class NavigationButton extends StatelessWidget {
  const NavigationButton(
      {super.key,
      required this.context,
      required this.navigation,
      required this.text,
      required this.color,
      required this.textcolor});
  final BuildContext context;
  final String navigation;
  final String text;
  final Color color;
  final Color textcolor;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      child: MaterialButton(
        onPressed: () {
          Navigator.pushNamed(context, navigation);
        },
        padding: const EdgeInsets.all(22),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        color: color,
        child: Text(
          text,
          style: TextStyle(color: textcolor),
        ),
      ),
    );
  }
}