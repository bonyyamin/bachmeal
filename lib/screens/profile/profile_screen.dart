import 'dart:io';
import 'package:bachmeal/blocs/widgets/cards/subscription_status.dart';
import 'package:bachmeal/core/theme.dart';
import 'package:bachmeal/global_state.dart';
import 'package:bachmeal/screens/profile/profile_details_screen.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  void initState() {
    super.initState();
    _loadProfileImage();
  }

  // Load saved profile image from SharedPreferences
  Future<void> _loadProfileImage() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? savedImagePath = prefs.getString('profile_image');
    profileImageNotifier.value = savedImagePath;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.offWhite,
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildProfileHeader(context),
            const SizedBox(height: 20),
            SubscriptionStatus(),
            const SizedBox(height: 20),
            _buildBillingInformation(context),
          ],
        ),
      ),
    );
  }

  Widget _buildProfileHeader(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(left: 10, top: 60, bottom: 20),
      child: Row(
        children: [
          Column(
            children: [
              // ✅ Dynamic Profile Picture with ValueListenableBuilder
              ValueListenableBuilder<String?>(
                valueListenable: profileImageNotifier,
                builder: (context, imagePath, _) {
                  return CircleAvatar(
                    radius: 40,
                    backgroundColor: Colors.white,
                    backgroundImage: imagePath != null
                        ? FileImage(File(imagePath))
                        : const AssetImage('assets/images/avatar.png')
                            as ImageProvider,
                  );
                },
              ),
              const SizedBox(height: 10),
              Text("Bony Yamin", style: AppTheme.textTheme.displaySmall),
              const SizedBox(height: 5),

              // Edit Profile Button
              ElevatedButton.icon(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ProfileDetailsScreen(
                        firstName: "Bony",
                        lastName: "Yamin",
                        phone: "+88 01706 846868",
                        address: "Sirajganj",
                        landmark: "Near Market",
                        floor: "3rd Floor",
                        religion: "Islam",
                        gender: "Male",
                        profession: "Student",
                        dietaryPreferences: ["Non-Vegetarian", "Avoid Beef"],
                      ),
                    ),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppTheme.gold,
                  foregroundColor: Colors.black,
                ),
                icon: const Icon(Icons.edit),
                label: const Text("Edit Profile"),
              ),
            ],
          ),
          const SizedBox(width: 20),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildInfoRow("Profession", "Student"),
              _buildInfoRow("Contact", "+88 01706 846868"),
              _buildInfoRow("Location", "Sirajganj"),
              _buildInfoRow("Subscription Status", "Premium User"),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildInfoRow(String title, String subtitle) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title, style: TextStyle(fontSize: 18, color: AppTheme.darkGray)),
          Text(subtitle,
              style:
                  AppTheme.textTheme.bodyLarge?.copyWith(color: AppTheme.gold)),
        ],
      ),
    );
  }

  Widget _buildBillingInformation(BuildContext context) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              "Billing Information",
              style: AppTheme.textTheme.headlineSmall
                  ?.copyWith(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            _buildInfoRow("Next Billing Date", "March 15, 2025"),
            _buildInfoRow("Payment Method", "Credit Card ending in ****1234"),
            const SizedBox(height: 15),
            LayoutBuilder(
              builder: (context, constraints) {
                return constraints.maxWidth > 400
                    ? Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: _buildButtonRow(context),
                      )
                    : Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: _buildButtonRow(context),
                      );
              },
            ),
          ],
        ),
      ),
    );
  }

  List<Widget> _buildButtonRow(BuildContext context) {
    return [
      ElevatedButton(
        onPressed: () {
          Navigator.pushNamed(context, "/update-payment");
        },
        child: const Text("Update Payment Method"),
      ),
      ElevatedButton(
        onPressed: () {
          Navigator.pushNamed(context, "/billing-history");
        },
        child: const Text("Billing History"),
      ),
    ];
  }
}
