import 'package:bachmeal/blocs/widgets/buttons/grid_quick_actions.dart';
import 'package:bachmeal/blocs/widgets/buttons/quick_action_button.dart';
import 'package:bachmeal/blocs/widgets/cards/delivery_status_card.dart';
import 'package:bachmeal/blocs/widgets/cards/meal_card_swiper.dart';
import 'package:bachmeal/blocs/widgets/cards/promotions1.dart';
import 'package:bachmeal/blocs/widgets/cards/promotions2.dart';
import 'package:bachmeal/core/theme.dart';
import 'package:bachmeal/screens/menu/custom_order_screen.dart';
import 'package:bachmeal/screens/payment/order_history_screen.dart';
import 'package:bachmeal/screens/profile/profile_screen.dart';
import 'package:bachmeal/screens/profile/settings_screen.dart';
import 'package:bachmeal/screens/subscription/pause_resume_screen.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

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
          _buildUserAvatar(),
          //const MealCardCarousel(),
          const SizedBox(height: 10),
          const MealCardSwiper(),
          const SizedBox(height: 10),
          DeliveryStatusCard(
            orderTime: DateTime.now().subtract(
                Duration(minutes: 10)), // Example: Order was placed 10 min ago
          ),
          //_buildTodayMenu(context),

          const QuickActions(),
          //_buildQuickActions(context),
          const SizedBox(height: 10),
          _buildAnnouncements(),
          Promotions1(),
          Promotions2(),
        ],
      ),
    );
  }

  Widget _buildUserAvatar() {
    return Container(
      height: 80,
      decoration: BoxDecoration(
        color: AppTheme.offWhite,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              const CircleAvatar(
                radius: 20,
                backgroundImage: AssetImage('assets/images/avatar.png'),
              ),
              const SizedBox(width: 10),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [
                  Text(
                    'Welcome,',
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.black54,
                    ),
                  ),
                  Text(
                    'Bony Yamin',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ],
          ),
          IconButton(
            onPressed: () {
              // Handle notification tap
            },
            icon: const Icon(Icons.notifications_outlined),
          ),
        ],
      ),
    );
  }

  
  /*Widget _buildTodayMenu(BuildContext context) {
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
          MaterialPageRoute(builder: (context) => const MenuScreen()),
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
  }*/

  Widget _buildQuickActions(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        QuickActionButton(
          icon: Icons.tune,
          label: "Customize Order",
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => const CustomOrderScreen()),
            );
          },
        ),
        const SizedBox(
          width: 10,
        ),
        QuickActionButton(
          icon: Icons.pause_circle_outline,
          label: "Pause Service",
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => const PauseResumeScreen()),
            );
          },
        ),
      ],
    );
  }

  Widget _buildAnnouncements() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppTheme.softPink,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          const Icon(FontAwesomeIcons.bell, color: Colors.red),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              "New seasonal menu available! Check out our latest meal options.",
              style: AppTheme.textTheme.bodyLarge,
            ),
          ),
        ],
      ),
    );
  }
}
