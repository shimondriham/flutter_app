import 'package:flutter_app/widgets/our_textfield.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class OTPBOX extends StatelessWidget {
  final TextEditingController thisController;
  final Function(String)? onChange;

  const OTPBOX(
      {super.key, required this.thisController, required this.onChange});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 54,
      width: 49,
      child: TextFormField(
        validator: (value) {
          return onValidate(value, "num", 1, 1);
        },
        style: Theme.of(context).textTheme.headlineSmall,
        keyboardType: TextInputType.number,
        textAlign: TextAlign.center,
        inputFormatters: [
          LengthLimitingTextInputFormatter(1),
          FilteringTextInputFormatter.digitsOnly,
        ],
        controller: thisController,
        decoration: InputDecoration(
            enabledBorder: const OutlineInputBorder(
                borderSide: BorderSide(color: Colors.white)),
            fillColor: Colors.grey[200],
            filled: true,
            hintText: "",
            hintStyle: TextStyle(color: Colors.grey[500])),
        autofocus: false,
        onChanged: onChange,
      ),
    );
  }
}
