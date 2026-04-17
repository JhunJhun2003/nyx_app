import 'package:flutter/material.dart';
import 'package:nyxproject/pages/detailsPages/accountpages/OTP.dart';
import 'package:nyxproject/pages/detailsPages/accountpages/login.dart';
import 'package:nyxproject/pages/detailsPages/accountpages/terms.dart';
import 'package:nyxproject/services/session_service.dart';
import 'package:nyxproject/util/Api.dart';
// import 'package:http/http.dart' as http;
// import 'dart:convert';

// Future<bool> signupUser(String name, String email, String date, String password) async {
//   final url = Uri.parse("");
// }

class SignupPage extends StatefulWidget {
  final SessionService sessionService;
  const SignupPage({super.key, required this.sessionService});

  @override
  State<SignupPage> createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {

  final formKey = GlobalKey<FormState>();

  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController = TextEditingController();
  final TextEditingController _controller = TextEditingController();

  Future<void> _selectDate() async {
    DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime(2100),
    );

    if (pickedDate != null) {
      setState(() {
        _controller.text =
            "${pickedDate.day}/${pickedDate.month}/${pickedDate.year}";
      });
    }
  }

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
    super.dispose();
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
              SizedBox(height: 10),
              _Userinput(),
              SizedBox(height: 240),
              _footer(),
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
            onPressed: (){
              Navigator.pop(context);
            }, 
            icon: Icon(
              Icons.arrow_back_ios_new_rounded, 
              color: Colors.white,
              ),
            ),
            Expanded(
              child: const Text(
                "Create User", 
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

  Widget _Userinput(){
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 10),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TextField(
            controller: nameController,
            style: TextStyle(
              fontFamily: "Custom",
              color: Color.fromARGB(255, 255, 255, 255),
            ),
            decoration: InputDecoration(
              hintText: "Name*",
              filled: true,
              fillColor: Color.fromARGB(255, 13, 27, 42),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(15)
              ),
            ),
          ),

          const SizedBox(height: 10),

          TextFormField(
            controller: emailController,
            style: TextStyle(
              fontFamily: "Custom",
              color: Color.fromARGB(255, 255, 255, 255),
            ),
            decoration: InputDecoration(
              hintText: "Email*",
              filled: true,
              fillColor: Color.fromARGB(255, 13, 27, 42),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(15)
              ),
            ),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return "Enter email";
              }
              return null;
            },
          ),

          const SizedBox(height: 10),

          TextFormField(
            controller: _controller,
            readOnly: true, // 👈 prevents typing
            onTap: _selectDate, // 👈 open date picker
            style: const TextStyle(color: Colors.white),
            decoration: InputDecoration(
              hintText: "Date of Birth",
              hintStyle: const TextStyle(color: Colors.grey),

              prefixIcon: const Icon(Icons.calendar_today, color: Colors.white),

              filled: true,
              fillColor: Color.fromARGB(255, 13, 27, 42),

              // contentPadding: const EdgeInsets.symmetric(vertical: 18),

              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(15),
                borderSide: BorderSide.none,
              ),

              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(15),
                borderSide: BorderSide.none,
              ),

              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: const BorderSide(color: Colors.blue),
              ),
            ),
          ),

          const SizedBox(height: 10),

          TextFormField(
            controller: passwordController,
            obscureText: true,
            style: TextStyle(
              fontFamily: "Custom",
              color: Color.fromARGB(255, 255, 255, 255),
            ),
            decoration: InputDecoration(
              hintText: "Password",
              filled: true,
              fillColor: Color.fromARGB(255, 13, 27, 42),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(15)
              ),
            ),

            validator: (value) {
              if (value == null || value.isEmpty) {
                return "Enter password";
              }
              if (value.length < 6) {
                return "Password must be at least 6 characters";
              }
              return null;
            },
          ),

          const SizedBox(height: 10),

          TextFormField(
            controller: confirmPasswordController,
            obscureText: true,
            style: TextStyle(
              fontFamily: "Custom",
              color: Color.fromARGB(255, 255, 255, 255),
            ),
            decoration: InputDecoration(
              hintText: "Confirm Password",
              filled: true,
              fillColor: Color.fromARGB(255, 13, 27, 42),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(15)
              ),
            ),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return "Confirm password";
              }
              return null;
            },
          ),

          const SizedBox(height: 35),

          // SIGN UP BUTTON
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                minimumSize: const Size(350, 50),
                backgroundColor: Colors.red,
              ),
              onPressed: () async {
                if (!formKey.currentState!.validate()) return;
                if (passwordController.text != confirmPasswordController.text) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text("Passwords do not match")),
                  );
                  return;
                }

                final Map<String, dynamic> signupResult = await Api.signupUser(
                  name: nameController.text.trim(),
                  email: emailController.text.trim(),
                  phone: "",
                  dateOfBirth: _controller.text.trim(),
                  password: passwordController.text.trim(),
                );

                if (!mounted) return;
                final bool success = signupResult['success'] == true;
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(
                      signupResult['message']?.toString() ??
                          (success ? "Account created successfully!" : "Signup failed"),
                    ),
                  ),
                );

                if (success) {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (context) => LoginPage(
                        sessionService: widget.sessionService,
                      ),
                    ),
                  );
                }
              },
              child: const Text("SIGN UP",
                style: TextStyle(
                  fontFamily: "Custom",
                  fontSize: 15,
                  color: Colors.white
                ),
              ),
            ),
          ),
          
          SizedBox(height: 10),

          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text("Already have an account?", 
                style: TextStyle(
                  fontFamily: "Custom", 
                  fontSize: 15, 
                  color: Color.fromARGB(255, 13, 27, 42)
                ),
              ),
              TextButton(
                onPressed: (){
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => LoginPage(
                        sessionService: widget.sessionService,
                      ),
                    ),
                  );
                }, 
                child: Text("Login",
                style: TextStyle(
                  fontFamily: "Custom", 
                  fontSize: 15, 
                  color: Colors.red
                ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
  
  bool _isChecked = false;

  Widget _footer(){
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        CheckboxListTile(
          title: const Text("By registration, I have read agree the"),
          value: _isChecked,
          onChanged: (bool? value) {
            setState(() {
              _isChecked = value!;
            });
          },
          controlAffinity: ListTileControlAffinity.leading,
        ),
        
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextButton(
                onPressed: (){
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => termsPage()),
                  );
                }, 
                child: Text("Terms & Conditions",
                  style: TextStyle(
                    fontFamily: "Custom", 
                    fontSize: 15, 
                    color: Colors.red
                  ),
                ),
              ),
              Text("and"),
              TextButton(
                onPressed: (){
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => OTPpage()),
                  );
                }, 
                child: Text("Privacy Policy",
                  style: TextStyle(
                    fontFamily: "Custom", 
                    fontSize: 15, 
                    color: Colors.red
                  ),
                ),
              ),
          ],
        ),
      ],
    );
  }

  // INPUT STYLE (reusable)
  InputDecoration inputStyle(String label) {
    return InputDecoration(
      labelText: label,
      labelStyle: const TextStyle(color: Colors.white),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
        borderSide: const BorderSide(color: Colors.white, width: 2),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
        borderSide: const BorderSide(color: Colors.white, width: 2),
      ),
    );
  }
  
}


