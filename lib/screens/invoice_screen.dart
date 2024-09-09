import 'package:flutter/material.dart';
import 'package:invoice/services/pdf_services.dart';

class InvoiceScreen extends StatelessWidget {
  const InvoiceScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Medicine Invoice"),
        actions: [
          IconButton(
            icon: const Icon(Icons.download),
            onPressed: () async {
              await PdfService().generatePdf();  // Generate PDF when clicked
            },
          ),
        ],
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: () async {
            await PdfService().generatePdf();  // Generate PDF when clicked
          },
          child: const Text("Generate Invoice"),
        ),
      ),
    );
  }
}
