import 'package:flutter/material.dart';
import 'dart:async';

class DeliveryStatusCard extends StatefulWidget {
  final DateTime orderTime; // When the order was placed
  final Duration preparationTime; // Time required to prepare food
  final Duration deliveryTime; // Time required to deliver food

  const DeliveryStatusCard({
    Key? key,
    required this.orderTime,
    this.preparationTime = const Duration(minutes: 15),
    this.deliveryTime = const Duration(minutes: 20),
  }) : super(key: key);

  @override
  _DeliveryStatusCardState createState() => _DeliveryStatusCardState();
}

class _DeliveryStatusCardState extends State<DeliveryStatusCard> {
  String _status = "Preparing";
  late DateTime _estimatedDeliveryTime;
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    _calculateStatus();
    _startTimer();
  }

  void _calculateStatus() {
    DateTime now = DateTime.now();
    DateTime foodReadyTime = widget.orderTime.add(widget.preparationTime);
    _estimatedDeliveryTime = foodReadyTime.add(widget.deliveryTime);

    if (now.isBefore(foodReadyTime)) {
      _status = "Preparing";
    } else if (now.isBefore(_estimatedDeliveryTime)) {
      _status = "Out for Delivery";
    } else {
      _status = "Delivered";
    }
  }

  void _startTimer() {
    _timer = Timer.periodic(const Duration(seconds: 30), (timer) {
      setState(() {
        _calculateStatus();
      });

      if (_status == "Delivered") {
        _timer?.cancel();
      }
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 6,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Lunch Delivery Status",
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 10),
            Row(
              children: [
                Icon(
                  _status == "Preparing"
                      ? Icons.restaurant_menu
                      : _status == "Out for Delivery"
                          ? Icons.delivery_dining
                          : Icons.check_circle,
                  color: _status == "Delivered"
                      ? Colors.green
                      : _status == "Out for Delivery"
                          ? Colors.orange
                          : Colors.blue,
                  size: 28,
                ),
                const SizedBox(width: 10),
                Text(
                  _status,
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                    color: _status == "Delivered"
                        ? Colors.green
                        : _status == "Out for Delivery"
                            ? Colors.orange
                            : Colors.blue,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10),
            if (_status == "Out for Delivery") ...[
              Row(
                children: [
                  const Icon(Icons.timer, color: Colors.grey),
                  const SizedBox(width: 5),
                  Text(
                    "Arriving in: ${_remainingDeliveryTime()}",
                    style: const TextStyle(fontSize: 16, color: Colors.grey),
                  ),
                ],
              ),
            ],
          ],
        ),
      ),
    );
  }

  String _remainingDeliveryTime() {
    Duration remaining = _estimatedDeliveryTime.difference(DateTime.now());
    if (remaining.inMinutes <= 0) return "Now";
    return "${remaining.inMinutes} min";
  }
}
