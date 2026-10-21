import 'dart:async';

import 'package:bazar/onboarding1.dart';
import 'package:bazar/services/app_prefs.dart';
import 'package:flutter/material.dart';

class Splash extends StatefulWidget {
  const Splash({super.key});

  @override
  State<Splash> createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    _timer = Timer(const Duration(seconds: 2), _routeNext);
  }

  Future<void> _routeNext() async {
    final seenOnboarding = await AppPrefs.hasSeenOnboarding();
    if (!mounted) return;

    if (seenOnboarding) {
      Navigator.pushNamedAndRemoveUntil(context, '/home', (route) => false);
    } else {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const Onboardingone()),
      );
    }
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Color(0xFF54408C),
        child: Stack(
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset("assets/images/logo.png"),
                    Text(
                      "Bazar.",
                      style: TextStyle(color: Colors.white, fontSize: 24),
                    ),
                  ],
                ),
              ],
            ),
            Positioned(
              left: 0,
              bottom: 0,
              child: Image.asset("assets/images/logo_placholder.png"),
            ),
          ],
        ),
      ),
    );
  }
}