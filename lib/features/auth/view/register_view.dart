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

  void _validateAndRegister(RegisterProvider provider) {
    setState(() {
      _showValidation = true;
      _fieldErrors.clear();
      
      if (provider.registerModel.name.isEmpty) _fieldErrors['name'] = true;
      if (provider.registerModel.mobileNumber.isEmpty) _fieldErrors['mobile'] = true;
      if (provider.registerModel.email.isEmpty) _fieldErrors['email'] = true;
      if (provider.registerModel.experience.isEmpty) _fieldErrors['experience'] = true;
      if (provider.registerModel.languages.isEmpty) _fieldErrors['languages'] = true;
      if (provider.registerModel.address.isEmpty) _fieldErrors['address'] = true;
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
          title: const Text(
            'Complete Profile',
            style: TextStyle(
              color: Colors.black,
              fontSize: 18,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
        body: Consumer<RegisterProvider>(
          builder: (context, registerProvider, child) {
            return SingleChildScrollView(
              padding: const EdgeInsets.all(20),
              child: Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: const Color(0xFFFF9800), width: 1),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Name Field
                    _buildLabel('Name *'),
                    _buildTextField(
                      'Enter Your Full Name',
                      onChanged: registerProvider.updateName,
                      fieldKey: 'name',
                    ),
                    const SizedBox(height: 16),

                    // Mobile Number Field
                    _buildLabel('Mobile Number *'),
                    _buildTextField(
                      'Enter Mobile Number',
                      onChanged: registerProvider.updateMobileNumber,
                      keyboardType: TextInputType.phone,
                      fieldKey: 'mobile',
                    ),
                    const SizedBox(height: 16),

                    // Email Field
                    _buildLabel('Email *'),
                    _buildTextField(
                      'Enter Email',
                      onChanged: registerProvider.updateEmail,
                      keyboardType: TextInputType.emailAddress,
                      fieldKey: 'email',
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
                        onPressed: registerProvider.registerModel.isLoading
                            ? null
                            : () => _validateAndRegister(registerProvider),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFFFF9800),
                          padding: const EdgeInsets.symmetric(vertical: 16),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
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

  Widget _buildLabel(String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Text(
        text,
        style: const TextStyle(
          fontSize: 14,
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
    Function(String) onChanged,
    {String? fieldKey}
  ) {
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
              contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 16),
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
    Function(List<String>) onChanged,
    {String? fieldKey}
  ) {
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
            onTap: () => _showLanguageDialog(options, selectedValues, onChanged, fieldKey),
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
                  onPressed: () {
                    onChanged(tempSelected);
                    if (fieldKey != null && tempSelected.isNotEmpty) {
                      setState(() {
                        _fieldErrors.remove(fieldKey);
                      });
                    }
                    Navigator.pop(context);
                  },
                  child: const Text('Done'),
                ),
              ],
            );
          },
        );
      },
    );
  }
}
