import 'package:flutter/material.dart';
import 'package:nyxproject/pages/detailsPages/classespages/rental_payment.dart';

class bookingForm extends StatefulWidget {
  const bookingForm({super.key});

  @override
  State<bookingForm> createState() => _bookingFormState();
}

class _bookingFormState extends State<bookingForm> {

  final TextEditingController inputController = TextEditingController();
  final TextEditingController dobController = TextEditingController();

  String? Court;
  String? TimeSlot;

  Future<void> _selectDate() async {
    DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
    );

    if (pickedDate != null) {
      setState(() {
        dobController.text = 
            "${pickedDate.year}-${pickedDate.month.toString().padLeft(2, '0')}-${pickedDate.day.toString().padLeft(2, '0')}";
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
              SizedBox(height: 20),
              _formInput1("Name","Enter your name"),
              SizedBox(height: 10),
              _formInput1("Phone Number","09 xxx xxx xxx"),
              SizedBox(height: 10),
              Row(
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _selection2("Choose Court",),
                      SizedBox(height: 5),
                      CustomDropdownField(
                        hint: "Court",
                        value: Court,
                        items: ["Court A", "Court B", "Court C"],
                        onChanged: (val) => setState(() => Court = val),
                      ),
                    ],
                  ),
                  SizedBox(width: 5),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _selection2("Court Price",),
                      SizedBox(height: 5),
                      _input("Auto Fill Price"),
                    ],
                  )
                ],
              ),
              SizedBox(height: 10),
              _dateInput(),
              SizedBox(height: 10),
              Row(
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _selection2("Choose Time Slot",),
                      SizedBox(height: 5),
                      CustomDropdownField(
                        hint: "Time Slot",
                        value: TimeSlot,
                        items: [
                          "6:00 - 7:00",
                          "7:30 - 8:30",
                          "9:00 - 10:00",
                          "16:30 - 17:30",
                          "18:00 - 19:00",
                          "20:30 - 21:30",
                        ],
                        onChanged: (val) => setState(() => TimeSlot = val),
                      ),
                    ],
                  ),
                  SizedBox(width: 5),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _selection2("Session Price",),
                      SizedBox(height: 5),
                      _input("Auto Fill Price"),
                    ],
                  )
                ],
              ),
              SizedBox(height: 10),
              _formInput1("Rantal Fees","Auto Fill"),
              SizedBox(height: 10),
              _formInput1("Total Charges (MMK)","Auto Fill (court * session)"),
              SizedBox(height: 10),
              _formInput2("Remark","Write remark"),
              SizedBox(height: 30),
              _confirm(),
            ],
          ),
        )
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
            onPressed: (){
              Navigator.pop(context);
            }, 
            icon: Icon(
              Icons.arrow_back_ios_new_rounded, 
              color: Colors.white,
            ),
          ),
          SizedBox(width: 70),
          Text(
            "BOOKING FORM",
            style: TextStyle(
              fontFamily: "Custom",
              color: Colors.white,
              fontSize: 20,
              fontWeight: FontWeight.w600
            ),
          ),
        ],
      ),
    );
  }

  Widget _formInput1(String title, String text){
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 5),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(
              color: Color.fromARGB(255, 13, 27, 42), 
              fontWeight: FontWeight.w500,
              fontFamily: 'Custom',
              fontSize: 17,
            )
          ),
          SizedBox(height: 5),
          Container(
            height: 40,
            child: TextFormField(
              controller: inputController,
              style: TextStyle(
                fontFamily: "Custom",
                color: Color.fromARGB(255, 255, 255, 255),
              ),
              decoration: InputDecoration(
                hintText: text,
                filled: true,
                fillColor: Color.fromARGB(255, 13, 27, 42),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10)
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _formInput2(String title, String text){
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 5),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(
              color: Color.fromARGB(255, 13, 27, 42), 
              fontWeight: FontWeight.w500,
              fontFamily: 'Custom',
              fontSize: 17,
            )
          ),
          SizedBox(height: 5),
          Container(
            height: 80,
            child: TextFormField(
              controller: inputController,
              style: TextStyle(
                fontFamily: "Custom",
                color: Color.fromARGB(255, 255, 255, 255),
              ),
              decoration: InputDecoration(
                hintText: text,
                filled: true,
                fillColor: Color.fromARGB(255, 13, 27, 42),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10)
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _input(String text){
    return Container(
      height: 40,
      width: 155,
      child: TextFormField(
        controller: inputController,
        style: TextStyle(
          fontFamily: "Custom",
          color: Color.fromARGB(255, 255, 255, 255),
        ),
        decoration: InputDecoration(
          hintText: text,
          filled: true,
          fillColor: Color.fromARGB(255, 13, 27, 42),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10)
          ),
        ),
      ),
    );
  }

  Widget _dateInput(){
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 5),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _selection2("Booking Date"),
          SizedBox(height: 5),
          TextFormField(
          controller: dobController,
          readOnly: true,
          onTap: _selectDate,
          style: const TextStyle(color: Colors.white),
          decoration: InputDecoration(
            hintText: "Booking Date (YYYY-MM-DD)",
            hintStyle: const TextStyle(color: Colors.grey),
            prefixIcon: const Icon(Icons.calendar_today, color: Colors.white),
            filled: true,
            fillColor: const Color.fromARGB(255, 13, 27, 42),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide.none,
            ),
          ),
        ),
        ]
      ),
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
      child: ElevatedButton(
        style: ButtonStyle(
          backgroundColor: WidgetStatePropertyAll(Colors.red),
        ),
        onPressed: (){
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => rentalPayment(),
            ),
          );
        }, 
        child: Text(
          "Confirm",
          style: TextStyle(
            color: Colors.white,
            fontFamily: "Custom",
            fontSize: 17,
            fontWeight: FontWeight.w700
          ),
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
      height: 40,
      width: 235,
      margin: EdgeInsets.symmetric(horizontal: 5),
      padding: EdgeInsets.symmetric(horizontal: 5),
      decoration: BoxDecoration(
        color: Color.fromARGB(255, 13, 27, 42),
        borderRadius: BorderRadius.circular(10),
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<String>(
          hint: Text(
            hint, 
            style: TextStyle(
              color: const Color.fromARGB(255, 79, 79, 79),
              fontFamily: "Custom",
              fontSize: 17
            ),
          ),
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