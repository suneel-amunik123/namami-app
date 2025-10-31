import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../provider/register_provider.dart';

class RegisterView extends StatefulWidget {
  const RegisterView({super.key});

  @override
  State<RegisterView> createState() => _RegisterViewState();
}

class _RegisterViewState extends State<RegisterView> {
  final Map<String, bool> _fieldErrors = {};
  bool _showValidation = false;

  final TextEditingController nameController = TextEditingController();
  final TextEditingController mobileController = TextEditingController();
  final TextEditingController emailController = TextEditingController();

  String? nameError;
  String? mobileError;
  String? emailError;

  void validateName(String value) {
    setState(() {
      nameError = value.length < 2 ? 'Please enter minimum 2 characters' : null;
    });
  }

  void validateMobile(String value) {
    setState(() {
      mobileError = value.length != 10 ? 'Enter 10 digit mobile number' : null;
    });
  }

  void validateEmail(String value) {
    setState(() {
      emailError = !RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(value)
          ? 'Enter valid email address'
          : null;
    });
  }

  void _validateAndRegister(RegisterProvider provider) {
    setState(() {
      _showValidation = true;
      _fieldErrors.clear();

      if (provider.registerModel.name.isEmpty) _fieldErrors['name'] = true;
      if (provider.registerModel.mobileNumber.isEmpty)
        _fieldErrors['mobile'] = true;
      if (provider.registerModel.email.isEmpty) _fieldErrors['email'] = true;
      if (provider.registerModel.experience.isEmpty)
        _fieldErrors['experience'] = true;
      if (provider.registerModel.languages.isEmpty)
        _fieldErrors['languages'] = true;
      if (provider.registerModel.address.isEmpty)
        _fieldErrors['address'] = true;
    });

    if (_fieldErrors.isEmpty) {
      provider.register();
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Row(
            children: [
              const Icon(Icons.error_outline, color: Colors.white),
              const SizedBox(width: 12),
              const Expanded(
                child: Text(
                  'Please fill all required fields',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ],
          ),
          backgroundColor: Colors.red,
          behavior: SnackBarBehavior.floating,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          margin: const EdgeInsets.all(16),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => RegisterProvider(),
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0,
          centerTitle: true,
          title: Text(
            'Complete Profile',
            style: TextStyle(
              color: Colors.black,
              fontSize: MediaQuery.of(context).size.width * 0.045,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
        body: Consumer<RegisterProvider>(
          builder: (context, registerProvider, child) {
            return SingleChildScrollView(
              padding: EdgeInsets.all(MediaQuery.of(context).size.width * 0.05),
              child: Container(
                padding: EdgeInsets.all(
                  MediaQuery.of(context).size.width * 0.04,
                ),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(
                    MediaQuery.of(context).size.width * 0.03,
                  ),
                  border: Border.all(color: const Color(0xFFE47f25), width: 1),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Name Field
                    _buildLabel('Name *'),
                    _buildValidatedTextField(
                      'Enter Your Full Name',
                      controller: nameController,
                      onChanged: (value) {
                        validateName(value);
                        registerProvider.updateName(value);
                      },
                      errorText: nameError,
                    ),
                    const SizedBox(height: 16),

                    // Mobile Number Field
                    _buildLabel('Mobile Number *'),
                    _buildValidatedTextField(
                      'Enter Mobile Number',
                      controller: mobileController,
                      onChanged: (value) {
                        validateMobile(value);
                        registerProvider.updateMobileNumber(value);
                      },
                      keyboardType: TextInputType.phone,
                      maxLength: 10,
                      errorText: mobileError,
                    ),
                    const SizedBox(height: 16),

                    // Email Field
                    _buildLabel('Email *'),
                    _buildValidatedTextField(
                      'Enter Email',
                      controller: emailController,
                      onChanged: (value) {
                        validateEmail(value);
                        registerProvider.updateEmail(value);
                      },
                      keyboardType: TextInputType.emailAddress,
                      errorText: emailError,
                    ),
                    const SizedBox(height: 16),

                    // Experience Dropdown
                    _buildLabel('Experience *'),
                    _buildDropdown(
                      'Select Experience',
                      registerProvider.experienceOptions,
                      registerProvider.registerModel.experience,
                      registerProvider.updateExperience,
                      fieldKey: 'experience',
                    ),
                    const SizedBox(height: 16),

                    // Languages Dropdown
                    _buildLabel('Languages Known *'),
                    _buildMultiSelectDropdown(
                      'Select Languages',
                      registerProvider.languageOptions,
                      registerProvider.registerModel.languages,
                      registerProvider.updateLanguages,
                      fieldKey: 'languages',
                    ),
                    const SizedBox(height: 16),

                    // Address Field
                    _buildLabel('Address *'),
                    _buildTextField(
                      'Enter Address',
                      onChanged: registerProvider.updateAddress,
                      maxLines: 2,
                      fieldKey: 'address',
                    ),
                    const SizedBox(height: 16),

                    // Bio Field
                    _buildLabel('Bio(Optional)'),
                    _buildTextField(
                      'Enter Bio',
                      onChanged: registerProvider.updateBio,

                      maxLines: 3,
                    ),
                    const SizedBox(height: 32),

                    // Register Button
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed:
                            registerProvider.registerModel.isLoading ||
                                nameError != null ||
                                mobileError != null ||
                                emailError != null ||
                                nameController.text.isEmpty ||
                                mobileController.text.isEmpty ||
                                emailController.text.isEmpty
                            ? null
                            : () => _validateAndRegister(registerProvider),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFFE47F25),
                          padding: const EdgeInsets.symmetric(vertical: 0),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                        ),
                        child: registerProvider.registerModel.isLoading
                            ? const CircularProgressIndicator(
                                color: Colors.white,
                              )
                            : const Text(
                                'Register',
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                              ),
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  Widget _buildValidatedTextField(
    String hint, {
    required TextEditingController controller,
    required Function(String) onChanged,
    TextInputType? keyboardType,
    int maxLines = 1,
    int? maxLength,
    String? errorText,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          decoration: BoxDecoration(
            color: Colors.grey[100],
            borderRadius: BorderRadius.circular(8),
            border: errorText != null
                ? Border.all(color: Colors.red, width: 1)
                : null,
          ),
          child: TextField(
            controller: controller,
            onChanged: onChanged,
            keyboardType: keyboardType,
            maxLines: maxLines,
            maxLength: maxLength,
            decoration: InputDecoration(
              hintText: hint,
              hintStyle: TextStyle(
                color: Colors.grey[500],
                fontSize: MediaQuery.of(context).size.width * 0.04,
              ),
              border: InputBorder.none,
              counterText: '',
              contentPadding: EdgeInsets.symmetric(
                horizontal: MediaQuery.of(context).size.width * 0.04,
                vertical: MediaQuery.of(context).size.width * 0.04,
              ),
            ),
          ),
        ),
        if (errorText != null)
          Padding(
            padding: EdgeInsets.only(
              top: MediaQuery.of(context).size.width * 0.01,
              left: MediaQuery.of(context).size.width * 0.02,
            ),
            child: Text(
              errorText,
              style: TextStyle(
                color: Colors.red,
                fontSize: MediaQuery.of(context).size.width * 0.03,
              ),
            ),
          ),
      ],
    );
  }

  Widget _buildLabel(String text) {
    return Padding(
      padding: EdgeInsets.only(
        bottom: MediaQuery.of(context).size.width * 0.02,
      ),
      child: Text(
        text,
        style: TextStyle(
          fontSize: MediaQuery.of(context).size.width * 0.035,
          fontWeight: FontWeight.w500,
          color: Colors.black87,
        ),
      ),
    );
  }

  Widget _buildTextField(
    String hint, {
    required Function(String) onChanged,
    TextInputType? keyboardType,
    int maxLines = 1,
    String? fieldKey,
  }) {
    bool hasError = _showValidation && _fieldErrors[fieldKey] == true;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          decoration: BoxDecoration(
            color: Colors.grey[100],
            borderRadius: BorderRadius.circular(8),
            border: hasError ? Border.all(color: Colors.red, width: 1) : null,
          ),
          child: TextField(
            onChanged: (value) {
              onChanged(value);
              if (hasError && value.isNotEmpty) {
                setState(() {
                  _fieldErrors.remove(fieldKey);
                });
              }
            },
            keyboardType: keyboardType,
            maxLines: maxLines,
            decoration: InputDecoration(
              hintText: hint,
              hintStyle: TextStyle(color: Colors.grey[500]),
              border: InputBorder.none,
              contentPadding: const EdgeInsets.symmetric(
                horizontal: 16,
                vertical: 16,
              ),
            ),
          ),
        ),
        if (hasError)
          const Padding(
            padding: EdgeInsets.only(top: 4),
            child: Text(
              'Please fill the required field',
              style: TextStyle(color: Colors.red, fontSize: 12),
            ),
          ),
      ],
    );
  }

  Widget _buildDropdown(
    String hint,
    List<String> options,
    String selectedValue,
    Function(String) onChanged, {
    String? fieldKey,
  }) {
    bool hasError = _showValidation && _fieldErrors[fieldKey] == true;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          decoration: BoxDecoration(
            color: Colors.grey[100],
            borderRadius: BorderRadius.circular(8),
            border: hasError ? Border.all(color: Colors.red, width: 1) : null,
          ),
          child: DropdownButtonFormField<String>(
            value: selectedValue.isEmpty ? null : selectedValue,
            hint: Text(hint, style: TextStyle(color: Colors.grey[500])),
            decoration: const InputDecoration(
              border: InputBorder.none,
              contentPadding: EdgeInsets.symmetric(
                horizontal: 16,
                vertical: 16,
              ),
            ),
            items: options.map((option) {
              return DropdownMenuItem(value: option, child: Text(option));
            }).toList(),
            onChanged: (value) {
              if (value != null) {
                onChanged(value);
                if (hasError) {
                  setState(() {
                    _fieldErrors.remove(fieldKey);
                  });
                }
              }
            },
          ),
        ),
        if (hasError)
          const Padding(
            padding: EdgeInsets.only(top: 4),
            child: Text(
              'Please fill the required field',
              style: TextStyle(color: Colors.red, fontSize: 12),
            ),
          ),
      ],
    );
  }

