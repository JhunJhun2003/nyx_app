import 'package:flutter/material.dart';
import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:nyxproject/services/session_service.dart';
import 'package:nyxproject/services/cart_service.dart';
import 'package:nyxproject/util/Api.dart';
import 'package:nyxproject/util/Constant.dart';
import 'package:nyxproject/pages/detailsPages/accountpages/login.dart';

class EditProfile extends StatefulWidget {
  final SessionService sessionService;
  final CartService? cartService;

  const EditProfile({
    super.key, 
    required this.sessionService,
    this.cartService,
  });

  @override
  State<EditProfile> createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
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
  File? _selectedImage;
  bool _isUploading = false;
  final ImagePicker _picker = ImagePicker();

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
    if (!mounted) return;
    
    setState(() {
      _isLoading = true;
      _errorMessage = null;
    });

    try {
      final String? token = widget.sessionService.getToken();

      if (token == null || token.isEmpty) {
        if (mounted) {
          setState(() {
            _errorMessage = 'No authentication token found.\nPlease login again.';
            _isLoading = false;
          });
        }
        return;
      }

      final result = await Api.getMyProfile(token: token);

      if (mounted) {
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
      }
    } catch (e) {
      if (mounted) {
        setState(() {
          _errorMessage = 'Error loading profile: $e';
          _isLoading = false;
        });
      }
    }
  }

  void _populateForm(Map<String, dynamic> userData) {
    _nameController.text = userData['name']?.toString() ?? '';
    final dob = userData['dateOfBirth'];
    _dobController.text = dob != null && dob.toString().isNotEmpty ? dob.toString() : '';
    _emailController.text = userData['email']?.toString() ?? '';
    _phoneController.text = userData['phone']?.toString() ?? '';
    _addressController.text = userData['address']?.toString() ?? '';
    _imageUrl = userData['image_url']?.toString();
  }

  Future<void> _selectDate() async {
    DateTime? initialDate;
    if (_dobController.text.isNotEmpty) {
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
    );

    if (pickedDate != null) {
      final String formattedDate = 
          "${pickedDate.year}-${pickedDate.month.toString().padLeft(2, '0')}-${pickedDate.day.toString().padLeft(2, '0')}";
      setState(() {
        _dobController.text = formattedDate;
      });
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
        if (mounted) {
          setState(() {
            _errorMessage = 'Session expired. Please login again.';
            _isUpdating = false;
          });
        }
        return;
      }

      final response = await _callUpdateProfileAPI(token);

      final bool isSuccess = response['status'] == 'success' || 
                             response['status'] == 'Edit Profile';

      if (isSuccess) {
        final String? newToken = response['new_token'];
        
        if (newToken != null && newToken.isNotEmpty) {
          await widget.sessionService.saveToken(newToken);
          print('✅ New token saved');
        }

        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Profile updated successfully'),
              backgroundColor: Colors.green,
            ),
          );
        }

        await _loadUserProfile();
        
        if (mounted) {
          setState(() {
            _isUpdating = false;
          });
        }
      } else {
        if (mounted) {
          setState(() {
            _errorMessage = response['message'] ?? 'Update failed';
            _isUpdating = false;
          });
        }
      }
    } catch (e) {
      if (mounted) {
        setState(() {
          _errorMessage = 'Update failed: $e';
          _isUpdating = false;
        });
      }
    }
  }

  Future<Map<String, dynamic>> _callUpdateProfileAPI(String token) async {
    final Uri uri = Uri.parse("${Constant.API_URL}/editProfiled/update");

    final Map<String, dynamic> updateData = {
      'name': _nameController.text.trim(),
      'email': _emailController.text.trim(),
      'phone': _phoneController.text.trim(),
      'dateOfbirth': _dobController.text.trim(),
      'address': _addressController.text.trim(),
    };

    try {
      final http.Response response = await http.put(
        uri,
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          'Authorization': 'Bearer $token',
        },
        body: jsonEncode(updateData),
      ).timeout(const Duration(seconds: 30));

      if (response.statusCode == 200 || response.statusCode == 201) {
        if (response.body.isEmpty) {
          return {'status': 'success', 'message': 'Profile updated successfully'};
        }
        
        final responseData = jsonDecode(response.body);
        final String? tokenFromResponse = responseData['result'];
        
        return {
          'status': responseData['status'],
          'message': responseData['status'] ?? 'Profile updated',
          'new_token': tokenFromResponse,
          'data': responseData,
        };
      } else {
        return {'status': 'error', 'message': 'Update failed'};
      }
    } catch (e) {
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
                      const Icon(Icons.error_outline, size: 64, color: Colors.red),
                      const SizedBox(height: 20),
                      Text(_errorMessage!, textAlign: TextAlign.center),
                      const SizedBox(height: 20),
                      ElevatedButton(
                        onPressed: _loadUserProfile,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFF0D1B2A),
                        ),
                        child: const Text('Retry'),
                      ),
                    ],
                  ),
                ),
              )
            : SingleChildScrollView(
                child: Column(
                  children: [
                    _header(),
                    const SizedBox(height: 10),
                    _AccPhoto(),
                    const SizedBox(height: 5),
                    _edit(),
                    const SizedBox(height: 10),
                    _buildTextField("Name", _nameController),
                    _buildTextField("Date of Birth", _dobController, isDate: true),
                    _buildTextField("Email", _emailController),
                    _buildTextField("Phone", _phoneController),
                    _buildTextField("Address", _addressController),
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
        children: [
          IconButton(
            onPressed: () => Navigator.pop(context),
            icon: const Icon(Icons.arrow_back_ios_new_rounded, color: Colors.white),
          ),
          const Expanded(
            child: Text(
              "Edit Profile",
              style: TextStyle(
                fontFamily: "Custom",
                color: Colors.white,
                fontSize: 18,
              ),
              textAlign: TextAlign.center,
            ),
          ),
        ],
      ),
    );
  }

  Widget _AccPhoto() {
    return Center(
      child: Container(
        width: 120,
        height: 120,
        decoration: BoxDecoration(
          color: Colors.white,
          shape: BoxShape.circle,
          border: Border.all(color: Colors.black, width: 2),
        ),
        child: _imageUrl != null && _imageUrl!.isNotEmpty
            ? ClipOval(
                child: Image.network(
                  _imageUrl!,
                  width: 120,
                  height: 120,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) {
                    return const Icon(Icons.person, size: 60);
                  },
                ),
              )
            : const Icon(Icons.person, size: 60),
      ),
    );
  }

  Widget _edit() {
    return Center(
      child: TextButton.icon(
        onPressed: () {},
        icon: const Icon(Icons.camera_alt),
        label: const Text("Change Photo"),
      ),
    );
  }

  Widget _buildTextField(String label, TextEditingController controller, {bool isDate = false}) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: TextField(
        controller: controller,
        readOnly: isDate,
        onTap: isDate ? _selectDate : null,
        decoration: InputDecoration(
          labelText: label,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          suffixIcon: isDate ? const Icon(Icons.calendar_today) : null,
        ),
      ),
    );
  }

  Widget _updateButton() {
    return Center(
      child: ElevatedButton(
        onPressed: _isUpdating ? null : _updateProfile,
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.red,
          minimumSize: const Size(200, 45),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30),
          ),
        ),
        child: _isUpdating
            ? const SizedBox(
                width: 20,
                height: 20,
                child: CircularProgressIndicator(strokeWidth: 2, color: Colors.white),
              )
            : const Text('Save Changes', style: TextStyle(fontSize: 16)),
      ),
    );
  }
}