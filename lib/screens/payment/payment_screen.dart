import 'package:flutter/material.dart';
import 'package:bachmeal/core/theme.dart';
import 'package:bachmeal/screens/payment/payment_success_screen.dart';

class PaymentScreen extends StatefulWidget {
  const PaymentScreen({super.key});

  @override
  State<PaymentScreen> createState() => _PaymentScreenState();
}

class _PaymentScreenState extends State<PaymentScreen> {
  String _selectedPaymentMethod = "Bkash"; // Default selection

  final List<Map<String, dynamic>> _paymentMethods = [
    {"name": "Bkash", "icon": "assets/icons/bkash.png"},
    {"name": "Nagad", "icon": "assets/icons/nagad.png"},
    {"name": "Rocket", "icon": "assets/icons/rocket.png"},
    {"name": "Visa/MasterCard", "icon": "assets/icons/cerdit_card.jpg"},
  ];

  void _confirmPayment() {
    // Navigate to a success screen or process the payment
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const PaymentSuccessScreen()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Select Payment Method"),
        backgroundColor: AppTheme.gold,
      ),
      backgroundColor: AppTheme.offWhite,
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Choose a Payment Method",
                style: AppTheme.textTheme.displaySmall),
            const SizedBox(height: 16),

            // Payment Options List
            ..._paymentMethods
                .map((method) => _buildPaymentOption(method))
                .toList(),

            const Spacer(),

            // Confirm Payment Button
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: _confirmPayment,
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppTheme.gold,
                  foregroundColor: Colors.black,
                ),
                child: const Text("Confirm Payment",
                    style: TextStyle(fontSize: 16)),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPaymentOption(Map<String, dynamic> method) {
    bool isSelected = _selectedPaymentMethod == method["name"];

    return GestureDetector(
      onTap: () {
        setState(() {
          _selectedPaymentMethod = method["name"];
        });
      },
      child: Card(
        elevation: isSelected ? 5 : 2,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        color: isSelected ? AppTheme.paleYellow : Colors.white,
        margin: const EdgeInsets.symmetric(vertical: 8),
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Row(
            children: [
              Image.asset(method["icon"], height: 40),
              const SizedBox(width: 12),
              Text(
                method["name"],
                style: AppTheme.textTheme.bodyLarge,
              ),
              const Spacer(),
              if (isSelected)
                const Icon(Icons.check_circle, color: Colors.green),
            ],
          ),
        ),
      ),
    );
  }
}
