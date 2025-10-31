import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:namami/providers/app_provider.dart';
import 'package:namami/core/routes/routes.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with TickerProviderStateMixin {
  bool _hasNavigated = false;
  late AnimationController _logoController;
  late Animation<double> _logoAnimation;

  @override
  void initState() {
    super.initState();
    log('Splash screen initialized');

    _logoController = AnimationController(
      duration: const Duration(milliseconds: 800),
      vsync: this,
    );
    _logoAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(parent: _logoController, curve: Curves.easeIn));

    Future.delayed(const Duration(milliseconds: 500), () {
      if (mounted) _logoController.forward();
    });

    _navigateToLogin();
  }

  void _navigateToLogin() {
    if (_hasNavigated) return;

    Future.delayed(const Duration(seconds: 3), () {
      if (mounted && !_hasNavigated) {
        _hasNavigated = true;
        log('Navigating to login...');
        Navigator.of(context).pushReplacementNamed(Routes.login.path);
      }
    });
  }

  @override
  void dispose() {
    _logoController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<ThemeProvider>(
      builder: (context, themeProvider, child) {
        return Scaffold(
          backgroundColor: themeProvider.isDarkMode
              ? Colors.black
              : Colors.white,
          body: Stack(
            children: [
              Image.asset(
                'assets/images/splash_screen1.jpg',

                fit: BoxFit.cover,
                width: double.infinity,
                height: double.infinity,
              ),
              Center(
                child: FadeTransition(
                  opacity: _logoAnimation,
                  child: Image.asset(
                    'assets/images/namami_logo2.png',
                    width: MediaQuery.of(context).size.width * 0.5,
                    height: MediaQuery.of(context).size.width * 0.5,
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
