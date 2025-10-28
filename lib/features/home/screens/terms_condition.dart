import 'package:flutter/material.dart';

class TermsConditionScreen extends StatelessWidget {
  const TermsConditionScreen({super.key});

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
          'Terms & Condition',
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

            // Welcome Section
            const Text(
              'Welcome to Pujari Booking App ("App", "we", "our", "us")',
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 8),
            const Text(
              'By accessing or using our app, you agree to these Terms and Conditions.\nPlease read them carefully before using the service.',
              style: TextStyle(fontSize: 14, height: 1.5),
            ),
            const SizedBox(height: 16),

            // About the App
            _buildSection(
              'About the App',
              'The Pujari Booking App connects devotees (users) with Pujaris for performing various religious and spiritual services, either online or in person.\nThe app allows:',
            ),
            _buildBulletPoint('Pujaris to register, list their services, and set prices.'),
            _buildBulletPoint('Users to browse, book, and rate pujas'),
            _buildBulletPoint('Secure communication and booking management'),
            const SizedBox(height: 16),

            // Account Registration
            _buildSection('Account Registration', ''),
            _buildSubSection('a) For Pujaris:'),
            _buildBulletPoint('You must provide accurate personal details (name, phone number, experience, languages, etc.).'),
            _buildBulletPoint('Verification may be required through official ID proof or temple certification.'),
            _buildBulletPoint('You are responsible for maintaining your profile information up to date.'),
            _buildSubSection('b) For Devotees:'),
            _buildBulletPoint('Users must provide a valid phone number for OTP login and communication.'),
            _buildBulletPoint('We reserve the right to suspend or remove any account if false, misleading, or inappropriate information is provided.'),
            const SizedBox(height: 16),

            // Booking Process
            _buildSection('Booking Process', ''),
            _buildBulletPoint('Devotees can browse available Pujaris and book services.'),
            _buildBulletPoint('Each booking will include puja type, date, time, location/mode, and payment details.'),
            _buildBulletPoint('Pujaris must accept, reject, or reschedule bookings promptly.'),
            _buildBulletPoint('Both parties should maintain respectful and timely communication.'),
            const SizedBox(height: 16),

            // Payments
            _buildSection('Payments', ''),
            _buildBulletPoint('All puja charges are displayed clearly before confirmation.'),
            _buildBulletPoint('Payments may be made through integrated payment gateways.'),
            _buildBulletPoint('The app may charge a small service or convenience fee.'),
            _buildBulletPoint('Any refunds or cancellations will be handled as per the Cancellation Policy (if applicable).'),
            const SizedBox(height: 16),

            // Responsibilities of Pujaris
            _buildSection('Responsibilities of Pujaris', 'By registering as a Pujari, you agree to:'),
            _buildBulletPoint('Perform services honestly, respectfully, and punctually.'),
            _buildBulletPoint('Not overcharge beyond listed prices.'),
            _buildBulletPoint('Maintain proper behavior with users and within the app community.'),
            _buildBulletPoint('Comply with local laws and religious ethics.'),
            _buildBulletPoint('Any misuse of the app or fraudulent activity can result in permanent suspension.'),
            const SizedBox(height: 16),

            // Cancellation & Refunds
            _buildSection('Cancellation & Refunds', ''),
            _buildBulletPoint('Users may cancel a booking as per the app\'s cancellation rules.'),
            _buildBulletPoint('Refunds (if applicable) will depend on the time of cancellation and payment mode.'),
            _buildBulletPoint('Pujaris can reschedule bookings if required, but must inform the user in advance.'),
            const SizedBox(height: 16),

            // Verification & Ratings
            _buildSection('Verification & Ratings', ''),
            _buildBulletPoint('Verified Pujaris will display a "Verified Badge" on their profile.'),
            _buildBulletPoint('Verification requires valid identity proof and admin approval.'),
            _buildBulletPoint('Users may rate or review Pujaris after each puja.'),
            _buildBulletPoint('Fake or abusive reviews may be removed by the admin team.'),
            const SizedBox(height: 16),

            // Data & Privacy
            _buildSection('Data & Privacy', 'All user and pujari information is protected as per our Privacy Policy.\nBy using the app, you consent to the collection and use of your information in accordance with that policy.'),
            const SizedBox(height: 16),

            // Prohibited Activities
            _buildSection('Prohibited Activities', 'You agree not to:'),
            _buildBulletPoint('Misuse the app for illegal or commercial activities.'),
            _buildBulletPoint('Impersonate another person or provide false information.'),
            _buildBulletPoint('Harass, abuse, or threaten other users'),
            _buildBulletPoint('Attempt to hack, copy, or reverse-engineer the app'),
            _buildBulletPoint('Violation of these terms may result in temporary or permanent ban.'),
            const SizedBox(height: 16),

            // Limitation of Liability
            _buildSection('Limitation of Liability', 'The app acts only as a platform to connect devotees and pujaris.\nWe are not responsible for the conduct, timing, or outcome of the pujas.\nAny dispute between Pujari and user should be resolved respectfully between the parties.'),
            const SizedBox(height: 16),

            // Changes to Terms
            _buildSection('Changes to Terms', 'We may update these Terms & Conditions occasionally.\nContinued use of the app after changes means you accept the updated terms.\nWe may notify users of major updates.'),
            const SizedBox(height: 16),

            // Contact Information
            _buildSection('For questions, complaints, or feedback, reach out to us:', ''),
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