import 'package:bachmeal/screens/package_details/package_details_screen.dart';
import 'package:flutter/material.dart';
import 'package:bachmeal/core/theme.dart';

class PackageOverviewScreen extends StatelessWidget {
  const PackageOverviewScreen({super.key});

  void _navigateToDetails(BuildContext context, String packageName, int price, List<String> features) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => PackageDetailsScreen(
          packageName: packageName,
          price: price,
          features: features,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Choose Your Meal Plan"),
        backgroundColor: AppTheme.gold,
      ),
      backgroundColor: AppTheme.offWhite,
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Choose Your Monthly Meal Plan",
              style: AppTheme.textTheme.displaySmall,
            ),
            const SizedBox(height: 16),

            // Package Cards
            PackageCard(
              packageName: "Basic Plan",
              price: 2700,
              features: const [
                "Daily Lunch & Dinner (Pre-set Menu)",
                "Delicious & Balanced Meals",
                "Convenient Delivery",
                "Vacation Pause Option",
              ],
              onSelect: () => _navigateToDetails(context, "Basic Plan", 2700, [
                "Daily Lunch & Dinner (Pre-set Menu)",
                "Delicious & Balanced Meals",
                "Convenient Delivery",
                "Vacation Pause Option",
              ]),
            ),
            PackageCard(
              packageName: "Standard Plan",
              price: 3300,
              features: const [
                "All Basic Plan Features",
                "Daily Breakfast",
                "Option to Add Extra Food to Menu (e.g., Fish/Meat)",
                "Guest Meal Feature",
              ],
              onSelect: () => _navigateToDetails(context, "Standard Plan", 3300, [
                "All Basic Plan Features",
                "Daily Breakfast",
                "Option to Add Extra Food to Menu (e.g., Fish/Meat)",
                "Guest Meal Feature",
              ]),
            ),
            PackageCard(
              packageName: "Premium Plan",
              price: 4500,
              features: const [
                "All Standard Plan Features",
                "More Variety in Menu (More Protein, Special Dishes)",
                "Priority Support",
              ],
              onSelect: () => _navigateToDetails(context, "Premium Plan", 4500, [
                "All Standard Plan Features",
                "More Variety in Menu (More Protein, Special Dishes)",
                "Priority Support",
              ]),
            ),

            const SizedBox(height: 24),

            // "See Today's Menu" Section
            Center(
              child: TextButton(
                onPressed: () {
                  // Navigate to Sample Menu Screen (Replace with actual navigation)
                },
                child: const Text(
                  "Want to See Today's Menu?",
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.blue),
                ),
              ),
            ),

            const SizedBox(height: 16),

            // "How It Works" Section
            Text(
              "How It Works",
              style: AppTheme.textTheme.headlineMedium,
            ),
            const SizedBox(height: 8),
            const HowItWorksStep(number: "1", text: "Choose Your Plan"),
            const HowItWorksStep(number: "2", text: "Enjoy Daily Meals"),
            const HowItWorksStep(number: "3", text: "Customize & Manage in App"),
          ],
        ),
      ),
    );
  }
}

// Package Card Widget
class PackageCard extends StatelessWidget {
  final String packageName;
  final int price;
  final List<String> features;
  final VoidCallback onSelect;

  const PackageCard({
    super.key,
    required this.packageName,
    required this.price,
    required this.features,
    required this.onSelect,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      margin: const EdgeInsets.symmetric(vertical: 10),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              packageName,
              style: AppTheme.textTheme.headlineMedium,
            ),
            const SizedBox(height: 8),
            Text(
              "$price Taka/Month",
              style: AppTheme.textTheme.bodyLarge!.copyWith(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: features.map((feature) => Padding(
                padding: const EdgeInsets.only(bottom: 4),
                child: Row(
                  children: [
                    const Icon(Icons.check_circle, color: Colors.green, size: 18),
                    const SizedBox(width: 6),
                    Expanded(child: Text(feature, style: AppTheme.textTheme.bodyMedium)),
                  ],
                ),
              )).toList(),
            ),
            const SizedBox(height: 12),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: onSelect,
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppTheme.gold,
                  foregroundColor: Colors.black,
                ),
                child: const Text("Select Package"),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// "How It Works" Step Widget
class HowItWorksStep extends StatelessWidget {
  final String number;
  final String text;

  const HowItWorksStep({super.key, required this.number, required this.text});

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CircleAvatar(
          backgroundColor: AppTheme.gold,
          radius: 14,
          child: Text(
            number,
            style: const TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
          ),
        ),
        const SizedBox(width: 10),
        Expanded(child: Text(text, style: AppTheme.textTheme.bodyLarge)),
      ],
    );
  }
}
