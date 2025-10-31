import 'package:flutter/material.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';

class VerifyAccountScreen extends StatefulWidget {
  const VerifyAccountScreen({super.key});

  @override
  State<VerifyAccountScreen> createState() => _VerifyAccountScreenState();
}

class _VerifyAccountScreenState extends State<VerifyAccountScreen> {
  final _nameController = TextEditingController();
  final _dobController = TextEditingController();
  final _mobileController = TextEditingController(text: '9876543210');

  File? _selectedImage;
  final ImagePicker _picker = ImagePicker();

  DateTime? _selectedDate;
  
  String? _nameError;
  String? _mobileError;
  String? _dobError;
  String? _imageError;

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

  void _validateDob() {
    setState(() {
      _dobError = _selectedDate == null ? 'Please select date of birth' : null;
    });
  }

  void _validateImage() {
    setState(() {
      _imageError = _selectedImage == null ? 'Please upload identity proof' : null;
    });
  }

  Future<void> _selectDate() async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: const ColorScheme.light(primary: Color(0xFFE47F25)),
          ),
          child: child!,
        );
      },
    );

    if (picked != null && picked != _selectedDate) {
      setState(() {
        _selectedDate = picked;
        _dobController.text =
            '${picked.day.toString().padLeft(2, '0')}-${picked.month.toString().padLeft(2, '0')}-${picked.year}';
      });
    }
  }

  void _showImagePicker() {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (BuildContext context) {
        return Container(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text(
                'Select Image Source',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
              ),
              const SizedBox(height: 20),
              ListTile(
                leading: const Icon(Icons.camera_alt, color: Color(0xFFE47F25)),
                title: const Text('Camera'),
                onTap: () {
                  Navigator.pop(context);
                  _pickImage(ImageSource.camera);
                },
              ),
              ListTile(
                leading: const Icon(
                  Icons.photo_library,
                  color: Color(0xFFE47F25),
                ),
                title: const Text('Gallery'),
                onTap: () {
                  Navigator.pop(context);
                  _pickImage(ImageSource.gallery);
                },
              ),
              ListTile(
                leading: const Icon(Icons.folder, color: Color(0xFFE47F25)),
                title: const Text('File Manager'),
                onTap: () {
                  Navigator.pop(context);
                  _pickImage(ImageSource.gallery);
                },
              ),
            ],
          ),
        );
      },
    );
  }

  Future<void> _pickImage(ImageSource source) async {
    try {
      final XFile? image = await _picker.pickImage(source: source);
      if (image != null) {
        final File imageFile = File(image.path);
        final int fileSizeInBytes = await imageFile.length();
        final double fileSizeInMB = fileSizeInBytes / (1024 * 1024);

        if (fileSizeInMB <= 5) {
          setState(() {
            _selectedImage = imageFile;
          });
        } else {
          _showErrorDialog(
            'File size exceeds 5 MB limit. Please select a smaller file.',
          );
        }
      }
    } catch (e) {
      _showErrorDialog('Error picking image: $e');
    }
  }

  void _showErrorDialog(String message) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Error'),
          content: Text(message),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text(
                'OK',
                style: TextStyle(color: Color(0xFFE47F25)),
              ),
            ),
          ],
        );
      },
    );
  }

  void _showSuccessDialog() {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Icon(Icons.check_circle, color: Colors.green, size: 64),
              const SizedBox(height: 16),
              const Text(
                'Your account has been verified successfully',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                  color: Colors.black87,
                ),
              ),
              const SizedBox(height: 24),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                    Navigator.of(context).pop(true);
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFFe47F25),
                    padding: const EdgeInsets.symmetric(vertical: 12),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  child: const Text(
                    'OK',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ),
            ],
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        );
      },
    );
  }

  bool _isFormValid() {
    return _nameController.text.isNotEmpty &&
        _dobController.text.isNotEmpty &&
        _mobileController.text.isNotEmpty &&
        _selectedImage != null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Color(0xFFE47f25)),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          'Verify Account',
          style: TextStyle(
            color: const Color(0xFFE47f25),
            fontSize: MediaQuery.of(context).size.width * 0.045,
            fontWeight: FontWeight.w600,
          ),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(MediaQuery.of(context).size.width * 0.04),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Professional Details',
              style: TextStyle(
                fontSize: MediaQuery.of(context).size.width * 0.04,
                fontWeight: FontWeight.w600,
                color: const Color(0xFFE47F25),
              ),
            ),
            SizedBox(height: MediaQuery.of(context).size.width * 0.05),
            _buildValidatedTextField('Full Name *', _nameController, 'Enter Name', _validateName, _nameError),
            SizedBox(height: MediaQuery.of(context).size.width * 0.04),
            _buildDateField(),
            SizedBox(height: MediaQuery.of(context).size.width * 0.04),
            _buildValidatedTextField('Mobile Number *', _mobileController, '9876543210', _validateMobile, _mobileError, TextInputType.phone, 10),
            SizedBox(height: MediaQuery.of(context).size.width * 0.05),
            Text(
              'Identity Proof',
              style: TextStyle(
                fontSize: MediaQuery.of(context).size.width * 0.04,
                fontWeight: FontWeight.w600,
                color: const Color(0xFFE47F25),
              ),
            ),
            SizedBox(height: MediaQuery.of(context).size.width * 0.02),
            Text(
              'Aadhar Card or PAN Card',
              style: TextStyle(
                fontSize: MediaQuery.of(context).size.width * 0.035,
                color: Colors.black54,
              ),
            ),
            SizedBox(height: MediaQuery.of(context).size.width * 0.03),
            _buildUploadField(),
            if (_imageError != null)
              Padding(
                padding: EdgeInsets.only(top: MediaQuery.of(context).size.width * 0.02),
                child: Text(
                  _imageError!,
                  style: TextStyle(
                    color: Colors.red,
                    fontSize: MediaQuery.of(context).size.width * 0.03,
                  ),
                ),
              ),
            SizedBox(height: MediaQuery.of(context).size.width * 0.08),
            SizedBox(
              width: double.infinity,
              height: MediaQuery.of(context).size.width * 0.12,
              child: ElevatedButton(
                onPressed: _isFormValid() && _nameError == null && _mobileError == null
                    ? () {
                        _validateDob();
                        _validateImage();
                        if (_dobError == null && _imageError == null) {
                          _showSuccessDialog();
                        }
                      }
                    : null,
                style: ElevatedButton.styleFrom(
                  backgroundColor: _isFormValid()
                      ? const Color(0xFFE47F25)
                      : Colors.grey,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(MediaQuery.of(context).size.width * 0.06),
                  ),
                ),
                child: Text(
                  'Submit',
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
    );
  }

  Widget _buildValidatedTextField(
    String label,
    TextEditingController controller,
    String hint,
    Function(String) validator,
    String? errorText,
    [TextInputType? keyboardType,
    int? maxLength]
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
          maxLength: maxLength,
          onChanged: validator,
          decoration: InputDecoration(
            hintText: hint,
            filled: true,
            fillColor: Colors.grey.shade100,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(MediaQuery.of(context).size.width * 0.02),
              borderSide: BorderSide.none,
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(MediaQuery.of(context).size.width * 0.02),
              borderSide: const BorderSide(color: Color(0xFFE47F25)),
            ),
            errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(MediaQuery.of(context).size.width * 0.02),
              borderSide: const BorderSide(color: Colors.red),
            ),
            contentPadding: EdgeInsets.symmetric(
              horizontal: MediaQuery.of(context).size.width * 0.04,
              vertical: MediaQuery.of(context).size.width * 0.03,
            ),
            counterText: '',
            errorText: errorText,
          ),
        ),
      ],
    );
  }

  Widget _buildTextField(
    String label,
    TextEditingController controller,
    String hint,
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
          decoration: InputDecoration(
            hintText: hint,
            filled: true,
            fillColor: Colors.grey.shade100,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(MediaQuery.of(context).size.width * 0.02),
              borderSide: BorderSide.none,
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(MediaQuery.of(context).size.width * 0.02),
              borderSide: const BorderSide(color: Color(0xFFE47F25)),
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

  Widget _buildDateField() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Date of birth*',
          style: TextStyle(
            fontSize: MediaQuery.of(context).size.width * 0.035,
            fontWeight: FontWeight.w500,
            color: Colors.black87,
          ),
        ),
        SizedBox(height: MediaQuery.of(context).size.width * 0.02),
        GestureDetector(
          onTap: _selectDate,
          child: AbsorbPointer(
            child: TextFormField(
              controller: _dobController,
              decoration: InputDecoration(
                hintText: 'dd-mm-yyyy',
                filled: true,
                fillColor: Colors.grey.shade100,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(MediaQuery.of(context).size.width * 0.02),
                  borderSide: BorderSide.none,
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(MediaQuery.of(context).size.width * 0.02),
                  borderSide: const BorderSide(color: Color(0xFFE47F25)),
                ),
                errorBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(MediaQuery.of(context).size.width * 0.02),
                  borderSide: const BorderSide(color: Colors.red),
                ),
                contentPadding: EdgeInsets.symmetric(
                  horizontal: MediaQuery.of(context).size.width * 0.04,
                  vertical: MediaQuery.of(context).size.width * 0.03,
                ),
                suffixIcon: Icon(
                  Icons.calendar_today,
                  color: const Color(0xFFE47F25),
                  size: MediaQuery.of(context).size.width * 0.05,
                ),
                errorText: _dobError,
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildUploadField() {
    return GestureDetector(
      onTap: _showImagePicker,
      child: Container(
        width: double.infinity,
        height: 120,
        decoration: BoxDecoration(
          color: Colors.grey.shade100,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(
            color: Colors.grey.shade300,
            style: BorderStyle.solid,
          ),
        ),
        child: _selectedImage != null
            ? ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: Image.file(_selectedImage!, fit: BoxFit.cover),
              )
            : const Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.upload_file, size: 40, color: Colors.grey),
                  SizedBox(height: 8),
                  Text(
                    'Upload Photo',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                      color: Colors.black87,
                    ),
                  ),
                  SizedBox(height: 4),
                  Text(
                    'Max file size: 5 MB',
                    style: TextStyle(fontSize: 12, color: Colors.grey),
                  ),
                ],
              ),
      ),
    );
  }
}
