import 'package:bachmeal/core/theme.dart';
import 'package:bachmeal/screens/menu/daily_menu_screen.dart';
import 'package:flutter/material.dart';

class TodayMenu extends StatelessWidget {
  const TodayMenu({super.key});

  @override
  Widget build(BuildContext context) {
    List<String> menuItems = [
      "Grilled Chicken & Veggies",
      "Quinoa Salad",
      "Fresh Fruit Bowl",
      "Green Smoothie",
    ];

    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const DailyMenuScreen()),
        );
      },
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: AppTheme.paleYellow,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Today's Menu",
              style: AppTheme.textTheme.headlineMedium,
            ),
            const SizedBox(height: 8),
            Column(
              children: menuItems.map((item) {
                return Padding(
                  padding: const EdgeInsets.symmetric(vertical: 4),
                  child: Row(
                    children: [
                      const Icon(Icons.check_circle_outline,
                          color: Colors.green),
                      const SizedBox(width: 8),
                      Text(
                        item,
                        style: AppTheme.textTheme.bodyLarge,
                      ),
                    ],
                  ),
                );
              }).toList(),
            ),
          ],
        ),
      ),
    );
  }
}