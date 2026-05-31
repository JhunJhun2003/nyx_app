import 'package:flutter/material.dart';
import 'package:nyxproject/pages/detailsPages/servicepages/classes/classes_payment.dart';

class enrollForm extends StatefulWidget {
  const enrollForm({super.key});

  @override
  State<enrollForm> createState() => _enrollFormState();
}

class _enrollFormState extends State<enrollForm> {
  final TextEditingController fullnameController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController ageController = TextEditingController();
  final TextEditingController addressController = TextEditingController();
  final TextEditingController emergencyController = TextEditingController();

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
              const SizedBox(height: 5),
              _section1("Fullname"),
              const SizedBox(height: 5),
              _input("Enter your name", fullnameController),
              const SizedBox(height: 5),
              _section1("Gender"),
              const SizedBox(height: 5),
              _gender(),
              const SizedBox(height: 5),
              _section1("Phone Number"),
              const SizedBox(height: 5),
              _input("09 xxx xxx xxx", phoneController),
              const SizedBox(height: 5),
              _section1("Email Address"),
              const SizedBox(height: 5),
              _input("example@gmail.com", emailController),
              const SizedBox(height: 5),
              _section1("Age"),
              const SizedBox(height: 5),
              _input("Enter your age", ageController),
              const SizedBox(height: 5),
              _section1("Address"),
              const SizedBox(height: 5),
              _input("Enter your address", addressController),
              const SizedBox(height: 5),
              _section1("Emergency Contact"),
              const SizedBox(height: 5),
              _input("Emergency Contact Number", emergencyController),
              const SizedBox(height: 15),
              _section1("Choose"),
              const SizedBox(height: 5),
              LayoutBuilder(
                builder: (context, constraints) {
                  // On small screens, use column layout
                  if (constraints.maxWidth < 600) {
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _selection2("Course Selection:"),
                        const SizedBox(height: 5),
                        CustomDropdownField(
                          hint: "Course",
                          value: course,
                          items: const ["Badminton", "Futsals", "Tennis"],
                          onChanged: (val) => setState(() => course = val),
                        ),
                        const SizedBox(height: 10),
                        _selection2("Training Level:"),
                        const SizedBox(height: 5),
                        CustomDropdownField(
                          hint: "Training Level",
                          value: level,
                          items: const ["Beginner", "Intermediate", "Advanced"],
                          onChanged: (val) => setState(() => level = val),
                        ),
                        const SizedBox(height: 10),
                        _selection2("Training Schedule:"),
                        const SizedBox(height: 5),
                        CustomDropdownField(
                          hint: "Time Slot",
                          value: time,
                          items: const ["7AM - 9AM", "4PM - 6PM", "6PM - 8PM", "8PM - 10PM"],
                          onChanged: (val) => setState(() => time = val),
                        ),
                      ],
                    );
                  } else {
                    // On wider screens, use row layout
                    return Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            _selection2("Course Selection:"),
                            Expanded(
                              child: CustomDropdownField(
                                hint: "Course",
                                value: course,
                                items: const ["Badminton", "Futsals", "Tennis"],
                                onChanged: (val) => setState(() => course = val),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 5),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            _selection2("Training Level:"),
                            Expanded(
                              child: CustomDropdownField(
                                hint: "Training Level",
                                value: level,
                                items: const ["Beginner", "Intermediate", "Advanced"],
                                onChanged: (val) => setState(() => level = val),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 5),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            _selection2("Training Schedule:"),
                            Expanded(
                              child: CustomDropdownField(
                                hint: "Time Slot",
                                value: time,
                                items: const ["7AM - 9AM", "4PM - 6PM", "6PM - 8PM", "8PM - 10PM"],
                                onChanged: (val) => setState(() => time = val),
                              ),
                            ),
                          ],
                        ),
                      ],
                    );
                  }
                },
              ),
              const SizedBox(height: 15),
              _confirm(),
              const SizedBox(height: 15),
              _alert(),
              const SizedBox(height: 15),
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
        mainAxisAlignment: MainAxisAlignment.start,
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
          const SizedBox(width: 8),
          Expanded(
            child: Text(
              "Enrollment Form",
              style: TextStyle(
                fontFamily: "Custom",
                color: Colors.white,
                fontSize: 18,
                fontWeight: FontWeight.w600,
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
      child: Text(
        title,
        style: const TextStyle(
          color: Color.fromARGB(255, 13, 27, 42),
          fontWeight: FontWeight.w500,
          fontFamily: 'Custom',
          fontSize: 17,
        ),
      ),
    );
  }

  Widget _input(String text, TextEditingController controller) {
    return Container(
      height: 50,
      margin: const EdgeInsets.symmetric(horizontal: 5),
      child: TextFormField(
        controller: controller,
        style: const TextStyle(
          fontFamily: "Custom",
          color: Color.fromARGB(255, 255, 255, 255),
        ),
        decoration: InputDecoration(
          hintText: text,
          filled: true,
          fillColor: const Color.fromARGB(255, 13, 27, 42),
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(15)),
        ),
      ),
    );
  }

  Widget _gender() {
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
        const Text("Male"),
        Radio<String>(
          value: "Female",
          groupValue: selectedOption,
          onChanged: (value) {
            setState(() {
              selectedOption = value!;
            });
          },
        ),
        const Text("Female"),
      ],
    );
  }

  Widget _selection2(String main) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 5),
      child: Text(
        main,
        style: const TextStyle(
          fontFamily: "Custom",
          color: Color.fromARGB(255, 13, 27, 42),
          fontSize: 17,
        ),
      ),
    );
  }

  Widget _confirm() {
    return Center(
      child: ElevatedButton.icon(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const classesPayment()),
          );
        },
        label: const Text(
          "Confirm",
          style: TextStyle(
            color: Colors.white,
            fontFamily: "Custom",
            fontSize: 15,
          ),
        ),
        icon: const Icon(Icons.arrow_right_alt_sharp, color: Colors.white),
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.red,
          fixedSize: const Size(150, 50),
        ),
      ),
    );
  }

  Widget _alert() {
    return Center(
      child: Text(
        "*Trainees are responsible for their own physical safety.*",
        style: TextStyle(
          fontFamily: "Custom",
          fontSize: 15,
          color: const Color.fromARGB(255, 13, 27, 42),
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
      margin: const EdgeInsets.symmetric(horizontal: 5),
      padding: const EdgeInsets.symmetric(horizontal: 5),
      decoration: BoxDecoration(
        color: const Color.fromARGB(255, 13, 27, 42),
        borderRadius: BorderRadius.circular(15),
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<String>(
          hint: Text(hint, style: const TextStyle(color: Colors.white70)),
          value: value,
          dropdownColor: const Color(0xFF0F1E2E),
          icon: const Icon(Icons.keyboard_arrow_down, color: Colors.white70),
          style: const TextStyle(color: Colors.white),
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