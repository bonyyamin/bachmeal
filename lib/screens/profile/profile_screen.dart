import 'package:bachmeal/core/theme.dart';
import 'package:flutter/material.dart';

class ProfileScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.offWhite,
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildProfileHeader(),
            SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  Widget _buildProfileHeader() {
    return Container(
      padding: EdgeInsets.only(left: 40, top: 60, right: 20, bottom: 20),
      decoration: BoxDecoration(
        color: AppTheme.offWhite,
      ),
      child: Row(
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              CircleAvatar(
                radius: 40,
                backgroundColor: Colors.white,
                child: Image.asset('assets/avatar.png', fit: BoxFit.cover),
              ),
              SizedBox(height: 10),
              Text("Tobi Lateef", style: AppTheme.textTheme.displaySmall),
              SizedBox(height: 5),
            ],
          ),
          SizedBox(width: 20),
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              _buildInfoRow("Profession", "Contractor"),
              _buildInfoRow("Profession", "Contractor"),
              _buildInfoRow("Profession", "Contractor"),
              _buildInfoRow("Profession", "Contractor"),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildInfoRow(
    String title,
    String subtitle,
  ) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Column(
        children: [
          Text(
            title,
            style: TextStyle(fontSize: 18, color: AppTheme.darkGray),
          ),
          Text(subtitle,
              style:
                  AppTheme.textTheme.bodyLarge?.copyWith(color: AppTheme.gold)),
        ],
      ),
    );
  }
}
