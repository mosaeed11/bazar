import 'package:flutter/material.dart';

const String appFontFamily = 'Audiowide';

class AppColors {
  static const Color primary = Color(0xFF54408C);
  static const Color background = Color(0xFFFFFFFF);
  static const Color cardBackground = Color.fromARGB(255, 224, 224, 252);
  static const Color inputBorder = Color(0xFFE0E0E0);
  static const Color textPrimary = Color(0xFF1A1A1A);
  static const Color textSecondary = Color(0xFF9E9E9E);
  static const Color error = Color(0xFFE53935);
  static const Color rating = Color(0xFFFFC107);
  static const Color vendorName = Color(0xFFF4A000);
}

ThemeData buildAuthTheme() {
  return ThemeData(
    useMaterial3: true,
    fontFamily: appFontFamily,
    colorScheme: ColorScheme.fromSeed(seedColor: AppColors.primary),
    scaffoldBackgroundColor: AppColors.background,
  );
}

InputDecoration buildAuthInputDecoration({
  required String hintText,
  Widget? suffixIcon,
  Widget? prefixIcon,
}) {
  return InputDecoration(
    hintText: hintText,
    hintStyle: const TextStyle(color: AppColors.textSecondary),
    prefixIcon: prefixIcon,
    suffixIcon: suffixIcon,
    contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
    enabledBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(8),
      borderSide: const BorderSide(color: AppColors.inputBorder),
    ),
    focusedBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(8),
      borderSide: const BorderSide(color: AppColors.primary, width: 1.5),
    ),
  );
}

class AuthFieldLabel extends StatelessWidget {
  const AuthFieldLabel(this.text, {super.key});

  final String text;

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: const TextStyle(
        fontSize: 14,
        fontWeight: FontWeight.w500,
        color: AppColors.textPrimary,
      ),
    );
  }
}