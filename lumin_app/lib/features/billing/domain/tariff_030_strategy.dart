import 'bill_calculation_strategy.dart';

class Tariff030Strategy implements BillCalculationStrategy {
  static const double rate = 0.30;

  @override
  double calculateBill(double kwh) {
    if (kwh < 0) {
      throw ArgumentError('kWh cannot be negative');
    }

    return kwh * rate;
  }
}
