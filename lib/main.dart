import 'package:bazar/firebase_options.dart';
import 'package:bazar/onboarding1.dart';
import 'package:bazar/screens/auth/auth_styles.dart';
import 'package:bazar/screens/auth/congratulation_screen.dart';
import 'package:bazar/screens/auth/email_verification_screen.dart';
import 'package:bazar/screens/auth/login_screen.dart';
import 'package:bazar/screens/auth/phone_number_screen.dart';
import 'package:bazar/screens/auth/phone_verification_screen.dart';
import 'package:bazar/screens/auth/signup_screen.dart';
import 'package:bazar/screens/home/home_screen.dart';
import 'package:bazar/splash.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const Onboarding1());
}

class Onboarding1 extends StatelessWidget {
  const Onboarding1({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(fontFamily: appFontFamily),
      debugShowCheckedModeBanner: false,

      home: const Splash(),
      routes: {
        '/onboarding': (context) => const Onboardingone(),
        '/login': (context) => const LoginScreen(),
        '/signup': (context) => const SignUpScreen(),
        '/email-verification': (context) {
          final email = ModalRoute.of(context)?.settings.arguments;
          return EmailVerificationScreen(email: email is String ? email : '');
        },
        '/phone-number': (context) => const PhoneNumberScreen(),
        '/phone-verification': (context) {
          final phone = ModalRoute.of(context)?.settings.arguments;
          return PhoneVerificationScreen(phone: phone is String ? phone : '');
        },
        '/congratulation': (context) => const CongratulationScreen(),
        '/home': (context) => const HomeScreen(),
      },
    );
  }
}
