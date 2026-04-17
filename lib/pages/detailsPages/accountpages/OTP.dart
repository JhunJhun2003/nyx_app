import 'dart:async';
import 'package:flutter/material.dart';
import 'package:nyxproject/models/User.dart';
import 'package:nyxproject/pages/detailsPages/accountpages/login.dart';
import 'package:nyxproject/pages/main_dashboard.dart';
import 'package:nyxproject/services/session_service.dart';
import 'package:nyxproject/util/Api.dart';

class OTP extends StatefulWidget {
  final String email;
  final String tempToken;
  final SessionService sessionService;
  
  const OTP({
    super.key,
    required this.email,
    required this.tempToken,
    required this.sessionService,
  });

  @override
  State<OTP> createState() => _OTPState();
}

class _OTPState extends State<OTP> {
  final formKey = GlobalKey<FormState>();
  final TextEditingController otpController = TextEditingController();
  bool _isLoading = false;
  bool _isSendingCode = false;
  int _resendCooldown = 0;
  Timer? _cooldownTimer;
  
  @override
  void initState() {
    super.initState();
    // OTP is already sent during signup, so we do not auto-send here to avoid format errors.
  }

  @override
  void dispose() {
    otpController.dispose();
    _cooldownTimer?.cancel();
    super.dispose();
  }

