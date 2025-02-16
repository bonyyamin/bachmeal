import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';

class Promotions1 extends StatelessWidget {
  const Promotions1({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildSectionTitle("Add an Extra Meal"),
        _buildScrollableFoodCards(),

        const SizedBox(height: 20),

        _buildSectionTitle("New on the Menu"),
        _buildNewMenuCarousel(),

        const SizedBox(height: 20),

        _buildSpecialOfferCard(),
      ],
    );
  }

  /// Section title styling
  Widget _buildSectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16),
      child: Text(
        title,
        style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
      ),
    );
  }

  /// 1️⃣ Scrollable food cards for adding extra meals
  Widget _buildScrollableFoodCards() {
    final List<Map<String, String>> extraMeals = [
      {"name": "Grilled Salmon", "image": "assets/images/salmon.jpg"},
      {"name": "Pasta Carbonara", "image": "assets/images/pasta.jpg"},
      {"name": "Vegan Buddha Bowl", "image": "assets/images/buddha_bowl.jpg"},
      {"name": "Chicken Stir Fry", "image": "assets/images/stir_fry.jpg"},
    ];

    return SizedBox(
      height: 150,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: extraMeals.length,
        itemBuilder: (context, index) {
          return _buildFoodCard(
            name: extraMeals[index]["name"]!,
            imagePath: extraMeals[index]["image"]!,
            onTap: () => Navigator.pushNamed(context, "/add_extra_meal_screen"),
          );
        },
      ),
    );
  }

  /// Food card design
  Widget _buildFoodCard({
    required String name,
    required String imagePath,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 130,
        margin: const EdgeInsets.symmetric(horizontal: 8),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          image: DecorationImage(
            image: AssetImage(imagePath),
            fit: BoxFit.cover,
          ),
        ),
        child: Align(
          alignment: Alignment.bottomCenter,
          child: Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: Colors.black.withOpacity(0.6),
              borderRadius: const BorderRadius.only(
                bottomLeft: Radius.circular(10),
                bottomRight: Radius.circular(10),
              ),
            ),
            child: Text(
              name,
              style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
          ),
        ),
      ),
    );
  }

  /// 2️⃣ Carousel for new dishes on the menu
  Widget _buildNewMenuCarousel() {
    final List<Map<String, String>> newDishes = [
      {"name": "Sushi Platter", "image": "assets/images/sushi.jpg"},
      {"name": "Steak & Veggies", "image": "assets/images/steak.jpg"},
      {"name": "Avocado Toast", "image": "assets/images/avocado_toast.jpg"},
    ];

    return CarouselSlider(
      options: CarouselOptions(
        height: 180,
        autoPlay: true,
        enlargeCenterPage: true,
      ),
      items: newDishes.map((dish) {
        return _buildCarouselCard(dish["name"]!, dish["image"]!);
      }).toList(),
    );
  }

  /// Carousel card design
  Widget _buildCarouselCard(String name, String imagePath) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.symmetric(horizontal: 8),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        image: DecorationImage(
          image: AssetImage(imagePath),
          fit: BoxFit.cover,
        ),
      ),
      child: Align(
        alignment: Alignment.bottomCenter,
        child: Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: Colors.black.withOpacity(0.7),
            borderRadius: const BorderRadius.only(
              bottomLeft: Radius.circular(12),
              bottomRight: Radius.circular(12),
            ),
          ),
          child: Text(
            name,
            style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
            textAlign: TextAlign.center,
          ),
        ),
      ),
    );
  }

  /// 3️⃣ Special Offer Card (Refer a friend)
  Widget _buildSpecialOfferCard() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.deepPurple,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black26,
            blurRadius: 6,
            spreadRadius: 2,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "🎉 Special Offer!",
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white),
          ),
          const SizedBox(height: 8),
          const Text(
            "Refer a friend and get a FREE meal! 🎁",
            style: TextStyle(fontSize: 16, color: Colors.white70),
          ),
          const SizedBox(height: 10),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.white,
              foregroundColor: Colors.deepPurple,
            ),
            onPressed: () {
              // Handle Referral Logic
            },
            child: const Text("Refer Now"),
          ),
        ],
      ),
    );
  }
}
