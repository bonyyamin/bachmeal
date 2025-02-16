import 'package:bachmeal/blocs/widgets/cards/subscription_status.dart';
import 'package:bachmeal/core/theme.dart';
import 'package:bachmeal/screens/payment/payment_screen.dart';
import 'package:flutter/material.dart';

class ProfileScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.offWhite,
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildProfileHeader(),
            SizedBox(height: 20),
            SubscriptionStatus(),
            SizedBox(height: 20),
            _buildBillingInformation(context),
          ],
        ),
      ),
    );
  }

  Widget _buildProfileHeader() {
    return Container(
      padding: EdgeInsets.only(left: 10, top: 60, bottom: 20),
      child: Row(
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              CircleAvatar(
                radius: 40,
                backgroundColor: Colors.white,
                child:
                    Image.asset('assets/images/avatar.png', fit: BoxFit.cover),
              ),
              SizedBox(height: 10),
              Text("Tobi Lateef", style: AppTheme.textTheme.displaySmall),
              SizedBox(height: 5),
            ],
          ),
          SizedBox(width: 20),
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
          Text(
            title,
            style: TextStyle(fontSize: 18, color: AppTheme.darkGray),
          ),
          Text(
            subtitle,
            style: AppTheme.textTheme.bodyLarge?.copyWith(color: AppTheme.gold),
          ),
        ],
      ),
    );
  }

  Widget _buildBillingInformation(BuildContext context) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      child: Padding(
        padding: EdgeInsets.all(16),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min, // Prevent unnecessary expansion
            children: [
              Text(
                "Billing Information",
                style: AppTheme.textTheme.headlineSmall?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 10),
              _buildInfoRow("Next Billing Date", "March 15, 2025"),
              _buildInfoRow("Payment Method", "Credit Card ending in ****1234"),
              SizedBox(height: 15),
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
      ),
    );
  }

  List<Widget> _buildButtonRow(BuildContext context) {
    return [
      ElevatedButton(
        onPressed: () {
          Navigator.pushNamed(context, "/update-payment");
        },
        child: Text("Update Payment Method"),
      ),
      ElevatedButton(
        onPressed: () {
          Navigator.pushNamed(context, "/billing-history");
        },
        child: Text("Billing History"),
      ),
      ElevatedButton(
          onPressed: () {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => const PaymentScreen()));
          },
          child: Text("Cancel Subscription")),
    ];
  }
}
