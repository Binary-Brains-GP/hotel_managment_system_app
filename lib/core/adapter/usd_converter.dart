import 'currency_converter.dart';

class USDConverter implements CurrencyConverter {
  @override
  double convert(double amount) {
    return amount; // No conversion needed for USD
  }
}
