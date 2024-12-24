import 'package:design_pattern/core/networking/resident_payment_provider.dart';
import 'package:design_pattern/core/networking/worker_payment_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class IncomeProvider with ChangeNotifier {
  final WorkerPaymentProvider workerPaymentProvider;
  final ResidentPaymentProvider residentPaymentProvider;

  IncomeProvider({
    required this.workerPaymentProvider,
    required this.residentPaymentProvider,
  });

  double calculateTotalIncome() {
    return - workerPaymentProvider.calculateTotalIncome() +
        residentPaymentProvider.calculateTotalIncome();
  }
}
