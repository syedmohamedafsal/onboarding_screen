import 'dart:async';
import 'package:flutter/material.dart';
import 'package:onboarding_eid_screen/presentation/onboarding/onboarding_screen.dart';
import 'package:rive/rive.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();

    Future.delayed(const Duration(seconds: 5), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const OnboardingScreen()),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Center(
        child: SizedBox(
          height: double.infinity,
          width: double.infinity,
          child: RiveAnimation.asset(
            'assets/rive/elegant-line-mosque-and-moon-design-for-eid-mubarak.riv',
            fit: BoxFit.cover,
            onInit: (_) {},
          ),
        ),
      ),
    );
  }
}