  Widget _buildMultiSelectDropdown(
    String hint,
    List<String> options,
    List<String> selectedValues,
    Function(List<String>) onChanged, {
    String? fieldKey,
  }) {
    bool hasError = _showValidation && _fieldErrors[fieldKey] == true;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          decoration: BoxDecoration(
            color: Colors.white70,
            borderRadius: BorderRadius.circular(8),
            border: hasError ? Border.all(color: Colors.red, width: 1) : null,
          ),
          child: InkWell(
            onTap: () => _showLanguageDialog(
              options,
              selectedValues,
              onChanged,
              fieldKey,
            ),
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 5),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Expanded(
                    child: Text(
                      selectedValues.isEmpty ? hint : selectedValues.join(', '),
                      style: TextStyle(
                        color: selectedValues.isEmpty
                            ? Colors.grey[500]
                            : Colors.black,
                      ),
                    ),
                  ),
                  const Icon(Icons.arrow_drop_down, color: Colors.grey),
                ],
              ),
            ),
          ),
        ),
        if (hasError)
          const Padding(
            padding: EdgeInsets.only(top: 4),
            child: Text(
              'Please fill the required field',
              style: TextStyle(color: Colors.red, fontSize: 12),
            ),
          ),
      ],
    );
  }

  void _showLanguageDialog(
    List<String> options,
    List<String> selectedValues,
    Function(List<String>) onChanged,
    String? fieldKey,
  ) {
    showDialog(
      context: context,
      builder: (context) {
        List<String> tempSelected = List.from(selectedValues);
        return StatefulBuilder(
          builder: (context, setState) {
            return AlertDialog(
              backgroundColor: Colors.white,
              title: const Text('Select Languages'),
              content: SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: options.map((language) {
                    return CheckboxListTile(
                      title: Text(language),
                      value: tempSelected.contains(language),
                      onChanged: (bool? value) {
                        setState(() {
                          if (value == true) {
                            tempSelected.add(language);
                          } else {
                            tempSelected.remove(language);
                          }
                        });
                      },
                    );
                  }).toList(),
                ),
              ),
              actions: [
                TextButton(
                  onPressed: () => Navigator.pop(context),
                  child: const Text('Cancel'),
                ),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFFE47F25),
                  ),
                  onPressed: () {
                    onChanged(tempSelected);
                    if (fieldKey != null && tempSelected.isNotEmpty) {
                      setState(() {
                        _fieldErrors.remove(fieldKey);
                      });
                    }
                    Navigator.pop(context);
                  },
                  child: Container(
                    child: const Text(
                      'Done',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ),
              ],
            );
          },
        );
      },
    );
  }
}
