import 'package:bachmeal/core/theme.dart';
import 'package:flutter/material.dart';

class AboutUsPage extends StatelessWidget {
  const AboutUsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("About Us"),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("About BachMeal", style: AppTheme.textTheme.displaySmall),
            const SizedBox(height: 10),
            Text(
              "Tired of the daily cooking struggle? BachMeal was created to solve the mealtime problems faced by busy bachelor employees and students in Bangladesh. We understand the challenges of cooking alone – the time wasted, the inconsistent taste, and the unreliable hired help.",
              style: AppTheme.textTheme.bodyLarge,
            ),
            const SizedBox(height: 10),
            Text(
              "BachMeal offers a convenient and affordable solution with our monthly meal subscription service. We deliver delicious, home-style meals right to your doorstep, based on pre-planned menus that are both tasty and balanced. Choose from our Basic, Standard, or Premium packages to find the plan that fits your needs and budget.",
              style: AppTheme.textTheme.bodyLarge,
            ),
            const SizedBox(height: 20),

            // Mission Section
            Text("Our Mission", style: AppTheme.textTheme.displaySmall),
            const SizedBox(height: 10),
            Text(
              "To make healthy and delicious meals easily accessible and affordable for bachelor employees and students, freeing up their time and reducing cooking stress.",
              style: AppTheme.textTheme.bodyLarge,
            ),
            const SizedBox(height: 20),

            // What We Offer Section
            Text("What We Offer", style: AppTheme.textTheme.displaySmall),
            const SizedBox(height: 10),
            _buildOfferItem(Icons.fastfood, "Delicious & Convenient Meals",
                "Enjoy tasty, home-style Bangladeshi food without the hassle of cooking."),
            _buildOfferItem(Icons.menu_book, "Pre-planned Menus",
                "Know what you're eating each day and eliminate mealtime decision fatigue."),
            _buildOfferItem(Icons.payments, "Flexible Packages",
                "Choose a plan that suits your budget and preferences, with options for customization."),
            _buildOfferItem(Icons.delivery_dining, "Reliable Delivery",
                "Get your meals delivered on time, directly to your door."),
            _buildOfferItem(
                Icons.pause_circle_outline,
                "Vacation Mode & Guest Meals",
                "Pause deliveries when you're away and easily order extra meals for guests."),

            const SizedBox(height: 20),

            // Contact Us Section
            Text("Contact Us", style: AppTheme.textTheme.displaySmall),
            const SizedBox(height: 10),
            _buildContactItem(
                Icons.location_on, "Office Location", "123, Dhaka, Bangladesh"),
            _buildContactItem(Icons.phone, "Phone Number", "+880 1234-567890"),
            _buildContactItem(Icons.email, "Email", "support@bachmeal.com"),
            _buildContactItem(
                Icons.facebook, "Facebook", "facebook.com/bachmeal"),
            _buildContactItem(Icons.public, "Website", "www.bachmeal.com"),
          ],
        ),
      ),
    );
  }

  Widget _buildOfferItem(IconData icon, String title, String description) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, color: AppTheme.darkGray, size: 28),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title,
                    style: AppTheme.textTheme.bodyLarge
                        ?.copyWith(fontWeight: FontWeight.w600)),
                Text(description, style: AppTheme.textTheme.bodyMedium),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildContactItem(IconData icon, String title, String value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Row(
        children: [
          Icon(icon, color: AppTheme.darkGray, size: 28),
          const SizedBox(width: 10),
          Text("$title: ",
              style: AppTheme.textTheme.bodyLarge
                  ?.copyWith(fontWeight: FontWeight.w600)),
          Expanded(
            child: Text(value, style: AppTheme.textTheme.bodyMedium),
          ),
        ],
      ),
    );
  }
}
