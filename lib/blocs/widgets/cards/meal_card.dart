import 'package:bachmeal/core/theme.dart';
import 'package:bachmeal/models/meal.dart'; // Add this import
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class MealCard extends StatelessWidget {
  final Meal meal; // Changed to strongly typed Meal

  const MealCard({super.key, required this.meal});

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      margin: const EdgeInsets.symmetric(vertical: 10),
      elevation: 3,
      child: Row(
        children: [
          ClipRRect(
            borderRadius:
                const BorderRadius.horizontal(left: Radius.circular(12)),
            child: Hero(
              // Added Hero widget for smooth transitions
              tag: 'meal_${meal.name}',
              child: Image.asset(
                meal.image, // Updated to use Meal model
                width: 100,
                height: 100,
                fit: BoxFit.cover,
              ),
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    meal.time, // Updated to use Meal model
                    style: AppTheme.textTheme.bodyMedium
                        ?.copyWith(color: Colors.grey),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    meal.name, // Updated to use Meal model
                    style: AppTheme.textTheme.bodyLarge,
                  ),
                  const SizedBox(height: 6),
                  Row(
                    children: [
                      const Icon(FontAwesomeIcons.fire,
                          size: 14, color: Colors.orange),
                      const SizedBox(width: 6),
                      Text(meal.calories, style: AppTheme.textTheme.bodyMedium),
                      const SizedBox(width: 10),
                      const Icon(FontAwesomeIcons.utensils,
                          size: 14, color: Colors.green),
                      const SizedBox(width: 6),
                      Text(meal.portion, style: AppTheme.textTheme.bodyMedium),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
