import 'package:bachmeal/blocs/widgets/cards/subscription_status.dart';
import 'package:bachmeal/core/theme.dart';
import 'package:flutter/material.dart';

class ProfileScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Profile"),
        backgroundColor: AppTheme.gold,
      ),
      backgroundColor: AppTheme.offWhite,
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildProfileHeader(),
            const SizedBox(height: 20),
            SubscriptionStatus(),
            const SizedBox(height: 20),
            _buildBillingInformation(context),
          ],
        ),
      ),
    );
  }

  Widget _buildProfileHeader() {
    return Container(
      padding: const EdgeInsets.only(left: 10, top: 40, bottom: 20),
      child: Row(
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const CircleAvatar(
                radius: 40,
                backgroundColor: Colors.white,
                child: Image(
                  image: AssetImage('assets/images/avatar.png'),
                  fit: BoxFit.cover,
                ),
              ),
              const SizedBox(height: 10),
              Text("Bony Yamin", style: AppTheme.textTheme.displaySmall),
              const SizedBox(height: 5),
            ],
          ),
          const SizedBox(width: 20),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildInfoRow(Icons.work, "Profession", "Student"),
              _buildInfoRow(Icons.phone, "Contact", "+88 01706 846868"),
              _buildInfoRow(Icons.location_on, "Location", "Sirajganj"),
              _buildInfoRow(Icons.star, "Subscription Status", "Premium User"),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildInfoRow(IconData icon, String title, String subtitle) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 5),
      child: Row(
        children: [
          Icon(icon, color: AppTheme.darkGray, size: 20),
          const SizedBox(width: 8),
          Text(
            "$title: ",
            style: AppTheme.textTheme.bodyLarge
                ?.copyWith(fontWeight: FontWeight.w600),
          ),
          Text(subtitle, style: AppTheme.textTheme.bodyMedium),
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
          children: [
            Text(
              "Billing Information",
              style: AppTheme.textTheme.headlineMedium
                  ?.copyWith(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            _buildInfoRow(
                Icons.calendar_today, "Next Billing Date", "March 15, 2025"),
            _buildInfoRow(Icons.payment, "Payment Method",
                "Credit Card ending in ****1234"),
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
