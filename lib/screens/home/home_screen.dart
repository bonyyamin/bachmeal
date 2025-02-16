import 'package:bachmeal/blocs/widgets/buttons/grid_quick_actions.dart';
import 'package:bachmeal/blocs/widgets/cards/announcments.dart';
import 'package:bachmeal/blocs/widgets/cards/delivery_status_card.dart';
import 'package:bachmeal/blocs/widgets/cards/meal_card_carousel.dart';
import 'package:bachmeal/blocs/widgets/cards/meal_card_swiper.dart';
import 'package:bachmeal/blocs/widgets/cards/promotions.dart';
import 'package:bachmeal/blocs/widgets/cards/refer_friend_card.dart';
import 'package:bachmeal/blocs/widgets/cards/today_menu.dart';
import 'package:bachmeal/blocs/widgets/cards/user_avatar.dart';
import 'package:bachmeal/core/theme.dart';
import 'package:bachmeal/screens/payment/order_history_screen.dart';
import 'package:bachmeal/screens/profile/profile_screen.dart';
import 'package:bachmeal/screens/profile/settings_screen.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;

  final List<Widget> _screens = [
    const HomeContent(), // Changed from HomeScreen to HomeContent
    OrderHistoryScreen(),
    ProfileScreen(),
    const SettingsScreen(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.offWhite,
      body: _screens[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        selectedItemColor: AppTheme.gold,
        unselectedItemColor: Colors.grey,
        showUnselectedLabels: true,
        type: BottomNavigationBarType.fixed,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home_outlined),
            label: "Home",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.receipt_long_outlined),
            label: "Orders",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person_outline),
            label: "Profile",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings_outlined),
            label: "Settings",
          ),
        ],
      ),
    );
  }
}

class HomeContent extends StatelessWidget {
  const HomeContent({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          UserAvatar(),
          const SizedBox(height: 10),
          const MealCardSwiper(),
          const SizedBox(height: 10),
          DeliveryStatusCard(
            orderTime: DateTime.now().subtract(
                Duration(minutes: 10)), // Example: Order was placed 10 min ago
          ),
          const SizedBox(height: 10),
          const QuickActions(),
          const SizedBox(height: 10),
          Announcements(),
          const SizedBox(height: 10),
          Promotions(),
          const SizedBox(height: 10),
        ],
      ),
    );
  }
}
