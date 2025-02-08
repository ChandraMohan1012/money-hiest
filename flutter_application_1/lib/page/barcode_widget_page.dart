import 'package:flutter/material.dart';

class BarcodeWidgetPage extends StatelessWidget {
  const BarcodeWidgetPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Barcode Widget Page')),
      body: const Center(
        child: Text('Barcode Scanner Widget (Android Only)'),
      ),
    );
  }
}
