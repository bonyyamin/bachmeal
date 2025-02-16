import 'package:flutter/material.dart';
import 'package:bachmeal/core/theme.dart';

class PaymentScreen2 extends StatefulWidget {
  const PaymentScreen2({super.key});

  @override
  State<PaymentScreen2> createState() => _PaymentScreenState();
}

class _PaymentScreenState extends State<PaymentScreen2> {
  final double _monthlyFee = 3000.0; // Example Monthly Fee
  double _extraCharges = 0.0;
  double _totalAmount = 0.0;
  String? _selectedPaymentMethod;

  final List<Map<String, dynamic>> _extraOrders = [
    {"item": "Extra Chicken", "price": 50, "quantity": 2},
    {"item": "Guest Meal", "price": 100, "quantity": 1},
  ];

  final List<String> _paymentMethods = ["bKash", "Nagad", "Credit Card", "Cash"];

  @override
  void initState() {
    super.initState();
    _calculateTotal();
  }

  void _calculateTotal() {
    double extraCost = 0.0;
    for (var order in _extraOrders) {
      extraCost += order["price"] * order["quantity"];
    }
    setState(() {
      _extraCharges = extraCost;
      _totalAmount = _monthlyFee + _extraCharges;
    });
  }

  void _processPayment() {
    if (_selectedPaymentMethod == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Please select a payment method")),
      );
      return;
    }

    // Simulate payment processing
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text("Payment Successful via $_selectedPaymentMethod"),
        backgroundColor: Colors.green,
      ),
    );

    // Navigate to a receipt screen or display confirmation
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.offWhite,
      appBar: AppBar(
        title: Text("Payment", style: AppTheme.textTheme.displaySmall),
        centerTitle: true,
        backgroundColor: AppTheme.gold,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Payment Summary", style: AppTheme.textTheme.headlineMedium),
            const SizedBox(height: 10),
            Card(
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
              elevation: 2,
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildSummaryRow("Monthly Fee", _monthlyFee),
                    ..._extraOrders.map((order) {
                      return _buildSummaryRow(
                        "${order["item"]} (x${order["quantity"]})",
                        order["price"] * order["quantity"],
                      );
                    }),
                    _buildSummaryRow("Extra Charges", _extraCharges, isBold: true),
                    const Divider(),
                    _buildSummaryRow("Total Amount", _totalAmount, isBold: true, color: Colors.red),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 20),
            Text("Select Payment Method", style: AppTheme.textTheme.headlineMedium),
            const SizedBox(height: 10),
            Column(
              children: _paymentMethods.map((method) {
                return RadioListTile<String>(
                  title: Text(method, style: AppTheme.textTheme.bodyLarge),
                  value: method,
                  groupValue: _selectedPaymentMethod,
                  activeColor: AppTheme.gold,
                  onChanged: (value) {
                    setState(() {
                      _selectedPaymentMethod = value;
                    });
                  },
                );
              }).toList(),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: AppTheme.gold,
                foregroundColor: Colors.black,
                padding: const EdgeInsets.symmetric(vertical: 12),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
              ),
              onPressed: _processPayment,
              child: const Center(child: Text("Proceed to Payment")),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSummaryRow(String label, double amount, {bool isBold = false, Color? color}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: AppTheme.textTheme.bodyLarge!.copyWith(fontWeight: isBold ? FontWeight.bold : FontWeight.normal)),
          Text(
            "${amount.toStringAsFixed(2)} BDT",
            style: AppTheme.textTheme.bodyLarge!.copyWith(fontWeight: isBold ? FontWeight.bold : FontWeight.normal, color: color),
          ),
        ],
      ),
    );
  }
}
