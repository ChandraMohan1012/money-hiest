import 'package:flutter/material.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';

class NextPage extends StatefulWidget {
  const NextPage({super.key});

  @override
  _NextPageState createState() => _NextPageState();
}

class _NextPageState extends State<NextPage> {
  bool isDarkMode = false;

  // Function to scan barcode
  Future<void> scanBarcode() async {
    try {
      String barcodeScanRes = await FlutterBarcodeScanner.scanBarcode(
        "#ff6666", // Color of the scan button
        "Cancel",  // Text for the cancel button
        true,      // Whether to show flash icon
        ScanMode.BARCODE, // Scan mode
      );

      if (!mounted) return;

      setState(() {
        // Handle the scanned barcode result
        print("Scanned Barcode: $barcodeScanRes");
      });
    } catch (e) {
      print("Error scanning barcode: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: isDarkMode ? Colors.black : Colors.pink.shade300,
        leading: IconButton(
          icon: Icon(Icons.person, color: Colors.white),
          onPressed: () {},
        ),
        actions: [
          IconButton(
            icon: Icon(
              isDarkMode ? Icons.dark_mode : Icons.light_mode,
              color: Colors.white,
            ),
            onPressed: () {
              setState(() {
                isDarkMode = !isDarkMode;
              });
            },
          ),
        ],
      ),
      body: Container(
        color: isDarkMode ? Colors.grey[900] : Colors.white,
        padding: EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Barcode scan button
            ElevatedButton(
              onPressed: scanBarcode, // Trigger barcode scan
              child: Text("Scan Barcode"),
            ),
          ],
        ),
      ),
    );
  }
}
