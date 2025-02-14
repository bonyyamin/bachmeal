import 'package:bachmeal/screens/menu/weekly_menu.dart';
import 'package:flutter/material.dart';
import 'package:bachmeal/blocs/widgets/cards/meal_card.dart';
import 'package:bachmeal/core/theme.dart';
import 'package:bachmeal/models/meal.dart';

class MenuScreen extends StatefulWidget {
  const MenuScreen({super.key});

  @override
  State<MenuScreen> createState() => _MenuScreenState();
}

class _MenuScreenState extends State<MenuScreen> {
  late final List<Meal> _meals;

  @override
  void initState() {
    super.initState();
    _meals = [
      Meal(
        time: "Breakfast",
        image: "assets/images/breakfast.jpg",
        name: "Avocado Toast & Smoothie",
        calories: "350 kcal",
        portion: "1 serving",
        ingredients: ["Avocado", "Whole-grain bread", "Banana", "Milk"],
      ),
      Meal(
        time: "Lunch",
        image: "assets/images/launch.jpg",
        name: "Grilled Chicken Salad",
        calories: "500 kcal",
        portion: "1 bowl",
        ingredients: ["Chicken breast", "Lettuce", "Tomatoes", "Olive oil"],
      ),
      Meal(
        time: "Dinner",
        image: "assets/images/dinner.jpg",
        name: "Salmon with Quinoa",
        calories: "600 kcal",
        portion: "1 plate",
        ingredients: ["Salmon", "Quinoa", "Broccoli", "Lemon"],
      ),
    ];
  }

  void _showMealDetails(BuildContext context, Meal meal) {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) {
        return Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                meal.name,
                style: AppTheme.textTheme.headlineMedium,
              ),
              const SizedBox(height: 8),
              Text(
                "Calories: ${meal.calories}",
                style: AppTheme.textTheme.bodyLarge,
              ),
              Text(
                "Portion: ${meal.portion}",
                style: AppTheme.textTheme.bodyLarge,
              ),
              const SizedBox(height: 12),
              Text(
                "Ingredients:",
                style: AppTheme.textTheme.headlineMedium,
              ),
              ...meal.ingredients.map<Widget>((ingredient) {
                return Padding(
                  padding: const EdgeInsets.symmetric(vertical: 4),
                  child: Row(
                    children: [
                      const Icon(Icons.circle, size: 8, color: Colors.grey),
                      const SizedBox(width: 8),
                      Text(
                        ingredient,
                        style: AppTheme.textTheme.bodyLarge,
                      ),
                    ],
                  ),
                );
              }).toList(),
              const SizedBox(height: 20),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppTheme.gold,
                  foregroundColor: Colors.black,
                  padding: const EdgeInsets.symmetric(vertical: 12),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                onPressed: () => Navigator.pop(context),
                child: const Center(child: Text("Close")),
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.offWhite,
      appBar: AppBar(
        title: Text("Daily Menu", style: AppTheme.textTheme.displaySmall),
        centerTitle: true,
        backgroundColor: AppTheme.gold,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: _meals.length,
              itemBuilder: (context, index) {
                final meal = _meals[index];
                return GestureDetector(
                  onTap: () => _showMealDetails(context, meal),
                  child: MealCard(meal: meal),
                );
              },
            ),
            const SizedBox(height: 20),
            WeeklyMenu(),
          ],
        ),
      ),
    );
  }
}
