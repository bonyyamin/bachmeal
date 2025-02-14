class Subscription {
  final String id;
  final String plan;
  final String status; // e.g., Active, Expired, Cancelled
  final DateTime startDate;
  final DateTime endDate;

  Subscription({
    required this.id,
    required this.plan,
    required this.status,
    required this.startDate,
    required this.endDate,
  });
}