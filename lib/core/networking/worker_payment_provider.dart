import 'package:flutter/foundation.dart';

import '../model/workers_model.dart';

class WorkerPaymentProvider with ChangeNotifier {

   List<Worker> _worker = Worker.getPredefinedWorkers();

  List<Worker> get workerPayments => _worker;

  void addPayment(Worker payment) {
    _worker.add(payment);
    notifyListeners();
  }

  void removePayment(String name) {
    _worker.removeWhere((payment) => payment.salary == name);
    notifyListeners();
  }

  double calculateTotalIncome() {
    return _worker.fold(0, (sum, item) => sum + item.salary);
  }

}

// core/networking/resident_payment_provider.dart
