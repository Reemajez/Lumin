import 'bill_calculation_strategy.dart';
import 'tariff_018_strategy.dart';
import 'tariff_030_strategy.dart';

class BillPrediction {
  static const double tierLimitKwh = 6000;

  BillCalculationStrategy _strategy = Tariff018Strategy();

  void setStrategy(BillCalculationStrategy strategy) {
    _strategy = strategy;
  }

  double predictMonthlyBill(double monthKwh) {
    if (monthKwh < 0) {
      throw ArgumentError('kWh cannot be negative');
    }

    // إذا أقل من أو يساوي 6000
    if (monthKwh <= tierLimitKwh) {
      setStrategy(Tariff018Strategy());
      return _strategy.calculateBill(monthKwh);
    }

    // لو تعدى 6000 نحسب على شريحتين
    final tier1Kwh = tierLimitKwh;
    final tier2Kwh = monthKwh - tierLimitKwh;

    setStrategy(Tariff018Strategy());
    final tier1Cost = _strategy.calculateBill(tier1Kwh);

    setStrategy(Tariff030Strategy());
    final tier2Cost = _strategy.calculateBill(tier2Kwh);

    return tier1Cost + tier2Cost;
  }

  bool exceedsLimit({
    required double predictedBillSar,
    required double limitSar,
  }) {
    return predictedBillSar > limitSar;
  }
}
