import 'package:bachmeal/core/theme.dart';
import 'package:flutter/material.dart';

class ContactSupport extends StatelessWidget {
  const ContactSupport({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Contact Support"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Text(
              "How would you like to contact us?",
              style: AppTheme.textTheme.headlineMedium,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 20),
            _buildContactOption(
              context,
              icon: Icons.chat,
              title: "Live Chat",
              subtitle: "Chat with a support agent",
              onTap: () {
                // Implement chat functionality
              },
            ),
            _buildContactOption(
              context,
              icon: Icons.phone,
              title: "Call Support",
              subtitle: "Talk to a customer representative",
              onTap: () {
                // Implement call functionality
              },
            ),
            _buildContactOption(
              context,
              icon: Icons.email,
              title: "Email Support",
              subtitle: "Send us an email",
              onTap: () {
                // Implement email functionality
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildContactOption(BuildContext context,
      {required IconData icon,
      required String title,
      required String subtitle,
      required VoidCallback onTap}) {
    return Card(
      color: AppTheme.lightBeige,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      child: ListTile(
        leading: Icon(icon, color: AppTheme.darkGray, size: 28),
        title: Text(title, style: AppTheme.textTheme.bodyLarge),
        subtitle: Text(subtitle, style: AppTheme.textTheme.bodyMedium),
        onTap: onTap,
      ),
    );
  }
}
