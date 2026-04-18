import 'package:flutter/material.dart';

class editProfile extends StatefulWidget {
  const editProfile({super.key});

  @override
  State<editProfile> createState() => _editProfileState();
}

class _editProfileState extends State<editProfile> {
  double get screenWidth => MediaQuery.of(context).size.width;

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
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _header(),
              SizedBox(height: 10),
              _AccPhoto(),
              SizedBox(height: 5),
              _edit(),
              SizedBox(height: 10),
              customInput(label: "Name :", hint: "Enter your name"),
              customInput(label: "Date of Birth :", hint: "", isDate: true),
              customInput(label: "Email :", hint: "Enter your email"),
              customInput(label: "Phone :", hint: "Enter your phone number"),
              customInput(label: "Address :", hint: "Enter your Address"),
              SizedBox(height: 10),
              
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

  Widget _AccPhoto(){
    return Center(
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(100),
          border: BoxBorder.all(color: Colors.black, width: 2),
        ),
        child: Icon(Icons.image, size: 160),
      ),
    );
  }

  Widget _edit(){
    return Center(
      child: GestureDetector(
        onTap: () {
          
        },
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Text(
              'Change Profile',
              style: TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.bold, 
              ),
            ),
            const SizedBox(width: 4),
            Container(
              padding: const EdgeInsets.all(4),
              child: const Icon(
                Icons.mode_edit,
                size: 20,
              ),
            ),
          ],
        ),
      )
    );
  }

  Widget customInput({required String label, required String hint, bool isDate = false}) {
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
          Text(
            label,
            style: const TextStyle(
              fontFamily: "Custom",
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 16,
            ),
          ),
          const SizedBox(width: 20),
          Expanded(
            child: TextField(
              style: const TextStyle(color: Colors.white),
              decoration: InputDecoration(
                hintText: hint,
                hintStyle: const TextStyle(color: Colors.grey,fontFamily: "Custom",),
                border: InputBorder.none,
                suffixIcon: isDate 
                  ? GestureDetector(
                    onTap: _selectDate,
                    child: Icon(Icons.calendar_month, color: Colors.grey)) 
                  : null,
              ),
            ),
          ),
        ],
      ),
    );
  }
}