import 'package:bachmeal/core/theme.dart';
import 'package:flutter/material.dart';

class PrivacyPolicyPage extends StatelessWidget {
  const PrivacyPolicyPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Terms & Conditions"),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Legal Disclaimer",
              style: AppTheme.textTheme.displaySmall,
            ),
            const SizedBox(height: 10),
            Text(
              "These Terms & Conditions have been drafted based on standard industry practices. However, it is strongly recommended that you consult a legal professional in Bangladesh to ensure full compliance with local laws and to protect your business.",
              style: AppTheme.textTheme.bodyLarge,
            ),
            const SizedBox(height: 20),
            _buildSection("1. Acceptance of Terms",
                "By using the BachMeal app, you agree to be bound by these Terms & Conditions."),
            _buildSection(
                "2. Subscription Terms",
                "• Subscription period is monthly and renews automatically.\n"
                    "• Billing occurs in Bangladeshi Taka via selected payment methods.\n"
                    "• Cancellations must be made within the specified notice period.\n"
                    "• Package changes (upgrades/downgrades) take effect from the next billing cycle.\n"
                    "• We reserve the right to modify pricing with prior notice."),
            _buildSection(
                "3. Delivery",
                "• We deliver within specific areas and delivery times may change.\n"
                    "• Users must provide an accurate address and be available during delivery.\n"
                    "• Missed deliveries: If we cannot reach you, the meal will not be refunded.\n"
                    "• Consume meals immediately or refrigerate as per guidelines."),
            _buildSection(
                "4. Food Quality and Allergies",
                "• Meals are prepared in a facility that may handle allergens.\n"
                    "• We do not guarantee allergen-free meals.\n"
                    "• Users must inform us of allergies before ordering.\n"
                    "• We are not liable for allergic reactions."),
            _buildSection(
                "5. User Account",
                "• Users must provide accurate details during registration.\n"
                    "• Account security is the user's responsibility.\n"
                    "• We reserve the right to terminate accounts violating our policies."),
            _buildSection(
                "6. Intellectual Property",
                "• App content, logo, and design are BachMeal's intellectual property.\n"
                    "• Users may not copy, distribute, or misuse content."),
            _buildSection(
                "7. Disclaimer of Warranties",
                "• The app is provided 'as is' without warranties.\n"
                    "• No guarantee of uninterrupted service or menu accuracy."),
            _buildSection(
                "8. Limitation of Liability",
                "• Our liability is limited to the extent permitted by law.\n"
                    "• We are not responsible for damages arising from app use."),
            _buildSection("9. Indemnification",
                "• Users agree to indemnify us against claims from their app use."),
            _buildSection(
                "10. Governing Law and Jurisdiction",
                "• These Terms are governed by the laws of Bangladesh.\n"
                    "• Any disputes will be resolved in Bangladeshi courts."),
            _buildSection("11. Changes to Terms and Conditions",
                "• We reserve the right to modify these Terms with notice."),
            _buildSection(
                "12. Privacy Policy",
                "• See our Privacy Policy for details on data collection and security.\n"
                    "• Link: [Insert Privacy Policy URL]"),
            _buildSection(
                "13. Contact Information",
                "• Office: 123, Dhaka, Bangladesh\n"
                    "• Phone: +880 1234-567890\n"
                    "• Email: support@bachmeal.com"),
          ],
        ),
      ),
    );
  }

  Widget _buildSection(String title, String content) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: Card(
        color: AppTheme.lightBeige,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        child: ExpansionTile(
          title: Text(title, style: AppTheme.textTheme.headlineMedium),
          children: [
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: Text(content, style: AppTheme.textTheme.bodyMedium),
            ),
          ],
        ),
      ),
    );
  }
}
