import 'package:flutter/material.dart';
import 'package:bachmeal/core/theme.dart';
import 'package:bachmeal/screens/home/home_screen.dart';

class PaymentSuccessScreen extends StatelessWidget {
  const PaymentSuccessScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.offWhite,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.check_circle, color: Colors.green, size: 100),
            const SizedBox(height: 16),
            Text("Payment Successful!", style: AppTheme.textTheme.displayMedium),
            const SizedBox(height: 10),
            Text("Your subscription has been activated.", style: AppTheme.textTheme.bodyLarge),
            const SizedBox(height: 30),
            ElevatedButton(
              onPressed: () {
                Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(builder: (context) => const HomeScreen()),
                  (route) => false,
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: AppTheme.gold,
                foregroundColor: Colors.black,
              ),
              child: const Text("Go to Home"),
            ),
          ],
        ),
      ),
    );
  }
}
