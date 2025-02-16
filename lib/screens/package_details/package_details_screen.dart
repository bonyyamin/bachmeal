import 'package:bachmeal/screens/payment/payment_screen.dart';
import 'package:flutter/material.dart';
import 'package:bachmeal/core/theme.dart';

class PackageDetailsScreen extends StatelessWidget {
  final String packageName;
  final int price;
  final List<String> features;

  const PackageDetailsScreen({
    super.key,
    required this.packageName,
    required this.price,
    required this.features,
  });

  @override
  Widget build(BuildContext context) {
    final mealPlan = _getMealPlan(packageName);

    return Scaffold(
      appBar: AppBar(
        title: Text(packageName),
        backgroundColor: AppTheme.gold,
      ),
      backgroundColor: AppTheme.offWhite,
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "$price Taka/Month",
              style: AppTheme.textTheme.displayMedium,
            ),
            const SizedBox(height: 10),

            // Features Section
            Text(
              "Key Benefits",
              style: AppTheme.textTheme.headlineMedium,
            ),
            const SizedBox(height: 6),
            ...features.map((feature) => Row(
                  children: [
                    const Icon(Icons.check_circle,
                        color: Colors.green, size: 18),
                    const SizedBox(width: 6),
                    Expanded(
                        child: Text(feature,
                            style: AppTheme.textTheme.bodyMedium)),
                  ],
                )),
            const SizedBox(height: 16),

            // Meal Plan Table
            Text(
              "Weekly Meal Plan",
              style: AppTheme.textTheme.headlineMedium,
            ),
            const SizedBox(height: 6),
            _buildMealTable(mealPlan),
            const SizedBox(height: 16),

            // Expandable Nutritional Information
            _buildExpandableNutritionalInfo(),
          ],
        ),
      ),

      // Floating "Pay Now" Button
      floatingActionButton: FloatingActionButton.extended(
        backgroundColor: AppTheme.gold,
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const PaymentScreen(),
            ),
          );
        },
        label: const Text("Pay Now",
            style: TextStyle(color: Colors.black, fontSize: 16)),
        icon: const Icon(Icons.payment, color: Colors.black),
      ),
    );
  }

  // Function to get the meal plan based on package selection
  Map<String, Map<String, List<String>>> _getMealPlan(String package) {
    switch (package) {
      case "Basic Plan":
        return _basicPlan;
      case "Standard Plan":
        return _standardPlan;
      case "Premium Plan":
        return _premiumPlan;
      default:
        return {};
    }
  }

  // Function to build meal table
  Widget _buildMealTable(Map<String, Map<String, List<String>>> mealPlan) {
    return Table(
      border: TableBorder.all(color: Colors.black12),
      columnWidths: const {
        0: FractionColumnWidth(0.3),
        1: FractionColumnWidth(0.35),
        2: FractionColumnWidth(0.35),
      },
      children: [
        _buildTableHeader(),
        ...mealPlan.entries
            .map((entry) => _buildTableRow(entry.key, entry.value))
            .toList(),
      ],
    );
  }

  // Table Header Row
  TableRow _buildTableHeader() {
    return const TableRow(
      decoration: BoxDecoration(color: Colors.grey),
      children: [
        Padding(
            padding: EdgeInsets.all(8.0),
            child: Text("Day", style: TextStyle(fontWeight: FontWeight.bold))),
        Padding(
            padding: EdgeInsets.all(8.0),
            child: Text("Noon", style: TextStyle(fontWeight: FontWeight.bold))),
        Padding(
            padding: EdgeInsets.all(8.0),
            child:
                Text("Night", style: TextStyle(fontWeight: FontWeight.bold))),
      ],
    );
  }

  // Table Row Builder
  TableRow _buildTableRow(String day, Map<String, List<String>> meals) {
    return TableRow(
      children: [
        Padding(
            padding: const EdgeInsets.all(8.0),
            child:
                Text(day, style: const TextStyle(fontWeight: FontWeight.bold))),
        Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(meals["Noon"]!.join(", "))),
        Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(meals["Night"]!.join(", "))),
      ],
    );
  }

  // Expandable Section for Nutritional Info
  Widget _buildExpandableNutritionalInfo() {
    return ExpansionTile(
      title: Text("Average Daily Nutritional Info",
          style: AppTheme.textTheme.headlineMedium),
      children: [
        Padding(
          padding: const EdgeInsets.all(10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: const [
              Text("✅ Calories: 1800-2200 kcal per day"),
              Text("✅ Protein: 60-80g per day"),
              Text("✅ Carbs: 200-250g per day"),
              Text("✅ Fats: 50-70g per day"),
            ],
          ),
        ),
      ],
    );
  }
}

