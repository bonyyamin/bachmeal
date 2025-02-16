import 'package:bachmeal/screens/menu/daily_menu_screen.dart';
import 'package:flutter/material.dart';
import 'package:card_swiper/card_swiper.dart';

class MealCardSwiper extends StatelessWidget {
  const MealCardSwiper({Key? key}) : super(key: key);

  final List<Map<String, dynamic>> meals = const [
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
  Widget build(BuildContext context) {
    return SizedBox(
      height: 150,
      child: Swiper(
        itemBuilder: (BuildContext context, int index) {
          return GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const DailyMenuScreen()),
              );
            },
            child: _buildMealCard(
              title: meals[index]['title']!,
              details: meals[index]['details']!,
              color: meals[index]['color']!,
            ),
          );
        },
        itemCount: meals.length,
        autoplay: true,
        autoplayDelay: 3000,
        loop: true,
        itemWidth: 350,
        layout: SwiperLayout.STACK,
      ),
    );
  }

  Widget _buildMealCard({
    required String title,
    required String details,
    required Color color,
  }) {
    return Container(
      width: 360,
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
