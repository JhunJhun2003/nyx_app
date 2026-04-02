import 'package:flutter/material.dart';
import '../../../db_helper.dart';

DBHelper dbHelper = DBHelper();

class SignupPage extends StatefulWidget {
  const SignupPage({super.key});

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

          SizedBox(
            child: Text("NRC",style: TextStyle(fontFamily: "Custom",fontSize: 15)),
          ),
          
          const SizedBox(height: 10),

          Row(
            children: [
              _dropdownBox("1"),
              const SizedBox(width: 8),
              const Text("/", style: TextStyle(color: Colors.white)),
              const SizedBox(width: 8),
              Expanded(child: _dropdownBox("MA KA TA")),
              const SizedBox(width: 8),
              _dropdownBox("(N)"),
            ],
          ),

          const SizedBox(height: 10),

          // 🔷 Bottom TextField
          TextField(
            style: const TextStyle(color: Colors.white),
            decoration: InputDecoration(
              hintText: "NRC Number",
              hintStyle: const TextStyle(color: Colors.grey),
              filled: true,
              fillColor: const Color(0xFF0F2A3D),
              contentPadding: const EdgeInsets.symmetric(horizontal: 16),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide.none,
              ),
            ),
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
              fillColor: const Color(0xFF1E2A38),

              contentPadding: const EdgeInsets.symmetric(vertical: 18),

              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: BorderSide.none,
              ),

              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
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

          Row(
            children: [],
          ),
        ],
      ),
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

  Widget _dropdownBox(String text) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12),
      height: 45,
      decoration: BoxDecoration(
        color: const Color(0xFF0F2A3D),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(text, style: const TextStyle(color: Colors.white)),
          const SizedBox(width: 6),
          const Icon(Icons.keyboard_arrow_down, color: Colors.white),
        ],
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