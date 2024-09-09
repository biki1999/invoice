import 'dart:typed_data';
import 'dart:html' as html;

class PdfServiceWeb {
  void viewPdfWeb(Uint8List bytes) {
    final blob = html.Blob([bytes], 'application/pdf');
    final url = html.Url.createObjectUrlFromBlob(blob);
    html.window.open(url, '_blank');
    html.Url.revokeObjectUrl(url);
  }
}
