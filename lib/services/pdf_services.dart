import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:pdf/widgets.dart' as pw;
import 'package:pdf/pdf.dart';
import 'package:flutter/services.dart';
import 'pdf_service_web.dart';
import 'pdf_service_mobile.dart';

class PdfService {
  static const pw.TextStyle normalStyle = pw.TextStyle(
    fontSize: 12,
  );

  static final pw.BoxDecoration boxDecoration =
      pw.BoxDecoration(border: pw.Border.all(color: PdfColors.black, width: 1));

  Future<void> generatePdf() async {
    final pdf = pw.Document();

    final header = await buildHeader();
    final body = buildBody();
    final footer = buildFooter();

    pdf.addPage(
      pw.Page(
        build: (context) {
          return pw.Column(
            children: [
              header,
              pw.SizedBox(height: 10),
              body,
              pw.Spacer(),
              pw.SizedBox(height: 10),
              footer,
            ],
          );
        },
      ),
    );

    final bytes = await pdf.save();

    if (kIsWeb) {
      PdfServiceWeb().viewPdfWeb(bytes);
    } else {
      await PdfServiceMobile().savePdfMobile(bytes);
    }
  }

  // Header section
  Future<pw.Widget> buildHeader() async {
    final imageLogo = pw.MemoryImage(
      (await rootBundle.load('assets/logo.jpg')).buffer.asUint8List(),
    );

    return pw.Column(children: [
      pw.Container(
        padding: const pw.EdgeInsets.all(10),
        decoration: boxDecoration,
        child: pw.Column(
            crossAxisAlignment: pw.CrossAxisAlignment.stretch,
            children: [
              pw.Row(
                mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                crossAxisAlignment: pw.CrossAxisAlignment.start,
                children: [
                  // Left-side Logo
                  pw.Padding(
                    padding: const pw.EdgeInsets.all(8.0),
                    child: pw.Image(imageLogo, width: 50, height: 50),
                  ),

                  // Centered Header Content
                  pw.Column(
                    mainAxisAlignment: pw.MainAxisAlignment.center,
                    crossAxisAlignment: pw.CrossAxisAlignment.center,
                    children: [
                      // Heading with Underline
                      pw.Text(
                        'RETAIL BILL / CASH MEMO',
                        style: pw.TextStyle(
                            fontSize: 16,
                            fontWeight: pw.FontWeight.bold,
                            color: PdfColors.blue),
                      ),
                      pw.Container(
                        width: 220, // Underline width same as heading width
                        height: 1,
                        color: PdfColors.green, // Underline color
                      ),
                      pw.SizedBox(height: 5),

                      // Medicine Store Name
                      pw.Text(
                        'MEDICINE STORE NAME',
                        style: pw.TextStyle(
                            fontSize: 14,
                            fontWeight: pw.FontWeight.bold,
                            color: PdfColors.blue),
                      ),
                      pw.SizedBox(height: 5),

                      // GST and DL Numbers
                      pw.Text('Address: 123 Street, City, State',
                          style: normalStyle),
                      pw.Text('GST No.: ABC123', style: normalStyle),
                      pw.Text('DL No.: XYZ456', style: normalStyle),
                    ],
                  ),

                  // Empty space on the right side (or use if you need more elements)
                  pw.SizedBox(width: 50),
                ],
              )
            ]),
      ),
      pw.Container(
        decoration: boxDecoration,
        child: pw.Row(
          children: [
            // Left container with Patient Name and Prescribed by Doctor
            pw.Expanded(
              child: pw.Container(
                padding: const pw.EdgeInsets.all(8.0),
                child: pw.Column(
                  crossAxisAlignment: pw.CrossAxisAlignment.start,
                  children: [
                    pw.Text('Patient Name: Name', style: normalStyle),
                    pw.Text('Prescribed by Doctor: Doctor', style: normalStyle),
                  ],
                ),
              ),
            ),
            // Right container with Invoice Number and Date
            pw.Expanded(
              child: pw.Container(
                decoration: boxDecoration,
                padding: const pw.EdgeInsets.all(8.0),
                child: pw.Column(
                  crossAxisAlignment: pw.CrossAxisAlignment.start,
                  children: [
                    pw.Text('INVOICE NO.: 12345', style: normalStyle),
                    pw.Text('INVOICE DATE: 30/08/2024', style: normalStyle),
                    pw.Text('PAYMENT METHOD: Cash', style: normalStyle)
                  ],
                ),
              ),
            ),
          ],
        ),
      )
    ]);
    //
  }

  // Body section (medicine details)
  pw.Widget buildBody() {
    return pw.TableHelper.fromTextArray(
      headers: [
        'SL',
        'MEDICINE NAME',
        'QTY',
        'UNIT',
        'PRICE',
        'GST(%)',
        'DISC(%)',
        'AMOUNT'
      ],
      data: [
        ['1', 'Paracetamol', '2', '10', '10', '2%', '9%', '200'],
        ['2', 'Ibuprofen', '1', '10', '15', '3%', '9%', '150'],
        // Add more medicine data here
      ],
    );
  }

  // Footer section (totals and message)
  pw.Widget buildFooter() {
    return pw.Container(
      decoration: boxDecoration,
      child: pw.Column(
        crossAxisAlignment: pw.CrossAxisAlignment.start,
        children: [
          pw.Row(
            children: [
              pw.Expanded(
                flex: 2,
                child: pw.Container(
                    padding: const pw.EdgeInsets.all(10),
                    child: pw.Text(
                        'Amount in Words :Three Hundred Thirty Rupees Only.',
                        style: normalStyle)),
              ),
              pw.Expanded(
                flex: 1,
                child: pw.Container(
                  padding: const pw.EdgeInsets.all(10),
                  decoration: boxDecoration,
                  child: pw.Column(
                    crossAxisAlignment: pw.CrossAxisAlignment.start,
                    children: [
                      pw.Text('Total Amount: 350'),
                      pw.Text('Discount: 5%'),
                      pw.Text('GST: 18%'),
                      pw.Text('ROUNDED OFF : - 0.95'),
                      pw.Text('Net Total: 330.00',
                          style: pw.TextStyle(fontWeight: pw.FontWeight.bold)),
                    ],
                  ),
                ),
              ),
            ],
          ),
          pw.Container(
              decoration: boxDecoration,
              child: pw.Row(children: [
                pw.Expanded(
                  flex: 2,
                  child: pw.Container(
                      padding: const pw.EdgeInsets.all(10),
                      child: pw.Text(
                          'GOODS ONCE SOLD WILL NOT BE REPLACED OR TAKEN BACK.',
                          style: normalStyle)),
                ),
                pw.Expanded(
                    flex: 1,
                    child: pw.Container(
                        padding: const pw.EdgeInsets.all(10),
                        child: pw.Column(
                            crossAxisAlignment: pw.CrossAxisAlignment.start,
                            children: [
                              pw.Text('FOR : MEDICINE STORE NAME '),
                              pw.Text('SIGNATURE : ')
                            ]))),
              ]))
        ],
      ),
    );
  }
}
