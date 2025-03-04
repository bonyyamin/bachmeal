import 'package:bachmeal/global_state.dart';
import 'package:bachmeal/screens/package_details/package_overview_section.dart';
import 'package:bachmeal/screens/settings/settings_screen.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:bachmeal/core/theme.dart';
import 'package:bachmeal/screens/payment/order_history_screen.dart';
import 'package:bachmeal/screens/profile/profile_screen.dart';
import 'package:bachmeal/blocs/widgets/buttons/grid_quick_actions.dart';
import 'package:bachmeal/blocs/widgets/cards/announcments.dart';
import 'package:bachmeal/blocs/widgets/cards/delivery_status_card.dart';
import 'package:bachmeal/blocs/widgets/cards/meal_card_swiper.dart';
import 'package:bachmeal/blocs/widgets/cards/promotions.dart';
import 'package:bachmeal/blocs/widgets/cards/user_avatar.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;
  bool _isFirstTimeUser = false;
  bool _showMinimizedBanner = false;
  late SharedPreferences _prefs;

  final List<Widget> _screens = [
    const HomeContent(),
    OrderHistoryScreen(),
    ProfileScreen(),
    SettingsScreen(),
  ];

  @override
  void initState() {
    super.initState();
    _initializePreferences();
  }

  Future<void> _initializePreferences() async {
    _prefs = await SharedPreferences.getInstance();
    await _checkFirstTimeUser();
    await _loadBannerState();
    _loadProfileImage();
  }

  Future<void> _checkFirstTimeUser() async {
    bool firstTime = _prefs.getBool('isFirstTimeUser') ?? true;
    if (firstTime) {
      setState(() => _isFirstTimeUser = true);
      Future.delayed(const Duration(milliseconds: 500), _showWelcomePopup);
      _prefs.setBool('isFirstTimeUser', false);
    }
  }

  Future<void> _loadBannerState() async {
    bool showBanner = _prefs.getBool('showMinimizedBanner') ?? false;
    setState(() => _showMinimizedBanner = showBanner);
  }

  Future<void> _loadProfileImage() async {
    // Load user profile image from API
    String? imagePath = _prefs.getString('profile_image');
    profileImageNotifier.value = imagePath;
  }

  void _showWelcomePopup() {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => AlertDialog(
        title: const Text("Welcome to BachMeal!"),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text(
              "Say goodbye to cooking stress! Enjoy delicious, pre-planned meals delivered daily.",
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 10),
            Image.asset("assets/images/welcome_meal.jpg", height: 120),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              _handleMaybeLater();
            },
            child: const Text("Maybe Later"),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(backgroundColor: AppTheme.gold),
            onPressed: () {
              _closeBanner(); // Close banner when meal plan is chosen
              Navigator.pop(context);
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const PackageOverviewScreen()));
              // Navigate to subscription page
            },
            child: const Text("Choose a Meal Plan"),
          ),
        ],
      ),
    );
  }

  void _handleMaybeLater() async {
    await _prefs.setBool('showMinimizedBanner', true);
    setState(() => _showMinimizedBanner = true);
  }

  void _closeBanner() async {
    await _prefs.setBool('showMinimizedBanner', false);
    setState(() => _showMinimizedBanner = false);
  }

  void _onItemTapped(int index) {
    setState(() => _selectedIndex = index);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.offWhite,
      body: Stack(
        children: [
          _screens[_selectedIndex],
          if (_showMinimizedBanner)
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: _buildMinimizedBanner(),
            ),
        ],
      ),
      bottomNavigationBar: _buildBottomNavBar(),
    );
  }

  Widget _buildMinimizedBanner() {
    return GestureDetector(
      onTap: _showWelcomePopup, // Reopen popup when banner is tapped
      child: Container(
        padding: const EdgeInsets.all(12),
        color: AppTheme.gold.withOpacity(0.9),
        child: const Row(
          children: [
            Expanded(
              child: Text(
                "Welcome to BachMeal! Tap here to explore meal plans.",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 14,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  BottomNavigationBar _buildBottomNavBar() {
    return BottomNavigationBar(
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
            orderTime: DateTime.now().subtract(const Duration(minutes: 10)),
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
