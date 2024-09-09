import 'package:flutter/material.dart';
import 'package:flutter_pdfview/flutter_pdfview.dart';

class PdfViewerWidget extends StatelessWidget {
  final String pdfFilePath;

  const PdfViewerWidget({super.key, required this.pdfFilePath});

  @override
  Widget build(BuildContext context) {
    return PDFView(
      filePath: pdfFilePath,
    );
  }
}
