import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:nyxproject/pages/detailsPages/accountpages/login.dart';
import 'package:nyxproject/services/session_service.dart';
import 'package:nyxproject/util/Api.dart';
import 'package:nyxproject/util/Constant.dart';

class EditProfile extends StatefulWidget {
  final SessionService sessionService;

  const EditProfile({super.key, required this.sessionService});

  @override
  State<EditProfile> createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  double get screenWidth => MediaQuery.of(context).size.width;

  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _dobController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();

  bool _isLoading = true;
  bool _isUpdating = false;
  String? _imageUrl;
  String? _errorMessage;
  Map<String, dynamic>? _originalUserData;

  @override
  void initState() {
    super.initState();
    _loadUserProfile();
  }

  @override
  void dispose() {
    _nameController.dispose();
    _dobController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    _addressController.dispose();
    super.dispose();
  }

  Future<void> _loadUserProfile() async {
    setState(() {
      _isLoading = true;
      _errorMessage = null;
    });

    try {
      final String? token = widget.sessionService.getToken();

      print(
        '🔍 Token from SessionService: ${token != null ? "Exists" : "Null"}',
      );

      if (token == null || token.isEmpty) {
        setState(() {
          _errorMessage = 'No authentication token found.\nPlease login again.';
          _isLoading = false;
        });
        return;
      }

      final result = await Api.getMyProfile(token: token);

      print(' API Result success: ${result['success']}');

      setState(() {
        if (result['success']) {
          _originalUserData = result['data'];
          _populateForm(_originalUserData!);
          _errorMessage = null;
        } else {
          _errorMessage = result['message'];
        }
        _isLoading = false;
      });
    } catch (e) {
      print(' Exception: $e');
      setState(() {
        _errorMessage = 'Error loading profile: $e';
        _isLoading = false;
      });
    }
  }

  void _populateForm(Map<String, dynamic> userData) {
    _nameController.text = userData['name']?.toString() ?? '';

    // Handle date of birth properly
    final dob = userData['dateOfBirth'];
    if (dob != null && dob.toString().isNotEmpty && dob.toString() != 'null') {
      _dobController.text = dob.toString();
    } else {
      _dobController.text = ''; // Empty if no date
    }

    _emailController.text = userData['email']?.toString() ?? '';
    _phoneController.text = userData['phone']?.toString() ?? '';
    _addressController.text = userData['address']?.toString() ?? '';
    _imageUrl = userData['image_url']?.toString();

    print('🖼️ Image URL: $_imageUrl');
    print('📅 Date of Birth from API: ${_dobController.text}');
  }

  Future<void> _selectDate() async {
    // Parse existing date if available
    DateTime? initialDate;
    if (_dobController.text.isNotEmpty && _dobController.text != 'null') {
      try {
        initialDate = DateTime.parse(_dobController.text);
      } catch (e) {
        initialDate = DateTime.now();
      }
    } else {
      initialDate = DateTime.now();
    }

    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: initialDate,
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
      helpText: 'Select Date of Birth',
      cancelText: 'Cancel',
      confirmText: 'OK',
    );

    if (pickedDate != null) {
      // Format: YYYY-MM-DD (API expects this exact format)
      final String formattedDate =
          "${pickedDate.year}-${pickedDate.month.toString().padLeft(2, '0')}-${pickedDate.day.toString().padLeft(2, '0')}";

      setState(() {
        _dobController.text = formattedDate;
      });

      print('✅ Date selected: $formattedDate');

      // Optional: Show confirmation
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Date of Birth set to: $formattedDate'),
          duration: const Duration(seconds: 1),
        ),
      );
    }
  }

