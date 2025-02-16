import 'package:bachmeal/core/theme.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';


class Announcements extends StatelessWidget {
  const Announcements({super.key});

  @override
  Widget build(BuildContext context) {
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
