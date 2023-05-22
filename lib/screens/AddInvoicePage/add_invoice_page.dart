import 'dart:io';
import 'package:billy_app/providers/invoice_providet.dart';
import 'package:billy_app/widgets/add_invoice_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';


class AddInvoicePage extends StatefulWidget {
  static const String id = 'add_invoice_page';
  const AddInvoicePage({super.key});

  @override
  State<AddInvoicePage> createState() => _AddInvoicePageState();
}

class _AddInvoicePageState extends State<AddInvoicePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      appBar: AppBar(
        title: const Text(
          "Adding an invoice",
          style: TextStyle(
            fontSize: 25,
            color: Colors.black,
          ),
        ),
        leading: BackButton(onPressed: () {
          Navigator.pop(context);
        }),
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        shadowColor: Colors.white,
      ),
      body: SafeArea(
        minimum: const EdgeInsets.all(25.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            context.read<Invoice>().invoice != null
                ? Image.file(
                    context.watch<Invoice>().invoice!,
                    height: 300,
                    width: 300,
                  )
                : Image.asset(
                    'lib/images/invoice.jpg',
                    height: 300,
                  ),
            const SizedBox(height: 30),
            AddInvoiceButton(
              context: context,
              text: "Pick frome Gallery",
              icon: Icons.image_outlined,
              onClick: () => getImage(ImageSource.gallery),
            ),
            const SizedBox(height: 10),
            AddInvoiceButton(
              context: context,
              text: "Pick frome Camera",
              icon: Icons.camera_alt_outlined,
              onClick: () => getImage(ImageSource.camera),
            ),
          ],
        ),
      ),
    );
  }

  Future getImage(ImageSource source) async {
    try {
      final image = await ImagePicker().pickImage(source: source);
      if (image == null) return;

      final originalImage = File(image.path);
      final compressedImage = await compressImage(originalImage, 500, 500, 85);
      print(compressedImage);// ignore: avoid_print
      setState(() {
        context.read<Invoice>().newInvoice(originalImage);
      });
    } on PlatformException catch (e) {
      print('failed to pick image : $e'); // ignore: avoid_print
    }
  }

  Future<File> compressImage(
      File imageFile, int minWidth, int minHeight, int quality) async {
    final compressedImage = await FlutterImageCompress.compressWithFile(
      imageFile.absolute.path,
      minWidth: minWidth,
      minHeight: minHeight,
      quality: quality,
    );
    final compressedFile = File('${imageFile.path}.compressed.jpg');
    if (compressedImage != null) {
      await compressedFile.writeAsBytes(compressedImage);
    }
    return compressedFile;
  }
}
