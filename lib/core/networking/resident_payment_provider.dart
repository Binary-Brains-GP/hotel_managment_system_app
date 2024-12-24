import 'package:flutter/foundation.dart';
import '../model/payment.dart';
import '../model/resident_model.dart';

class ResidentPaymentProvider with ChangeNotifier {
  final List<Resident> _resident = Resident.getResidents();
  double _cumulativeIncome = 0; // Tracks all payments made

  // Getter for residents
  List<Resident> get residents => _resident;

  // Getter for cumulative income
  double get cumulativeIncome => _cumulativeIncome;

  // Add a new resident/payment
  void addPayment(Resident payment) {
    _resident.add(payment);
    _cumulativeIncome += payment.roomPrice; // Add to cumulative income
    notifyListeners(); // Notify when a resident is added
  }

  // Remove a resident by name
  void removePayment(String name) {
    final resident = _resident.firstWhere(
          (payment) => payment.name == name,
      orElse: () => throw Exception("Resident not found"),
    );
    _resident.remove(resident);
    notifyListeners(); // Notify when a resident is removed
  }

  // Calculate total income of current residents
  double calculateTotalIncome() {
    return _resident.fold(0, (sum, item) => sum + item.roomPrice);
  }

  // Edit a resident's payment
  void editResidentPayment(String name, double newPrice) {
    // Find the resident by name
    final resident = _resident.firstWhere(
          (resident) => resident.name == name,
      orElse: () => throw Exception("Resident not found"),
    );

    // Update the resident's price
    resident.roomPrice += newPrice;

    // Add the difference to the cumulative income
    _cumulativeIncome += newPrice;

    // Notify listeners about the update
    notifyListeners();
  }

  // Calculate income for a specific time period
  double calculateIncomeForPeriod({
    required DateTime startDate,
    required DateTime endDate,
  }) {
    return residents
        .where((resident) =>
    resident.checkIn.isAfter(startDate) &&
        resident.checkOut.isBefore(endDate))
        .fold(0.0, (sum, resident) => sum + resident.roomPrice);
  }

  // Add to cumulative income directly (used for checkout scenarios)
  void addToCumulativeIncome(double amount) {
    _cumulativeIncome += amount;
    notifyListeners(); // Notify when cumulative income is updated
  }
}
