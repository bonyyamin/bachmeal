import 'package:bachmeal/blocs/widgets/buttons/auth_button.dart';
import 'package:bachmeal/blocs/widgets/inputs/auth_action_text.dart';
import 'package:bachmeal/core/theme.dart';
import 'package:bachmeal/screens/auth/register_screen.dart';
import 'package:bachmeal/screens/home/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.offWhite,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              "Welcome back",
              style: AppTheme.textTheme.displaySmall,
            ),
            const SizedBox(height: 32),
            AuthButton(
              icon: FontAwesomeIcons.apple,
              text: "Continue with Apple",
              onPressed: () {},
            ),
            const SizedBox(height: 16),
            AuthButton(
              icon: FontAwesomeIcons.google,
              text: "Continue with Google",
              onPressed: () {},
            ),
            const SizedBox(height: 24),
            Text(
              "OR SIGN UP WITH EMAIL",
              style: AppTheme.textTheme.bodyMedium?.copyWith(
                color: Colors.grey.shade600,
              ),
            ),
            const SizedBox(height: 16),
            CustomTextField(
              hintText: "Email address",
              icon: Icons.email_outlined,
            ),
            const SizedBox(height: 12),
            CustomTextField(
              hintText: "Password",
              icon: Icons.lock_outline,
              isPassword: true,
            ),
            const SizedBox(height: 24),
            SizedBox(
              width: double.infinity,
              height: 50,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.red,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                ),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const HomeScreen()),
                  );
                },
                child: Text(
                  "Log in",
                  style: AppTheme.textTheme.bodyLarge?.copyWith(
                    color: Colors.white,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 16),
            AuthActionText(
              question: "ALREADY HAVE AN ACCOUNT?",
              actionText: "SIGN UP",
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const SignUpScreen()),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
