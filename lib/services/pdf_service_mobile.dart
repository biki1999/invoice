import 'dart:io';
import 'dart:typed_data';
import 'package:path_provider/path_provider.dart';

class PdfServiceMobile {
  Future<void> savePdfMobile(Uint8List bytes) async {
    final directory = await getApplicationDocumentsDirectory();
    final file = File('${directory.path}/invoice.pdf');
    await file.writeAsBytes(bytes);

    // You can then use any mobile PDF viewer to open the PDF file.
    print("PDF saved at ${file.path}");
  }
}
