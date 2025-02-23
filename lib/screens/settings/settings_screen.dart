import 'package:bachmeal/screens/settings/about_us.dart';
import 'package:bachmeal/screens/settings/contact_support.dart';
import 'package:bachmeal/screens/settings/faq_help_center.dart';
import 'package:bachmeal/screens/settings/privacy_policy.dart';
import 'package:flutter/material.dart';
import 'package:bachmeal/core/theme.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  bool deliveryUpdates = true;
  bool promotions = true;
  bool orderConfirmations = true;
  String selectedLanguage = "English";
  ThemeMode selectedTheme = ThemeMode.system;

  void _confirmDeleteAccount() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text("Delete Account"),
        content: const Text(
            "Are you sure you want to delete your account? This action cannot be undone."),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text("Cancel"),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
            onPressed: () {
              // Handle account deletion logic here
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text("Account deleted successfully.")),
              );
            },
            child: const Text("Delete"),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Settings")),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          _buildSectionTitle("App Settings"),
          _buildSwitchTile("Delivery Updates", deliveryUpdates,
              (value) => setState(() => deliveryUpdates = value)),
          _buildSwitchTile("Promotions", promotions,
              (value) => setState(() => promotions = value)),
          _buildSwitchTile("Order Confirmations", orderConfirmations,
              (value) => setState(() => orderConfirmations = value)),
          const SizedBox(height: 12),
          _buildSectionTitle("Language"),
          _buildDropdownTile(
              "App Language",
              selectedLanguage,
              ["English", "Spanish", "French"],
              (value) => setState(() => selectedLanguage = value!)),
          const SizedBox(height: 12),
          _buildSectionTitle("Theme"),
          _buildThemeDropdownTile("Theme Mode", selectedTheme,
              (ThemeMode? value) {
            setState(() => selectedTheme = value!);
          }),
          const SizedBox(height: 16),
          _buildSectionTitle("Help & Support"),
          _buildListTile("FAQ / Help Center", Icons.help_outline, () {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => const FAQHelpCenter()));
          }),
          _buildListTile("Contact Support", Icons.support_agent, () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => const ContactSupport()));
          }),
          _buildListTile("About Us", Icons.info_outline, () {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => const AboutUsPage()));
          }),
          _buildListTile("Terms & Privacy Policy", Icons.privacy_tip_outlined,
              () {
            // Navigator.push(
            //     context,
            //     MaterialPageRoute(
            //         builder: (context) => const PrivacyPolicyPage()));
          }),
          const SizedBox(height: 16),
          _buildSectionTitle("Account Actions"),
          _buildListTile("Logout", Icons.logout, () {
            // Handle Logout
          }),
          _buildListTile(
              "Delete Account", Icons.delete_outline, _confirmDeleteAccount,
              color: Colors.red),
        ],
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Text(title, style: AppTheme.textTheme.headlineMedium),
    );
  }

  Widget _buildSwitchTile(String title, bool value, Function(bool) onChanged) {
    return SwitchListTile(
      title: Text(title, style: AppTheme.textTheme.bodyLarge),
      value: value,
      onChanged: onChanged,
      activeColor: AppTheme.gold,
    );
  }

  Widget _buildDropdownTile(String title, String value, List<String> options,
      Function(String?) onChanged) {
    return ListTile(
      title: Text(title, style: AppTheme.textTheme.bodyLarge),
      trailing: DropdownButton<String>(
        value: value,
        items: options
            .map((e) => DropdownMenuItem(value: e, child: Text(e)))
            .toList(),
        onChanged: onChanged,
      ),
    );
  }

  Widget _buildThemeDropdownTile(
      String title, ThemeMode value, Function(ThemeMode?) onChanged) {
    return ListTile(
      title: Text(title, style: AppTheme.textTheme.bodyLarge),
      trailing: DropdownButton<ThemeMode>(
        value: value,
        items: [
          DropdownMenuItem(value: ThemeMode.light, child: Text("Light")),
          DropdownMenuItem(value: ThemeMode.dark, child: Text("Dark")),
          DropdownMenuItem(
              value: ThemeMode.system, child: Text("System Default")),
        ],
        onChanged: onChanged,
      ),
    );
  }

  Widget _buildListTile(String title, IconData icon, VoidCallback onTap,
      {Color? color}) {
    return ListTile(
      leading: Icon(icon, color: color ?? AppTheme.darkGray),
      title: Text(title,
          style: AppTheme.textTheme.bodyLarge?.copyWith(color: color)),
      trailing: const Icon(Icons.arrow_forward_ios, size: 16),
      onTap: onTap,
    );
  }
}
