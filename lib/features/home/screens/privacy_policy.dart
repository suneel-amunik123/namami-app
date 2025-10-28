import 'package:flutter/material.dart';

class PrivacyPolicyScreen extends StatelessWidget {
  const PrivacyPolicyScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: const Icon(Icons.arrow_back, color: Colors.black),
        ),
        title: const Text(
          'Privacy Policy',
          style: TextStyle(
            color: Color(0xFFFF9800),
            fontSize: 18,
            fontWeight: FontWeight.w600,
          ),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Last Updated
            const Text(
              'Last updated: 12-02-2024',
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 16),

            // Introduction
            const Text(
              'This Privacy Policy explains how we collect, use, and protect your information when you use our Pujari Booking App.',
              style: TextStyle(fontSize: 14, height: 1.5),
            ),
            const SizedBox(height: 8),
            const Text(
              'By using the App, you agree to the terms described below.',
              style: TextStyle(fontSize: 14, height: 1.5),
            ),
            const SizedBox(height: 16),

            // Information We Collect
            _buildSection('Information We Collect', 'We collect information to provide better services to both Pujaris and Users (Devotees):'),
            
            _buildSubSection('a) Personal Information (for Pujaris)'),
            _buildBulletPoint('Name'),
            _buildBulletPoint('Phone number'),
            _buildBulletPoint('Email ID (if provided)'),
            _buildBulletPoint('Address / City'),
            _buildBulletPoint('Languages known'),
            _buildBulletPoint('Puja services offered and their prices'),
            _buildBulletPoint('Experience details'),
            _buildBulletPoint('Verification documents (ID proof, certificates, etc.)'),
            
            _buildSubSection('b) Booking & Transaction Data'),
            _buildBulletPoint('Puja booking details (date, time, location, mode)'),
            _buildBulletPoint('Payment amount and status'),
            _buildBulletPoint('Ratings and reviews'),
            
            _buildSubSection('c) Device & App Usage Data'),
            _buildBulletPoint('Device information and operating system'),
            _buildBulletPoint('App version and usage statistics'),
            _buildBulletPoint('IP address and general location'),
            const SizedBox(height: 16),

            // How We Use Your Data
            _buildSection('How We Use Your Data', 'We use your data to:'),
            _buildBulletPoint('Create and manage your Pujari profile'),
            _buildBulletPoint('Display your services to potential devotees'),
            _buildBulletPoint('Facilitate puja bookings and payments'),
            _buildBulletPoint('Send notifications, reminders, and booking updates'),
            _buildBulletPoint('Verify user identity and ensure service authenticity'),
            _buildBulletPoint('Improve user experience and security'),
            const SizedBox(height: 16),

            // Information Sharing
            _buildSection('Information Sharing', 'We do not sell your personal data.\nWe may share limited information only in these cases:'),
            _buildBulletPoint('With users (devotees) who book your puja (eg., your name, language, and contact)'),
            _buildBulletPoint('With service providers for OTP, payment, and verification'),
            _buildBulletPoint('When required by law or government authorities'),
            const SizedBox(height: 16),

            // Data Security
            _buildSection('Data Security', 'We use secure servers and encryption to protect your personal data.\nHowever, no online system is 100% secure — we take all reasonable steps to keep your data safe.'),
            const SizedBox(height: 16),

            // Your Rights
            _buildSection('Your Rights', 'As a Pujari, you can:'),
            _buildBulletPoint('View or edit your profile details anytime'),
            _buildBulletPoint('Update your phone number or puja services'),
            _buildBulletPoint('Request account deletion or data removal by contacting support'),
            const SizedBox(height: 16),

            // Cookies & Analytics
            _buildSection('Cookies & Analytics', 'We may use analytics tools or cookies to improve app performance and understand usage patterns.\nThis data is anonymous and does not identify you personally.'),
            const SizedBox(height: 16),

            // Third-Party Services
            _buildSection('Third-Party Services', 'Our app may include third-party tools (like payment gateways, OTP services, or Google Maps).\nEach of these services follows its own privacy policy — we encourage you to review them.'),
            const SizedBox(height: 16),

            // Children's Privacy
            _buildSection('Children\'s Privacy', 'Our services are not directed toward children under 13 years old.\nIf we learn that a child has registered, their account will be removed.'),
            const SizedBox(height: 16),

            // Updates to This Policy
            _buildSection('Updates to This Policy', 'We may update this Privacy Policy from time to time.\nWhen we do, we will update the "Last Updated" date at the top.'),
            const SizedBox(height: 16),

            // Contact Us
            _buildSection('Contact Us', 'If you have any questions or concerns about this Privacy Policy, please contact us at:'),
            const SizedBox(height: 8),
            Row(
              children: [
                const Icon(Icons.email, color: Color(0xFFFF9800), size: 16),
                const SizedBox(width: 8),
                const Text(
                  'support@pujaribookingapp.com',
                  style: TextStyle(
                    fontSize: 14,
                    color: Color(0xFFFF9800),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            Row(
              children: [
                const Icon(Icons.phone, color: Color(0xFFFF9800), size: 16),
                const SizedBox(width: 8),
                const Text(
                  '+91 90000 00000',
                  style: TextStyle(
                    fontSize: 14,
                    color: Color(0xFFFF9800),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 24),
          ],
        ),
      ),
    );
  }

  Widget _buildSection(String title, String content) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600,
          ),
        ),
        if (content.isNotEmpty) ...[
          const SizedBox(height: 8),
          Text(
            content,
            style: const TextStyle(fontSize: 14, height: 1.5),
          ),
        ],
      ],
    );
  }

  Widget _buildSubSection(String title) {
    return Padding(
      padding: const EdgeInsets.only(top: 8, bottom: 4),
      child: Text(
        title,
        style: const TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }

  Widget _buildBulletPoint(String text) {
    return Padding(
      padding: const EdgeInsets.only(left: 16, bottom: 4),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('• ', style: TextStyle(fontSize: 14)),
          Expanded(
            child: Text(
              text,
              style: const TextStyle(fontSize: 14, height: 1.5),
            ),
          ),
        ],
      ),
    );
  }
}