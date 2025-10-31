import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'mobile_otp_screen.dart';

class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen({super.key});

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  final _nameController = TextEditingController(text: 'Ramesh');
  final _mobileController = TextEditingController(text: '9876543210');
  final _emailController = TextEditingController(text: 'Ramesh@gmail.com');
  final _addressController = TextEditingController(text: 'Hyderabad');
  final _bioController = TextEditingController();

  bool _isVerified = false;
  String _selectedExperience = '4 - 6 years';
  String _selectedLanguage = 'Hindi, Sanskrit';
  
  String? _nameError;
  String? _mobileError;
  String? _emailError;

  void _validateName(String value) {
    setState(() {
      _nameError = value.length < 2 ? 'Please enter minimum 2 characters' : null;
    });
  }

  void _validateMobile(String value) {
    setState(() {
      _mobileError = value.length != 10 ? 'Enter 10 digit mobile number' : null;
    });
  }

  void _validateEmail(String value) {
    setState(() {
      _emailError = !RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(value)
          ? 'Enter valid email address' : null;
    });
  }

  final List<String> _experienceOptions = [
    '1 - 3 years',
    '4 - 6 years',
    '7 - 10 years',
    '10+ years',
  ];

  final List<String> _languageOptions = [
    'Hindi, Sanskrit',
    'English, Hindi',
    'Telugu, Hindi',
    'Tamil, Sanskrit',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Color(0xFFE47F25)),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          'Edit Profile',
          style: TextStyle(
            color: const Color(0xFFE47F25),
            fontSize: MediaQuery.of(context).size.width * 0.045,
            fontWeight: FontWeight.w600,
          ),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(MediaQuery.of(context).size.width * 0.04),

        child: Container(
          padding: EdgeInsets.all(MediaQuery.of(context).size.width * 0.04),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(MediaQuery.of(context).size.width * 0.03),
            border: Border.all(color: const Color(0xFFE47F25), width: 1),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildValidatedTextField('Name *', _nameController, _validateName, _nameError),
              SizedBox(height: MediaQuery.of(context).size.width * 0.04),
              _buildMobileField(),
              SizedBox(height: MediaQuery.of(context).size.width * 0.04),
              _buildValidatedTextField('Email *', _emailController, _validateEmail, _emailError, TextInputType.emailAddress),
              const SizedBox(height: 16),
              _buildDropdownField(
                'Experience *',
                _selectedExperience,
                _experienceOptions,
                (value) {
                  setState(() => _selectedExperience = value!);
                },
              ),
              const SizedBox(height: 16),
              _buildDropdownField(
                'Languages Known *',
                _selectedLanguage,
                _languageOptions,
                (value) {
                  setState(() => _selectedLanguage = value!);
                },
              ),
              const SizedBox(height: 16),
              _buildTextField('Address *', _addressController),
              const SizedBox(height: 16),
              _buildBioField(),
              const SizedBox(height: 32),
              SizedBox(
                width: double.infinity,
                height: MediaQuery.of(context).size.width * 0.12,
                child: ElevatedButton(
                  onPressed: _nameError == null && _mobileError == null && _emailError == null &&
                      _nameController.text.isNotEmpty && _mobileController.text.isNotEmpty &&
                      _emailController.text.isNotEmpty
                      ? () => Navigator.pop(context)
                      : null,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFFE47F25),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(MediaQuery.of(context).size.width * 0.06),
                    ),
                  ),
                  child: Text(
                    'Update Profile',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: MediaQuery.of(context).size.width * 0.04,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildValidatedTextField(
    String label,
    TextEditingController controller,
    Function(String) validator,
    String? errorText,
    [TextInputType? keyboardType]
  ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(
            fontSize: MediaQuery.of(context).size.width * 0.035,
            fontWeight: FontWeight.w500,
            color: Colors.black87,
          ),
        ),
        SizedBox(height: MediaQuery.of(context).size.width * 0.02),
        TextFormField(
          controller: controller,
          keyboardType: keyboardType,
          onChanged: validator,
          decoration: InputDecoration(
            filled: true,
            fillColor: Colors.grey.shade100,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(MediaQuery.of(context).size.width * 0.02),
              borderSide: BorderSide.none,
            ),
            errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(MediaQuery.of(context).size.width * 0.02),
              borderSide: const BorderSide(color: Colors.red),
            ),
            contentPadding: EdgeInsets.symmetric(
              horizontal: MediaQuery.of(context).size.width * 0.04,
              vertical: MediaQuery.of(context).size.width * 0.03,
            ),
            errorText: errorText,
          ),
        ),
      ],
    );
  }

  Widget _buildTextField(String label, TextEditingController controller) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(
            fontSize: MediaQuery.of(context).size.width * 0.035,
            fontWeight: FontWeight.w500,
            color: Colors.black87,
          ),
        ),
        SizedBox(height: MediaQuery.of(context).size.width * 0.02),
        TextFormField(
          controller: controller,
          decoration: InputDecoration(
            filled: true,
            fillColor: Colors.grey.shade100,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(MediaQuery.of(context).size.width * 0.02),
              borderSide: BorderSide.none,
            ),
            contentPadding: EdgeInsets.symmetric(
              horizontal: MediaQuery.of(context).size.width * 0.04,
              vertical: MediaQuery.of(context).size.width * 0.03,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildMobileField() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Mobile Number *',
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w500,
            color: Colors.black87,
          ),
        ),
        const SizedBox(height: 8),
        Row(
          children: [
            Expanded(
              child: TextFormField(
                controller: _mobileController,
                keyboardType: TextInputType.phone,
                maxLength: 10,
                onChanged: _validateMobile,
                inputFormatters: [
                  FilteringTextInputFormatter.digitsOnly,
                  LengthLimitingTextInputFormatter(10),
                ],
                decoration: InputDecoration(
                  prefixText: '+91 ',
                  prefixStyle: const TextStyle(
                    color: Colors.black87,
                    fontWeight: FontWeight.w500,
                  ),
                  filled: true,
                  fillColor: Colors.grey.shade100,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: BorderSide.none,
                  ),
                  errorBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: const BorderSide(color: Colors.red),
                  ),
                  contentPadding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 12,
                  ),
                  counterText: '',
                  errorText: _mobileError,
                ),
              ),
            ),
            const SizedBox(width: 12),
            SizedBox(
              height: 48,
              child: ElevatedButton(
                onPressed: () async {
                  if (_isVerified) return;
                  final result = await Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const MobileOtpScreen(),
                    ),
                  );
                  if (result == true) {
                    setState(() => _isVerified = true);
                  }
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: _isVerified
                      ? Colors.green
                      : const Color(0xFFE47f25),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(25),
                  ),
                ),
                child: Text(
                  _isVerified ? 'Verified' : 'Send OTP',
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildDropdownField(
    String label,
    String value,
    List<String> options,
    ValueChanged<String?> onChanged,
  ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w500,
            color: Colors.black87,
          ),
        ),
        const SizedBox(height: 8),
        DropdownButtonFormField<String>(
          value: value,
          decoration: InputDecoration(
            filled: true,
            fillColor: Colors.grey.shade100,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: BorderSide.none,
            ),
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 16,
              vertical: 12,
            ),
          ),
          items: options.map((String option) {
            return DropdownMenuItem<String>(value: option, child: Text(option));
          }).toList(),
          onChanged: onChanged,
        ),
      ],
    );
  }

  Widget _buildBioField() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Bio(Optional)',
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w500,
            color: Colors.black87,
          ),
        ),
        const SizedBox(height: 8),
        TextFormField(
          controller: _bioController,
          maxLines: 3,
          decoration: InputDecoration(
            hintText: 'Enter Bio',
            filled: true,
            fillColor: Colors.grey.shade100,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: BorderSide.none,
            ),
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 16,
              vertical: 12,
            ),
          ),
        ),
      ],
    );
  }
}
