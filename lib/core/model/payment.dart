abstract class Payment {
  final String id;
  final double amount;

  Payment({required this.id, required this.amount});
}

class WorkerPayment extends Payment {
  WorkerPayment({required String id, required double amount})
      : super(id: id, amount: amount);
}

class ResidentPayment extends Payment {
  ResidentPayment({required String id, required double amount})
      : super(id: id, amount: amount);
}
