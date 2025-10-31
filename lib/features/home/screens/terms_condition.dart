import 'package:flutter/material.dart';

class TermsConditionScreen extends StatelessWidget {
  const TermsConditionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final isTablet = screenWidth > 600;
    
    // Responsive values
    final horizontalPadding = isTablet ? screenWidth * 0.1 : 16.0;
    final maxContentWidth = isTablet ? 800.0 : double.infinity;
    final titleFontSize = isTablet ? 22.0 : 18.0;
    
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: Icon(
            Icons.arrow_back, 
            color: Colors.black,
            size: isTablet ? 28 : 24,
          ),
        ),
        title: Text(
          'Terms & Condition',
          style: TextStyle(
            color: const Color(0xFFE47F25),
            fontSize: titleFontSize,
            fontWeight: FontWeight.w600,
          ),
        ),
        centerTitle: true,
      ),
      body: Center(
        child: ConstrainedBox(
          constraints: BoxConstraints(maxWidth: maxContentWidth),
          child: SingleChildScrollView(
            padding: EdgeInsets.symmetric(
              horizontal: horizontalPadding,
              vertical: 16.0,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Last Updated
                Text(
                  'Last updated: 12-02-2024',
                  style: TextStyle(
                    fontSize: _getResponsiveFontSize(context, 14), 
                    fontWeight: FontWeight.w600,
                  ),
                ),
                SizedBox(height: _getResponsiveSpacing(context, 16)),

                // Welcome Section
                Text(
                  'Welcome to Pujari Booking App ("App", "we", "our", "us")',
                  style: TextStyle(
                    fontSize: _getResponsiveFontSize(context, 14), 
                    fontWeight: FontWeight.w600,
                  ),
                ),
                SizedBox(height: _getResponsiveSpacing(context, 8)),
                Text(
                  'By accessing or using our app, you agree to these Terms and Conditions.\nPlease read them carefully before using the service.',
                  style: TextStyle(
                    fontSize: _getResponsiveFontSize(context, 14), 
                    height: 1.5,
                  ),
                ),
                SizedBox(height: _getResponsiveSpacing(context, 16)),

                // About the App
                _buildSection(
                  'About the App',
                  'The Pujari Booking App connects devotees (users) with Pujaris for performing various religious and spiritual services, either online or in person.\nThe app allows:',
                ),
                _buildBulletPoint(
                  'Pujaris to register, list their services, and set prices.',
                ),
                _buildBulletPoint('Users to browse, book, and rate pujas'),
                _buildBulletPoint('Secure communication and booking management'),
                SizedBox(height: _getResponsiveSpacing(context, 16)),

                // Account Registration
                _buildSection('Account Registration', ''),
                _buildSubSection('a) For Pujaris:'),
                _buildBulletPoint(
                  'You must provide accurate personal details (name, phone number, experience, languages, etc.).',
                ),
                _buildBulletPoint(
                  'Verification may be required through official ID proof or temple certification.',
                ),
                _buildBulletPoint(
                  'You are responsible for maintaining your profile information up to date.',
                ),
                _buildSubSection('b) For Devotees:'),
                _buildBulletPoint(
                  'Users must provide a valid phone number for OTP login and communication.',
                ),
                _buildBulletPoint(
                  'We reserve the right to suspend or remove any account if false, misleading, or inappropriate information is provided.',
                ),
                SizedBox(height: _getResponsiveSpacing(context, 16)),

                // Booking Process
                _buildSection('Booking Process', ''),
                _buildBulletPoint(
                  'Devotees can browse available Pujaris and book services.',
                ),
                _buildBulletPoint(
                  'Each booking will include puja type, date, time, location/mode, and payment details.',
                ),
                _buildBulletPoint(
                  'Pujaris must accept, reject, or reschedule bookings promptly.',
                ),
                _buildBulletPoint(
                  'Both parties should maintain respectful and timely communication.',
                ),
                SizedBox(height: _getResponsiveSpacing(context, 16)),

                // Payments
                _buildSection('Payments', ''),
                _buildBulletPoint(
                  'All puja charges are displayed clearly before confirmation.',
                ),
                _buildBulletPoint(
                  'Payments may be made through integrated payment gateways.',
                ),
                _buildBulletPoint(
                  'The app may charge a small service or convenience fee.',
                ),
                _buildBulletPoint(
                  'Any refunds or cancellations will be handled as per the Cancellation Policy (if applicable).',
                ),
                SizedBox(height: _getResponsiveSpacing(context, 16)),

                // Responsibilities of Pujaris
                _buildSection(
                  'Responsibilities of Pujaris',
                  'By registering as a Pujari, you agree to:',
                ),
                _buildBulletPoint(
                  'Perform services honestly, respectfully, and punctually.',
                ),
                _buildBulletPoint('Not overcharge beyond listed prices.'),
                _buildBulletPoint(
                  'Maintain proper behavior with users and within the app community.',
                ),
                _buildBulletPoint('Comply with local laws and religious ethics.'),
                _buildBulletPoint(
                  'Any misuse of the app or fraudulent activity can result in permanent suspension.',
                ),
                SizedBox(height: _getResponsiveSpacing(context, 16)),

                // Cancellation & Refunds
                _buildSection('Cancellation & Refunds', ''),
                _buildBulletPoint(
                  'Users may cancel a booking as per the app\'s cancellation rules.',
                ),
                _buildBulletPoint(
                  'Refunds (if applicable) will depend on the time of cancellation and payment mode.',
                ),
                _buildBulletPoint(
                  'Pujaris can reschedule bookings if required, but must inform the user in advance.',
                ),
                SizedBox(height: _getResponsiveSpacing(context, 16)),

                // Verification & Ratings
                _buildSection('Verification & Ratings', ''),
                _buildBulletPoint(
                  'Verified Pujaris will display a "Verified Badge" on their profile.',
                ),
                _buildBulletPoint(
                  'Verification requires valid identity proof and admin approval.',
                ),
                _buildBulletPoint(
                  'Users may rate or review Pujaris after each puja.',
                ),
                _buildBulletPoint(
                  'Fake or abusive reviews may be removed by the admin team.',
                ),
                SizedBox(height: _getResponsiveSpacing(context, 16)),

                // Data & Privacy
                _buildSection(
                  'Data & Privacy',
                  'All user and pujari information is protected as per our Privacy Policy.\nBy using the app, you consent to the collection and use of your information in accordance with that policy.',
                ),
                SizedBox(height: _getResponsiveSpacing(context, 16)),

                // Prohibited Activities
                _buildSection('Prohibited Activities', 'You agree not to:'),
                _buildBulletPoint(
                  'Misuse the app for illegal or commercial activities.',
                ),
                _buildBulletPoint(
                  'Impersonate another person or provide false information.',
                ),
                _buildBulletPoint('Harass, abuse, or threaten other users'),
                _buildBulletPoint(
                  'Attempt to hack, copy, or reverse-engineer the app',
                ),
                _buildBulletPoint(
                  'Violation of these terms may result in temporary or permanent ban.',
                ),
                SizedBox(height: _getResponsiveSpacing(context, 16)),

                // Limitation of Liability
                _buildSection(
                  'Limitation of Liability',
                  'The app acts only as a platform to connect devotees and pujaris.\nWe are not responsible for the conduct, timing, or outcome of the pujas.\nAny dispute between Pujari and user should be resolved respectfully between the parties.',
                ),
                SizedBox(height: _getResponsiveSpacing(context, 16)),

                // Changes to Terms
                _buildSection(
                  'Changes to Terms',
                  'We may update these Terms & Conditions occasionally.\nContinued use of the app after changes means you accept the updated terms.\nWe may notify users of major updates.',
                ),
                SizedBox(height: _getResponsiveSpacing(context, 16)),

                // Contact Information
                _buildSection(
                  'For questions, complaints, or feedback, reach out to us:',
                  '',
                ),
                SizedBox(height: _getResponsiveSpacing(context, 8)),
                Wrap(
                  spacing: 8,
                  runSpacing: 8,
                  children: [
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(
                          Icons.email, 
                          color: const Color(0xFFE47F25), 
                          size: _getResponsiveIconSize(context, 16),
                        ),
                        SizedBox(width: _getResponsiveSpacing(context, 8)),
                        Flexible(
                          child: Text(
                            'support@pujaribookingapp.com',
                            style: TextStyle(
                              fontSize: _getResponsiveFontSize(context, 14), 
                              color: const Color(0xFFE47F25),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                SizedBox(height: _getResponsiveSpacing(context, 8)),
                Row(
                  children: [
                    Icon(
                      Icons.phone, 
                      color: const Color(0xFFE47F25), 
                      size: _getResponsiveIconSize(context, 16),
                    ),
                    SizedBox(width: _getResponsiveSpacing(context, 8)),
                    Text(
                      '+91 90000 00000',
                      style: TextStyle(
                        fontSize: _getResponsiveFontSize(context, 14), 
                        color: const Color(0xFFE47F25),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: _getResponsiveSpacing(context, 24)),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // Responsive helper methods
  double _getResponsiveFontSize(BuildContext context, double baseFontSize) {
    final screenWidth = MediaQuery.of(context).size.width;
    if (screenWidth > 600) {
      return baseFontSize * 1.2;
    }
    return baseFontSize;
  }

  double _getResponsiveSpacing(BuildContext context, double baseSpacing) {
    final screenWidth = MediaQuery.of(context).size.width;
    if (screenWidth > 600) {
      return baseSpacing * 1.5;
    }
    return baseSpacing;
  }

  double _getResponsiveIconSize(BuildContext context, double baseSize) {
    final screenWidth = MediaQuery.of(context).size.width;
    if (screenWidth > 600) {
      return baseSize * 1.3;
    }
    return baseSize;
  }

  Widget _buildSection(String title, String content) {
    return Builder(
      builder: (context) => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: TextStyle(
              fontSize: _getResponsiveFontSize(context, 16), 
              fontWeight: FontWeight.w600,
            ),
          ),
          if (content.isNotEmpty) ...[
            SizedBox(height: _getResponsiveSpacing(context, 8)),
            Text(
              content, 
              style: TextStyle(
                fontSize: _getResponsiveFontSize(context, 14), 
                height: 1.5,
              ),
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildSubSection(String title) {
    return Builder(
      builder: (context) => Padding(
        padding: EdgeInsets.only(
          top: _getResponsiveSpacing(context, 8), 
          bottom: _getResponsiveSpacing(context, 4),
        ),
        child: Text(
          title,
          style: TextStyle(
            fontSize: _getResponsiveFontSize(context, 14), 
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }

  Widget _buildBulletPoint(String text) {
    return Builder(
      builder: (context) => Padding(
        padding: EdgeInsets.only(
          left: _getResponsiveSpacing(context, 16), 
          bottom: _getResponsiveSpacing(context, 4),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              '• ', 
              style: TextStyle(fontSize: _getResponsiveFontSize(context, 14)),
            ),
            Expanded(
              child: Text(
                text,
                style: TextStyle(
                  fontSize: _getResponsiveFontSize(context, 14), 
                  height: 1.5,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
