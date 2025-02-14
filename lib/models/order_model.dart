class Order {
  final String id;
  final DateTime date;
  final double amount;
  final String status; // e.g., Paid, Pending, Cancelled

  Order({
    required this.id,
    required this.date,
    required this.amount,
    required this.status,
  });
}