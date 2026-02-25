import 'package:flutter/material.dart';
import 'features/billing/domain/bill_prediction.dart';

void main() {
  final billPrediction = BillPrediction();

  print('1000 kWh = ${billPrediction.predictMonthlyBill(1000)} SAR');
  print('6000 kWh = ${billPrediction.predictMonthlyBill(6000)} SAR');
  print('6500 kWh = ${billPrediction.predictMonthlyBill(6500)} SAR');

  runApp(const LuminApp());
}

class LuminApp extends StatelessWidget {
  const LuminApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'LUMIN',
      home: Scaffold(
        body: Center(
          child: Text(
            'LUMIN App',
            style: TextStyle(fontSize: 24),
          ),
        ),
      ),
    );
  }
}