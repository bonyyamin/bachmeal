import 'package:flutter/material.dart';

class Promotions2 extends StatelessWidget {
  const Promotions2({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildSectionTitle("Add Extra Meal"),
        _buildHorizontalList(_extraMeals()),

        _buildSectionTitle("New on the Menu"),
        _buildCarousel(_newMenuItems()),

        _buildSectionTitle("Special Offer"),
        _buildSpecialOffer(),
      ],
    );
  }

  Widget _buildSectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 16),
      child: Text(
        title,
        style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
      ),
    );
  }

  Widget _buildHorizontalList(List<Widget> items) {
    return SizedBox(
      height: 150,
      child: ListView(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 16),
        children: items,
      ),
    );
  }

  Widget _buildCarousel(List<Widget> items) {
    return SizedBox(
      height: 180,
      child: PageView(
        scrollDirection: Axis.horizontal,
        children: items,
      ),
    );
  }

  Widget _buildSpecialOffer() {
    return Container(
      margin: const EdgeInsets.all(16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.orangeAccent,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(color: Colors.black26, blurRadius: 5, spreadRadius: 2),
        ],
      ),
      child: Row(
        children: [
          const Icon(Icons.card_giftcard, size: 40, color: Colors.white),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const [
                Text(
                  "Refer a Friend!",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white),
                ),
                SizedBox(height: 5),
                Text(
                  "Invite a friend and get a free meal!",
                  style: TextStyle(fontSize: 14, color: Colors.white70),
                ),
              ],
            ),
          ),
          TextButton(
            onPressed: () {}, 
            child: const Text("Refer Now", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
          ),
        ],
      ),
    );
  }

  List<Widget> _extraMeals() {
    return [
      _buildFoodCard("Extra Chicken Bowl", "assets/images/chicken_bowl.png"),
      _buildFoodCard("Extra Salad", "assets/images/salad.png"),
      _buildFoodCard("Extra Pasta", "assets/images/pasta.png"),
    ];
  }

  List<Widget> _newMenuItems() {
    return [
      _buildHighlightCard("Grilled Salmon", "assets/images/salmon.png"),
      _buildHighlightCard("Vegan Burger", "assets/images/vegan_burger.png"),
      _buildHighlightCard("Quinoa Bowl", "assets/images/quinoa.png"),
    ];
  }

  Widget _buildFoodCard(String title, String imagePath) {
    return Container(
      width: 140,
      margin: const EdgeInsets.only(right: 10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 4)],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(imagePath, width: 80, height: 80, fit: BoxFit.cover),
          const SizedBox(height: 8),
          Text(title, textAlign: TextAlign.center, style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold)),
        ],
      ),
    );
  }

  Widget _buildHighlightCard(String title, String imagePath) {
    return Container(
      width: 300,
      margin: const EdgeInsets.symmetric(horizontal: 16),
      decoration: BoxDecoration(
        color: Colors.deepPurpleAccent,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 4)],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(imagePath, width: 120, height: 120, fit: BoxFit.cover),
          const SizedBox(height: 8),
          Text(title, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white)),
        ],
      ),
    );
  }
}
