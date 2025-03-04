import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:bachmeal/core/theme.dart';
import 'package:bachmeal/screens/on_boarding/taking_information_screen.dart';
import 'package:bachmeal/global_state.dart'; // Import ValueNotifier

class ProfileDetailsScreen extends StatefulWidget {
  final String firstName;
  final String lastName;
  final String phone;
  final String address;
  final String landmark;
  final String floor;
  final String religion;
  final String gender;
  final String profession;
  final List<String> dietaryPreferences;

  const ProfileDetailsScreen({
    super.key,
    required this.firstName,
    required this.lastName,
    required this.phone,
    required this.address,
    required this.landmark,
    required this.floor,
    required this.religion,
    required this.gender,
    required this.profession,
    required this.dietaryPreferences,
  });

  @override
  State<ProfileDetailsScreen> createState() => _ProfileDetailsScreenState();
}

class _ProfileDetailsScreenState extends State<ProfileDetailsScreen> {
  final ImagePicker _picker = ImagePicker();
  String? _profileImagePath;
  final ScrollController _scrollController = ScrollController();
  bool _isAtBottom = false;

  @override
  void initState() {
    super.initState();
    _loadProfileImage();
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  // Load saved profile image from SharedPreferences
  Future<void> _loadProfileImage() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      _profileImagePath = prefs.getString('profile_image');
      profileImageNotifier.value = _profileImagePath;
    });
  }

  // Pick Image from Gallery and Save
  Future<void> _pickImage() async {
    final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.setString('profile_image', image.path);
      setState(() {
        _profileImagePath = image.path;
        profileImageNotifier.value = _profileImagePath;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.offWhite,
      appBar: AppBar(
        title: const Text("Profile Details"),
        backgroundColor: AppTheme.gold,
      ),
      // Wrap the scrollable area with a NotificationListener
      body: NotificationListener<ScrollNotification>(
        onNotification: (ScrollNotification notification) {
          if (notification is ScrollEndNotification) {
            final currentPosition = _scrollController.position.pixels;
            final maxPosition = _scrollController.position.maxScrollExtent;
            // Check if we are within 20 pixels of the bottom
            const double threshold = 10.0;
            bool isAtBottom = currentPosition >= maxPosition - threshold;
            if (isAtBottom != _isAtBottom) {
              setState(() {
                _isAtBottom = isAtBottom;
              });
            }
          }
          return true;
        },
        child: SingleChildScrollView(
          controller: _scrollController,
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              _buildProfileCard(context),
              const SizedBox(height: 20),
              _buildSectionCard("Personal Information", [
                _buildInfoRow(Icons.person, "Full Name",
                    "${widget.firstName} ${widget.lastName}"),
                _buildInfoRow(Icons.phone, "Phone", widget.phone),
                _buildInfoRow(Icons.wc, "Gender", widget.gender),
                _buildInfoRow(Icons.book, "Religion", widget.religion),
                _buildInfoRow(Icons.work, "Profession", widget.profession),
              ]),
              const SizedBox(height: 20),
              _buildSectionCard("Delivery Address", [
                _buildInfoRow(Icons.home, "Address", widget.address),
                if (widget.landmark.isNotEmpty)
                  _buildInfoRow(Icons.location_on, "Landmark", widget.landmark),
                if (widget.floor.isNotEmpty)
                  _buildInfoRow(
                      Icons.apartment, "Floor/Apartment", widget.floor),
              ]),
              const SizedBox(height: 20),
              _buildDietaryPreferencesCard(),
              const SizedBox(height: 30),
            ],
          ),
        ),
      ),
      floatingActionButton: _isAtBottom ? null : _buildFloatingActionButton(),
      bottomNavigationBar: _isAtBottom ? _builBottomButtom() : null,
    );
  }

  Widget _buildFloatingActionButton() {
    return FloatingActionButton.extended(
      onPressed: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => TakingInformationScreen()),
        );
      },
      backgroundColor: AppTheme.gold,
      icon: const Icon(Icons.edit, color: Colors.black),
      label: const Text("Edit Profile Info",
          style: TextStyle(color: Colors.black)),
    );
  }

  Widget _builBottomButtom() {
    return Container(
      padding: const EdgeInsets.all(16),
      width: double.infinity,
      color: Colors.white,
      child: ElevatedButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => TakingInformationScreen()),
          );
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: AppTheme.gold,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          padding: const EdgeInsets.symmetric(vertical: 14),
        ),
        child: const Text("Edit Profile Info",
            style: TextStyle(color: Colors.black, fontSize: 16)),
      ),
    );
  }

  // Profile Card with Editable Picture
  Widget _buildProfileCard(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      elevation: 4,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          children: [
            Stack(
              children: [
                CircleAvatar(
                  radius: 45,
                  backgroundColor: AppTheme.lavender,
                  backgroundImage: _profileImagePath != null
                      ? FileImage(File(_profileImagePath!))
                      : null,
                  child: _profileImagePath == null
                      ? Text(
                          widget.firstName[0],
                          style: const TextStyle(
                              fontSize: 32, color: Colors.white),
                        )
                      : null,
                ),
                Positioned(
                  bottom: 0,
                  right: 0,
                  child: GestureDetector(
                    onTap: _pickImage,
                    child: const CircleAvatar(
                      radius: 14,
                      backgroundColor: AppTheme.gold,
                      child: Icon(Icons.edit, size: 16, color: Colors.black),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(width: 16),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("${widget.firstName} ${widget.lastName}",
                    style: AppTheme.textTheme.displaySmall),
                const SizedBox(height: 4),
                Text(widget.profession,
                    style: AppTheme.textTheme.bodyLarge
                        ?.copyWith(color: Colors.grey)),
                const SizedBox(height: 4),
                Row(
                  children: [
                    const Icon(Icons.phone, size: 16, color: Colors.grey),
                    const SizedBox(width: 5),
                    Text(widget.phone, style: AppTheme.textTheme.bodyLarge),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  // Section Card Reusable Widget
  Widget _buildSectionCard(String title, List<Widget> children) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      elevation: 4,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(title, style: AppTheme.textTheme.headlineMedium),
            const Divider(thickness: 1.2),
            ...children,
          ],
        ),
      ),
    );
  }

  // Info Row with Icon
  Widget _buildInfoRow(IconData icon, String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        children: [
          Icon(icon, color: AppTheme.gold),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(label,
                    style: AppTheme.textTheme.bodyMedium
                        ?.copyWith(color: Colors.grey)),
                Text(value, style: AppTheme.textTheme.bodyLarge),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // Dietary Preferences Chips
  Widget _buildDietaryPreferencesCard() {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      elevation: 4,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Dietary Preferences",
                style: AppTheme.textTheme.headlineMedium),
            const Divider(thickness: 1.2),
            widget.dietaryPreferences.isNotEmpty
                ? Wrap(
                    spacing: 8,
                    children: widget.dietaryPreferences.map((pref) {
                      return Chip(
                        label: Text(pref),
                        backgroundColor: AppTheme.lavender,
                        labelStyle: const TextStyle(color: Colors.white),
                      );
                    }).toList(),
                  )
                : const Text("No specific dietary preferences",
                    style: TextStyle(color: Colors.grey)),
          ],
        ),
      ),
    );
  }
}
