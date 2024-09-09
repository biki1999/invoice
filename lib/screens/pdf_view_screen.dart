import 'package:flutter/material.dart';
import 'package:invoice/widgets/pdf_viewer.dart';

class PdfViewScreen extends StatelessWidget {
  const PdfViewScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('View Invoice'),
      ),
      body: const PdfViewerWidget(pdfFilePath: 'pdfFilePath',), // Will be discussed in another file
    );
  }
}
