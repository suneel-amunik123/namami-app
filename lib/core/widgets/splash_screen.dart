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

class _SplashScreenState extends State<SplashScreen> {
  bool _hasNavigated = false;

  @override
  void initState() {
    super.initState();
    log('Splash screen initialized');
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
          body: Center(
            child: Image.asset(
              'assets/images/splashscreen.png',
              fit: BoxFit.contain,
            ),
          ),
        );
      },
    );
  }
}
