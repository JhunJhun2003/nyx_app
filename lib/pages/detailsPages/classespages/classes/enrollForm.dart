import 'package:flutter/material.dart';
import 'package:nyxproject/pages/detailsPages/servicepages/classes/classes_payment.dart';

class enrollForm extends StatefulWidget {
  const enrollForm({super.key});

  @override
  State<enrollForm> createState() => _enrollFormState();
}

class _enrollFormState extends State<enrollForm> {

  final TextEditingController input = TextEditingController();
  String selectedOption = "Male";
  String? course;
  String? level;
  String? time;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _header(),
              SizedBox(height: 5),
              _section1("Fullname"),
              SizedBox(height: 5),
              _input("Enter your name"),
              SizedBox(height: 5),
              _section1("Gender"),
              SizedBox(height: 5),
              _gender(),
              SizedBox(height: 5),
              _section1("Phone Number"),
              SizedBox(height: 5),
              _input("09 xxx xxx xxx"),
              SizedBox(height: 5),
              _section1("Email Address"),
              SizedBox(height: 5),
              _input("example@gmail.com"),
              SizedBox(height: 5),
              _section1("Age"),
              SizedBox(height: 5),
              _input("Enter your age"),
              SizedBox(height: 5),
              _section1("Address"),
              SizedBox(height: 5),
              _input("Enter your address"),
              // SizedBox(height: 5),
              // _section1("Emergency Contact"),
              // SizedBox(height: 5),
              // _input("Emergency Contact Number"),
              SizedBox(height: 15),
              _section1("Choose"),
              SizedBox(height: 5),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  _selection2("Course Selection:",),
                  CustomDropdownField(
                    hint: "Course",
                    value: course,
                    items: ["Badminton", "Futsals", "Tennis"],
                    onChanged: (val) => setState(() => course = val),
                  ),
                ],
              ),
              SizedBox(height: 5),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  _selection2("Training Level:",),
                  CustomDropdownField(
                    hint: "Training Level",
                    value: level,
                    items: ["Beginner", "Intermediate", "Advanced"],
                    onChanged: (val) => setState(() => level = val),
                  ),
                ],
              ),
              SizedBox(height: 5),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  _selection2("Training Schedule:",),
                  CustomDropdownField(
                    hint: "Time Slot",
                    value: time,
                    items: ["7AM - 9AM", "4PM - 6PM", "6PM - 8PM","8PM - 10PM"],
                    onChanged: (val) => setState(() => time = val),
                  ),
                ],
              ),
              SizedBox(height: 15),
              _confirm(),
              SizedBox(height: 15),
              _alert(),
              SizedBox(height: 15),
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
          SizedBox(width: 80),
          Expanded(
            child: Text(
              "Enrollment Form",
              style: TextStyle(
                fontFamily: "Custom",
                color: Colors.white,
                fontSize: 18,
                fontWeight: FontWeight.w600
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _section1(String title) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      child: Text(title,
       style: const TextStyle(
        color: Color.fromARGB(255, 13, 27, 42), 
        fontWeight: FontWeight.w500,
        fontFamily: 'Custom',
        fontSize: 17,
        )
      ),
    );
  }

  Widget _input(String text){
    return Container(
      height: 50,
      margin: EdgeInsets.symmetric(horizontal: 5),
      child: TextFormField(
        controller: input,
        style: TextStyle(
          fontFamily: "Custom",
          color: Color.fromARGB(255, 255, 255, 255),
        ),
        decoration: InputDecoration(
          hintText: text,
          filled: true,
          fillColor: Color.fromARGB(255, 13, 27, 42),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15)
          ),
        ),
      )
    );
  }

  Widget _gender(){
    return Row(
      children: [
        Radio<String>(
          value: "Male",
          groupValue: selectedOption,
          onChanged: (value) {
            setState(() {
              selectedOption = value!;
            });
          },
        ),
        Text("Male"),

        Radio<String>(
          value: "Female",
          groupValue: selectedOption,
          onChanged: (value) {
            setState(() {
              selectedOption = value!;
            });
          },
        ),
        Text("Female"),
      ],
    );
  }

  Widget _selection2(String main){
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 5),
      child: Text(
        main,
        style: TextStyle(
          fontFamily: "Custom",
          color: Color.fromARGB(255, 13, 27, 42),
          fontSize: 17
        ),
      ),
    );
  }

  Widget _confirm(){
    return Center(
      child: ElevatedButton.icon(
        onPressed: (){
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => classesPayment()),
          );
        }, 
        label: Text(
          "Confirm",
          style: TextStyle(
            color: Colors.white,
            fontFamily: "Custom",
            fontSize: 15,
          ),
        ),
        icon: Icon(Icons.arrow_right_alt_sharp,color: Colors.white,),
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.red,
          fixedSize: Size(150, 50)
        ),
      ),
    );
  }

  Widget _alert(){
    return Center(
      child: Text(
        "*Trainees are responsible for their own physical safety.*",
        style: TextStyle(
          fontFamily: "Custom",
          fontSize: 15,
          color: Color.fromARGB(255, 13, 27, 42),
        ),
      ),
    );
  }
  
}

class CustomDropdownField extends StatelessWidget {
  final String hint;
  final String? value;
  final List<String> items;
  final Function(String?) onChanged;

  const CustomDropdownField({
    super.key,
    required this.hint,
    required this.value,
    required this.items,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      width: 240,
      margin: EdgeInsets.symmetric(horizontal: 5),
      padding: EdgeInsets.symmetric(horizontal: 5),
      decoration: BoxDecoration(
        color: Color.fromARGB(255, 13, 27, 42),
        borderRadius: BorderRadius.circular(15),
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<String>(
          hint: Text(hint, style: TextStyle(color: Colors.white70)),
          value: value,
          dropdownColor: Color(0xFF0F1E2E),
          icon: Icon(Icons.keyboard_arrow_down, color: Colors.white70),
          style: TextStyle(color: Colors.white),
          isExpanded: true,
          onChanged: onChanged,
          items: items.map((item) {
            return DropdownMenuItem(
              value: item,
              child: Text(item),
            );
          }).toList(),
        ),
      ),
    );
  }
}