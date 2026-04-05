import 'package:flutter/material.dart';

class OTPpage extends StatefulWidget {
  const OTPpage({super.key});

  @override
  State<OTPpage> createState() => _OTPpageState();

  
}

class _OTPpageState extends State<OTPpage> {

  final formKey = GlobalKey<FormState>();

  final TextEditingController emailController = TextEditingController();
  final TextEditingController  OTPController = TextEditingController();

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
              _main(),
              SizedBox(height: 15),
              _verifyBTN(),
            ],
          ),
        )
      ),
    );
  }

  Widget _header() {
    return Container(
      color:  Color.fromARGB(255, 13, 27, 42),
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
      padding: EdgeInsets.symmetric(horizontal: 10),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("Please verify your email account.", 
            style: TextStyle(
              fontFamily: "Custom",
              color: Color.fromARGB(255, 13, 27, 42),
              fontSize: 15,
            ),
          ),

          SizedBox(height: 15),

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

          SizedBox(height: 10),

          ElevatedButton(
            style: ElevatedButton.styleFrom(
              minimumSize: const Size(150, 50),
              backgroundColor: Colors.red,
            ),
            onPressed: (){}, 
            child: Text(
              "Send OTP Code",
              style: TextStyle(
                fontFamily: "Custom",
                fontSize: 15,
                color: Colors.white
              ),
            ),
          ),

          SizedBox(height: 10),

          TextFormField(
            controller: OTPController,
            style: TextStyle(
              fontFamily: "Custom",
              color: Color.fromARGB(255, 255, 255, 255),
            ),
            decoration: InputDecoration(
              hintText: "Enter your OTP",
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
        ],
      ),
    );
  }

  Widget _verifyBTN(){
    return Center(
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          minimumSize: const Size(150, 50),
          backgroundColor: Colors.red,
        ),
        onPressed: (){}, 
        child: Text(
          "Verify",
          style: TextStyle(
            fontFamily: "Custom",
            fontSize: 15,
            color: Colors.white
          ),
         ),
      ),
    );
  }

}