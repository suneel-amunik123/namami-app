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
  String selectedCountryCode = '+91';
  String selectedFlagImage = 'assets/images/indian_flag.jpg';
  bool isDropdownOpen = false;

  final List<Map<String, String>> countries = [
    {'code': '+91', 'flag': 'assets/images/indian_flag.jpg', 'name': 'India'},
    {'code': '+1', 'flag': 'assets/images/usa_flag2.jpg', 'name': 'USA'},
    {'code': '+44', 'flag': 'assets/images/uk_flag.png', 'name': 'UK'},
    {'code': '+61', 'flag': 'assets/images/austraila.png', 'name': 'Australia'},
  ];

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
                        color: Color(0xFFE47F25),
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
                      height: 8,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(4),
                        color: isActive
                            ? const Color(0xFFE47F25)
                            : Colors.white.withOpacity(0.6),
                        boxShadow: isActive
                            ? [
                                BoxShadow(
                                  color: const Color(
                                    0xFFE47F25,
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
                              fontSize: 25,
                              fontWeight: FontWeight.bold,
                              // color: Color(0xFF6A1B9A),
                              color: Color.fromARGB(255, 8, 8, 8),
                            ),
                          ),
                        ),
                        const SizedBox(height: 15),
                        const Text(
                          'Enter Phone Number',
                          style: TextStyle(fontSize: 16, color: Colors.grey),
                        ),
                        const SizedBox(height: 8),
                        // Phone Input
                        Container(
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.grey[300]!),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Row(
                            children: [
                              GestureDetector(
                                onTap: () {
                                  setState(() {
                                    isDropdownOpen = !isDropdownOpen;
                                  });
                                },
                                child: Container(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 12,
                                    vertical: 14,
                                  ),
                                  child: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Image.asset(
                                        selectedFlagImage,
                                        width:
                                            MediaQuery.of(context).size.width *
                                            0.08,
                                        height:
                                            MediaQuery.of(context).size.width *
                                            0.08,
                                        errorBuilder:
                                            (context, error, stackTrace) {
                                              return Container(
                                                width:
                                                    MediaQuery.of(
                                                      context,
                                                    ).size.width *
                                                    0.06,
                                                height:
                                                    MediaQuery.of(
                                                      context,
                                                    ).size.width *
                                                    0.04,
                                                color: Color(0xFFE47F25),
                                                child: Icon(
                                                  Icons.flag,
                                                  size:
                                                      MediaQuery.of(
                                                        context,
                                                      ).size.width *
                                                      0.03,
                                                  color: Colors.white,
                                                ),
                                              );
                                            },
                                      ),
                                      SizedBox(
                                        width:
                                            MediaQuery.of(context).size.width *
                                            0.02,
                                      ),
                                      Text(
                                        selectedCountryCode,
                                        style: TextStyle(
                                          fontSize:
                                              MediaQuery.of(
                                                context,
                                              ).size.width *
                                              0.04,
                                        ),
                                      ),
                                      SizedBox(
                                        width:
                                            MediaQuery.of(context).size.width *
                                            0.01,
                                      ),
                                      Icon(
                                        isDropdownOpen
                                            ? Icons.keyboard_arrow_up
                                            : Icons.keyboard_arrow_down,
                                        size:
                                            MediaQuery.of(context).size.width *
                                            0.05,
                                        color: Colors.grey[600],
                                      ),
                                    ],
                                  ),
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
                        if (isDropdownOpen)
                          Container(
                            margin: const EdgeInsets.only(top: 8),
                            decoration: BoxDecoration(
                              border: Border.all(color: Colors.grey[300]!),
                              borderRadius: BorderRadius.circular(8),
                              color: Colors.white,
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withOpacity(0.1),
                                  blurRadius: 4,
                                  offset: const Offset(0, 2),
                                ),
                              ],
                            ),
                            child: Column(
                              children: countries.map((country) {
                                return GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      selectedCountryCode = country['code']!;
                                      selectedFlagImage = country['flag']!;
                                      isDropdownOpen = false;
                                    });
                                  },
                                  child: Container(
                                    padding: EdgeInsets.symmetric(
                                      horizontal:
                                          MediaQuery.of(context).size.width *
                                          0.04,
                                      vertical:
                                          MediaQuery.of(context).size.width *
                                          0.03,
                                    ),
                                    decoration: BoxDecoration(
                                      border: Border(
                                        bottom: BorderSide(
                                          color: Colors.grey[200]!,
                                          width: 0.5,
                                        ),
                                      ),
                                    ),
                                    child: Row(
                                      children: [
                                        Image.asset(
                                          country['flag']!,
                                          width:
                                              MediaQuery.of(
                                                context,
                                              ).size.width *
                                              0.06,
                                          height:
                                              MediaQuery.of(
                                                context,
                                              ).size.width *
                                              0.04,
                                          errorBuilder:
                                              (context, error, stackTrace) {
                                                return Container(
                                                  width:
                                                      MediaQuery.of(
                                                        context,
                                                      ).size.width *
                                                      0.06,
                                                  height:
                                                      MediaQuery.of(
                                                        context,
                                                      ).size.width *
                                                      0.04,
                                                  color: Colors.orange,
                                                  child: Icon(
                                                    Icons.flag,
                                                    size:
                                                        MediaQuery.of(
                                                          context,
                                                        ).size.width *
                                                        0.03,
                                                    color: Colors.white,
                                                  ),
                                                );
                                              },
                                        ),
                                        SizedBox(
                                          width:
                                              MediaQuery.of(
                                                context,
                                              ).size.width *
                                              0.03,
                                        ),
                                        Text(
                                          '${country['code']} ${country['name']}',
                                          style: TextStyle(
                                            fontSize:
                                                MediaQuery.of(
                                                  context,
                                                ).size.width *
                                                0.04,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                );
                              }).toList(),
                            ),
                          ),
                        const SizedBox(height: 40),
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
                              backgroundColor: const Color(0xFFE47F25),
                              padding: const EdgeInsets.symmetric(vertical: 0),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20),
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
                        const SizedBox(height: 55),
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
                                    color: Color(0xFFE47F25),
                                    decoration: TextDecoration.underline,
                                  ),
                                ),
                                TextSpan(text: ' and '),
                                TextSpan(
                                  text: 'Privacy Policy',
                                  style: TextStyle(
                                    color: Color(0xFFE47F25),
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
