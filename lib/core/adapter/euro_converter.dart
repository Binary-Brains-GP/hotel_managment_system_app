import 'currency_converter.dart';

class EuroConverter implements CurrencyConverter {
  final double exchangeRate = 0.85; // Example rate

  @override
  double convert(double amount) {
    return amount * exchangeRate; // Convert to Euros
  }
}
