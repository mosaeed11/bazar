import 'package:bazar/screens/auth/auth_styles.dart';
import 'package:bazar/services/app_prefs.dart';
import 'package:bazar/widgets/auth_button.dart';
import 'package:flutter/material.dart';

class CongratulationScreen extends StatelessWidget {
  const CongratulationScreen({super.key});

  Future<void> _handleGetStarted(BuildContext context) async {
    await AppPrefs.setSeenOnboarding(true);
    if (!context.mounted) return;
    Navigator.pushNamedAndRemoveUntil(context, '/home', (route) => false);
  }

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: buildAuthTheme(),
      child: Scaffold(
        body: SafeArea(
          child: LayoutBuilder(
            builder: (context, constraints) {
              return SingleChildScrollView(
                padding: const EdgeInsets.symmetric(
                  horizontal: 24,
                  vertical: 32,
                ),
                child: ConstrainedBox(
                  constraints: BoxConstraints(
                    minHeight: constraints.maxHeight - 64,
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const _CelebrationIllustration(),
                      const SizedBox(height: 32),
                      const Text(
                        'Congratulation!',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 26,
                          fontWeight: FontWeight.bold,
                          color: AppColors.textPrimary,
                        ),
                      ),
                      const SizedBox(height: 8),
                      const Text(
                        'your account is complete, please enjoy the\nbest menu from us.',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 14,
                          color: AppColors.textSecondary,
                        ),
                      ),
                      const SizedBox(height: 40),
                      AuthButton(
                        label: 'Get Started',
                        onPressed: () => _handleGetStarted(context),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}

class _CelebrationIllustration extends StatelessWidget {
  const _CelebrationIllustration();

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 160,
      height: 160,
      child: Image.asset(
        'assets/images/celebration.png',
        fit: BoxFit.contain,
        errorBuilder: (context, error, stack) => const _CelebrationPlaceholder(),
      ),
    );
  }
}

class _CelebrationPlaceholder extends StatelessWidget {
  const _CelebrationPlaceholder();

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 120,
      height: 120,
      child: Stack(
        alignment: Alignment.center,
        children: [
          Positioned(
            top: 2,
            right: 10,
            child: Icon(Icons.star, size: 20, color: Colors.amber.shade400),
          ),
          Positioned(
            top: 14,
            left: 6,
            child: Icon(Icons.star, size: 14, color: Colors.amber.shade300),
          ),
          Positioned(
            bottom: 8,
            right: 2,
            child: Icon(Icons.star, size: 12, color: Colors.amber.shade500),
          ),
          Container(
            width: 104,
            height: 104,
            decoration: BoxDecoration(
              color: const Color(0xFFECE6FF),
              borderRadius: BorderRadius.circular(24),
              border: Border.all(color: AppColors.primary, width: 1.5),
            ),
            alignment: Alignment.center,
            child: const Icon(
              Icons.card_giftcard,
              size: 56,
              color: AppColors.primary,
            ),
          ),
        ],
      ),
    );
  }
}