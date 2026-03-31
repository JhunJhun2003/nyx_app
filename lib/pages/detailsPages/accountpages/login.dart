// import 'package:flutter/foundation.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:flutter/material.dart';
// import 'package:nyxproject/pages/main_dashboard.dart';
import '../../../db_helper.dart';
// import 'lib/pages/detailsPages/accountpages/signup.dart';
// import 'home.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {

  double get screenWidth => MediaQuery.of(context).size.width;

  // final _formKey = GlobalKey<FormState>();

  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  DBHelper dbHelper = DBHelper();

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
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
              _inputform(),
              _forget(),
              _login(),
              SizedBox(height: 10),
              _continuewith("--- or Continue With ---"),
              SizedBox(height: 15),
              _choice(),

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
                "Login", 
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

  Widget _inputform(){
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 10),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          TextFormField(
            controller: emailController,
            style: TextStyle(
              fontFamily: "Custom",
              color: Color.fromARGB(255, 255, 255, 255),
            ),
            decoration: InputDecoration(
              hintText: "Email",
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
        ],
      ),
    );
  }

  InputDecoration inputStyle(String label) {
    return InputDecoration(
      labelText: label,
      labelStyle: const TextStyle(color:  Color.fromARGB(255, 13, 27, 42),),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(20),
        borderSide: const BorderSide(color:  Color.fromARGB(255, 13, 27, 42), width: 2),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(20),
        borderSide: const BorderSide(color:  Color.fromARGB(255, 13, 27, 42), width: 2),
      ),
    );
  }

  Widget _forget(){
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 10),
      child: TextButton(
        onPressed: (){

        }, 
        child: Text(
          "Forget passeowrd?",
          style: TextStyle(
            fontFamily: "Custom",
            fontSize: 15
          ),
        )
      ),
    );
  }

  Widget _login(){
    return Center(
      // padding: EdgeInsets.symmetric(horizontal: 10),
      child: ElevatedButton(
        onPressed: (){},
        child: Text(
          "Login",
           style: TextStyle(
              fontFamily: "Custom",
              fontSize: 15,
              color: Colors.black
            ),
        ),
      ),
    );
  }

  Widget _continuewith(String title){
    return Center(
        child: Text(title, style: TextStyle(fontFamily: "Custom",fontSize: 15),),
    );
  }

  Widget _choice(){
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        SizedBox(
          child: ElevatedButton.icon(
            onPressed: (){}, 
            icon: Icon(Icons.facebook_rounded),
            label: Text(
              "Facebook", 
              style: TextStyle(
                fontFamily: "Custom",
                fontSize: 15,
                color: Colors.white
              ),
            ),
            style: ElevatedButton.styleFrom(
              backgroundColor: Color.fromARGB(255, 13, 27, 42),
              iconColor: Colors.white
            ),
          ),
        ),
        SizedBox(
          child: ElevatedButton.icon(
            onPressed: (){}, 
            icon: Icon(FontAwesomeIcons.google),
            label: Text(
              "Google", 
              style: TextStyle(
                fontFamily: "Custom",
                fontSize: 15,
                color: Colors.white
              ),
            ),
            style: ElevatedButton.styleFrom(
              backgroundColor: Color.fromARGB(255, 13, 27, 42),
              iconColor: Colors.white
            ),
          ),
        ),
      ],
    );
  }

  
}
