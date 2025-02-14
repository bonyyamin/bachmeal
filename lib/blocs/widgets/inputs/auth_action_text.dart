import 'package:bachmeal/core/theme.dart';
import 'package:flutter/material.dart';

class AuthActionText extends StatelessWidget {
  final String question;
  final String actionText;
  final VoidCallback onTap;

  const AuthActionText({
    super.key,
    required this.question,
    required this.actionText,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Text.rich(
        TextSpan(
          text: "$question ",
          style: AppTheme.textTheme.bodyMedium?.copyWith(
            color: Colors.grey.shade600,
          ),
          children: [
            TextSpan(
              text: actionText,
              style: AppTheme.textTheme.bodyMedium?.copyWith(
                color: Colors.red,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
