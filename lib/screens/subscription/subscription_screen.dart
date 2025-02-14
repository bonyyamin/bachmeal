import 'package:bachmeal/screens/payment/order_history_screen.dart';
import 'package:flutter/material.dart';
import 'package:bachmeal/core/theme.dart';

class SubscriptionScreen extends StatefulWidget {
  const SubscriptionScreen({super.key});

  @override
  State<SubscriptionScreen> createState() => _SubscriptionScreenState();
}

class _SubscriptionScreenState extends State<SubscriptionScreen> {
  String _currentPlan = "Mid Budget"; // Example current plan
  String _nextBillingDate = "March 10, 2025";
  final List<Map<String, dynamic>> _plans = [
    {
      "name": "Low Budget",
      "price": "2700 Taka",
      "features": [
        "Basic meal plan",
        "No customization",
        "Standard ingredients"
      ],
    },
    {
      "name": "Mid Budget",
      "price": "3300 Taka",
      "features": [
        "Standard meal plan",
        "Some customization",
        "Better ingredients"
      ],
    },
    {
      "name": "High Budget",
      "price": "4500 Taka",
      "features": [
        "Premium meal plan",
        "Full customization",
        "Organic ingredients"
      ],
    },
  ];

  void _changePlan(String newPlan) {
    setState(() {
      _currentPlan = newPlan;
    });

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text("Subscription updated to $newPlan package."),
        backgroundColor: Colors.green,
      ),
    );
  }

  // void _viewInvoices() {
  //   // Function to navigate or show past invoices
  //   ScaffoldMessenger.of(context).showSnackBar(
  //     const SnackBar(content: Text("Viewing past invoices...")),
  //   );
  // }

  Widget _buildPlanCard(Map<String, dynamic> plan) {
    bool isCurrentPlan = plan["name"] == _currentPlan;

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: isCurrentPlan ? AppTheme.gold.withOpacity(0.3) : Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 6,
            spreadRadius: 2,
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            plan["name"],
            style: AppTheme.textTheme.headlineMedium,
          ),
          const SizedBox(height: 8),
          Text(
            plan["price"],
            style: AppTheme.textTheme.bodyLarge!
                .copyWith(fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 8),
          ...plan["features"].map<Widget>((feature) {
            return Padding(
              padding: const EdgeInsets.symmetric(vertical: 2),
              child: Row(
                children: [
                  const Icon(Icons.check, color: Colors.green, size: 16),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      feature,
                      style: AppTheme.textTheme.bodyLarge,
                    ),
                  ),
                ],
              ),
            );
          }).toList(),
          const SizedBox(height: 12),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: isCurrentPlan ? Colors.grey : AppTheme.gold,
              foregroundColor: Colors.black,
              padding: const EdgeInsets.symmetric(vertical: 12),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
            onPressed: isCurrentPlan ? null : () => _changePlan(plan["name"]),
            child: Text(
                isCurrentPlan ? "Current Plan" : "Switch to ${plan["name"]}"),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.offWhite,
      appBar: AppBar(
        title: Text("Subscription Management",
            style: AppTheme.textTheme.displaySmall),
        centerTitle: true,
        backgroundColor: AppTheme.gold,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Current Plan Details
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.1),
                    blurRadius: 6,
                    spreadRadius: 2,
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Current Plan: $_currentPlan",
                    style: AppTheme.textTheme.headlineMedium,
                  ),
                  const SizedBox(height: 8),
                  Text(
                    "Next Billing Date: $_nextBillingDate",
                    style: AppTheme.textTheme.bodyLarge,
                  ),
                  const SizedBox(height: 12),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppTheme.gold,
                      foregroundColor: Colors.black,
                      padding: const EdgeInsets.symmetric(vertical: 12),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => OrderHistoryScreen()),
                      );
                    },
                    child: const Center(child: Text("View Past Invoices")),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 20),

            // Subscription Plans
            Text("Choose a Subscription Plan",
                style: AppTheme.textTheme.displaySmall),
            const SizedBox(height: 12),
            ..._plans.map((plan) => Padding(
                  padding: const EdgeInsets.only(bottom: 12),
                  child: _buildPlanCard(plan),
                )),
          ],
        ),
      ),
    );
  }
}
