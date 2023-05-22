import 'dart:io';
import 'package:flutter/material.dart';

class Invoice with ChangeNotifier {
  File? _invoice;

  File? get invoice => _invoice;

  void newInvoice(File? invoice) {
    _invoice = invoice;
    notifyListeners();
  }

  void deleteInvoice() {
    _invoice = null;
    notifyListeners();
  }
}