// **Meal Plan Data**
final Map<String, Map<String, List<String>>> _basicPlan = {
  "Friday": {
    "Noon": ["Chicken Biryani"],
    "Night": ["White rice", "Dal", "Eggs", "Vegetables"]
  },
  "Saturday": {
    "Noon": ["White rice", "Dal", "Fried Eggs"],
    "Night": ["White rice", "Dal", "Small Fish", "Vegetables"]
  },
  "Sunday": {
    "Noon": ["White rice", "Dal", "Chicken"],
    "Night": ["White rice", "Dal", "Fried Eggs", "Vegetables"]
  },
  "Monday": {
    "Noon": ["White rice", "Dal", "Big Fish"],
    "Night": ["White rice", "Dal", "Fried Eggs", "Vegetables"]
  },
  "Tuesday": {
    "Noon": ["White rice", "Dal", "Chicken"],
    "Night": ["White rice", "Dal", "Small Fish"]
  },
  "Wednesday": {
    "Noon": ["White rice", "Dal", "Big Fish"],
    "Night": ["White rice", "Dal", "Small Fish"]
  },
  "Thursday": {
    "Noon": ["White rice", "Dal", "Chicken"],
    "Night": ["White rice", "Dal", "Small Fish", "Vegetables"]
  },
};

final Map<String, Map<String, List<String>>> _standardPlan = {
  "Friday": {
    "Noon": ["Beef Biryani"],
    "Night": ["White rice", "Dal", "Egg Bhaji", "Vegetables"]
  },
  "Saturday": {
    "Noon": ["White rice", "Dal", "Egg Bhaji"],
    "Night": ["White rice", "Dal", "Small Fish"]
  },
  "Sunday": {
    "Noon": ["White rice", "Dal", "Chicken"],
    "Night": ["White rice", "Dal", "Egg Bhaji"]
  },
  "Monday": {
    "Noon": ["White rice", "Dal", "Big Fish"],
    "Night": ["White rice", "Dal", "Egg Bhaji"]
  },
  "Tuesday": {
    "Noon": ["White rice", "Dal", "Chicken"],
    "Night": ["White rice", "Dal", "Big Fish"]
  },
};

final Map<String, Map<String, List<String>>> _premiumPlan = {
  "Friday": {
    "Noon": ["Kachchi Biryani"],
    "Night": ["White rice", "Dal", "Fried Eggs"]
  },
  "Saturday": {
    "Noon": ["White rice", "Dal", "Chicken"],
    "Night": ["White rice", "Dal", "Large Fish"]
  },
  "Sunday": {
    "Noon": ["White rice", "Dal", "Chicken"],
    "Night": ["White rice", "Dal", "Fried Eggs"]
  },
  "Monday": {
    "Noon": ["White rice", "Dal", "Cow/Khashi"],
    "Night": ["White rice", "Dal", "Fried Eggs"]
  },
  "Tuesday": {
    "Noon": ["White rice", "Dal", "Large Fish"],
    "Night": ["White rice", "Dal", "Stuffed Eggs"]
  },
};