Future<void> _updateProfile() async {
  setState(() {
    _isUpdating = true;
    _errorMessage = null;
  });

  try {
    final String? token = widget.sessionService.getToken();

    if (token == null) {
      setState(() {
        _errorMessage = 'Session expired. Please login again.';
        _isUpdating = false;
      });
      return;
    }

    final response = await _callUpdateProfileAPI(token);

    final bool isSuccess = response['status'] == 'success' || 
                           response['status'] == 'Edit Profile';

    if (isSuccess) {
      // Save the new token
      final String? newToken = response['new_token'];
      
      if (newToken != null && newToken.isNotEmpty) {
        await widget.sessionService.saveToken(newToken);
        print(' New token saved after profile update');
      }

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Profile updated successfully'),
            backgroundColor: Colors.green,
          ),
        );
      }

      // Refresh the current page data (stay on same page)
      await _loadUserProfile();
      
      //  IMPORTANT: Do NOT navigate back - stay on this page
      // Comment out or remove: Navigator.pop(context, true);
      
      setState(() {
        _isUpdating = false;
      });
      
    } else {
      setState(() {
        _errorMessage = response['message'] ?? 'Update failed';
        _isUpdating = false;
      });
    }
  } catch (e) {
    print(' Update error: $e');
    setState(() {
      _errorMessage = 'Update failed: $e';
      _isUpdating = false;
    });
  }
}
  Future<Map<String, dynamic>> _callUpdateProfileAPI(String token) async {
    final Uri uri = Uri.parse("${Constant.API_URL}/editProfiled/update");

    print("📡 Update URL: $uri");

    final Map<String, dynamic> updateData = {
      'name': _nameController.text.trim(),
      'email': _emailController.text.trim(),
      'phone': _phoneController.text.trim(),
      'dateOfbirth': _dobController.text.trim(), // ← FIXED: lowercase 'b'
      'address': _addressController.text.trim(),
    };

    print("📦 Update Data: $updateData");
    print(
      "🔑 Token: ${token.substring(0, token.length > 20 ? 20 : token.length)}...",
    );

    try {
      final http.Response response = await http
          .put(
            uri,
            headers: {
              'Content-Type': 'application/json',
              'Accept': 'application/json',
              'Authorization': 'Bearer $token',
            },
            body: jsonEncode(updateData),
          )
          .timeout(const Duration(seconds: 30));

      print("Update Response Status: ${response.statusCode}");
      print("Update Response Body: ${response.body}");

      if (response.statusCode == 200 || response.statusCode == 201) {
        if (response.body.isEmpty) {
          return {
            'status': 'success',
            'message': 'Profile updated successfully',
          };
        }

        final responseData = jsonDecode(response.body);

        final String? tokenFromResponse = responseData['result'];

        return {
          'status': responseData['status'],
          'message': responseData['status'] ?? 'Profile updated',
          'new_token': tokenFromResponse,
          'data': responseData,
        };
      } else if (response.statusCode == 401) {
        return {
          'status': 'error',
          'message': 'Session expired. Please login again.',
        };
      } else {
        String errorMessage = 'Server error: ${response.statusCode}';
        try {
          final errorData = jsonDecode(response.body);
          errorMessage =
              errorData['message'] ?? errorData['status'] ?? errorMessage;
        } catch (e) {}
        return {'status': 'error', 'message': errorMessage};
      }
    } catch (e) {
      print("Update Profile Error: $e");
      return {'status': 'error', 'message': 'Network error: $e'};
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: _isLoading
            ? const Center(child: CircularProgressIndicator())
            : _errorMessage != null && !_isUpdating
            ? Center(
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(
                        Icons.error_outline,
                        size: 64,
                        color: Colors.red,
                      ),
                      const SizedBox(height: 20),
                      Text(
                        _errorMessage!,
                        style: const TextStyle(fontSize: 16),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 20),
                      ElevatedButton(
                        onPressed: _loadUserProfile,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFF0D1B2A),
                        ),
                        child: const Text('Retry'),
                      ),
                      const SizedBox(height: 10),
                      TextButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => LoginPage(
                                sessionService: widget.sessionService,
                              ),
                            ),
                          );
                        },
                        child: const Text('Go to Login'),
                      ),
                    ],
                  ),
                ),
              )
            : SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _header(),
                    const SizedBox(height: 10),
                    _AccPhoto(),
                    const SizedBox(height: 5),
                    _edit(),
                    const SizedBox(height: 10),
                    customInput(
                      label: "Name :",
                      hint: "Enter your name",
                      controller: _nameController,
                    ),
                    customInput(
                      label: "Date of Birth :",
                      hint: "YYYY-MM-DD",
                      controller: _dobController,
                      isDate: true,
                    ),
                    customInput(
                      label: "Email :",
                      hint: "Enter your email",
                      controller: _emailController,
                    ),
                    customInput(
                      label: "Phone :",
                      hint: "Enter your phone number",
                      controller: _phoneController,
                    ),
                    customInput(
                      label: "Address :",
                      hint: "Enter your Address",
                      controller: _addressController,
                    ),
                    const SizedBox(height: 20),
                    _updateButton(),
                    const SizedBox(height: 20),
                  ],
                ),
              ),
      ),
    );
  }

  Widget _header() {
    return Container(
      color: const Color.fromARGB(255, 13, 27, 42),
      padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 5),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(
              Icons.arrow_back_ios_new_rounded,
              color: Colors.white,
            ),
          ),
          const Expanded(
            child: Text(
              "Edit Profile",
              style: TextStyle(
                fontFamily: "Custom",
                color: Colors.white,
                fontSize: 18,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _AccPhoto() {
    return Center(
      child: Container(
        width: 160,
        height: 160,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(100),
          border: Border.all(color: Colors.black, width: 2),
        ),
        child: _imageUrl != null && _imageUrl!.isNotEmpty
            ? ClipOval(
                child: Image.network(
                  _imageUrl!,
                  width: 160,
                  height: 160,
                  fit: BoxFit.cover,
                  loadingBuilder: (context, child, loadingProgress) {
                    if (loadingProgress == null) return child;
                    return const Center(child: CircularProgressIndicator());
                  },
                  errorBuilder: (context, error, stackTrace) {
                    print('❌ Image error: $error');
                    return const Icon(Icons.person, size: 160);
                  },
                ),
              )
            : const Icon(Icons.person, size: 160),
      ),
    );
  }

  Widget _edit() {
    return Center(
      child: GestureDetector(
        onTap: () {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Image change coming soon')),
          );
        },
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Text(
              'Change Profile',
              style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
            ),
            const SizedBox(width: 4),
            Container(
              padding: const EdgeInsets.all(4),
              child: const Icon(Icons.mode_edit, size: 20),
            ),
          ],
        ),
      ),
    );
  }

  Widget _updateButton() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: ElevatedButton(
        onPressed: _isUpdating ? null : _updateProfile,
        style: ElevatedButton.styleFrom(
          backgroundColor: const Color(0xFF0D1B2A),
          minimumSize: const Size(double.infinity, 50),
        ),
        child: _isUpdating
            ? const CircularProgressIndicator(color: Colors.white)
            : const Text(
                'Update Profile',
                style: TextStyle(fontSize: 18, color: Colors.white),
              ),
      ),
    );
  }

  Widget customInput({
    required String label,
    required String hint,
    required TextEditingController controller,
    bool isDate = false,
  }) {
    return Container(
      margin: const EdgeInsets.only(bottom: 5),
      decoration: BoxDecoration(
        color: const Color(0xFF0D1B2A),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.white, width: 1),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
      child: Row(
        children: [
          SizedBox(
            width: 100,
            child: Text(
              label,
              style: const TextStyle(
                fontFamily: "Custom",
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 16,
              ),
            ),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: TextField(
              controller: controller,
              style: const TextStyle(color: Colors.white),
              readOnly: isDate,
              onTap: isDate ? _selectDate : null,
              decoration: InputDecoration(
                hintText: hint,
                hintStyle: const TextStyle(
                  color: Colors.grey,
                  fontFamily: "Custom",
                ),
                border: InputBorder.none,
                suffixIcon: isDate
                    ? GestureDetector(
                        onTap: _selectDate,
                        child: const Icon(
                          Icons.calendar_month,
                          color: Colors.grey,
                        ),
                      )
                    : null,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
