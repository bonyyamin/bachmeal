import 'package:flutter/material.dart';
import 'dart:async';

class MealCardCarousel extends StatefulWidget {
  const MealCardCarousel({Key? key}) : super(key: key);

  @override
  _MealCardCarouselState createState() => _MealCardCarouselState();
}

class _MealCardCarouselState extends State<MealCardCarousel> {
  late PageController _pageController;
  Timer? _timer;
  final int _initialPage = 1000; // Large number to simulate infinite loop

  final List<Map<String, dynamic>> meals = [
    {
      'title': 'Breakfast (8:00 AM - 9:00 AM)',
      'details': 'Pancakes with Honey and Berries',
      'color': Colors.orangeAccent,
    },
    {
      'title': 'Lunch (1:00 PM - 2:00 PM)',
      'details': 'Vegetables and Eggs with Rice',
      'color': Colors.greenAccent,
    },
    {
      'title': 'Dinner (7:00 PM - 8:00 PM)',
      'details': 'Grilled Chicken with Steamed Broccoli',
      'color': Colors.blueAccent,
    },
  ];

  @override
  void initState() {
    super.initState();
    _pageController = PageController(initialPage: _initialPage);
    _startAutoSlide();
  }

  @override
  void dispose() {
    _timer?.cancel();
    _pageController.dispose();
    super.dispose();
  }

  void _startAutoSlide() {
    _timer?.cancel();
    _timer = Timer.periodic(const Duration(seconds: 3), (Timer timer) {
      if (_pageController.hasClients) {
        _pageController.nextPage(
          duration: const Duration(milliseconds: 500),
          curve: Curves.easeInOut,
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 150,
      child: PageView.builder(
        controller: _pageController,
        itemBuilder: (context, index) {
          final mealIndex = index % meals.length; // Loop through meals infinitely
          return _buildMealCard(
            title: meals[mealIndex]['title']!,
            details: meals[mealIndex]['details']!,
            color: meals[mealIndex]['color']!,
          );
        },
      ),
    );
  }

  Widget _buildMealCard({
    required String title,
    required String details,
    required Color color,
  }) {
    return Container(
      width: 320,
      height: 160,
      margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(15),
        boxShadow: const [
          BoxShadow(
            color: Colors.black26,
            blurRadius: 6,
            spreadRadius: 2,
            offset: Offset(0, 3),
          )
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              title,
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 10),
            Text(
              details,
              style: const TextStyle(
                fontSize: 16,
                color: Colors.white70,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