// Center(
//         child: Container(
//           width: 350,
//           padding: const EdgeInsets.all(30),
//           decoration: BoxDecoration(
//             color: const Color.fromARGB(255, 13, 27, 42),
//             borderRadius: BorderRadius.circular(15),
//           ),

//           child: Form(
//             key: formKey,
//             child: Column(
//               mainAxisSize: MainAxisSize.min,
//               children: [

//                 SizedBox(
//                   width: 400,
//                   height: 200,
//                   child: Image.asset("assets/images/logo.png"),
//                 ),

//                 const Text(
//                   "Create Account",
//                   style: TextStyle(
//                     fontSize: 26,
//                     fontWeight: FontWeight.bold,
//                     color: Colors.white,
//                   ),
//                 ),

//                 const SizedBox(height: 20),

//                 // EMAIL
//                 TextFormField(
//                   controller: emailController,
//                   style: const TextStyle(color: Colors.white),
//                   decoration: inputStyle("Email"),
//                   validator: (value) {
//                     if (value == null || value.isEmpty) {
//                       return "Enter email";
//                     }
//                     return null;
//                   },
//                 ),

//                 const SizedBox(height: 15),

//                 // PASSWORD
//                 TextFormField(
//                   controller: passwordController,
//                   obscureText: true,
//                   style: const TextStyle(color: Colors.white),
//                   decoration: inputStyle("Password"),
//                   validator: (value) {
//                     if (value == null || value.isEmpty) {
//                       return "Enter password";
//                     }
//                     if (value.length < 6) {
//                       return "Password must be at least 6 characters";
//                     }
//                     return null;
//                   },
//                 ),

//                 const SizedBox(height: 15),

//                 // CONFIRM PASSWORD
//                 TextFormField(
//                   controller: confirmPasswordController,
//                   obscureText: true,
//                   style: const TextStyle(color: Colors.white),
//                   decoration: inputStyle("Confirm Password"),
//                   validator: (value) {
//                     if (value == null || value.isEmpty) {
//                       return "Confirm password";
//                     }
//                     return null;
//                   },
//                 ),

//                 const SizedBox(height: 25),

//                 // SIGN UP BUTTON
//                 SizedBox(
//                   width: double.infinity,
//                   child: ElevatedButton(
//                     onPressed: () async {

//                       // 1. Validate form
//                       if (formKey.currentState!.validate()) {

//                         // 2. Check password match
//                         if (passwordController.text != confirmPasswordController.text) {
//                           ScaffoldMessenger.of(context).showSnackBar(
//                             const SnackBar(content: Text("Passwords do not match")),
//                           );
//                           return;
//                         }

//                         // 3. Save user
//                         await dbHelper.insertUser(
//                           emailController.text.trim(),
//                           passwordController.text.trim(),
//                         );

//                         // 4. Success message
//                         ScaffoldMessenger.of(context).showSnackBar(
//                           const SnackBar(content: Text("Account created successfully!")),
//                         );

//                         // 5. Go back to login
//                         Navigator.pop(context);
//                       }
//                     },
//                     child: const Text("SIGN UP"),
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         ),
//       ),