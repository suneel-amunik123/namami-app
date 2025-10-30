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
      body: SafeArea(
        child: Consumer<LoginProvider>(
          builder: (context, loginProvider, child) {
            return Column(
              children: [
                // Animated Image Section
                Expanded(
                  flex: 3,
                  child: Container(
                    width: double.infinity,
                    // decoration: const BoxDecoration(
                    //   gradient: LinearGradient(
                    //     colors: [Color(0xFFFF9800), Color(0xFFFFB74D)],
                    //     // begin: Alignment.topCenter,
                    //     // end: Alignment.bottomCenter,
                    //   ),
                    // ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        AnimatedSwitcher(
                          duration: const Duration(milliseconds: 500),
                          child: Image.asset(
                            loginProvider.currentImage,
                            key: ValueKey(loginProvider.currentImage),
                            height: 360,
                            fit: BoxFit.fill,

                            errorBuilder: (context, error, stackTrace) {
                              return Container(
                                height: 150,
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
                        // const SizedBox(height: 10),
                        // Row(
                        //   mainAxisAlignment: MainAxisAlignment.center,
                        //   children: List.generate(4, (index) {
                        //     return GestureDetector(
                        //       onTap: () => loginProvider.selectImage(index),
                        //       child: Container(
                        //         margin: const EdgeInsets.symmetric(
                        //           horizontal: 4,
                        //         ),
                        //         width: 12,
                        //         height: 12,
                        //         decoration: BoxDecoration(
                        //           shape: BoxShape.circle,
                        //           color:
                        //               loginProvider
                        //                       .loginModel
                        //                       .currentImageIndex ==
                        //                   index
                        //               ? Colors.white
                        //               : Colors.white.withOpacity(0.5),
                        //         ),
                        //       ),
                        //     );
                        //   }),
                        // ),
                      ],
                    ),
                  ),
                ),
                // Login Form Section
                Expanded(
                  flex: 3,
                  child: Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(24),
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.vertical(
                        top: Radius.circular(30),

                        // top: Radius.elliptical(30, 30),
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
                                padding: const EdgeInsets.symmetric(
                                  vertical: 16,
                                ),
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
                          const Center(
                            child: Text(
                              'By continuing, you agree to our\nTerms & Conditions and Privacy Policy',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: 12,
                                color: Colors.grey,
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
      ),
    );
  }
}