  void _startCooldownTimer() {
    _cooldownTimer?.cancel();
    setState(() {
      _resendCooldown = 60;
    });
    
    _cooldownTimer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (mounted && _resendCooldown > 0) {
        setState(() {
          _resendCooldown--;
        });
      } else {
        timer.cancel();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _header(),
              const SizedBox(height: 10),
              _main(),
              const SizedBox(height: 15),
              _verifyBTN(),
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
              "Verification", 
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

  Widget _main() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: Form(
        key: formKey,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Please verify your email account.", 
              style: TextStyle(
                fontFamily: "Custom",
                color: const Color.fromARGB(255, 13, 27, 42),
                fontSize: 15,
              ),
            ),

            const SizedBox(height: 15),

            // Email Display (read-only)
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
              decoration: BoxDecoration(
                color: const Color.fromARGB(255, 13, 27, 42),
                borderRadius: BorderRadius.circular(15),
              ),
              child: Row(
                children: [
                  const Icon(Icons.email, color: Colors.white70),
                  const SizedBox(width: 10),
                  Expanded(
                    child: Text(
                      widget.email,
                      style: const TextStyle(
                        fontFamily: "Custom",
                        color: Colors.white,
                        fontSize: 16,
                      ),
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 20),

            // Send OTP Button
            // Center(
            //   child: ElevatedButton(
            //     style: ElevatedButton.styleFrom(
            //       minimumSize: const Size(200, 45),
            //       backgroundColor: Colors.red,
            //     ),
            //     onPressed: (_isSendingCode || _resendCooldown > 0) ? null : () => _sendOtpCode(),
            //     child: _isSendingCode
            //         ? const SizedBox(
            //             height: 20,
            //             width: 20,
            //             child: CircularProgressIndicator(
            //               strokeWidth: 2,
            //               valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
            //             ),
            //           )
            //         : Text(
            //             _resendCooldown > 0 
            //                 ? "Resend OTP (${_resendCooldown}s)" 
            //                 : "Send OTP Code",
            //             style: const TextStyle(
            //               fontFamily: "Custom",
            //               fontSize: 15,
            //               color: Colors.white,
            //             ),
            //           ),
            //   ),
            // ),

            // const SizedBox(height: 20),

            // OTP Input Field
            TextFormField(
              controller: otpController,
              style: const TextStyle(
                fontFamily: "Custom",
                color: Color.fromARGB(255, 255, 255, 255),
              ),
              decoration: InputDecoration(
                hintText: "Enter your OTP",
                hintStyle: const TextStyle(color: Colors.grey),
                filled: true,
                fillColor: const Color.fromARGB(255, 13, 27, 42),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(15)
                ),
                prefixIcon: const Icon(Icons.security, color: Colors.white70),
              ),
              keyboardType: TextInputType.number,
              maxLength: 6,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return "Please enter OTP";
                }
                if (value.length != 6) {
                  return "OTP must be 6 digits";
                }
                return null;
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _verifyBTN() {
    return Center(
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          minimumSize: const Size(200, 50),
          backgroundColor: Colors.red,
        ),
        onPressed: _isLoading ? null : _verifyOtp,
        child: _isLoading
            ? const SizedBox(
                height: 20,
                width: 20,
                child: CircularProgressIndicator(
                  strokeWidth: 2,
                  valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                ),
              )
            : const Text(
                "Verify",
                style: TextStyle(
                  fontFamily: "Custom",
                  fontSize: 15,
                  color: Colors.white,
                ),
              ),
      ),
    );
  }

  Future<void> _sendOtpCode({bool autoSend = false}) async {
    if (!autoSend && _resendCooldown > 0) return;
    
    setState(() {
      _isSendingCode = true;
    });

    try {
      final Map<String, dynamic> result = await Api.sendOtpCode(
        email: widget.email,
      );

      if (!mounted) return;
      
      if (result['success'] == true) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text("OTP sent successfully! Check your email."),
            backgroundColor: Colors.green,
          ),
        );
        
        _startCooldownTimer();
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              result['message']?.toString() ?? "Failed to send OTP",
            ),
            backgroundColor: Colors.red,
          ),
        );
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error: $e'), backgroundColor: Colors.red),
        );
      }
    } finally {
      if (mounted) {
        setState(() {
          _isSendingCode = false;
        });
      }
    }
  }

  Future<void> _verifyOtp() async {
    final String otp = otpController.text.trim();

    if (otp.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Please enter OTP")),
      );
      return;
    }

    if (otp.length != 6) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("OTP must be 6 digits")),
      );
      return;
    }

    setState(() {
      _isLoading = true;
    });

    try {
      final Map<String, dynamic> result = await Api.verifyOtp(
        otp: otp,
        tempToken: widget.tempToken,
      );

      if (!mounted) return;
      
      final bool success = result['success'] == true;
      
      if (success) {
        final responseData = result['data'];
        
        // Initialize with default values - FIXED: Use int? for userId
        int? userId;
        String userName = 'User';
        String userEmail = widget.email;
        String userPhone = '';
        String authToken = '';

        if (responseData is Map<String, dynamic>) {
          Map<String, dynamic> userData = responseData;
          
          if (responseData['user'] != null && responseData['user'] is Map<String, dynamic>) {
            userData = responseData['user'] as Map<String, dynamic>;
          }
          
          // Extract id and convert to int properly
          if (userData['id'] != null) {
            final idValue = userData['id'];
            if (idValue is int) {
              userId = idValue;
            } else if (idValue is String) {
              userId = int.tryParse(idValue);
            } else if (idValue is num) {
              userId = idValue.toInt();
            }
          }
          
          userName = userData['name']?.toString() ?? userName;
          userPhone = userData['phone']?.toString() ?? userPhone;
          
          authToken = responseData['token']?.toString() ?? 
                      responseData['accessToken']?.toString() ?? 
                      '';
        }

        // Create user object with int? id - FIXED: Now passing int?
        final user = User(
          id: userId,
          name: userName,
          email: userEmail,
          phone: userPhone,
        );

        await widget.sessionService.saveSession(user, authToken);

        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text("Email verified successfully!"),
              backgroundColor: Colors.green,
            ),
          );

          Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(
              builder: (_) => MainDashboard(sessionService: widget.sessionService),
            ),
            (route) => false,
          );
        }
      } else {
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(result['message']?.toString() ?? "Invalid OTP"),
              backgroundColor: Colors.red,
            ),
          );
        }
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error: $e'), backgroundColor: Colors.red),
        );
      }
    } finally {
      if (mounted) {
        setState(() {
          _isLoading = false;
        });
      }
    }
  }
}