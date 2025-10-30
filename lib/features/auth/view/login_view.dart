import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../provider/login_provider.dart';

class LoginView extends StatefulWidget {
  const LoginView({super.key});

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  @override
  void initState() {
    super.initState();
    log('LoginView initialized successfully');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 95, 90, 90),
      body: Consumer<LoginProvider>(
        builder: (context, loginProvider, child) {
          return Stack(
            children: [
              // Full screen animated images
              Positioned.fill(
                bottom: 350,
                child: AnimatedSwitcher(
                  duration: const Duration(milliseconds: 800),
                  child: Image.asset(
                    loginProvider.currentImage,
                    key: ValueKey(loginProvider.currentImage),
                    width: double.infinity,
                    height: double.infinity,

                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) {
                      return Container(
                        width: double.infinity,
                        height: double.infinity,
                        color: Colors.orange.shade200,
                        child: const Icon(
                          Icons.image_not_supported,
                          size: 100,
                          color: Colors.white,
                        ),
                      );
                    },
                  ),
                ),
              ),
              // Gradient overlay for better visibility
              Positioned.fill(
                child: Container(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                        Colors.transparent,
                        Colors.black.withOpacity(0.3),
                        Colors.black.withOpacity(0.6),
                      ],
                      stops: const [0.0, 0.7, 1.0],
                    ),
                  ),
                ),
              ),
              // Animated Dots indicator
              Positioned(
                bottom: MediaQuery.of(context).size.height * 0.35,
                left: 0,
                right: 0,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: List.generate(4, (index) {
                    bool isActive =
                        loginProvider.loginModel.currentImageIndex == index;
                    return AnimatedContainer(
                      duration: const Duration(milliseconds: 300),
                      margin: const EdgeInsets.symmetric(horizontal: 4),
                      width: isActive ? 12 : 8,
                      height: 4,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(4),
                        color: isActive
                            ? const Color(0xFFFF9800)
                            : Colors.white.withOpacity(0.6),
                        boxShadow: isActive
                            ? [
                                BoxShadow(
                                  color: const Color(
                                    0xFFFF9800,
                                  ).withOpacity(0.4),
                                  blurRadius: 8,
                                  spreadRadius: 1,
                                ),
                              ]
                            : null,
                      ),
                    );
                  }),
                ),
              ),
              // Login Form Section - Overlapping
              Positioned(
                bottom: 0,
                left: 0,
                right: 0,
                height: MediaQuery.of(context).size.height * 0.48,
                child: Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(24),
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.vertical(
                      top: Radius.circular(40),
                    ),
                  ),
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Center(
                          child: const Text(
                            'Login',
                            style: TextStyle(
                              fontSize: 28,
                              fontWeight: FontWeight.bold,
                              // color: Color(0xFF6A1B9A),
                              color: Color.fromARGB(255, 8, 8, 8),
                            ),
                          ),
                        ),
                        const SizedBox(height: 8),
                        const Text(
                          'Enter Phone Number',
                          style: TextStyle(fontSize: 16, color: Colors.grey),
                        ),
                        const SizedBox(height: 24),
                        // Phone Input
                        Container(
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.grey[300]!),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Row(
                            children: [
                              Container(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 12,
                                  vertical: 16,
                                ),
                                child: Row(
                                  children: [
                                    Image.asset(
                                      'assets/images/indian_flag.jpg',
                                      width: 24,
                                      height: 16,
                                      errorBuilder:
                                          (context, error, stackTrace) {
                                            return Container(
                                              width: 24,
                                              height: 16,
                                              color: Colors.orange,
                                              child: const Icon(
                                                Icons.flag,
                                                size: 12,
                                                color: Colors.white,
                                              ),
                                            );
                                          },
                                    ),
                                    const SizedBox(width: 8),
                                    const Text('+91'),
                                  ],
                                ),
                              ),
                              Container(
                                width: 1,
                                height: 40,
                                color: Colors.grey[300],
                              ),
                              Expanded(
                                child: TextField(
                                  onChanged: loginProvider.updatePhoneNumber,
                                  keyboardType: TextInputType.phone,
                                  decoration: const InputDecoration(
                                    hintText: '9876543210',
                                    border: InputBorder.none,
                                    contentPadding: EdgeInsets.symmetric(
                                      horizontal: 12,
                                      vertical: 16,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 8),
                        // Send OTP Button
                        SizedBox(
                          width: double.infinity,
                          child: ElevatedButton(
                            onPressed: loginProvider.loginModel.isLoading
                                ? null
                                : () {
                                    loginProvider.sendOTP(context);
                                  },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: const Color(0xFFFF9800),
                              padding: const EdgeInsets.symmetric(vertical: 16),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                            ),
                            child: loginProvider.loginModel.isLoading
                                ? const CircularProgressIndicator(
                                    color: Colors.white,
                                  )
                                : const Text(
                                    'Send OTP',
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white,
                                    ),
                                  ),
                          ),
                        ),
                        const SizedBox(height: 20),
                        // Terms and Conditions
                        Center(
                          child: RichText(
                            textAlign: TextAlign.center,
                            text: const TextSpan(
                              style: TextStyle(
                                fontSize: 12,
                                color: Colors.grey,
                              ),
                              children: [
                                TextSpan(
                                  text: 'By continuing, you agree to our\n',
                                ),
                                TextSpan(
                                  text: 'Terms & Conditions',
                                  style: TextStyle(
                                    color: Color(0xFFFF9800),
                                    decoration: TextDecoration.underline,
                                  ),
                                ),
                                TextSpan(text: ' and '),
                                TextSpan(
                                  text: 'Privacy Policy',
                                  style: TextStyle(
                                    color: Color(0xFFFF9800),
                                    decoration: TextDecoration.underline,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
