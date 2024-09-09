import 'package:flutter/material.dart';
import 'package:invoice/screens/invoice_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Medicine Invoice',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: InvoiceScreen(),
    );
  }
}
