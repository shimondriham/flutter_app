import 'package:flutter/material.dart';

class AddInvoiceButton extends StatelessWidget {
  const AddInvoiceButton(
      {super.key,
      required this.context,
      required this.text,
      required this.icon,
      required this.onClick});
  final BuildContext context;
  final String text;
  final IconData icon;
  final VoidCallback onClick;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      child: MaterialButton(
        onPressed: onClick,
        padding: const EdgeInsets.all(22),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        color: Colors.black,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Icon(
              icon,
              color: Colors.white,
            ),
            const SizedBox(width: 15),
            Text(
              text,
              style: const TextStyle(color: Colors.white),
            )
          ],
        ),
      ),
    );
  }
}
