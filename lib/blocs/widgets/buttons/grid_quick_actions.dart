import 'package:flutter/material.dart';

class QuickActions extends StatelessWidget {
  const QuickActions({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GridView.count(
      crossAxisCount: 2,
      crossAxisSpacing: 12,
      mainAxisSpacing: 12,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      children: [
        _buildActionCard(
          context,
          title: "View Full Meal Plan",
          icon: Icons.restaurant_menu,
          color: Colors.blue,
          onTap: () => Navigator.pushNamed(context, '/meals'),
        ),
        _buildActionCard(
          context,
          title: "Customize Tomorrow's Meals",
          icon: Icons.edit_calendar,
          color: Colors.orange,
          onTap: () => Navigator.pushNamed(context, '/custom_order_screen'),
        ),
        _buildActionCard(
          context,
          title: "Add Extra Meals",
          icon: Icons.add_circle,
          color: Colors.green,
          onTap: () => Navigator.pushNamed(context, '/add_extra_meal_screen'),
        ),
        _buildActionCard(
          context,
          title: "Manage Vacation",
          icon: Icons.pause_circle_filled,
          color: Colors.red,
          onTap: () => Navigator.pushNamed(context, '/pause_resume_screen'),
        ),
      ],
    );
  }

  Widget _buildActionCard(
    BuildContext context, {
    required String title,
    required IconData icon,
    required Color color,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: Colors.black26,
              blurRadius: 5,
              spreadRadius: 2,
              offset: Offset(0, 3),
            ),
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, size: 36, color: Colors.white),
            const SizedBox(height: 10),
            Text(
              title,
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
