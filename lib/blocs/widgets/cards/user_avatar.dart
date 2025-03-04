import 'dart:io';
import 'package:bachmeal/core/theme.dart';
import 'package:bachmeal/global_state.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserAvatar extends StatefulWidget {
  const UserAvatar({super.key});

  @override
  State<UserAvatar> createState() => _UserAvatarState();
}

class _UserAvatarState extends State<UserAvatar> {
  @override
  void initState() {
    super.initState();
    _loadUserData();
  }

  // Load username and profile picture from SharedPreferences
  Future<void> _loadUserData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? savedName = prefs.getString('user_name') ?? "Bony Yamin";
    String? savedImagePath = prefs.getString('profile_image');

    userNameNotifier.value = savedName;
    profileImageNotifier.value = savedImagePath;
  }

  @override
  Widget build(BuildContext context) {
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
              // Dynamic Profile Picture
              ValueListenableBuilder<String?>(
                valueListenable: profileImageNotifier,
                builder: (context, imagePath, _) {
                  return CircleAvatar(
                    radius: 20,
                    backgroundImage: imagePath != null
                        ? FileImage(File(imagePath))
                        : const AssetImage('assets/images/avatar.png')
                            as ImageProvider,
                  );
                },
              ),
              const SizedBox(width: 10),

              // Dynamic Username
              ValueListenableBuilder<String>(
                valueListenable: userNameNotifier,
                builder: (context, userName, _) {
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        'Welcome,',
                        style: TextStyle(fontSize: 14, color: Colors.black54),
                      ),
                      Text(
                        userName,
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  );
                },
              ),
            ],
          ),
          IconButton(
            onPressed: () {
              // Notification button action
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text("No new notifications")),
              );
            },
            icon: const Icon(Icons.notifications_outlined),
          ),
        ],
      ),
    );
  }
}
