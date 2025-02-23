import 'package:bachmeal/core/theme.dart';
import 'package:flutter/material.dart';

class FAQHelpCenter extends StatelessWidget {
  const FAQHelpCenter({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("FAQ & Help Center"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Expanded(
              child: ListView(
                children: [
                  _buildCategory(
                    "General / About the Service",
                    [
                      _buildFAQ("What is [App Name]?",
                          "[App Name] is a meal subscription service designed for bachelor employees and students."),
                      _buildFAQ("Where do you deliver?",
                          "We currently deliver within [Specific Areas/Cities in Bangladesh]."),
                      _buildFAQ("What types of meals do you offer?",
                          "We provide home-style meals, including rice, lentils, vegetables, eggs, chicken, and more."),
                      _buildFAQ("Is your food Halal?",
                          "Yes, all our meals are prepared according to Halal guidelines."),
                    ],
                  ),
                  _buildCategory(
                    "Packages and Subscriptions",
                    [
                      _buildFAQ("What are the different monthly packages?",
                          "We offer Basic (2700 Taka), Standard (3300 Taka), and Premium (4500 Taka) plans."),
                      _buildFAQ("How do I choose a package and subscribe?",
                          "You can select a package from the home page and proceed with the subscription process."),
                      _buildFAQ("Can I change my package after subscribing?",
                          "Yes, you can upgrade or downgrade your package from the Subscription section."),
                    ],
                  ),
                  _buildCategory(
                    "Delivery and Logistics",
                    [
                      _buildFAQ("What are your delivery times?",
                          "We deliver Lunch (12 PM - 2 PM) and Dinner (7 PM - 9 PM)."),
                      _buildFAQ(
                          "What happens if I am not home during delivery?",
                          "If you are unavailable, we will try to contact you. If unsuccessful, the meal will be returned."),
                      _buildFAQ("What if my delivery is late or incorrect?",
                          "Please contact customer support immediately through the app."),
                    ],
                  ),
                ],
              ),
            ),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton.icon(
                icon: const Icon(Icons.support_agent),
                label: const Text("Contact Support"),
                onPressed: () {
                  _showContactOptions(context);
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppTheme.lavender,
                  foregroundColor: AppTheme.darkGray,
                  textStyle: const TextStyle(
                      fontSize: 18, fontWeight: FontWeight.w500),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCategory(String title, List<Widget> faqs) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: Card(
        color: AppTheme.lightBeige,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        child: ExpansionTile(
          title: Text(title, style: AppTheme.textTheme.headlineMedium),
          children: faqs,
        ),
      ),
    );
  }

  Widget _buildFAQ(String question, String answer) {
    return ListTile(
      title: Text(question,
          style: AppTheme.textTheme.bodyLarge
              ?.copyWith(fontWeight: FontWeight.w600)),
      subtitle: Text(answer, style: AppTheme.textTheme.bodyMedium),
    );
  }

  void _showContactOptions(BuildContext context) {
    showModalBottomSheet(
      context: context,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      builder: (context) {
        return Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text("Contact Support", style: AppTheme.textTheme.headlineMedium),
              const SizedBox(height: 10),
              ListTile(
                leading: const Icon(Icons.chat, color: AppTheme.darkGray),
                title: const Text("Live Chat"),
                onTap: () {
                  // Implement chat functionality
                },
              ),
              ListTile(
                leading: const Icon(Icons.phone, color: AppTheme.darkGray),
                title: const Text("Call Support"),
                onTap: () {
                  // Implement call functionality
                },
              ),
              ListTile(
                leading: const Icon(Icons.email, color: AppTheme.darkGray),
                title: const Text("Email Support"),
                onTap: () {
                  // Implement email functionality
                },
              ),
            ],
          ),
        );
      },
    );
  }
}
