import 'dart:io';
import 'package:bachmeal/core/theme.dart';
import 'package:bachmeal/global_state.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';

class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen({super.key});

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  final TextEditingController _nameController = TextEditingController();
  final ImagePicker _picker = ImagePicker();
  String? _profileImagePath;

  @override
  void initState() {
    super.initState();
    _loadUserData();
  }

  Future<void> _loadUserData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    _nameController.text = prefs.getString('user_name') ?? "Bony Yamin";
    _profileImagePath = prefs.getString('profile_image');
    setState(() {});
  }

  Future<void> _saveChanges() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    // Save name
    String newName = _nameController.text;
    await prefs.setString('user_name', newName);
    userNameNotifier.value = newName;

    // Save profile image path
    if (_profileImagePath != null) {
      await prefs.setString('profile_image', _profileImagePath!);
      profileImageNotifier.value = _profileImagePath;
    }

    Navigator.pop(context);
  }

  Future<void> _pickImage() async {
    final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      setState(() {
        _profileImagePath = image.path;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Edit Profile"),
        backgroundColor: AppTheme.gold,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            GestureDetector(
              onTap: _pickImage,
              child: CircleAvatar(
                radius: 50,
                backgroundImage: _profileImagePath != null
                    ? FileImage(File(_profileImagePath!))
                    : const AssetImage('assets/images/avatar.png')
                        as ImageProvider,
                child: const Align(
                  alignment: Alignment.bottomRight,
                  child: CircleAvatar(
                    radius: 14,
                    backgroundColor: AppTheme.gold,
                    child: Icon(Icons.edit, size: 16, color: Colors.black),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 20),
            TextField(
              controller: _nameController,
              decoration: const InputDecoration(
                labelText: "Full Name",
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: _saveChanges,
              style: ElevatedButton.styleFrom(
                backgroundColor: AppTheme.gold,
              ),
              child: const Text("Save Changes"),
            ),
          ],
        ),
      ),
    );
  }
}
